//
//  KJLoadingAnimationTool.m
//  优司雇
//
//  Created by 杨科军 on 2019/3/20.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJLoadingAnimationTool.h"

#import "KJEatDougAnimation.h" /// 吃豆豆
#import "KJWritingEffectAnimation.h"
#import "KJThreeDotsAnimation.h"
#import "KJBallClipRotateAnimation.h"
#import "KJLineScalePulseOutAnimation.h"
#import "KJTurnedAroundAnimation.h"
#import "KJTwoDotsAnimation.h"
#import "KJOutwardWavesAnimation.h"
#import "KJLoveHeartAnimation.h"
#import "KJElectrocardiogramAnimation.h"
#import "KJPlayImageAnimation.h"

@interface KJLoadingAnimationTool ()
@property(nonatomic,strong) KJLoadingAnmationConfiguration *con;
@property(nonatomic,strong) UIView *coverView;
@property(nonatomic,strong) UIView *maskingView;
@property(nonatomic,strong) UIView *animationView;
@property(nonatomic,strong) UILabel *animationLabel;
@property(nonatomic,assign) bool isFrist;  /// 开关用于解决第一次错位的bug
@end

@implementation KJLoadingAnimationTool
static KJLoadingAnimationTool *_LoadingAnimationTool = nil;

+ (instancetype)kLoadingAnimationTool{
    @synchronized (self) {
        if (!_LoadingAnimationTool) {
            _LoadingAnimationTool = [[KJLoadingAnimationTool alloc]init];
        }
    }
    return _LoadingAnimationTool;
}

+ (KJLoadingAnimationTool*)initWithLoadingAnmationConfiguration:(KJLoadingAnmationConfiguration*__nullable)configuration{
    @synchronized (self) {
        if (!_LoadingAnimationTool) {
            _LoadingAnimationTool = [[KJLoadingAnimationTool alloc]init];
        }
    }
    _LoadingAnimationTool.con = configuration == nil ? [KJLoadingAnmationConfiguration defaultLoadingAnmationConfiguration] : configuration;
    return _LoadingAnimationTool;
}

/// 开始动画  __nullable 可以为空
- (void)kLoadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingAnmationConfiguration*__nullable)configuration{
    [self kLoadingAnimationStopAnimating];
    
    self.con = configuration == nil ? [KJLoadingAnmationConfiguration defaultLoadingAnmationConfiguration] : configuration;
    [KJLoadingAnimationTool kSetupWithTool:self View:view];
    if (self.isFrist == false) {
        self.isFrist = true;
        [self kLoadingAnimationStopAnimating];
        [KJLoadingAnimationTool kSetupWithTool:self View:view];
    }
}
/// 停止
- (void)kLoadingAnimationStopAnimating{
    self.animationView.layer.speed = 0.0f;
    self.animationView.layer.sublayers = nil;
    [self.maskingView removeFromSuperview];
    [self.coverView removeFromSuperview];
}


/// 开始动画
+ (void)kLoadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingAnmationConfiguration*__nullable)configuration{
    /// 先移出之前的
    [self kRemove];
    
    KJLoadingAnimationTool *_tool = [self initWithLoadingAnmationConfiguration:configuration];
    [self kSetupWithTool:_tool View:view];
    if (_tool.isFrist == false) {
        _tool.isFrist = true;
        [self kRemove];
        [self kSetupWithTool:_tool View:view];
    }
}

