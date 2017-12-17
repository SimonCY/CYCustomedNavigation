//
//  CYBaseAnimatedTransition.h
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYBaseAnimatedTransition;

@protocol CYAnimatedTransitionDelegate <NSObject>

/*
 * Sycn called before animation, you can add some UIViewAnimation for other view in this method and the UIViewAnimation-task's characteristic ,it would seem like to called asycn.
 */
- (void)CYAnimatedTransitionStartAnimatingWithAnimatedTransition:(CYBaseAnimatedTransition *_Nullable)animatedTransition;

@end

@protocol CYAnimatedTransitionSourceViewDataSource <NSObject>

- (UIView * _Nonnull)sourceViewForCYAnimatedTransition:(CYBaseAnimatedTransition *_Nullable)animatedTransition;

@end


@protocol CYAnimatedTransitionDestinationViewDataSource <NSObject>

- (UIView * _Nonnull)destinationViewForCYAnimatedTransition:(CYBaseAnimatedTransition *_Nullable)animatedTransition;

@end



NS_ASSUME_NONNULL_BEGIN

@interface CYBaseAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (weak,nonatomic) id<CYAnimatedTransitionSourceViewDataSource> _Nullable sourceViewDataSource;

@property (weak,nonatomic) id<CYAnimatedTransitionDestinationViewDataSource> _Nullable destinationViewDataSource;

@property (weak,nonatomic) id<CYAnimatedTransitionDelegate> delegate;

@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

/**
 *  Transition Duration, default is 0.6.
 */
@property (nonatomic, assign, readonly) NSTimeInterval  transitionDuration;

/**
 *  From view controller.
 */
@property (nonatomic, readonly, weak) UIViewController *sourceViewController;

/**
 *  Target view controller.
 */
@property (nonatomic, readonly, weak) UIViewController *destinationViewController;

/**
 *  Container view.
 */
@property (nonatomic, readonly, weak) UIView *containerView;

/**
 *  Animate Transition's implementation. Recover it in animatedTransition's subclass.
 */
- (void)animateTransition;

/**
 *  Complete transition.
 *  This must be called whenever a transition completes. Call it at the end of method "- (void)animateTransition" when the view-animation all finished.
 */
- (void)transitionComplete;

/**
 *  Fetch tabbar of destinationViewController if existed.
 */
- (UITabBar * _Nullable)fetchTabBar;

@end

NS_ASSUME_NONNULL_END
