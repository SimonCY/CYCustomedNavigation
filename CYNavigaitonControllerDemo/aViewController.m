//
//  aViewController.m
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/5.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "aViewController.h"
#import "ACCustomedNavigationBar.h"
#import "bViewController.h"
#import "CYAnimatedTransition.h"

@interface aViewController ()

@end

@implementation aViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navBar = [[ACCustomedNavigationBar alloc] init];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    static BOOL jump = YES;
//    if (jump) {
//        jump = NO;
//    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
            bViewController *b = [[bViewController alloc] init];
            [b cy_presentFromTopViewControllerWithAnimated:YES];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
