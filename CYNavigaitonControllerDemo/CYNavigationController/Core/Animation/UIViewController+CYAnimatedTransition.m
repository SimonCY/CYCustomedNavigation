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

- (void)setCY_animatedTransition:(CYBaseAnimatedTransition *)cy_animatedTransition forToViewControllerClass:(__unsafe_unretained Class)toViewControllerClass {

    NSAssert((self.navigationController != nil), @"fromViewController doesn't have a navigationController");
    self.navigationController.delegate = self;
 
    if ([self cy_animatedTransitionForToViewControllerClass:toViewControllerClass] != cy_animatedTransition) {

        objc_setAssociatedObject(self, class_getName(toViewControllerClass),
                                 cy_animatedTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

#pragma mark - getter

- (CYBaseAnimatedTransition *)cy_animatedTransitionForToViewControllerClass:(Class)toViewControllerClass {

    return objc_getAssociatedObject(self, class_getName(toViewControllerClass));
}

#pragma - mark - navigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {

    return [self cy_animatedTransitionForToViewControllerClass:[toVC class]];
}
@end
