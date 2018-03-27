//
//  CYPushInverseTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by chenyan on 2018/3/27.
//  Copyright © 2018年 DeepAI. All rights reserved.
//

#import "CYPushInverseTransition.h"

static const CGFloat CYPushTransitionShadowOpacity = 0.4;
static const CGFloat CYPushTransitionPushingViewOffsetX = -0.3;
static const CGFloat CYPushTransitionShadowWidth = 5;

@implementation CYPushInverseTransition

- (instancetype)init {
    if (self = [super init]) {
        self.transitionDuration = 0.35;
    }
    return self;
}

- (void)animateTransition {
    [super animateTransition];
 
    //Setup toVC before animating.
    self.destinationViewController.view.transform = CGAffineTransformMakeTranslation(self.containerView.bounds.size.width * CYPushTransitionPushingViewOffsetX, 0);
    
    //add shadow
    UIView *shadowView = [[UIView alloc] init];
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = CYPushTransitionShadowOpacity;
    shadowView.frame = self.sourceViewController.view.bounds;
    self.sourceViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.sourceViewController.view.layer.shadowOffset = CGSizeMake(-CYPushTransitionShadowWidth, 0);
    self.sourceViewController.view.layer.shadowOpacity = CYPushTransitionShadowOpacity;
    self.sourceViewController.view.layer.shadowRadius = CYPushTransitionShadowWidth;
    
    //Start animating.
    [self.containerView insertSubview:self.destinationViewController.view belowSubview:self.sourceViewController.view];
    [self.destinationViewController.view addSubview:shadowView];
    [self.containerView layoutIfNeeded];
    
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
  
        self.destinationViewController.view.transform = CGAffineTransformIdentity;
        self.sourceViewController.view.transform = CGAffineTransformMakeTranslation(self.containerView.bounds.size.width, 0);
        shadowView.alpha = 0;
    } completion:^(BOOL finished) {
 
        self.sourceViewController.view.layer.shadowOpacity = 0;
        self.sourceViewController.view.transform = CGAffineTransformIdentity;
        [shadowView removeFromSuperview];
        [self transitionComplete];
    }];
}

//pop动画使用默认手势百分比
- (UIPercentDrivenInteractiveTransition *)percentDrivenTransition {
    
    return self.defaultPopPercentDriven;
}

@end
