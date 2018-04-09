

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

#pragma mark - public

- (UIButton *)customButton
{
  if (self.customView && [self.customView isKindOfClass:[UIButton class]])
  {
    return (UIButton *)self.customView;
  }
  else if (self.customView.subviews.count && [self.customView.subviews[0] isKindOfClass:[UIButton class]])
  {
    return self.customView.subviews[0];
  }
  else
  {
    return nil;
  }
}

+ (instancetype)rightItemWithImage:(NSString *)image Target:(id)target action:(SEL)action
{
  return [self itemWithImage:image type:CYBarButtonItemTypeRight target:target action:action];
}

+ (instancetype)rightItemWithBackgroundImage:(NSString *)backgroundImage Target:(id)target action:(SEL)action
{
  return [self itemWithBackgroundImage:backgroundImage type:CYBarButtonItemTypeRight target:target action:action];
}

+ (instancetype)rightItemWithTitle:(NSString *)title Target:(id)target action:(SEL)action
{
  return [self itemWithTitle:title type:CYBarButtonItemTypeRight target:target action:action];
}


+ (instancetype)leftItemWithImage:(NSString *)image Target:(id)target action:(SEL)action
{
  return [self itemWithImage:image type:CYBarButtonItemTypeLeft target:target action:action];
}

+ (instancetype)leftItemWithBackgroundImage:(NSString *)backgroundImage Target:(id)target action:(SEL)action
{
  return [self itemWithBackgroundImage:backgroundImage type:CYBarButtonItemTypeLeft target:target action:action];
}

+ (instancetype)leftItemWithtitle:(NSString *)title Target:(id)target action:(SEL)action
{
  return [self itemWithTitle:title type:CYBarButtonItemTypeLeft target:target action:action];
}


+ (instancetype)backItemWithTarget:(id)target action:(SEL)action
{
  return [self itemWithImage:cy_defaultBackItemImageNormal lightedImage:cy_defaultBackItemImageNormal disableImage:cy_defaultBackItemImageDisable type:CYBarButtonItemTypeBack target:target action:action];
}


/**
 create a barButtonItem with image only.
 */
+ (instancetype)itemWithImage:(NSString *)image
                         type:(CYBarButtonItemType)type
                       target:(id)target
                       action:(SEL)action
{
  return [self itemWithImage:image lightedImage:nil disableImage:nil type:type target:target action:action];
}

/**
 create a barButtonItem with image only.
 */
+ (instancetype)itemWithBackgroundImage:(NSString *)image
                                   type:(CYBarButtonItemType)type
                                 target:(id)target
                                 action:(SEL)action
{
  return [self itemWithBackgroundImage:image lightedBackgroundImage:nil disableBackgroundImage:nil type:type target:target action:action];
}

/**
 create a barButtonItem with image only.
 */
+ (instancetype)itemWithImage:(NSString *)image
                 lightedImage:(NSString *)lightedImage
                 disableImage:(NSString *)disableImage
                         type:(CYBarButtonItemType)type
                       target:(id)target
                       action:(SEL)action
{
  UIButton *button = [self buttonWithImage:image lightedImage:lightedImage disableImage:disableImage backgroundImage:nil lightedBackgroundImage:nil disableBackgroundImage:nil title:nil titleColor:nil lightedTitleColor:nil target:target action:action];
 
  switch (type) {
    case CYBarButtonItemTypeLeft:
      
      button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//      button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0,0);
      break;
      
    case CYBarButtonItemTypeRight:
      
      button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
      break;
      
    case CYBarButtonItemTypeBack:
      
      button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//      button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0,0);
      break;
      
    default:
      break;
  }

  UIView *frameLimitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cy_defaultItemWidth, cy_defaultItemHeight)];
  frameLimitView.backgroundColor = [UIColor clearColor];
  [frameLimitView addSubview:button];
  
  return [[UIBarButtonItem alloc] initWithCustomView:frameLimitView];
}

/**
 create a barButtonItem with backgroundImage only.
 */
