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

@property (nonatomic, weak) CYForwardTransition *forwardTransition;

@property (strong,nonatomic,readonly) UIScreenEdgePanGestureRecognizer *defaultPopGustureRecognizer;

@property (strong,nonatomic,readonly) UIPercentDrivenInteractiveTransition *defaultPopPercentDriven;

@end
