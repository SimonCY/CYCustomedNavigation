//
//  UIViewController+CYAnimatedTransition.h
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/4.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYForwardTransition;

@interface UIViewController (CYAnimatedTransition) <UINavigationControllerDelegate>
 
- (void)setCY_animatedTransition:(CYForwardTransition *)cy_animatedTransition forSourceViewController:(UIViewController *)sourceViewController;

- (CYForwardTransition *)cy_animatedTransitionForSourceViewController:(UIViewController *)sourceViewController;

@end
