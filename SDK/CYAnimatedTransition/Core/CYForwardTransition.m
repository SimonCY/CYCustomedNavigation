//
//  CYTransition.m
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/17.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYForwardTransition.h"
#import "CYInverseTransition.h"
#import <objc/runtime.h>

@implementation CYForwardTransition

- (void)dealloc {

    //remove Observe for keyPathes
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([CYBaseAnimatedTransition class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        if ([propertyName containsString:@"DataSource"]) {
            [self removeObserver:self forKeyPath:propertyName];
        }
    }
}

- (instancetype)init {

    if (self = [super init]) {

        //setup back inverseTransition
        NSString *inverseTransitionClassName = [NSString stringWithFormat:@"%@InverseTransition",[NSStringFromClass([self class]) substringToIndex:[NSStringFromClass([self class]) rangeOfString:@"Transition"].location]];
        _inverseTransition = [[NSClassFromString(inverseTransitionClassName) alloc] init];
        _inverseTransition.forwardTransition = self;
        
        //set Observe for keyPathes
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList([CYBaseAnimatedTransition class], &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
            if ([propertyName containsString:@"DataSource"]) {
                [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew context:nil];
            }
        }
    }
    return self;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    [_inverseTransition setValue:change[NSKeyValueChangeNewKey] forKeyPath:keyPath];
}

#pragma mark - getter

- (UIView *)sourceView {

    return [self.sourceViewDataSource sourceViewForCYAnimatedTransition:self];
}

- (UIView *)destinationView {

    return [self.destinationViewDataSource destinationViewForCYAnimatedTransition:self];
}

- (UIPercentDrivenInteractiveTransition *)percentDrivenTransition {
    
    if (self.sourceViewDataSource && [self.sourceViewDataSource respondsToSelector:@selector(percentDrivenForCYForwardTransition:)]) {
        
        return [self.sourceViewDataSource percentDrivenForCYForwardTransition:self];
    } else {
        
        return nil;
    }
}

@end
