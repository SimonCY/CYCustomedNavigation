//
//  UIViewController+CYAnimatedTransition.h
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/4.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYForwardTransition;
 
@interface UIViewController (CYAnimatedTransition) <UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

/**
 * pravite for recording if the VC's pop animation is customed. So the animator will setter the delegate of navigationController automatic.
 */
@property (nonatomic,assign,getter=isPushTransitionCustomed) BOOL pushTransitionCustomed;

@property (nonatomic,assign,getter=isPresentTransitionCustomed) BOOL presentTransitionCustomed;


- (void)setCY_pushAnimatedTransition:(CYForwardTransition *)cy_animatedTransition forSourceViewController:(UIViewController *)sourceViewController;

- (CYForwardTransition *)cy_pushAnimatedTransitionForSourceViewController:(UIViewController *)sourceViewController;


- (void)setCY_presentAnimatedTransition:(CYForwardTransition *)cy_animatedTransition;

- (CYForwardTransition *)cy_PresentAnimatedTransition;


/** 从当前显示的页面，以present形式弹出 */
- (void)cy_presentFromTopViewControllerWithAnimated:(BOOL)animated;

/** dismiss到present栈中指定的页面,一次性dimiss掉多个ViewController */
- (void)cy_dismissAllPresentedViewControllerWithAnimated:(BOOL)animated completion:(void (^)(void))completion;

+ (UIViewController *)fetchTopViewController;



@end
