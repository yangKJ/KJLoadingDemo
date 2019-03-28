//
//  KJLoadingAnimation.h
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/20.
//  Copyright © 2019 杨科军. All rights reserved.
//  加载等待工具

/*
 加载等待工具 - 二次封装整理，方便好用
 陆陆续续后续还会添加更多数据源
 部分数据来源于网络
 */

#import <Foundation/Foundation.h>
#import "KJLoadingAnmationConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJLoadingAnimation : NSObject

+ (instancetype)kLoadingAnimation;
/// 背景图层，用于外界操作图层
@property(nonatomic,strong,readonly) UIView *kCoverView;
/// 开始动画  __nullable 可以为空
+ (void)kLoadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingAnmationConfiguration*__nullable)configuration;
/// 停止
+ (void)kLoadingAnimationStopAnimating;

/// 开始动画  __nullable 可以为空
- (void)kLoadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingAnmationConfiguration*__nullable)configuration;
/// 停止
- (void)kLoadingAnimationStopAnimating;


@end

NS_ASSUME_NONNULL_END
