//
//  KJLoading.h
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/20.
//  Copyright © 2019 杨科军. All rights reserved.
//  加载等待工具，部分数据来源于网络
//  使用方法：可在 KJLoadingDeploy 设置相关配置信息

#import <Foundation/Foundation.h>
#import "KJLoadingDeploy.h"
NS_ASSUME_NONNULL_BEGIN

@interface KJLoading : NSObject
+ (instancetype)kLoadingAnimation;
/// 背景图层，用于外界操作图层
@property(nonatomic,strong,readonly) UIView *kCoverView;
/// 开始动画
+ (void)kLoadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingDeploy*__nullable)configuration;
/// 开始动画
- (void)kLoadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingDeploy*__nullable)configuration;
/// 停止
+ (void)kLoadingAnimationStopAnimating;
/// 停止
- (void)kLoadingAnimationStopAnimating;

@end

NS_ASSUME_NONNULL_END
