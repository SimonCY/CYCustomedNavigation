//
//  aViewController.m
//  CYNavigaitonControllerDemo
//
//  Created by chenyan on 2018/4/17.
//  Copyright © 2018年 DeepAI. All rights reserved.
//

#import "aViewController.h"
#import "CYCustomedNavigationBar.h"

@interface aViewController ()

@end

@implementation aViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.cy_navigationBar = [[CYCustomedNavigationBar alloc] init];
    self.cy_navigationBar.barTintColor = [UIColor blueColor];
    self.cy_navigationBar.navigationItem.title = @"aViewController";
    self.cy_navigationBar.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.cy_navigationBar.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回到首页" style:UIBarButtonItemStyleDone target:self action:@selector(backToListView)];
}


#pragma mark - item clicked events
- (void)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)backToListView {
 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissNotification" object:nil userInfo:nil];
 
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [super dismissViewControllerAnimated:flag completion:completion];
    
}


@end
