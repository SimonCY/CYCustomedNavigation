//
//  CYInverseTransition.h
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/17.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYBaseAnimatedTransition.h"

@class CYBaseAnimatedTransition;
 

@interface CYInverseTransition : CYBaseAnimatedTransition

@property (strong,nonatomic) UIPercentDrivenInteractiveTransition *defaultPopPercentDriven;

@end
