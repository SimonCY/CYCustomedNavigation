//
//  CYInverseTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/17.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYInverseTransition.h"
#import "CYForwardTransition.h"
#import "CYBaseAnimatedTransition.h"
#import "UIViewController+CYAnimatedTransition.h"

@interface CYInverseTransition ()

@property (strong, nonatomic) UIScreenEdgePanGestureRecognizer *defaultPopGustureRecognizer;

@end

@implementation CYInverseTransition

- (void)dealloc {
    
    [[UIApplication sharedApplication].keyWindow removeGestureRecognizer:_defaultPopGustureRecognizer];
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.rightPanGustureEnable = YES;
        
        //setup gusture
        _defaultPopGustureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
        _defaultPopGustureRecognizer.enabled = self.isRightPanGustureEnable;
        
        //设置从什么边界滑入
        ((UIScreenEdgePanGestureRecognizer *)_defaultPopGustureRecognizer).edges = UIRectEdgeLeft;
        [[UIApplication sharedApplication].keyWindow addGestureRecognizer:_defaultPopGustureRecognizer];
    }
    return self;
}
 
#pragma mark - pravite

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer {
  
  UIViewController *currentVC = [UIViewController fetchTopViewController];
  
  if (!currentVC.isPushTransitionCustomed && !currentVC.isPresentTransitionCustomed) {
    
    return;
  }
 
    CGFloat progress = [recognizer translationInView:recognizer.view].x / (recognizer.view.bounds.size.width * 1.0);
    //limited between 0 ~ 1
    progress = MIN(1.0, MAX(0.0, progress));
  
    if (recognizer.state == UIGestureRecognizerStateBegan) {
      
        _rightPanPopPercentDriven = [[UIPercentDrivenInteractiveTransition alloc]init];
      
 
        if (currentVC.navigationController) {
            
            [currentVC.navigationController popViewControllerAnimated:YES];
        } else {
            
            [currentVC dismissViewControllerAnimated:YES completion:nil];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        [_rightPanPopPercentDriven updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {

      _rightPanPopPercentDriven.completionSpeed = 0.3;
 
        if (progress > 0.5) {
            
            [_rightPanPopPercentDriven finishInteractiveTransition];
        } else {
            
            [_rightPanPopPercentDriven cancelInteractiveTransition];
        }
        _rightPanPopPercentDriven = nil;
    }
}

#pragma mark - setter

- (void)setRightPanGustureEnable:(BOOL)rightPanGustureEnable {
    _rightPanGustureEnable = rightPanGustureEnable;
    
    self.defaultPopGustureRecognizer.enabled = _rightPanGustureEnable;
}

#pragma mark - getter

- (UIView *)sourceView {

    return [self.destinationViewDataSource destinationViewForCYAnimatedTransition:self];
}

- (UIView *)destinationView {

    return [self.sourceViewDataSource sourceViewForCYAnimatedTransition:self];
}

- (UIPercentDrivenInteractiveTransition *)percentDrivenTransition {
    
    if (self.isRightPanGustureEnable) {
        
        return self.rightPanPopPercentDriven;
    } else {
        
        if (self.destinationViewDataSource && [self.destinationViewDataSource respondsToSelector:@selector(percentDrivenForCYInverseTransition:)]) {
            
            return [self.destinationViewDataSource percentDrivenForCYInverseTransition:self];
        } else {
            
            return nil;
        }
    }

}

@end
