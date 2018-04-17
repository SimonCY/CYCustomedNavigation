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

CYCustomNavigationBar可以让你在不适用UINavigationController时在ViewController中仍然拥有一个独立管理的、可以像适用navigationController时一样设置各种item的NavigationBar，默认适配iPhoneX。


* CYAnimatedTransition

CYAnimatedTransition是一个可拓展的转场动画库，动画对象同时适用于Push和Present两种新页面显示模式，支持默认手势返回和自定义手势返回。随SDK附赠一对“神奇效果”的动画，一对模仿系统Push的动画。

二者可以结合使用也可以根据需要单独集成某一项。

------------------------------------------------------
## Example
 
<div align=center><img width="270" height="480" src="https://img-blog.csdn.net/20180417103328832?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTQ2MDQxMDY=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"/></div>

## Usage


### Download

考虑到可能的代码扩充，项目暂时不进行CocoaPod集成方式的支持，集成时请直接Download zip文件，讲Demo中的CYCustomedNavigationSDK目录直接拖进自己的工程目录即可。


### 调用


#### CYCustomedNavigationBar


使用CYCustomedNavigationBar时,直接在ViewController中:

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


```objc
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

#### CYAnimatedTransition


CYAnimatedTransition在使用时也可做到无侵入，每个动画包含Forward正向动画和Inverse反向动画两部分，做动画库拓展时我们需要注意，下文会有所介绍，使用时我们的代码中只需涉猎到正向动画即可


导入主头文件


```objc
#import "CYAnimatedTransition.h"
 
```


* Present


为ViewController创建一个转场动画对象，并设置给ViewController

```objc
//自定义present
CYMagicMoveTransition *animatedTransition = [[CYMagicMoveTransition alloc] init];
animatedTransition.sourceViewDataSource = self;
animatedTransition.destinationViewDataSource = detailVC;
animatedTransition.delegate = detailVC;
[detailVC setCY_presentAnimatedTransition:animatedTransition];
```

然后像平时一样调用present


```objc
[self presentViewController:detailVC animated:YES completion:nil];
```


* Push


创建一个同样的转场动画对象，并设置给ViewController

```objc
//自定义push
CYMagicMoveTransition *animatedTransition = [[CYMagicMoveTransition alloc] init];
animatedTransition.sourceViewDataSource = self;
animatedTransition.destinationViewDataSource = detailVC;
animatedTransition.delegate = detailVC;
[detailVC setCY_pushAnimatedTransition:animatedTransition forSourceViewController:self];
```


然后像平时一样调用push


```objc
[self.navigationController pushViewController:detailVC animated:YES];
```

此外，SDK中还提供了一个方法，自动帮你找到当前显示的页面并将新页面从当前显示页面以Push动画效果Present出来，此方法可直接应用于组件化中模拟push。

```objc
[detailVC cy_presentFromTopViewControllerWithAnimated:YES];
```


* 关于sourceViewDataSource和destinationViewDataSource


类似于“神奇效果”动画一样，有的动画需要在动画过程中将前一个SourceViewController中的一个View移动到DestiationViewController中的另一个位置，为了做到无侵入，所以这里通过DataSource将这些View传递给动画。


* 关于sourceViewDataSource和destinationViewDataSource


有时，除了SourceViewDataSource提供的View之外，我们可能需要在DestinationViewController中在动画开始时做一些其他的UI控件的动画，或者在动画开始时或者结束时做一些其他的事情，此时可以用到以下两个delegate方法

```objc
@protocol CYAnimatedTransitionDelegate <NSObject>

@optional
/*
 * Sycn called before animation, you can add some UIViewAnimation for other view in this method and the UIViewAnimation-task's characteristic ,it would seem like to called asycn.
 */
- (void)CYAnimatedTransitionStartAnimatingWithAnimatedTransition:(CYBaseAnimatedTransition *_Nullable)animatedTransition;

