//
//  ACPresentedViewNavigationBar.h
//  ArtCalendar
//
//  Created by chenyan on 2018/3/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+CYCustomedNavigationBar.h"

#define cy_IS_IPHONEPlUS ([UIScreen mainScreen].bounds.size.width == 414 || [UIScreen mainScreen].bounds.size.height == 414)

#define cy_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define cy_NavbarHeight        (cy_isLandscape? ((cy_IS_IPHONEPlUS || cy_IS_IPAD) ? 44:32) : 44)
#define cy_StatusBarHeight     [[UIApplication sharedApplication] statusBarFrame].size.height
#define cy_customNavbarHeight  (cy_NavbarHeight + cy_StatusBarHeight)

#define cy_ScreenWidth         [UIScreen mainScreen].bounds.size.width
#define cy_ScreenHeight        [UIScreen mainScreen].bounds.size.height
#define cy_isLandscape         (cy_ScreenWidth > cy_ScreenHeight)


@interface CYCustomedNavigationBar : UIView

/**
 *  you can set leftItem, leftItems, title, titleView, rightItem, rightItems for the navigationBar throught navigationItem.
 */
@property (nonatomic, strong) UINavigationItem *navigationItem;

/**
 *  backgroundColor for navBar
 */
@property (nonatomic, strong) UIColor *barTintColor;

@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *titleTextAttributes NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign, getter=isShadowHidden) BOOL shadowHidden;

@end
