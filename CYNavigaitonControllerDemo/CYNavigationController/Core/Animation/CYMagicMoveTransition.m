//
//  CYMagicMoveTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYMagicMoveTransition.h"

@interface CYMagicMoveTransition()

@property (strong,nonatomic) UIImageView *fromViewShotImageView;

@end

@implementation CYMagicMoveTransition

#pragma mark - getter

- (UIImageView *)fromViewShotImageView{

    if (!_fromViewShotImageView) {

        _fromViewShotImageView = [UIImageView new];
    }
    return _fromViewShotImageView;
}


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
    UIView *fromView = [self.fromViewDataSource fromViewForCYMagicMoveTransition];
    UIView *toView = [self.toViewDataSource toViewForCYMagicMoveTransition];

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
