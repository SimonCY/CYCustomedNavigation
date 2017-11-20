//
//  CYBaseAnimatedTransition.h
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYBaseAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  Transition Duration.
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
 *  Animate Transition.
 */
- (void)animateTransition;

/**
 *  Complete transition.
 */
- (void)transitionComplete;

/**
 *  Fetch tabbar if existed.
 */
- (UITabBar * _Nullable)fetchTabBar;

@end

NS_ASSUME_NONNULL_END
