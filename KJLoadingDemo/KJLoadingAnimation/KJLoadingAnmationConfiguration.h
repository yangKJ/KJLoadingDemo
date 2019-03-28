//
//  KJLoadingAnmationConfiguration.h
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/20.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, KJLoadingAnimationType) {
    KJLoadingAnimationTypeCustom = 0,   /// 自定义
    KJLoadingAnimationTypePlayImages, /// 播放指定图片
    KJLoadingAnimationTypeWritingEffect, /// 写文字加载
    KJLoadingAnimationTypeEatDouh,   /// 吃豆豆
    KJLoadingAnimationTypeThreeDots, /// 三个横排闪烁点
    KJLoadingAnimationTypeBallClipRotate, /// 不规则圆旋转
    KJLoadingAnimationTypeLineScalePulseOut, /// 竖线波浪
    KJLoadingAnimationTypeTurnedAround, /// 小球转圈圈
    KJLoadingAnimationTypeTwoDots, /// 大小点
    KJLoadingAnimationTypeOutwardWaves, /// 向外扩展波浪
    KJLoadingAnimationTypeLoveHeart, /// 爱心
    KJLoadingAnimationTypeElectrocardiogram, /// 心电图
};

@interface KJLoadingAnmationConfiguration : NSObject

/** 默认加载动画配置 */
+ (instancetype)defaultLoadingAnmationConfiguration;

/// 播放图片, 有默认数据
@property(nonatomic,strong) NSArray<UIImage*> *kImages;
/// 播放图片持续时间, 默认2.5秒
@property(nonatomic,assign) CGFloat kDuration;

/// 写文字笔图片
@property (nonatomic,strong) UIImage *writingPencil;
/// 自定义动画类名
@property (nonatomic,strong) NSString *class_name;
/// 开启随机动画类型 默认NO
@property (nonatomic,assign) BOOL kOpenRandomType;
/// 指定随机类型 默认随机全部
@property (nonatomic,strong) NSArray *kRandomTypeArray;
/// 动画类型 默认 "吃豆豆"
@property (nonatomic,assign,getter=kjType) KJLoadingAnimationType kType;
/// 动画速度 默认1.0
@property (nonatomic,assign) CGFloat kSpeed;
/// 动画颜色 默认白色
@property (nonatomic,strong) UIColor *kAnmationColor;
/// 尺寸 默认 屏幕宽度/4
@property (nonatomic,assign) CGSize kSize;
/// 显示文字 默认加载中..
@property (nonatomic,strong) NSString *kDisplayString;
/// 显示文字字体 默认14
@property (nonatomic,strong) UIFont *kDisplayTitleFont;
/// 文字颜色 默认动画颜色
@property (nonatomic,strong) UIColor *kTitleColor;
/// 蒙版圆角 默认 5
@property (nonatomic,assign) CGFloat kMaskingCircular;
/// 蒙版背景颜色 默认黑色50%
@property (nonatomic,strong) UIColor *kMaskingBackgroundColor;
/// 遮盖层背景颜色 默认白色50%
@property (nonatomic,strong) UIColor *kCoverBackgroundColor;

/********************************** 公用方法 - 用于子类重载 ******************************************/
- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor;

@end
