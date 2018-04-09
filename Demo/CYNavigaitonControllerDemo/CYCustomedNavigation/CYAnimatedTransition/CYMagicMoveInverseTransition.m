//
//  CYMagicMoveInverseTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/3.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYMagicMoveInverseTransition.h"

@interface CYMagicMoveInverseTransition ()

@end

@implementation CYMagicMoveInverseTransition

#pragma mark - cover from super-class

- (void)animateTransition {
    [super animateTransition];

    // Get sourceView, destinationView and create sourceView's snapShot.In inverseTransition, view change from destinationView to sourceView, it's inserve from forwardTransition.
    UIView *snapShotView = [self.sourceView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [self.containerView convertRect:self.sourceView.frame fromView:self.sourceView.superview];
    snapShotView.clipsToBounds = YES;

    //Setup toVC before animating.
    self.destinationViewController.view.frame = [self.transitionContext finalFrameForViewController:self.destinationViewController];
    self.destinationViewController.view.alpha = 0;

    //Start animating.
    [self.containerView addSubview:self.destinationViewController.view];
    [self.containerView addSubview:snapShotView];
    [self.containerView layoutIfNeeded];

    self.sourceView.hidden = YES;
    self.destinationView.hidden = YES;

    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{

        snapShotView.layer.cornerRadius = 20;
        self.destinationViewController.view.alpha = 1.0;
        snapShotView.frame = [self.containerView convertRect:self.destinationView.frame fromView:self.destinationView.superview];

    } completion:^(BOOL finished) {

        self.sourceView.hidden = NO;
        self.destinationView.hidden = NO;
        
        [UIView animateWithDuration:0.2 animations:^{
            snapShotView.alpha = 0;
        } completion:^(BOOL finished) {
            
            [snapShotView removeFromSuperview];
            [self transitionComplete];
        }];
    }];
}
@end
