//
//  CYBaseAnimatedTransition.h
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYAnimatedTransitionDelegate <NSObject>

/*
 * Sycn called before animation, you can add some UIViewAnimation for other view in this method and the UIViewAnimation-task's characteristic ,it would seem like to called asycn.
 */
- (void)CYAnimatedTransitionStartAnimatingWithDuration:(NSTimeInterval)duration;

@end

@protocol CYAnimatedTransitionFromViewDataSource <NSObject>

- (UIView * _Nonnull)fromViewForCYAnimatedTransition;

@end


@protocol CYAnimatedTransitionToViewDataSource <NSObject>

- (UIView * _Nonnull)toViewForCYAnimatedTransition;

@end


NS_ASSUME_NONNULL_BEGIN

@interface CYBaseAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (weak,nonatomic) id<CYAnimatedTransitionFromViewDataSource> fromViewDataSource;

@property (weak,nonatomic) id<CYAnimatedTransitionToViewDataSource> toViewDataSource;

@property (weak,nonatomic) id<CYAnimatedTransitionDelegate> delegate;

@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

/**
 *  Transition Duration, default is 0.6.
 */
@property (nonatomic, assign, readonly) NSTimeInterval  transitionDuration;

/**
 *  From view controller.
 */
@property (nonatomic, readonly, weak) UIViewController *fromViewController;

/**
 *  Target view controller.
 */
@property (nonatomic, readonly, weak) UIViewController *toViewController;

/**
 *  Container view.
 */
@property (nonatomic, readonly, weak) UIView *containerView;

/**
 *  Animate Transition. recover it in animatedTransition's subclass.
 */
- (void)animateTransition;

/**
 *  Complete transition.
 *  This must be called whenever a transition completes (or is cancelled.)
 */
- (void)transitionComplete;

/**
 *  Fetch tabbar if existed.
 */
- (UITabBar * _Nullable)fetchTabBar;

@end

NS_ASSUME_NONNULL_END
