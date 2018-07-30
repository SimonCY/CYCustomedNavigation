//
//  CYInverseTransition.h
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/17.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYBaseAnimatedTransition.h"

@class CYBaseAnimatedTransition,CYForwardTransition;


@interface CYInverseTransition : CYBaseAnimatedTransition

@property (weak, nonatomic) CYForwardTransition *forwardTransition;

/** default is yes */
@property (nonatomic, assign, getter=isRightPanGustureEnable) BOOL rightPanGustureEnable;

@property (strong, nonatomic, readonly) UIPercentDrivenInteractiveTransition *rightPanPopPercentDriven;

@end
