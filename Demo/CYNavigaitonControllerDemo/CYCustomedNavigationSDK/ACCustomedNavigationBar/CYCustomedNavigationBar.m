//
//  ACPresentedViewNavigationBar.m
//  ArtCalendar
//
//  Created by chenyan on 2018/3/7.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "CYCustomedNavigationBar.h"

#define CYPresentedViewNavigationBarDefaultBarTintColor [UIColor colorWithWhite:246 / 255.0 alpha:1]

@interface CYCustomedNavigationBar ()

@property (nonatomic, strong) UINavigationBar *navBar;

@end

@implementation CYCustomedNavigationBar

#pragma mark - system

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self commonSetup];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self commonSetup];
  }
  return self;
}

- (void)commonSetup {
  
  //navBar
  self.navBar = [[UINavigationBar alloc] init];
  if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
    self.navBar.translucent = NO;
  }
  [self addSubview:self.navBar];
 
  //items container
  self.navigationItem = [[UINavigationItem alloc] init];
  [self.navBar pushNavigationItem:self.navigationItem animated:NO];
 
  //defaultData
  self.barTintColor = CYPresentedViewNavigationBarDefaultBarTintColor;
  self.shadowHidden = NO;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  self.frame = CGRectMake(0, 0, self.superview.bounds.size.width, cy_customNavbarHeight);
  self.navBar.frame = CGRectMake(0, cy_StatusBarHeight, self.bounds.size.width, cy_NavbarHeight);
}

#pragma mark - touch

//过滤掉触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
}

#pragma mark - setter

- (void)setShadowHidden:(BOOL)shadowHidden {

  _shadowHidden = shadowHidden;
  self.navBar.shadowImage = _shadowHidden? [UIImage new] : nil;
}

- (void)setBarTintColor:(UIColor *)barTintColor {
  _barTintColor = barTintColor;
  
  self.navBar.barTintColor = barTintColor;
  self.backgroundColor = barTintColor;
  
  if (barTintColor == [UIColor clearColor]) {
    
    [self.navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
      self.navBar.translucent = YES;
    }
  } else {
    [self.navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
      self.navBar.translucent = NO;
    }
  }
}

@end
