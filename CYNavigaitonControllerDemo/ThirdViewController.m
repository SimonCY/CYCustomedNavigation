//
//  ThirdViewController.m
//  CYNavigaitonControllerDemo
//
//  Created by Chenyan on 2017/12/18.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()<UINavigationControllerDelegate>

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate = self;
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
