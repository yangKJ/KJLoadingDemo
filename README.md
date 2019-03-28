# KJLoadingDemo

* 这个工程提供了一些iOS开发中用到的加载控件
* pod 'KJLoadingAnimationTool'

加载等待工具 - 二次封装整理，方便好用
陆陆续续后续还会添加更多数据源
部分数据啊来源于网络

####版本更新日志：

Add 1.0.3

-  优化调整，去除不必要的代码工作

Add 1.0.2

- 新增三种加载动画
- 1. 写文字，笔图片可换
- 2. 画爱心
- 3. 心电图   时间有限没怎么细调，有空再来优化
- 4. 播放指定图片 

Add 1.0.0

- KJLoadingAnimationTool内含 7 种加载动画，多种属性自定义调整
- 同样可以自定义，自定义动画素材需要继承自 KJLoadingAnmationConfiguration
- 然后重载如下方法：

```
- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor;
```
自定义素材使用方法：

```
KJLoadingAnmationConfiguration *loadingConfig = [KJLoadingAnmationConfiguration defaultLoadingAnmationConfiguration];
loadingConfig.class_name = @"KJCustom";  /// 继承的动画素材类名
loadingConfig.kType = KJLoadingAnimationTypeCustom;
[KJLoadingAnimationTool kLoadingAnimationStartAnimatingWithView:self.view Configuration:loadingConfig];

```
