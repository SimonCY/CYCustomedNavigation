//
//  CYNavigationController.m
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "CYNavigationController.h"

@interface CYNavigationController ()

@end

@implementation CYNavigationController

+ (void)initialize {
    
    [self setupNavigationBarTheme];
    [self setupBarButtonItemTheme];
}

#pragma mark - pravite

+ (void)setupNavigationBarTheme {
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    //title
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18 weight:2];
    [appearance setTitleTextAttributes:textAttrs];
    
    //navBar background
    //设置颜色  带阴影线
    [appearance setBarTintColor:[UIColor colorWithRed:147 / 255.0 green:88/ 255.0  blue:255/ 255.0  alpha:1]];
    
    //设置拉伸背景图 不带阴影线
//    [appearance setBackgroundImage:[UIImage createImageWithColor:[UIColor redColor] size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
}

+ (void)setupBarButtonItemTheme {
    
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    [appearance setTintColor:[UIColor whiteColor]];
    //item
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
}
@end
