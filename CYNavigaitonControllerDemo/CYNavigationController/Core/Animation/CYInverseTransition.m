//
//  CYInverseTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/17.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYInverseTransition.h"
#import "CYBaseAnimatedTransition.h"

@implementation CYInverseTransition

#pragma mark - getter

- (UIView *)sourceView {

    return [self.destinationViewDataSource destinationViewForCYAnimatedTransition:self];
}

- (UIView *)destinationView {

    return [self.sourceViewDataSource sourceViewForCYAnimatedTransition:self];
}


@end
