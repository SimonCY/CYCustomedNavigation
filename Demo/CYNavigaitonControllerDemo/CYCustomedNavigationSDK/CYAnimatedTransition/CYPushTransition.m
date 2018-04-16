//
//  CYPushTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by chenyan on 2018/3/27.
//  Copyright © 2018年 DeepAI. All rights reserved.
//

#import "CYPushTransition.h"

static const CGFloat CYPushTransitionShadowOpacity = 0.4;
static const CGFloat CYPushTransitionPushingViewOffsetX = -0.3;

@implementation CYPushTransition

#pragma mark - cover from super-class

- (instancetype)init {
    if (self = [super init]) {
        self.transitionDuration = 0.35;
    }
    return self;
}

- (void)animateTransition {
    [super animateTransition];
    
 
    //Setup toVC before animating.
    self.destinationViewController.view.frame = [self.transitionContext finalFrameForViewController:self.destinationViewController];
    self.destinationViewController.view.transform = CGAffineTransformMakeTranslation(self.containerView.bounds.size.width , 0);
    
    //add shadow
    UIView *shadowView = [[UIView alloc] init];
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = 0;
    shadowView.frame = self.sourceViewController.view.bounds;
 
    //Start animating.
    [self.containerView addSubview:self.destinationViewController.view];
    [self.containerView insertSubview:shadowView belowSubview:self.destinationViewController.view];
 
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    
        self.destinationViewController.view.transform = CGAffineTransformIdentity;
        self.sourceViewController.view.transform = CGAffineTransformMakeTranslation(self.containerView.bounds.size.width * CYPushTransitionPushingViewOffsetX, 0);
        shadowView.alpha = CYPushTransitionShadowOpacity;
    } completion:^(BOOL finished) {
 
         self.sourceViewController.view.transform = CGAffineTransformIdentity;
        [shadowView removeFromSuperview];
        [self transitionComplete];
    }];
}

@end
