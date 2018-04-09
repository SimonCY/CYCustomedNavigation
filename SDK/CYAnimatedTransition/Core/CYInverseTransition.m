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

@implementation CYInverseTransition

- (void)dealloc {
    
    [[UIApplication sharedApplication].keyWindow removeGestureRecognizer:_defaultPopGustureRecognizer];
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        //setup defaultPopPercentDriven
        _defaultPopGustureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
        
        //设置从什么边界滑入
        ((UIScreenEdgePanGestureRecognizer *)_defaultPopGustureRecognizer).edges = UIRectEdgeLeft;
        [[UIApplication sharedApplication].keyWindow addGestureRecognizer:_defaultPopGustureRecognizer];
    }
    return self;
}
 
#pragma mark - pravite

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer {
 
    CGFloat progress = [recognizer translationInView:recognizer.view].x / (recognizer.view.bounds.size.width * 1.0);
    //limited between 0 ~ 1
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        _defaultPopPercentDriven = [[UIPercentDrivenInteractiveTransition alloc]init];
        
        UIViewController *currentVC = [UIViewController fetchTopViewController];
 
        if (currentVC.navigationController) {
            
            [currentVC.navigationController popViewControllerAnimated:YES];
        } else {
            
            [currentVC dismissViewControllerAnimated:YES completion:nil];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        [_defaultPopPercentDriven updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
 
        if (progress > 0.3) {
            
            [_defaultPopPercentDriven finishInteractiveTransition];
        } else {
            
            [_defaultPopPercentDriven cancelInteractiveTransition];
        }
        _defaultPopPercentDriven = nil;
    }
}

#pragma mark - getter

- (UIView *)sourceView {

    return [self.destinationViewDataSource destinationViewForCYAnimatedTransition:self];
}

- (UIView *)destinationView {

    return [self.sourceViewDataSource sourceViewForCYAnimatedTransition:self];
}

- (UIPercentDrivenInteractiveTransition *)percentDrivenTransition {

    if (self.destinationViewDataSource && [self.destinationViewDataSource respondsToSelector:@selector(percentDrivenForCYInverseTransition:)]) {
        
        return [self.destinationViewDataSource percentDrivenForCYInverseTransition:self];
    } else {
        
        return nil;
    }
}

@end