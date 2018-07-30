//
//  CYPushTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by chenyan on 2018/3/27.
//  Copyright © 2018年 DeepAI. All rights reserved.
//

#import "CYPushTransition.h"

static const CGFloat CYPushTransitionPushingViewOffsetX = -0.3;

@implementation CYPushTransition

#pragma mark - cover from super-class
 
- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

- (void)animateTransition {
    [super animateTransition];
    
 
    //Setup toVC before animating.
    self.destinationViewController.view.frame = [self.transitionContext finalFrameForViewController:self.destinationViewController];
    self.destinationViewController.view.transform = CGAffineTransformMakeTranslation(self.containerView.bounds.size.width , 0);
 
    //Start animating.
    [self.containerView addSubview:self.destinationViewController.view];
 
    [UIView animateWithDuration:self.transitionDuration
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
        
        self.destinationViewController.view.transform = CGAffineTransformIdentity;
        self.sourceViewController.view.transform = CGAffineTransformMakeTranslation(self.containerView.bounds.size.width * CYPushTransitionPushingViewOffsetX, 0);
 
    } completion:^(BOOL finished) {
 
         self.sourceViewController.view.transform = CGAffineTransformIdentity;
        [self transitionComplete];
    }];
}

@end
