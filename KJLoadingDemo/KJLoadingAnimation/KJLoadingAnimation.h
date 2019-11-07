//
//  KJLoadingAnimation.h
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/20.
//  Copyright © 2019 杨科军. All rights reserved.
//  加载等待工具
/*------------- 本人其他库 -------------
 播放器 - KJPlayer是一款视频播放器，AVPlayer的封装，继承UIView
 - 视频可以边下边播，把播放器播放过的数据流缓存到本地，下次直接从缓冲读取播放
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
 
 
 Github地址：https://github.com/yangKJ
 简书地址：https://www.jianshu.com/u/c84c00476ab6
 博客地址：https://blog.csdn.net/qq_34534179

 加载等待工具 - 二次封装整理，方便好用
 陆陆续续后续还会添加更多数据源
 部分数据来源于网络
 
 使用方法：
 可在 KJLoadingConfiguration 设置相关配置信息
 */

#import <Foundation/Foundation.h>
#import "KJLoadingConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJLoadingAnimation : NSObject

+ (instancetype)kLoadingAnimation;
/// 背景图层，用于外界操作图层
@property(nonatomic,strong,readonly) UIView *kCoverView;
/// 开始动画  __nullable 可以为空
+ (void)kLoadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingConfiguration*__nullable)configuration;
/// 停止
+ (void)kLoadingAnimationStopAnimating;

/// 开始动画  __nullable 可以为空
- (void)kLoadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingConfiguration*__nullable)configuration;
/// 停止
- (void)kLoadingAnimationStopAnimating;


@end

NS_ASSUME_NONNULL_END
