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
    
    // Get sourceView, destinationView and create sourceView's snapShot.
    UIView *snapShotView = [self.sourceView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [self.containerView convertRect:self.sourceView.frame fromView:self.sourceView.superview];
    snapShotView.layer.cornerRadius = 20;
    
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

        
        snapShotView.layer.cornerRadius = 0;
        self.destinationViewController.view.alpha = 1.0;
        snapShotView.frame = [self.containerView convertRect:self.destinationView.frame fromView:self.destinationView.superview];

    } completion:^(BOOL finished) {

        self.sourceView.hidden = NO;
        self.destinationView.hidden = NO;
        [snapShotView removeFromSuperview];
        [self transitionComplete];
    }];
}
@end
