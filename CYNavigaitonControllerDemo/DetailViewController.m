//
//  DetailViewController.m
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "DetailViewController.h"
#import "ThirdViewController.h"
#import "aViewController.h"


@interface DetailViewController ()<CYAnimatedTransitionSourceViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    [self.imageView addGestureRecognizer:tapImage];
    UITapGestureRecognizer *tapText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewTapped:)];
    [self.textView addGestureRecognizer:tapText];
}

 
#pragma mark - touch

- (void)imageViewTapped:(UITapGestureRecognizer *)tap {

    [self performSegueWithIdentifier:@"push" sender:nil];
}

- (void)textViewTapped:(UITapGestureRecognizer *)tap {
    
    aViewController *vc = [[aViewController alloc] init];
//    CYPushTransition *animatedTransition = [[CYPushTransition alloc] init];
//    [vc setCY_animatedTransition:animatedTransition withShowType:CYAnimatedTransitionControllerShowTypePresent forSourceViewController:self];
//    [self presentViewController:vc animated:YES completion:nil];
//    [self presentViewController:vc animated:YES completion:nil];
    [vc cy_presentFromTopViewControllerWithAnimated:YES];
}

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    ThirdViewController *detailVC = segue.destinationViewController;
 
    CYMagicMoveTransition *animatedTransition = [[CYMagicMoveTransition alloc] init];
    animatedTransition.sourceViewDataSource = self;
    animatedTransition.destinationViewDataSource = detailVC;
    [detailVC setCY_animatedTransition:animatedTransition withShowType:CYAnimatedTransitionControllerShowTypePresent forSourceViewController:self];
}


#pragma mark - CYMagicMoveTransitionDestinationViewDataSource

- (UIView *)destinationViewForCYAnimatedTransition:(CYBaseAnimatedTransition *_Nullable)animatedTransitio {

    return self.imageView;
}

- (UIPercentDrivenInteractiveTransition *)percentDrivenForCYInverseTransition:(CYInverseTransition *)animatedTransition {
    
    return animatedTransition.defaultPopPercentDriven;
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
