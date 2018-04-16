![这里写图片描述](https://github.com/SimonCY/CYNavigaitonController/raw/master/Img/logo.png)


## What is CYNavigationController ?
![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)&nbsp; 
![License MIT](https://img.shields.io/badge/support-iOS%208%2B-orange.svg)&nbsp; 
![License MIT](https://img.shields.io/badge/support-iPhoneX-ff69b4.svg)&nbsp; 
 
### 应用场景

* 场景1

&emsp;&emsp;采用组件化路由协议架构APP，有时可能需要根据URI跳转到任意界面，考虑到当前显示的父级Controller的不确定性，这种业务场景是复杂的，如果当前展示的ViewController不是基于Controller管理的，就只能使用Present方式弹出新页面，而默认的Present动画在一般场景下又显得比较突兀；而且有时，在新的页面不在某个NavigationController管理下，此时我们仍然需要它具有一个导航栏，所以如果我们需要根据各种情况，去用不同的方法来实现相同效果的，容易造成混乱。

&emsp;&emsp;CYNavigationController正好提供了这样一套解决方案，在项目中我们可以不嵌套一层导航控制器，而是通过CYAnimatedTransition自定义Present动画模拟Push，用CYCustomedNavigationBar单独为每个页面实现一个导航栏，这样就可以采用统一的方式对包括协议跳转的页面在内的这些页面进行管理，做到同UINavigationController一样的显示效果。

* 场景2

&emsp;&emsp;CYAnimatedTransition可以单独集成使用，的自定义拓展性比较强，可以根据需求进行Push和Present动画的自定义，拓展的详细方法下文会有介绍，SDK默认包含一个“神奇效果”动画，一个“push”动画可以直接使用和作为自定义动画的示例参考，动画对象一经创建，在Present和push场景下通用。

* 场景3

&emsp;&emsp;CYCustomedNavigationBar也可以单独集成使用，在UINavigationController涉猎不到的某个页面仍然需要一个导航栏，不一定非要为这个页面再单独嵌套一层导航控制器，也不必担心通过自定义View来制作导航栏添加按钮和设置样式的繁琐，CYCustomedNavigationBar可以让你在没有导航控制器支持的ViewController中像使用系统导航控制器一样拥有一个导航栏，并且是自己独立管理的。


### CYNavigationControllerSDK包含两部分：
 
* CYCustomedNavigationBar

&emsp;&emsp;CYCustomNavigationBar可以让你在不适用UINavigationController时在ViewController中仍然拥有一个独立管理的、可以像适用navigationController时一样设置各种item的NavigationBar，默认适配iPhoneX。

* CYAnimatedTransition

&emsp;&emsp;CYAnimatedTransition是一个可拓展的转场动画库，动画对象同时适用于Push和Present两种新页面显示模式，支持默认手势返回和自定义手势返回。随SDK附赠一对“神奇效果”的动画，一对模仿系统Push的动画。

二者可以结合使用也可以根据需要单独集成某一项。

------------------------------------------------------
## Example
 
<div align=center><img width="270" height="480" src="https://github.com/SimonCY/CYNavigaitonController/raw/master/Img/screenshot.gif"/></div>


<div align=center><img width="700" height="315" src="https://github.com/SimonCY/CYNavigaitonController/raw/master/Img/structure_present.jpeg"/></div>


<div align=center><img width="700" height="430" src="https://github.com/SimonCY/CYNavigaitonController/raw/master/Img/structure_push.jpeg"/></div>
 

## Usage

#### Download

&emsp;&emsp;考虑到可能的代码扩充，项目暂时不进行CocoaPod集成方式的支持，集成时请直接Download zip文件，讲Demo中的CYCustomedNavigationSDK目录直接拖进自己的工程目录即可。

#### 调用

* CYCustomedNavigationBar

&emsp;&emsp;使用CYCustomedNavigationBar时,直接在ViewController中:

```objc
#import "aViewController.h"
#import "CYCustomedNavigationBar.h"

@interface aViewController ()

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //当此页面需要一个导航栏时，需要手动创建
    self.cy_navigationBar = [[CYCustomedNavigationBar alloc] init];
    
    //设置导航栏title
    self.cy_navigationBar.navigationItem.title = @"present模仿push动画";
 
    //设置导航栏背景颜色
    self.cy_navigationBar.barTintColor = [UIColor orangeColor];
    
    //leftItem
    self.cy_navigationBar.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithTarget:self action:@selector(backItemClicked)];
    
}

@end
```

其中各种Item的颜色、字体等的主题设置已然生效，但是导航栏的背景必须由cy_navigationBar.barTintColor来设置。

```
//title
UINavigationBar *appearance = [UINavigationBar appearance];
NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18 weight:2];
[appearance setTitleTextAttributes:textAttrs];
   
//item
UIBarButtonItem *appearance = [UIBarButtonItem appearance];
[appearance setTintColor:[UIColor whiteColor]];
NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
[appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];

```
* CYAnimatedTransition

&emsp;&emsp;

## Expansion

 
#### 1.单个使用

```objc
CYPromptCoverView *cover = [[CYPromptCoverView alloc] initWithBgColor:[UIColor colorWithWhite:0 alpha:0.5] revealView:self.typeBtn revealType:CYPromptCoverViewRevealTypeOval layoutType:CYPromptCoverViewLayoutTypeRightDown];
cover.des = @"000000000000";
cover.detailDes = @"3s 4s 5s";
cover.delegate = self;
[Cover showInView:self.view];
```
 
## <a id="Hope"></a>Hope
* If you find bug when used，Hope you can Issues me，Thank you or try to download the latest code of this framework to see the BUG has been fixed or not）
* If you find the function is not enough when used，Hope you can Issues me，I very much to add more useful function to this framework ，Thank you !
* 如果使用过程中发现任何问题，欢迎issue我，我会尽快解决。
* 如果在需求上有任何的意见或者建议，也欢迎issue提出，非常感谢！
## Contact to me
* QQ:397604080  
 
## License

The MIT License (MIT) - see [LICENSE](LICENSE) file.
