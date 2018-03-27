//
//  UIViewController+CYAnimatedTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/4.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "UIViewController+CYAnimatedTransition.h"
#import <objc/runtime.h>
#import "CYForwardTransition.h"
#import "CYInverseTransition.h"

@implementation UIViewController (CYAnimatedTransition)

#pragma mark - runtime

+ (void)load {
    
    cy_exchangeInstanceMethod([self class], @selector(viewWillAppear:), @selector(cy_viewWillAppear:));
}

- (void)cy_viewWillAppear:(BOOL)animated {
    
    if (self.navigationController) {
        
        if (self.isPushTransitionCustomed) {
            
            self.navigationController.delegate = self;
        } else {
            
            self.navigationController.delegate = nil;
        }
    }

    [self cy_viewWillAppear:animated];
}

static void cy_exchangeInstanceMethod(Class class, SEL originalSelector, SEL newSelector) {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method newMethod = class_getInstanceMethod(class, newSelector);
    if(class_addMethod(class, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        
        class_replaceMethod(class, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

#pragma - mark - setter

- (void)setCY_animatedTransition:(CYForwardTransition *)cy_animatedTransition withShowType:(CYAnimatedTransitionControllerShowType)showType forSourceViewController:(UIViewController *)sourceViewController {

    if ([self cy_animatedTransitionForSourceViewController:sourceViewController] != cy_animatedTransition) {

        objc_setAssociatedObject(self, class_getName([sourceViewController class]),
                                 cy_animatedTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        switch (showType) {
            case CYAnimatedTransitionControllerShowTypePush:
                
                NSAssert((sourceViewController.navigationController != nil), @"fromViewController doesn't have a navigationController");
                
                sourceViewController.navigationController.delegate = self;
                self.pushTransitionCustomed = YES;
                break;
                
            case CYAnimatedTransitionControllerShowTypePresent:
                
                self.transitioningDelegate = sourceViewController;
                break;
                
            default:
                break;
        }
 
    }
}

- (void)setPushTransitionCustomed:(BOOL)transitionCustomed {
    
    objc_setAssociatedObject(self, "isSelfADestinationVCForTransition", [NSNumber numberWithBool:transitionCustomed], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - getter

- (CYForwardTransition *)cy_animatedTransitionForSourceViewController:(UIViewController *)sourceViewController {

    return objc_getAssociatedObject(self, class_getName([sourceViewController class]));
}

- (BOOL)isPushTransitionCustomed {
    
    if (objc_getAssociatedObject(self, "isSelfADestinationVCForTransition")) {
        
        return [objc_getAssociatedObject(self, "isSelfADestinationVCForTransition") boolValue];
    } else {
        
        return NO;
    }
}

#pragma - mark - navigationControllerDelegate
 
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
 
    if (operation == UINavigationControllerOperationPush) {
        
        return [toVC cy_animatedTransitionForSourceViewController:fromVC];
    } else if (operation == UINavigationControllerOperationPop) {
        
        return (id <UIViewControllerAnimatedTransitioning>)[fromVC cy_animatedTransitionForSourceViewController:toVC].inverseTransition;
    } else {
        
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    return ((CYBaseAnimatedTransition *)animationController).percentDrivenTransition;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [presented cy_animatedTransitionForSourceViewController:source];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return (id <UIViewControllerAnimatedTransitioning>)[dismissed cy_animatedTransitionForSourceViewController:(UIViewController *)dismissed.transitioningDelegate].inverseTransition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    
    return ((CYBaseAnimatedTransition *)animator).percentDrivenTransition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    
    return ((CYBaseAnimatedTransition *)animator).percentDrivenTransition;
}

@end
