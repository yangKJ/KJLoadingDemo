# KJLoadingDemo

* 这个工程提供了一些iOS开发中用到的加载控件
* pod 'KJLoadingAnimationTool'


####版本更新日志：

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
