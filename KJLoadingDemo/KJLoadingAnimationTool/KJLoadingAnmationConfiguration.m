//
//  KJLoadingAnmationConfiguration.m
//  优司雇
//
//  Created by 杨科军 on 2019/3/20.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJLoadingAnmationConfiguration.h"

@implementation KJLoadingAnmationConfiguration

+ (instancetype)defaultLoadingAnmationConfiguration{
    CGFloat kw = [UIScreen mainScreen].bounds.size.width;
    KJLoadingAnmationConfiguration *configuration = [KJLoadingAnmationConfiguration new];
    /// 默认值
    configuration.kOpenRandomType = NO;
    configuration.kRandomTypeArray = @[@(KJLoadingAnimationTypeEatDouh),
                                       @(KJLoadingAnimationTypeThreeDots),
                                       @(KJLoadingAnimationTypeBallClipRotate),
                                       @(KJLoadingAnimationTypeLineScalePulseOut),
                                       @(KJLoadingAnimationTypeTurnedAround),
                                       @(KJLoadingAnimationTypeTwoDots),
                                       @(KJLoadingAnimationTypeOutwardWaves),
                                       ];
    configuration.kType = KJLoadingAnimationTypeEatDouh;
    configuration.kSpeed = 1.0;
    configuration.kAnmationColor = UIColor.whiteColor;
    configuration.kSize = CGSizeMake(kw / 4, kw / 4 + 10);
    configuration.kDisplayString = @"加载中..";
    configuration.kDisplayTitleFont = [UIFont systemFontOfSize:(14)];
    configuration.kTitleColor = configuration.kAnmationColor;
    configuration.kMaskingCircular = 5.0;
    configuration.kMaskingBackgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    configuration.kCoverBackgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];;
    
    return configuration;
}
- (KJLoadingAnimationType)kjType{
    if (_kOpenRandomType) {
        NSInteger ran = arc4random() % _kRandomTypeArray.count;
        return [_kRandomTypeArray[ran] integerValue];
    }else{
        return _kType;
    }
}

/// 公用方法 - 用于子类重载
- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{
    
}
@end
