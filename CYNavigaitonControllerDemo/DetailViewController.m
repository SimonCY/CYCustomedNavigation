//
//  DetailViewController.m
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

#pragma mark - CYMagicMoveTransitionDataSource

- (UIView *)toViewForCYAnimatedTransition {

    return self.imageView;
}

#pragma mark - CYMaigicMoveTranstionDelegate

- (void)CYAnimatedTransitionStartAnimatingWithDuration:(NSTimeInterval)duration {

    self.textView.transform = CGAffineTransformMakeTranslation(80, 0);
    [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{

        self.textView.transform = CGAffineTransformIdentity;

    } completion:^(BOOL finished) {
        
    }];
}
@end
