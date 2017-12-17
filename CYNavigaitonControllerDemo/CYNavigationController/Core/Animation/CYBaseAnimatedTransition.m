//
//  CYBaseAnimatedTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYBaseAnimatedTransition.h"

@interface CYBaseAnimatedTransition ()

@end

@implementation CYBaseAnimatedTransition

#pragma mark - system

- (instancetype)init {
    self = [super init];
    if (self) {
        _transitionDuration = 0.6f;
    }
    return self;
}

#pragma mark - public

- (void)transitionComplete {
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}

- (void)animateTransition{
    
}

#pragma mark - pravite

- (UITabBar *)fetchTabBar{

    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;

    UITabBarController *tabBarVc = [self fetchTabBarVcFromRootViewController:rootVc];

    if (tabBarVc) {
        return tabBarVc.tabBar;
    }
    return nil;
}

- (UITabBarController *)fetchTabBarVcFromRootViewController:(UIViewController *)rootVc{

    if (rootVc == nil) {
        
        return nil;
    } else if ([rootVc isKindOfClass:[UITabBarController class]]) {

        return (UITabBarController *)rootVc;
    } else{

        return [self fetchTabBarVcFromRootViewController:rootVc.childViewControllers.firstObject];
    }
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {

    return _transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    _sourceViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _destinationViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _containerView = [transitionContext containerView];
    _transitionContext = transitionContext;

    if (self.delegate && [self.delegate respondsToSelector:@selector(CYAnimatedTransitionStartAnimatingWithAnimatedTransition:)]) {
        [self.delegate CYAnimatedTransitionStartAnimatingWithAnimatedTransition:self];
    }

    // deal tabBar's hidden
    UITabBar *tabBar = [self fetchTabBar];
    if (tabBar) {

        tabBar.hidden = _destinationViewController.hidesBottomBarWhenPushed;
    }

    // animation
    [self animateTransition];
}

@end
