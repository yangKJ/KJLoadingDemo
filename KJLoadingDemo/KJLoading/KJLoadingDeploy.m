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
    KJLoadingDeploy *deploy = [KJLoadingDeploy new];
    /// 默认值
    deploy.kOpenRandomType = NO;
    deploy.kRandomTypeArray = @[@(KJLoadingAnimationTypeEatDouh),
                                       @(KJLoadingAnimationTypeThreeDots),
                                       @(KJLoadingAnimationTypeBallClipRotate),
                                       @(KJLoadingAnimationTypeLineScalePulseOut),
                                       @(KJLoadingAnimationTypeTurnedAround),
                                       @(KJLoadingAnimationTypeTwoDots),
                                       @(KJLoadingAnimationTypeOutwardWaves),
                                       @(KJLoadingAnimationTypeHourGlass),
                                       @(KJLoadingAnimationTypeCircleStrokeSpin),
                                       ];
    deploy.kType = KJLoadingAnimationTypeEatDouh;
    deploy.kSpeed = 1.0;
    deploy.writingPencil = [UIImage imageNamed:@"KJLoading.bundle/pencil.png"];
    deploy.kAnmationColor = UIColor.whiteColor;
    deploy.kSize = CGSizeMake(kw/4, kw/4+10);
    deploy.kDisplayString = @"加载中..";
    deploy.kDisplayTitleFont = [UIFont systemFontOfSize:(14)];
    deploy.kTitleColor = deploy.kAnmationColor;
    deploy.kMaskingCircular = 5.0;
    deploy.kMaskingBackgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    deploy.kCoverBackgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    deploy.kDuration = 2.5;
    deploy.kDismiss = NO;
    deploy.kDismissTime = 1.0;
    
    return deploy;
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
