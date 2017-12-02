//
//  CYMagicMoveTransition.h
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYBaseAnimatedTransition.h"


@protocol CYMagicMoveTransitionFromViewDataSource <NSObject>

- (UIView *)fromViewForCYMagicMoveTransition;

@end


@protocol CYMagicMoveTransitionToViewDataSource <NSObject>

- (UIView *)toViewForCYMagicMoveTransition;

@end



@interface CYMagicMoveTransition : CYBaseAnimatedTransition

@property (weak,nonatomic) id<CYMagicMoveTransitionFromViewDataSource> fromViewDataSource;

@property (weak,nonatomic) id<CYMagicMoveTransitionToViewDataSource> toViewDataSource;

@end
