//
//  KJLoading.h
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/20.
//  Copyright © 2019 杨科军. All rights reserved.
//  加载等待工具，部分数据来源于网络
//  使用方法：可在 KJLoadingDeploy 设置相关配置信息
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
#import <Foundation/Foundation.h>
#import "KJLoadingDeploy.h"
NS_ASSUME_NONNULL_BEGIN

@interface KJLoading : NSObject
/// 背景图层，用于外界操作图层
@property(nonatomic,strong,readonly) UIView *kCoverView;
/// 初始化
+ (instancetype)kj_initLoadingAnimation;
/// 开始动画
+ (void)kj_loadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingDeploy*__nullable)configuration;
/// 开始动画
- (void)kj_loadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingDeploy*__nullable)configuration;
/// 停止
+ (void)kj_loadingAnimationStopAnimating;
/// 停止
- (void)kj_loadingAnimationStopAnimating;

@end

NS_ASSUME_NONNULL_END
