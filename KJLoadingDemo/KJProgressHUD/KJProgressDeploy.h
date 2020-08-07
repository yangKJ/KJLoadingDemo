//
//  KJProgressDeploy.h
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/4/5.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KJLoadingDeploy.h"
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

@interface KJProgressDeploy : KJLoadingDeploy
/// 默认HUD配置
+ (instancetype)kj_default;
/// 显示HUD类型 默认 "动画 + 文字"
@property (nonatomic,assign) KJProgressHUDType kHUDType;
/// 动画类型 默认"对号"
@property (nonatomic,assign) KJProgressHUDAnimationType kHUDAnimationType;
/// 展示时间 默认1秒后消失
@property (nonatomic,assign) CGFloat kAfterDelay;

@end

NS_ASSUME_NONNULL_END
