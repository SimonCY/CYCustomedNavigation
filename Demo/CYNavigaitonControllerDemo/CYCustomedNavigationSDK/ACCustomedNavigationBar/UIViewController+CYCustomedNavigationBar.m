//
//  UIViewController+ACCustomedNavigationBar.m
//  ArtCalendar
//
//  Created by chenyan on 2018/3/9.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "UIViewController+CYCustomedNavigationBar.h"
#import <objc/runtime.h>
#import "CYCustomedNavigationBar.h"

#define CYCustomedNavBarPropertyName "CYCustomedNavBarPropertyName"



@implementation UIViewController (CYCustomedNavigationBar)

#pragma mark - runtime

+ (void)load {
  
  cy_exchangeInstanceMethod([self class], @selector(viewDidLayoutSubviews), @selector(cy_viewDidLayoutSubviews));
}

- (void)cy_viewDidLayoutSubviews {
  [self cy_viewDidLayoutSubviews];
  
  if (self.cy_navigationBar) {
    
    [self.view bringSubviewToFront:self.cy_navigationBar];
    self.cy_navigationBar.frame = CGRectMake(0, 0, self.view.bounds.size.width,cy_customNavbarHeight);
  }
  
}

static void cy_exchangeInstanceMethod(Class class, SEL originalSelector, SEL newSelector) {
  
  Method originalMethod = class_getInstanceMethod(class, originalSelector);
  Method newMethod = class_getInstanceMethod(class, newSelector);
  if(class_addMethod(class, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
    
    class_replaceMethod(class, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
  } else {
    
    method_exchangeImplementations(originalMethod, newMethod);
  }
}

#pragma mark - setter

- (void)setCy_navigationBar:(CYCustomedNavigationBar *)navBar {
  
  CYCustomedNavigationBar *oldBar = self.cy_navigationBar;
  
  if (oldBar) {
    
    [oldBar removeFromSuperview];
  }
  
  if (navBar) {
    
    if (navBar.superview) {
      
      [navBar removeFromSuperview];
    }
    [self.view addSubview:navBar];
  }
  
  objc_setAssociatedObject(self, CYCustomedNavBarPropertyName, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CYCustomedNavigationBar *)cy_navigationBar {
 
  
  return (CYCustomedNavigationBar *)objc_getAssociatedObject(self, CYCustomedNavBarPropertyName);
}

@end
