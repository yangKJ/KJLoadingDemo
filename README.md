# KJLoadingDemo
![coverImage](https://upload-images.jianshu.io/upload_images/1933747-b7e843a01999b9a9.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

加载控件，基于CALayer封装加载等待动画  
陆陆续续后续还会添加更多数据源，部分数据来源于网络    

----------------------------------------
### 框架整体介绍
* [作者信息](#作者信息)
* [作者其他库](#作者其他库)
* [功能介绍](#功能介绍)
* [Cocoapods安装](#Cocoapods安装)
* [更新日志](#更新日志)
* [效果图](#效果图)
* [打赏作者 &radic;](#打赏作者)

----------------------------------------

#### <a id="作者信息"></a>作者信息
> Github地址：https://github.com/yangKJ  
> 简书地址：https://www.jianshu.com/u/c84c00476ab6  
> 博客地址：https://blog.csdn.net/qq_34534179  

#### <a id="作者其他库"></a>作者其他Pod库
```
/*
*********************************************************************************
*
*⭐️⭐️⭐️ ----- 本人其他库 ----- ⭐️⭐️⭐️
*
粒子效果、自定义控件、自定义选中控件
pod 'KJEmitterView'
pod 'KJEmitterView/Control' # 自定义控件
 
扩展库 - Button图文混排、点击事件封装、扩大点击域、点赞粒子效果，
手势封装、圆角渐变、倒影、投影、内阴影、内外发光、渐变色滑块等，
图片压缩加工处理、滤镜渲染、泛洪算法、识别网址超链接等等
pod 'KJExtensionHandler'
pod 'KJExtensionHandler/Foundation'

基类库 - 封装整理常用，采用链式处理，提炼独立工具
pod 'KJBaseHandler'
pod 'KJBaseHandler/Tool' # 工具相关

播放器 - KJPlayer是一款视频播放器，AVPlayer的封装，继承UIView
视频可以边下边播，把播放器播放过的数据流缓存到本地，下次直接从缓冲读取播放
pod 'KJPlayer'  # 播放器功能区
pod 'KJPlayer/KJPlayerView'  # 自带展示界面

轮播图 - 支持缩放 多种pagecontrol 支持继承自定义样式 自带网络加载和缓存
pod 'KJBannerView'  # 轮播图，网络图片加载 支持网络GIF和网络图片和本地图片混合轮播

加载Loading - 多种样式供选择 HUD控件封装
pod 'KJLoading' # 加载控件

菜单控件 - 下拉控件 选择控件
pod 'KJMenuView' # 菜单控件

工具库 - 推送工具、网络下载工具、识别网页图片工具等
pod 'KJWorkbox' # 系统工具
pod 'KJWorkbox/CommonBox'
 
Github地址：https://github.com/yangKJ
简书地址：https://www.jianshu.com/u/c84c00476ab6
博客地址：https://blog.csdn.net/qq_34534179
 
* 如果觉得好用,希望您能Star支持,你的 ⭐️ 是我持续更新的动力!
*
*********************************************************************************
*/
```
#### <a id="Cocoapods安装"></a>Cocoapods安装
```
pod 'KJLoading'
pod 'KJLoading/KJProgressHUD'
```
#### <a id="更新日志"></a>更新日志
```
####版本更新日志：
##### Add 1.2.4
###### 重新整理，规范方法名

##### Add 1.2.0
###### 新增属性 kDismiss 和 kDismissTime 是否开启消失动画和消失时间

##### Add 1.1.1
###### 新增时间沙漏加载动画、错位旋转、渐变蛇 三种素材

##### Add 1.1.0
###### 优化调整，去除不必要的代码工作

##### Add 1.0.2
###### 新增三种加载动画    
1. 写文字，笔图片可换    
2. 画爱心    
3. 心电图   时间有限没怎么细调，有空再来优化    
4. 播放指定图片    

##### Add 1.0.0
KJLoading 内含 7 种加载动画，多种属性自定义调整    
同样可以自定义，自定义动画素材需要继承自 KJLoadingDeploy   
```

#### <a id="打赏作者"></a>打赏作者
* 如果你觉得有帮助，还请为我Star
* 如果在使用过程中遇到Bug，希望你能Issues，我会及时修复
* 大家有什么需要添加的功能，也可以给我留言，有空我将补充完善
* 谢谢大家的支持 - -！

[![谢谢老板](https://upload-images.jianshu.io/upload_images/1933747-879572df848f758a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)](https://github.com/yangKJ/KJPlayerDemo)


#### 救救孩子吧，谢谢各位老板～～～～

###### 然后重载如下方法
```ruby
- (void)kj_setAnimationFromLayer:(CALayer*)layer Size:(CGSize)size Color:(UIColor*)tintColor
```
###### 自定义素材使用方法
```ruby
KJLoadingDeploy *loadingConfig = [KJLoadingDeploy kj_defaultLoadingDeploy];
loadingConfig.class_name = @"KJCustom";  /// 继承的动画素材类名
loadingConfig.kType = KJLoadingAnimationTypeCustom;
[KJLoading kLoadingAnimationStartAnimatingWithView:self.view Configuration:loadingConfig];
```
---
### 问题总结
##### 1、xib布局，如果遇见视图显示错位，并不在父视图中心位置。
###### 解决方案：重置父视图frame

---
