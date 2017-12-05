//
//  CYMagicMoveInverseTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/3.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYMagicMoveInverseTransition.h"

@implementation CYMagicMoveInverseTransition

#pragma mark - cover from super-class

- (void)animateTransition {

    BOOL isTabBarHidden = self.toViewController.hidesBottomBarWhenPushed;

    [self animatedTransitionWithTabbarHidden:isTabBarHidden];
}

#pragma mark - pravite

- (void)animatedTransitionWithTabbarHidden:(BOOL)tabBarHidden {

    if (tabBarHidden) {
        UITabBar *tabBar = [self fetchTabBar];
        if (tabBar) {
            tabBar.hidden = YES;
        }
    }

    // Get fromView, toView and create fromView's snapShot.
    UIView *fromView = [self.fromViewDataSource fromViewForCYAnimatedTransition];
    UIView *toView = [self.toViewDataSource toViewForCYAnimatedTransition];

    UIView *snapShotView = [fromView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [self.containerView convertRect:fromView.frame fromView:fromView.superview];

    //Setup toVC before animating.
    self.toViewController.view.frame = [self.transitionContext finalFrameForViewController:self.toViewController];
    self.toViewController.view.alpha = 0;

    //Start animating.
    [self.containerView addSubview:self.toViewController.view];
    [self.containerView addSubview:snapShotView];
    [self.containerView layoutIfNeeded];

    fromView.hidden = YES;
    toView.hidden = YES;

    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{

        self.toViewController.view.alpha = 1.0;
        snapShotView.frame = [self.containerView convertRect:toView.frame fromView:toView.superview];

    } completion:^(BOOL finished) {

        fromView.hidden = NO;
        toView.hidden = NO;
        [snapShotView removeFromSuperview];
        [self transitionComplete];
    }];
}
@end
