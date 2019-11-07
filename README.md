# KJLoadingDemo
![coverImage](https://upload-images.jianshu.io/upload_images/1933747-b7e843a01999b9a9.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这个工程提供了一些iOS开发中用到的加载控件    
基于CALayer封装加载等待动画 - 加载等待工具    
陆陆续续后续还会添加更多数据源    
部分数据来源于网络    

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
播放器 - KJPlayer是一款视频播放器，AVPlayer的封装，继承UIView
- 支持播放网络和本地视频、播放多种格式
- 视频可以边下边播，把播放器播放过的数据流缓存到本地，下次直接从缓冲读取播放
- 支持拖动、手势快进倒退、增大减小音量、重力感应切换横竖屏等等
pod 'KJPlayer'  # 播放器功能区
pod 'KJPlayer/KJPlayerView'  # 自带展示界面

实用又方便的Category和自定义控件(Switch、选择控件等等)
pod 'KJEmitterView'
pod 'KJEmitterView/Function'#
pod 'KJEmitterView/Control' # 自定义控件

轮播图 - 支持缩放 多种pagecontrol 支持继承自定义样式 自带网络加载和缓存
pod 'KJBannerView'  # 轮播图，网络图片加载 支持网络GIF和网络图片和本地图片混合轮播

加载Loading - 多种样式供选择 HUD控件封装
pod 'KJLoadingAnimation' # 加载控件

菜单控件 - 下拉控件 选择控件
pod 'KJMenuView' # 菜单控件

```

##### Issue
如果您在使用中有好的需求及建议，或者遇到什么bug，欢迎随时issue，我会及时的回复，有空也会不断优化更新这些库

#### <a id="Cocoapods安装"></a>Cocoapods安装
```
pod 'KJLoadingAnimation'
pod 'KJLoadingAnimation/KJProgressHUD'
```

#### <a id="更新日志"></a>更新日志
```
####版本更新日志：

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
KJLoadingAnimation 内含 7 种加载动画，多种属性自定义调整    
同样可以自定义，自定义动画素材需要继承自 KJLoadingConfiguration   
```

#### <a id="打赏作者"></a>打赏作者
* 如果你觉得有帮助，还请为我Star
* 如果在使用过程中遇到Bug，希望你能Issues，我会及时修复
* 大家有什么需要添加的功能，也可以给我留言，有空我将补充完善
* 谢谢大家的支持 - -！

[![谢谢老板](https://upload-images.jianshu.io/upload_images/1933747-879572df848f758a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)](https://github.com/yangKJ/KJPlayerDemo)


#### 救救孩子吧，谢谢各位老板～～～～


###### 然后重载如下方法：

```ruby
- (void)setupAnimationInLayer:(CALayer *)layer 
withSize:(CGSize)size tintColor:(UIColor *)tintColor;
```
###### 自定义素材使用方法：

```ruby
KJLoadingConfiguration *loadingConfig = [KJLoadingConfiguration defaultLoadingConfiguration];
loadingConfig.class_name = @"KJCustom";  /// 继承的动画素材类名
loadingConfig.kType = KJLoadingAnimationTypeCustom;
[KJLoadingAnimation kLoadingAnimationStartAnimatingWithView:self.view Configuration:loadingConfig];

```
#### 温馨提示
#####1、使用第三方库Xcode报错  
Cannot synthesize weak property because the current deployment target does not support weak references  
可在`Podfile`文件底下加入下面的代码，'8.0'是对应的部署目标（deployment target） 删除库重新Pod  
不支持用weak修饰属性，而weak在使用ARC管理引用计数项目中才可使用  
遍历每个develop target，将target支持版本统一设成一个支持ARC的版本

```
##################加入代码##################
# 使用第三方库xcode报错Cannot synthesize weak property because the current deployment target does not support weak references
post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
end
end
end
##################加入代码##################
```
#####2、若搜索不到库
- 方案1：可执行pod repo update
- 方案2：使用 rm ~/Library/Caches/CocoaPods/search_index.json 移除本地索引然后再执行安装
- 方案3：更新一下 CocoaPods 版本

---
遇见的bug：
##### 1、xib布局，如果遇见视图显示错位，并不在父视图中心位置。
###### 解决方案：重置父视图frame

---