+ (void)kSetupWithTool:(KJLoadingAnimationTool*)_tool View:(UIView*)view{
    CGFloat w = _tool.con.kSize.width;
    CGFloat h = _tool.con.kSize.height;
    
    _tool.coverView.frame = view.bounds;
    _tool.coverView.backgroundColor = _tool.con.kCoverBackgroundColor;
    [view addSubview:_tool.coverView];
    
    _tool.maskingView.backgroundColor = _tool.con.kMaskingBackgroundColor;
    _tool.maskingView.frame = CGRectMake(0, 0, w, h);
    _tool.maskingView.center = _tool.coverView.center;
    _tool.maskingView.layer.masksToBounds = YES;
    _tool.maskingView.layer.cornerRadius = _tool.con.kMaskingCircular;
    [_tool.coverView addSubview:_tool.maskingView];
    
    /// 没有文字显示的状态
    if ([_tool.con.kDisplayString isEqualToString:@""] || _tool.con.kDisplayString == nil) {
        _tool.animationView.frame = CGRectMake(0, 0, w/2, h/2);
        _tool.animationView.center = CGPointMake(w/2, h/2);
    }else{
        _tool.animationView.frame = CGRectMake(0, 0, w/2, w/2);
        _tool.animationView.center = CGPointMake(w/2, w/2);
        CGFloat lh = w / 3;
        _tool.animationLabel.frame = CGRectMake(0, h - lh, w, lh);
        _tool.animationLabel.text = _tool.con.kDisplayString;
        _tool.animationLabel.textColor = _tool.con.kTitleColor;
        _tool.animationLabel.font = _tool.con.kDisplayTitleFont;
        [_tool.maskingView addSubview:_tool.animationLabel];
    }
    
    [_tool.maskingView addSubview:_tool.animationView];
    
    KJLoadingAnmationConfiguration *anmation = [self activityIndicatorAnimationForAnimationType:_tool.con.kType ClassName:_tool.con.class_name];
    if (_tool.con.kType == KJLoadingAnimationTypeWritingEffect) {
        ((KJWritingEffectAnimation*)anmation).writeString = _tool.con.kDisplayString;
        ((KJWritingEffectAnimation*)anmation).writeFont = _tool.con.kDisplayTitleFont;
        ((KJWritingEffectAnimation*)anmation).writingPencil = _tool.con.writingPencil;
    }else if (_tool.con.kType == KJLoadingAnimationTypePlayImages){
        ((KJPlayImageAnimation*)anmation).images = _tool.con.kImages;
        ((KJPlayImageAnimation*)anmation).durat = _tool.con.kDuration;
    }
    _tool.animationView.layer.speed = _tool.con.kSpeed;
    [anmation setupAnimationInLayer:_tool.animationView.layer withSize:_tool.animationView.frame.size tintColor:_tool.con.kAnmationColor];
}

/// 停止
+ (void)kLoadingAnimationStopAnimating{
//    [UIView animateWithDuration:0.2 animations:^{
//        _LoadingAnimationTool.coverView.hidden = YES;
//    } completion:^(BOOL finished) {
        [self kRemove];
//    }];
}

+ (void)kRemove{
    _LoadingAnimationTool.animationView.layer.speed = 0.0f;
    _LoadingAnimationTool.animationView.layer.sublayers = nil;
    [_LoadingAnimationTool.maskingView removeFromSuperview];
    [_LoadingAnimationTool.coverView removeFromSuperview];
}

+ (KJLoadingAnmationConfiguration*)activityIndicatorAnimationForAnimationType:(KJLoadingAnimationType)type ClassName:(NSString*)class_name{
    switch (type) {
        case KJLoadingAnimationTypeCustom: return [[NSClassFromString(class_name) alloc] init];
        case KJLoadingAnimationTypeEatDouh: return [[KJEatDougAnimation alloc] init];
        case KJLoadingAnimationTypeThreeDots: return [[KJThreeDotsAnimation alloc] init];
        case KJLoadingAnimationTypeBallClipRotate: return [[KJBallClipRotateAnimation alloc] init];
        case KJLoadingAnimationTypeLineScalePulseOut: return [[KJLineScalePulseOutAnimation alloc] init];
        case KJLoadingAnimationTypeTurnedAround: return [[KJTurnedAroundAnimation alloc] init];
        case KJLoadingAnimationTypeTwoDots: return [[KJTwoDotsAnimation alloc] init];
        case KJLoadingAnimationTypeOutwardWaves: return [[KJOutwardWavesAnimation alloc] init];
        case KJLoadingAnimationTypeWritingEffect: return [[KJWritingEffectAnimation alloc] init];
        case KJLoadingAnimationTypeLoveHeart: return [[KJLoveHeartAnimation alloc] init];
        case KJLoadingAnimationTypeElectrocardiogram: return [[KJElectrocardiogramAnimation alloc] init];
        case KJLoadingAnimationTypePlayImages: return [[KJPlayImageAnimation alloc] init];
    }
}
#pragma mark - lazy
- (UIView*)kCoverView{
    return _coverView;
}
- (UIView*)coverView{
    if (!_coverView) {
        _coverView = [UIView new];
    }
    return _coverView;
}
- (UIView*)maskingView{
    if (!_maskingView) {
        _maskingView = [UIView new];
    }
    return _maskingView;
}
- (UIView*)animationView{
    if (!_animationView) {
        _animationView = [UIView new];
    }
    return _animationView;
}
- (UILabel*)animationLabel{
    if (!_animationLabel) {
        _animationLabel = [[UILabel alloc] init];
        _animationLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _animationLabel;
}
@end
