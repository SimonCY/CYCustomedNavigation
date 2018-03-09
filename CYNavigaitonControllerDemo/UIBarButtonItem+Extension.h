

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CYBarButtonItemType) {
  CYBarButtonItemTypeLeft,
  CYBarButtonItemTypeRight,
  CYBarButtonItemTypeBack,
};

#define cy_defaultItemWidth               25
#define cy_defaultItemHeight              25

#define cy_defaultItemTitleColorNormal    [UIColor darkTextColor]
#define cy_defaultItemTitleColorLighted   cy_RGBColor(204,204,204)
#define cy_defaultItemTitleColorDisable   cy_RGBColor(150,150,150)

#define cy_RGBColor(r, g, b)              cy_RGBAColor(r, g, b, 1)
#define cy_RGBAColor(r, g, b, a)          [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define cy_RandomColor cy_RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define cy_defaultBackItemImageNormal     @""
#define cy_defaultBackItemImageLighted    @""
#define cy_defaultBackItemImageDisable    @""

@interface UIBarButtonItem (Extension)


/**
 if the item is create by a button this method will return a UIButton object, else return nil.
 */
- (UIButton *)customButton;


+ (instancetype)rightItemWithImage:(NSString *)image Target:(id)target action:(SEL)action;

+ (instancetype)rightItemWithBackgroundImage:(NSString *)image Target:(id)target action:(SEL)action;

+ (instancetype)rightItemWithTitle:(NSString *)title Target:(id)target action:(SEL)action;


+ (instancetype)leftItemWithImage:(NSString *)image Target:(id)target action:(SEL)action;

+ (instancetype)leftItemWithBackgroundImage:(NSString *)image Target:(id)target action:(SEL)action;

+ (instancetype)leftItemWithtitle:(NSString *)title Target:(id)target action:(SEL)action;

/**
 create a left item with defaut back image
 */
+ (instancetype)backItemWithTarget:(id)target action:(SEL)action;




/**
 create a barButtonItem with normalImage only.
 */
+ (instancetype)itemWithImage:(NSString *)image
                         type:(CYBarButtonItemType)type
                       target:(id)target
                       action:(SEL)action;

/**
 create a barButtonItem with image only.
 */
+ (instancetype)itemWithImage:(NSString *)image
                 lightedImage:(NSString *)lightedImage
                 disableImage:(NSString *)disableImage
                         type:(CYBarButtonItemType)type
                       target:(id)target
                       action:(SEL)action;

/**
 create a barButtonItem with backgroundImage only.
 */
+ (instancetype)itemWithBackgroundImage:(NSString *)image
                                   type:(CYBarButtonItemType)type
                                 target:(id)target
                                 action:(SEL)action;

/**
 create a barButtonItem with backgroundImage only.
 */
+ (instancetype)itemWithBackgroundImage:(NSString *)backgroundImage
                 lightedBackgroundImage:(NSString *)lightedBackgroundImage
                 disableBackgroundImage:(NSString *)disableBackgroundImage
                                   type:(CYBarButtonItemType)type
                                 target:(id)target
                                 action:(SEL)action;
 
/**
 create a barButtonItem with title only and default titleColor
 */
+ (instancetype)itemWithTitle:(NSString *)title
                         type:(CYBarButtonItemType)type
                       target:(id)target
                       action:(SEL)action;

/**
  create a barButtonItem with title only.
 */
+ (instancetype)itemWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
            lightedTitleColor:(UIColor *)lightedTitleColor
                         type:(CYBarButtonItemType)type
                       target:(id)target
                       action:(SEL)action;




@end
