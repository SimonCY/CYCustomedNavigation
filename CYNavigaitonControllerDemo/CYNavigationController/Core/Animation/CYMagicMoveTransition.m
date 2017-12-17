//
//  CYMagicMoveTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYMagicMoveTransition.h"

@interface CYMagicMoveTransition()

@end

@implementation CYMagicMoveTransition

#pragma mark - cover from super-class

- (void)animateTransition {
    [super animateTransition];
    
    // Get fromView, toView and create fromView's snapShot.
    UIView *sourceView = [self.sourceViewDataSource sourceViewForCYAnimatedTransition:self];
    UIView *destinationView = [self.destinationViewDataSource destinationViewForCYAnimatedTransition:self];

    UIView *snapShotView = [sourceView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [self.containerView convertRect:sourceView.frame fromView:sourceView.superview];

    //Setup toVC before animating.
    self.destinationViewController.view.frame = [self.transitionContext finalFrameForViewController:self.destinationViewController];
    self.destinationViewController.view.alpha = 0;

    //Start animating.
    [self.containerView addSubview:self.destinationViewController.view];
    [self.containerView addSubview:snapShotView];
    [self.containerView layoutIfNeeded];

    sourceView.hidden = YES;
    destinationView.hidden = YES;

    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{

        self.destinationViewController.view.alpha = 1.0;
        snapShotView.frame = [self.containerView convertRect:destinationView.frame fromView:destinationView.superview];

    } completion:^(BOOL finished) {

        sourceView.hidden = NO;
        destinationView.hidden = NO;
        [snapShotView removeFromSuperview];
        [self transitionComplete];
    }];
}
@end
