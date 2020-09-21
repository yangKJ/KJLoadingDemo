//
//  KJLoadingAnmationConfiguration.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/20.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJLoadingDeploy.h"

@implementation KJLoadingDeploy

+ (instancetype)kj_default{
    CGFloat kw = [UIScreen mainScreen].bounds.size.width;
    KJLoadingDeploy *configuration = [KJLoadingDeploy new];
    /// 默认值
    configuration.kOpenRandomType = NO;
    configuration.kRandomTypeArray = @[@(KJLoadingAnimationTypeEatDouh),
                                       @(KJLoadingAnimationTypeThreeDots),
                                       @(KJLoadingAnimationTypeBallClipRotate),
                                       @(KJLoadingAnimationTypeLineScalePulseOut),
                                       @(KJLoadingAnimationTypeTurnedAround),
                                       @(KJLoadingAnimationTypeTwoDots),
                                       @(KJLoadingAnimationTypeOutwardWaves),
                                       @(KJLoadingAnimationTypeHourGlass),
                                       @(KJLoadingAnimationTypeCircleStrokeSpin),
                                       ];
    configuration.kType = KJLoadingAnimationTypeEatDouh;
    configuration.kSpeed = 1.0;
    configuration.writingPencil = [UIImage imageNamed:@"KJLoading.bundle/pencil.png"];
    configuration.kAnmationColor = UIColor.whiteColor;
    configuration.kSize = CGSizeMake(kw / 4, kw / 4 + 10);
    configuration.kDisplayString = @"加载中..";
    configuration.kDisplayTitleFont = [UIFont systemFontOfSize:(14)];
    configuration.kTitleColor = configuration.kAnmationColor;
    configuration.kMaskingCircular = 5.0;
    configuration.kMaskingBackgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    configuration.kCoverBackgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    configuration.kDuration = 2.5;
    configuration.kDismiss = NO;
    configuration.kDismissTime = 1.0;
    
    return configuration;
}
- (KJLoadingAnimationType)kjType{
    if (_kOpenRandomType) {
        NSInteger ran = arc4random() % _kRandomTypeArray.count;
        return (KJLoadingAnimationType)[_kRandomTypeArray[ran] integerValue];
    }else{
        return _kType;
    }
}

/// 公用方法，用于子类重载
- (void)kj_setAnimationFromLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)tintColor{
    
}
@end
