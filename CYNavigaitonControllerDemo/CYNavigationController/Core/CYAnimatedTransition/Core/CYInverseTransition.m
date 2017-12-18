//
//  CYInverseTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/17.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYInverseTransition.h"
#import "CYBaseAnimatedTransition.h"

@implementation CYInverseTransition

- (instancetype)init {
    
    if (self = [super init]) {
        
        //setup defaultPopPercentDriven
        UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
        
        //设置从什么边界滑入
        edgePanGestureRecognizer.edges = UIRectEdgeLeft;
        [[UIApplication sharedApplication].keyWindow addGestureRecognizer:edgePanGestureRecognizer];
    }
    return self;
}

#pragma mark - pravite

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer {
 
    CGFloat progress = [recognizer translationInView:recognizer.view].x / (recognizer.view.bounds.size.width * 1.0);
    //limited between 0 ~ 1
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.defaultPopPercentDriven = [[UIPercentDrivenInteractiveTransition alloc]init];
        [[self fetchTopViewController].navigationController popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        [self.defaultPopPercentDriven updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
 
        if (progress > 0.3) {
            
            [self.defaultPopPercentDriven finishInteractiveTransition];
        } else {
            
            [_defaultPopPercentDriven cancelInteractiveTransition];
        }
        self.defaultPopPercentDriven = nil;
    }
}

- (UIViewController *)fetchTopViewController {
    
    UIViewController *resultVC;
    resultVC = [self topViewControllerOfViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];

    return resultVC;
}

- (UIViewController *)topViewControllerOfViewController:(UIViewController *)vc {
 
    if ([vc isKindOfClass:[UINavigationController class]]) {
        
        return [self topViewControllerOfViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        return [self topViewControllerOfViewController:[(UITabBarController *)vc selectedViewController]];
        
    } else if (vc.presentedViewController) {
        
        return [self topViewControllerOfViewController:vc.presentedViewController];
    } else {
        
        return vc;
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
