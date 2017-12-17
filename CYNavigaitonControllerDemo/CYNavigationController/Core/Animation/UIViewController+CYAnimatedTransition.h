//
//  UIViewController+CYAnimatedTransition.h
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/4.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYBaseAnimatedTransition;

@interface UIViewController (CYAnimatedTransition) <UINavigationControllerDelegate>

- (void)setCY_animatedTransition:(CYBaseAnimatedTransition *)cy_animatedTransition forDestinationViewController:(UIViewController *)destinationViewController;

- (CYBaseAnimatedTransition *)cy_animatedTransitionForDestinationViewController:(UIViewController *)destinationViewController;

@end
