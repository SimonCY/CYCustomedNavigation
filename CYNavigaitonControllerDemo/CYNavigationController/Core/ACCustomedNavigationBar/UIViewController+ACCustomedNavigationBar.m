//
//  UIViewController+ACCustomedNavigationBar.m
//  ArtCalendar
//
//  Created by chenyan on 2018/3/9.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "UIViewController+ACCustomedNavigationBar.h"
#import <objc/runtime.h>
#import "ACCustomedNavigationBar.h"

#define ACCustomedNavBarPropertyName "ACCustomedNavBarPropertyName"



@implementation UIViewController (ACCustomedNavigationBar)

#pragma mark - runtime

+ (void)load {
  
  cy_exchangeInstanceMethod([self class], @selector(viewDidLayoutSubviews), @selector(cy_viewDidLayoutSubviews));
}

- (void)cy_viewDidLayoutSubviews {
  [self cy_viewDidLayoutSubviews];
  
  if (self.navBar) {
    
    [self.view bringSubviewToFront:self.navBar];
    self.navBar.frame = CGRectMake(0, 0, self.view.bounds.size.width,cy_customNavbarHeight);
  }
  
}

void cy_exchangeInstanceMethod(Class class, SEL originalSelector, SEL newSelector) {
  
  Method originalMethod = class_getInstanceMethod(class, originalSelector);
  Method newMethod = class_getInstanceMethod(class, newSelector);
  if(class_addMethod(class, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
    
    class_replaceMethod(class, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
  } else {
    
    method_exchangeImplementations(originalMethod, newMethod);
  }
}

#pragma mark - setter

- (void)setNavBar:(ACCustomedNavigationBar *)navBar {
  
  ACCustomedNavigationBar *oldBar = self.navBar;
  
  if (oldBar) {
    
    [oldBar removeFromSuperview];
  }
  
  if (navBar) {
    
    if (navBar.superview) {
      
      [navBar removeFromSuperview];
    }
    [self.view addSubview:navBar];
  }
  
  objc_setAssociatedObject(self, ACCustomedNavBarPropertyName, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ACCustomedNavigationBar *)navBar {
 
  
  return (ACCustomedNavigationBar *)objc_getAssociatedObject(self, ACCustomedNavBarPropertyName);
}

@end
