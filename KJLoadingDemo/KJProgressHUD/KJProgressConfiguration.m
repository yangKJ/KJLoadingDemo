//
//  KJProgressConfiguration.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/4/5.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJProgressConfiguration.h"

@implementation KJProgressConfiguration 

+ (instancetype)defaultHUDConfiguration{
    CGFloat kw = [UIScreen mainScreen].bounds.size.width;
    KJProgressConfiguration *configuration = [KJProgressConfiguration new];
    /// 默认值
    configuration.kHUDType = KJProgressHUDTypeCustom;
    configuration.kHUDAnimationType = KJProgressHUDAnimationTypeCustom;
    configuration.kSpeed = 1.0;
    configuration.kAnmationColor = UIColor.whiteColor;
    configuration.kSize = CGSizeMake(kw / 4, kw / 4 + 10);
    configuration.kDisplayString = @"加载中..";
    configuration.kDisplayTitleFont = [UIFont systemFontOfSize:(14)];
    configuration.kTitleColor = configuration.kAnmationColor;
    configuration.kMaskingCircular = 5.0;
    configuration.kMaskingBackgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    configuration.kCoverBackgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    configuration.kAfterDelay = 1.0;
    
    return configuration;
}

/// 公用方法 - 用于子类重载
- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{
    
}

@end
