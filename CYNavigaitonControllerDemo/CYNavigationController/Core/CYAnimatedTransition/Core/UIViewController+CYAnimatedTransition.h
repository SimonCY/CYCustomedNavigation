//
//  UIViewController+CYAnimatedTransition.h
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/4.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYForwardTransition;

typedef NS_ENUM(NSUInteger, CYAnimatedTransitionControllerShowType) {
    CYAnimatedTransitionControllerShowTypePresent,
    CYAnimatedTransitionControllerShowTypePush,
};

@interface UIViewController (CYAnimatedTransition) <UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>

/**
 * pravite for recording if the VC's pop animation is customed. So the animator will setter the delegate of navigationController automatic.
 */
@property (nonatomic,assign,getter=isPushTransitionCustomed) BOOL pushTransitionCustomed;

@property (nonatomic,assign,getter=isPresentTransitionCustomed) BOOL presentTransitionCustomed;
 
- (void)setCY_animatedTransition:(CYForwardTransition *)cy_animatedTransition withShowType:(CYAnimatedTransitionControllerShowType)showType forSourceViewController:(UIViewController *)sourceViewController;

- (CYForwardTransition *)cy_animatedTransitionForSourceViewController:(UIViewController *)sourceViewController;

- (void)cy_presentFromTopViewControllerWithAnimated:(BOOL)animated;

+ (UIViewController *)fetchTopViewController;

@end
