//
//  CYPushInverseTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by chenyan on 2018/3/27.
//  Copyright © 2018年 DeepAI. All rights reserved.
//

#import "CYPushInverseTransition.h"

static const CGFloat CYPushTransitionPushingViewOffsetX = -0.3;

@implementation CYPushInverseTransition
 
- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

- (void)animateTransition {
    [super animateTransition];
 
    //Setup toVC before animating.
    self.destinationViewController.view.frame = [self.transitionContext finalFrameForViewController:self.destinationViewController];
    self.destinationViewController.view.transform = CGAffineTransformMakeTranslation(self.containerView.bounds.size.width * CYPushTransitionPushingViewOffsetX, 0);
    
    //add shadow
    self.sourceViewController.view.layer.shadowOffset = CGSizeMake(-5, 0);
    self.sourceViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.sourceViewController.view.layer.shadowOpacity =  0.1;
    self.sourceViewController.view.layer.shadowRadius = 5;
    
    //Start animating.
    if (self.destinationViewController.view.superview == nil) {
        
        [self.containerView insertSubview:self.destinationViewController.view belowSubview:self.sourceViewController.view];
    }
    
    if (self.rightPanPopPercentDriven) {
        
        [UIView animateWithDuration:self.transitionDuration * 0.5
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
 
                             self.destinationViewController.view.transform = CGAffineTransformIdentity;
                             self.sourceViewController.view.transform = CGAffineTransformMakeTranslation(self.containerView.bounds.size.width, 0);
                             
                         } completion:^(BOOL finished) {
                             
                             self.sourceViewController.view.transform = CGAffineTransformIdentity;
                             self.destinationViewController.view.transform = CGAffineTransformIdentity;
                             [self transitionComplete];
                         }];
    } else {
        
        [UIView animateWithDuration:self.transitionDuration
                              delay:0
             usingSpringWithDamping:1
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             self.destinationViewController.view.transform = CGAffineTransformIdentity;
                             self.sourceViewController.view.transform = CGAffineTransformMakeTranslation(self.containerView.bounds.size.width, 0);
                             
                         } completion:^(BOOL finished) {
                             
                             self.sourceViewController.view.transform = CGAffineTransformIdentity;
                             self.destinationViewController.view.transform = CGAffineTransformIdentity;
                             [self transitionComplete];
                         }];
    }
 
}
 

@end
