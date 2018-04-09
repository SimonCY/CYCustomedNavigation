//
//  DetailViewController.m
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "DetailViewController.h"
#import "CYCustomedNavigationBar.h"

@interface DetailViewController ()<CYAnimatedTransitionSourceViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    if (self.isNeedCY_customedNavigationBar) {
        
        self.cy_navigationBar = [[CYCustomedNavigationBar alloc] init];
        self.cy_navigationBar.navigationItem.title = @"present模仿push动画";
        self.textView.text = @"每个ViewController独立管理自己的navBar，在项目采用组件化URI路由结构时，同时使用CYCustomedNavigationBar和CYAnimatedTransition，达到用present模仿push方法跳转到任意协议页面的效果";
    } else {
        
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.navigationController) {
 
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    
}


#pragma mark - CYMagicMoveTransitionDestinationViewDataSource

- (UIView *)destinationViewForCYAnimatedTransition:(CYBaseAnimatedTransition *_Nullable)animatedTransitio {

    return self.imageView;
}

- (UIPercentDrivenInteractiveTransition *)percentDrivenForCYInverseTransition:(CYInverseTransition *)animatedTransition {
    if (self.navigationController) {
        
        return animatedTransition.defaultPopPercentDriven;
    }
    return nil;
}

#pragma mark - CYMaigicMoveTranstionDelegate

- (void)CYAnimatedTransitionStartAnimatingWithAnimatedTransition:(CYBaseAnimatedTransition *)animatedTransition {

    self.textView.transform = CGAffineTransformMakeTranslation(80, 0);
    [UIView animateWithDuration:animatedTransition.transitionDuration delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{

        self.textView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

#pragma mark - CYMagicMoveTransitionSourceViewDataSource

- (UIView *)sourceViewForCYAnimatedTransition:(CYBaseAnimatedTransition *)animatedTransition {
    
    return self.imageView;
}
@end