+ (instancetype)itemWithBackgroundImage:(NSString *)backgroundImage
                 lightedBackgroundImage:(NSString *)lightedBackgroundImage
                 disableBackgroundImage:(NSString *)disableBackgroundImage
                         type:(CYBarButtonItemType)type
                       target:(id)target
                       action:(SEL)action
{
  UIButton *button = [self buttonWithImage:nil lightedImage:nil disableImage:nil backgroundImage:backgroundImage lightedBackgroundImage:lightedBackgroundImage disableBackgroundImage:disableBackgroundImage title:nil titleColor:nil lightedTitleColor:nil target:target action:action];
  
  switch (type) {
    case CYBarButtonItemTypeLeft:
      
      button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
      //      button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0,0);
      break;
      
    case CYBarButtonItemTypeRight:
      
      button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
      break;
      
    case CYBarButtonItemTypeBack:
      
      button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
      //      button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0,0);
      break;
      
    default:
      break;
  }
  
  UIView *frameLimitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cy_defaultItemWidth, cy_defaultItemHeight)];
  frameLimitView.backgroundColor = [UIColor clearColor];
  [frameLimitView addSubview:button];
  
  return [[UIBarButtonItem alloc] initWithCustomView:frameLimitView];
}

/**
 create a barButtonItem with title only and default titleColor
 */
+ (instancetype)itemWithTitle:(NSString *)title
                         type:(CYBarButtonItemType)type
                       target:(id)target
                       action:(SEL)action
{
  return [self itemWithTitle:title titleColor:cy_defaultItemTitleColorNormal lightedTitleColor:cy_defaultItemTitleColorLighted type:type target:target action:action];
}


/**
 create a barButtonItem with title only.
 */
+ (instancetype)itemWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
            lightedTitleColor:(UIColor *)lightedTitleColor
                         type:(CYBarButtonItemType)type
                       target:(id)target
                       action:(SEL)action
{
  UIButton *button = [self buttonWithImage:nil lightedImage:nil disableImage:nil backgroundImage:nil lightedBackgroundImage:nil disableBackgroundImage:nil title:title titleColor:titleColor lightedTitleColor:lightedTitleColor target:target action:action];
  
  switch (type) {
    case CYBarButtonItemTypeLeft:
      
      button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
      break;
      
    case CYBarButtonItemTypeRight:
      
      button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
      break;
      
    case CYBarButtonItemTypeBack:
      
      button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
      break;
      
    default:
      break;
  }

  UIView *frameLimitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cy_defaultItemWidth, cy_defaultItemHeight)];
  frameLimitView.backgroundColor = [UIColor clearColor];
  [frameLimitView addSubview:button];
  
  return [[UIBarButtonItem alloc] initWithCustomView:frameLimitView];
}


#pragma mark - pravite

+ (UIButton *)buttonWithImage:(NSString *)image
                 lightedImage:(NSString *)lightedImage
                 disableImage:(NSString *)disableImage
              backgroundImage:(NSString *)backgroundImage
       lightedBackgroundImage:(NSString *)lightedBackgroundImage
       disableBackgroundImage:(NSString *)disableBackgroundImage
                        title:(NSString *)title
                   titleColor:(UIColor *)titleColor
            lightedTitleColor:(UIColor *)lightedTitleColor
                       target:(id)target
                       action:(SEL)action
{
  UIButton *button = [[UIButton alloc] init];
  
  [button setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
  [button setImage:[[UIImage imageNamed:lightedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
  [button setImage:[[UIImage imageNamed:disableImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateDisabled];
 
  [button setBackgroundImage:[[UIImage imageNamed:backgroundImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
  [button setBackgroundImage:[[UIImage imageNamed:lightedBackgroundImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
  [button setBackgroundImage:[[UIImage imageNamed:disableBackgroundImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateDisabled];
  
  button.frame = CGRectMake(0, 0, cy_defaultItemWidth, cy_defaultItemHeight);
  
  [button.titleLabel setFont:[UIFont systemFontOfSize:17]];
  [button setTitle:title forState:UIControlStateNormal];
  
  if (titleColor && [titleColor isKindOfClass:[UIColor class]])
  {
    [button setTitleColor:titleColor forState:UIControlStateNormal];
  }
  else
  {
    [button setTitleColor:cy_defaultItemTitleColorNormal forState:UIControlStateNormal];
  }
  
  if (lightedTitleColor && [lightedTitleColor isKindOfClass:[UIColor class]])
  {
    [button setTitleColor:lightedTitleColor forState:UIControlStateHighlighted];
  }
  else
  {
    [button setTitleColor:cy_defaultItemTitleColorLighted forState:UIControlStateHighlighted];
  }
  
  [button setTitleColor:cy_defaultItemTitleColorDisable forState:UIControlStateDisabled];
  
  if (target && [target respondsToSelector:action])
  {
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  }
  return button;
}


@end
