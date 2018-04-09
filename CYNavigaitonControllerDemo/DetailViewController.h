//
//  DetailViewController.h
//  CYNavigaitonControllerDemo
//
//  Created by DeepAI on 2017/11/20.
//  Copyright © 2017年 DeepAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYAnimatedTransition.h"

@interface DetailViewController : UIViewController <CYAnimatedTransitionDestinationViewDataSource,CYAnimatedTransitionDelegate>

@property (nonatomic, assign) BOOL isNeedCY_customedNavigationBar;

@end
