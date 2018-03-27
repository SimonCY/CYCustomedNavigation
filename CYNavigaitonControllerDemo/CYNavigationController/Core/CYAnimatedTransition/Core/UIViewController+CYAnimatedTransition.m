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
#import "CYPushTransition.h"

@implementation UIViewController (CYAnimatedTransition)

#pragma mark - runtime

+ (void)load {
    
    cy_exchangeInstanceMethod([self class], @selector(viewWillAppear:), @selector(cy_viewWillAppear:));
}

- (void)cy_viewWillAppear:(BOOL)animated {
    
    if (self.isPresentTransitionCustomed) {
        
    } else {
        
    }
 
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

#pragma mark - public

- (void)cy_presentFromTopViewControllerWithAnimated:(BOOL)animated {
    
    UIViewController *topVC = [UIViewController fetchTopViewController];
    if (topVC) {
        
        CYPushTransition *animatedTransition = [[CYPushTransition alloc] init];
        [self setCY_animatedTransition:animatedTransition withShowType:CYAnimatedTransitionControllerShowTypePresent forSourceViewController:topVC];
        [topVC presentViewController:self animated:animated completion:nil];
    }
}

+ (UIViewController *)fetchTopViewController {
    
    UIViewController *resultVC;
    resultVC = [self topViewControllerOfViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    
    return resultVC;
}

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
                self.presentTransitionCustomed = YES;
                break;
                
            default:
                break;
        }
    }
}

- (CYForwardTransition *)cy_animatedTransitionForSourceViewController:(UIViewController *)sourceViewController {
    
    return objc_getAssociatedObject(self, class_getName([sourceViewController class]));
}

#pragma mark - pravite

+ (UIViewController *)topViewControllerOfViewController:(UIViewController *)vc {
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        
        return [self topViewControllerOfViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        return [self topViewControllerOfViewController:[(UITabBarController *)vc selectedViewController]];
        
    } else if (vc.presentedViewController) {
        
        return [self topViewControllerOfViewController:vc.presentedViewController];
    } else {
        
        return vc;
    }
}
    
#pragma - mark - setter

- (void)setPushTransitionCustomed:(BOOL)transitionCustomed {
    
    objc_setAssociatedObject(self, "isSelfADestinationVCForCustomPushTransition", [NSNumber numberWithBool:transitionCustomed], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setPresentTransitionCustomed:(BOOL)presentTransitionCustomed{
    
    objc_setAssociatedObject(self, "isSelfADestinationVCForCustomPresentTransition", [NSNumber numberWithBool:presentTransitionCustomed], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - getter

- (BOOL)isPushTransitionCustomed {
    
    if (objc_getAssociatedObject(self, "isSelfADestinationVCForCustomPushTransition")) {
        
        return [objc_getAssociatedObject(self, "isSelfADestinationVCForCustomPushTransition") boolValue];
    } else {
        
        return NO;
    }
}

- (BOOL)isPresentTransitionCustomed {
    
    if (objc_getAssociatedObject(self, "isSelfADestinationVCForCustomPresentTransition")) {
        
        return [objc_getAssociatedObject(self, "isSelfADestinationVCForCustomPresentTransition") boolValue];
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
