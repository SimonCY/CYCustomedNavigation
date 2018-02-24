//
//  ThirdViewController.m
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/18.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CYAnimatedTransitionDestinationViewDataSource

- (UIView *)destinationViewForCYAnimatedTransition:(CYBaseAnimatedTransition *)animatedTransition {
    
    return self.imageView;
}

- (UIPercentDrivenInteractiveTransition *)percentDrivenForCYInverseTransition:(CYInverseTransition *)animatedTransition {
    
    return animatedTransition.defaultPopPercentDriven;
}
@end
