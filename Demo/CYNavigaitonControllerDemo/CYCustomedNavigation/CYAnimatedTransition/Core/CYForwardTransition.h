//
//  CYTransition.h
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/17.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYBaseAnimatedTransition.h"

@class CYInverseTransition;


@interface CYForwardTransition : CYBaseAnimatedTransition

@property (strong,nonatomic,readonly) CYInverseTransition * _Nullable inverseTransition;

@end
