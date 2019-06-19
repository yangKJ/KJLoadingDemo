//
//  KJProgressConfiguration.h
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/4/5.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, KJProgressHUDType) {
    KJProgressHUDTypeCustom = 0, /// 默认，动画 + 文字
    KJProgressHUDTypeText, /// 仅文字
    KJProgressHUDTypeAnimation, /// 仅动画
    KJProgressHUDTypeImage, /// 仅图片
    KJProgressHUDTypeImageAndText, /// 图片 + 文字
};

typedef NS_ENUM(NSUInteger, KJProgressHUDAnimationType) {
    KJProgressHUDAnimationTypeCustom = 0, /// 默认，对号
};

NS_ASSUME_NONNULL_BEGIN

@interface KJProgressConfiguration : NSObject
/** 默认HUD配置 */
+ (instancetype)defaultHUDConfiguration;

/// 显示HUD类型 默认 "动画 + 文字"
@property (nonatomic,assign) KJProgressHUDType kHUDType;
/// 动画类型 默认 "对号"
@property (nonatomic,assign) KJProgressHUDAnimationType kHUDAnimationType;
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
/// 展示时间 默认1秒后消失
@property (nonatomic,assign) CGFloat kAfterDelay;


/********************************** 公用方法 - 用于子类重载 ******************************************/
- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor;

@end

NS_ASSUME_NONNULL_END
