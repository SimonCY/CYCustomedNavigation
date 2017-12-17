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

@implementation UIViewController (CYAnimatedTransition)

#pragma - mark - setter

- (void)setCY_animatedTransition:(CYForwardTransition *)cy_animatedTransition forSourceViewController:(UIViewController *)sourceViewController {

    NSAssert((sourceViewController.navigationController != nil), @"fromViewController doesn't have a navigationController");
    sourceViewController.navigationController.delegate = self;
 
    if ([self cy_animatedTransitionForSourceViewController:sourceViewController] != cy_animatedTransition) {

        objc_setAssociatedObject(self, class_getName([sourceViewController class]),
                                 cy_animatedTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - getter

- (CYForwardTransition *)cy_animatedTransitionForSourceViewController:(UIViewController *)sourceViewController {

    return objc_getAssociatedObject(self, class_getName([sourceViewController class]));
}

#pragma - mark - navigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    if ([toVC cy_animatedTransitionForSourceViewController:fromVC]) {

        return [toVC cy_animatedTransitionForSourceViewController:fromVC];
    } else if ([fromVC cy_animatedTransitionForSourceViewController:toVC]) {

        return (id <UIViewControllerAnimatedTransitioning>)[fromVC cy_animatedTransitionForSourceViewController:toVC].inverseTransition;
    }
    return nil;
}

//- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
//    if ([animationController isKindOfClass:[MagicMoveInverseTransition class]]) {
//        return self.percentDrivenTransition;
//    }else{
//        return nil;
//    }
//}
@end