- (void)CYAnimatedTransitionEndAnimatingWithAnimatedTransition:(CYBaseAnimatedTransition *_Nullable)animatedTransition;
@end
```


## Expansion


<table><tr><td bgcolor=#FF4500>
如果需要对动画库进行拓展，需要仔细阅读本段落
</td></tr></table>


CYAnimatedTransition核心共包含三个类CYBaseAnimatedTransition、CYForwardTransition、CYInverseTransition，其中CYBaseAnimatedTransition为核心基类，CYForwardTransition、CYInverseTransition分别为正向、反向动画的基类，其中处理了一些正反向动画区别的业务，和在正向动画被创建时自动为我们创建一个反向动画并设置数据，我们拓展时创建正反向动画应该分别继承自这两个父类。


下面将以demo中的CYMagicMoveTransition为例，说明我们在拓展动画库时需要做的工作。


* 1.新建类文件


按照Forward中自动帮我们创建反向动画对象的规则，在创建动画类文件时我们应分别命名为：

```objc
正向动画类:XXXTransition
反向动画类:XXXInverseTransition
```


* 2.内部实现


&emsp;&emsp;在动画对象内部重写父类的动画方法，按需实现动画细节，其中的sourceViewController和destinationViewController是转场动画发生时系统自动帮我们获取的，sourceView和destinationView是我们通过上文提到的DataSource自定义获取到的，在动画结束时，须调用

```objc
[self transitionComplete];
```

进行收尾处理。在反向动画内部同理，只不过反向动画内部是把dimiss或者pop当做正向。示例如下：

```objc
#import "CYMagicMoveTransition.h"

@interface CYMagicMoveTransition()

@end

@implementation CYMagicMoveTransition

#pragma mark - cover from super-class

- (void)animateTransition {
    [super animateTransition];
    
    // Get sourceView, destinationView and create sourceView's snapShot.
    UIView *snapShotView = [self.sourceView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [self.containerView convertRect:self.sourceView.frame fromView:self.sourceView.superview];
    snapShotView.layer.cornerRadius = 20;
    
    //Setup toVC before animating.
    self.destinationViewController.view.frame = [self.transitionContext finalFrameForViewController:self.destinationViewController];
    self.destinationViewController.view.alpha = 0;

    //Start animating.
    [self.containerView addSubview:self.destinationViewController.view];
    [self.containerView addSubview:snapShotView];
    [self.containerView layoutIfNeeded];

    self.sourceView.hidden = YES;
    self.destinationView.hidden = YES;

    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{

        
        snapShotView.layer.cornerRadius = 0;
        self.destinationViewController.view.alpha = 1.0;
        snapShotView.frame = [self.containerView convertRect:self.destinationView.frame fromView:self.destinationView.superview];

    } completion:^(BOOL finished) {

        self.sourceView.hidden = NO;
        self.destinationView.hidden = NO;
        [snapShotView removeFromSuperview];
        [self transitionComplete];
    }];
}
@end
```


* 关于push和present自定义动画的异同


附上两张结构图：

<div align=center><img width="700" height="315" src="https://github.com/SimonCY/CYNavigaitonController/raw/master/Img/structure_present.jpeg"/></div>


<div align=center><img width="700" height="430" src="https://github.com/SimonCY/CYNavigaitonController/raw/master/Img/structure_push.jpeg"/></div>
 
 
## <a id="Hope"></a>Hope
* If you find bug when used，Hope you can Issues me，Thank you or try to download the latest code of this framework to see the BUG has been fixed or not）
* If you find the function is not enough when used，Hope you can Issues me，I very much to add more useful function to this framework ，Thank you !
* 如果使用过程中发现任何问题，欢迎issue我，我会尽快解决。
* 如果在需求上有任何的意见或者建议，也欢迎issue提出，非常感谢！
## Contact to me
* QQ:397604080  
 
## License

The MIT License (MIT) - see [LICENSE](LICENSE) file.
