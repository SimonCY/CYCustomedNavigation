![这里写图片描述](https://github.com/SimonCY/CYNavigaitonController/raw/master/Img/logo.png)

#### CYNavigationControllerSDK包含两部分：


* CYCustomedNavigationBar

&emsp;&emsp;CYCustomNavigationBar可以让你在不适用UINavigationController时在ViewController中仍然拥有一个独立管理的NavigationBar。

* CYAnimatedTransition

&emsp;&emsp;CYAnimatedTransition是一个可拓展的转场动画库，动画对象同时适用于Push和Present两种新页面显示模式。随SDK附赠一对“神奇效果”的动画，一对模仿系统Push的动画。


[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/AAChartModel/AAChartKit/blob/master/AAChartKit/ChartsDemo/LICENSE)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%208%2B-ff69b4.svg)](https://www.apple.com/nl/ios/)&nbsp;

------------------------------------------------------
## example
 
 ![Support](https://github.com/SimonCY/CYNavigaitonController/raw/master/Img/screenshot.gif)
 　<center>动画效果示例</center>


## Usage

## expansion

 
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
