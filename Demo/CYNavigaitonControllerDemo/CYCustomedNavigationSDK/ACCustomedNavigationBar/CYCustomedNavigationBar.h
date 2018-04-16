//
//  ACPresentedViewNavigationBar.h
//  ArtCalendar
//
//  Created by chenyan on 2018/3/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+CYCustomedNavigationBar.h"

#define cy_NavbarHeight        44
#define cy_customNavbarHeight  (cy_NavbarHeight + cy_StatusBarHeight)
#define cy_StatusBarHeight     [[UIApplication sharedApplication] statusBarFrame].size.height

@interface CYCustomedNavigationBar : UIView

/**
 *  you can set leftItem, leftItems, title, titleView, rightItem, rightItems for the navigationBar throught navigationItem.
 */
@property (nonatomic, strong) UINavigationItem *navigationItem;

/**
 *  backgroundColor for navBar
 */
@property (nonatomic, strong) UIColor *barTintColor;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign, getter=isShadowHidden) BOOL shadowHidden;

@end
