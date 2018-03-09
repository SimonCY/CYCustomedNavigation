//
//  ACPresentedViewNavigationBar.h
//  ArtCalendar
//
//  Created by chenyan on 2018/3/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ACCustomedNavigationBar.h"

@interface ACCustomedNavigationBar : UIView

/**
 *  you can set leftItem, leftItems, title, titleView, rightItem, rightItems for the navigationBar throught navigationItem.
 */
@property (nonatomic, strong) UINavigationItem *navigationItem;

@property (nonatomic, strong) UIColor *barTintColor;

@property (nonatomic, assign, getter=isShadowHidden) BOOL shadowHidden;

@end
