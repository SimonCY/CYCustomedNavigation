//
//  UIViewController+CYAnimatedTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/4.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "UIViewController+CYAnimatedTransition.h"
#import <objc/runtime.h>
#import "CYBaseAnimatedTransition.h"

@implementation UIViewController (CYAnimatedTransition)

#pragma - mark - setter

- (void)setCY_animatedTransition:(CYBaseAnimatedTransition *)cy_animatedTransition forDestinationViewController:(UIViewController *)destinationViewController {

    NSAssert((self.navigationController != nil), @"fromViewController doesn't have a navigationController");
    self.navigationController.delegate = self;
 
    if ([self cy_animatedTransitionForDestinationViewController:destinationViewController] != cy_animatedTransition) {

        objc_setAssociatedObject(self, class_getName([destinationViewController class]),
                                 cy_animatedTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - getter

- (CYBaseAnimatedTransition *)cy_animatedTransitionForDestinationViewController:(UIViewController *)destinationViewController {

    return objc_getAssociatedObject(self, class_getName([destinationViewController class]));
}

#pragma - mark - navigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {

    return [self cy_animatedTransitionForDestinationViewController:toVC];
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
