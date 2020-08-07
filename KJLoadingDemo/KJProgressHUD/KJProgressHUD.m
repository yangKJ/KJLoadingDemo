//
//  KJProgressHUD.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/4/5.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJProgressHUD.h"
#import "KJProgressRight.h"

@interface KJProgressHUD ()
@property(nonatomic,strong) KJProgressDeploy *kConfiguration;
@property(nonatomic,strong) UIView *coverView;
@property(nonatomic,strong) UIView *maskingView;
@property(nonatomic,strong) UIView *animationView;
@property(nonatomic,strong) UILabel *animationLabel;
@property(nonatomic,strong) UIView *superView;
@property(nonatomic,assign) dispatch_source_t gcdTimer;
@end

@implementation KJProgressHUD
static KJProgressHUD *_LoadingAnimation = nil;
#pragma mark - 初始化方法
+ (instancetype)kLoadingAnimation{
    @synchronized (self) {
        if (!_LoadingAnimation) {
            _LoadingAnimation = [[KJProgressHUD alloc]init];
        }
    }
    return _LoadingAnimation;
}
+ (KJProgressHUD*)initWithLoadingAnmationConfiguration:(KJProgressDeploy*__nullable)configuration{
    @synchronized (self) { if (!_LoadingAnimation) _LoadingAnimation = [[KJProgressHUD alloc]init]; }
    _LoadingAnimation.kConfiguration = configuration == nil ? [KJProgressDeploy kj_default] : configuration;
    return _LoadingAnimation;
}
/// HUD  为空时展示在KeyWindow
+ (void)kProgressHUDWithView:(UIView*__nullable)view Configuration:(KJProgressDeploy*__nullable)configuration{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    KJProgressHUD *tool = [self initWithLoadingAnmationConfiguration:configuration];
    [self kSetupWithTool:tool View:view];
}
#pragma mark - 内部方法
/// 布局subview
+ (void)kSetupWithTool:(KJProgressHUD*)animationTool View:(UIView*)superview{
    animationTool.superView = superview;
    [self kRemove];
    animationTool.coverView.frame = superview.bounds;
    animationTool.coverView.backgroundColor = animationTool.kConfiguration.kCoverBackgroundColor;
    [superview addSubview:animationTool.coverView];
    [animationTool.coverView addSubview:animationTool.maskingView];
    UIView *aView = [self kGetSubviewWithTool:animationTool];
    [animationTool.maskingView addSubview:aView];
    KJProgressDeploy *anmation = [self kGetAnimationMaterialWithAnimationType:animationTool.kConfiguration.kHUDAnimationType];
    animationTool.animationView.layer.speed = animationTool.kConfiguration.kSpeed;
    [anmation kj_setAnimationFromLayer:animationTool.animationView.layer Size:animationTool.animationView.frame.size Color:animationTool.kConfiguration.kAnmationColor];
}

- (void)kCreateGcdTimerWithEndTime:(CGFloat)endTime{
    /** 创建定时器对象 */
    dispatch_source_t gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    self.gcdTimer = gcdTimer;
    /** 设置定时器 para2: 任务开始时间 para3: 任务的间隔*/
    dispatch_source_set_timer(gcdTimer, DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    /** 设置定时器任务 */
    __block CGFloat gcdIndex = 0.0;
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(gcdTimer, ^{
        gcdIndex += 0.2;
        if(gcdIndex >= endTime) {
            dispatch_source_cancel(gcdTimer);//停止计时器，停止以后就可以释放_timer了
            weakSelf.gcdTimer = nil;
        }
    });
    // 启动任务, GCD计时器创建后需要手动启动
    dispatch_resume(gcdTimer);
}
/// 获取对应的子视图
+ (UIView*)kGetSubviewWithTool:(KJProgressHUD*)animationTool{
    KJProgressHUDType type = animationTool.kConfiguration.kHUDType;
    CGFloat w = animationTool.kConfiguration.kSize.width;
    CGFloat h = animationTool.kConfiguration.kSize.height;
    NSDictionary *attribute = @{NSFontAttributeName : animationTool.kConfiguration.kDisplayTitleFont};
    CGFloat xx = [animationTool.kConfiguration.kDisplayString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width + 20;
    w = w >= xx ? w : xx;
    animationTool.maskingView.backgroundColor = animationTool.kConfiguration.kMaskingBackgroundColor;
    animationTool.maskingView.frame = CGRectMake(0, 0, w, h);
    animationTool.maskingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    animationTool.maskingView.center = animationTool.coverView.center;
    animationTool.maskingView.layer.masksToBounds = YES;
    animationTool.maskingView.layer.cornerRadius = animationTool.kConfiguration.kMaskingCircular;
    [animationTool.maskingView addSubview:animationTool.animationView];
    
    /// 没有文字显示的状态
    if ([animationTool.kConfiguration.kDisplayString isEqualToString:@""] || animationTool.kConfiguration.kDisplayString == nil) {
        animationTool.animationView.frame = CGRectMake(0, 0, animationTool.kConfiguration.kSize.width/2, h/2);
        animationTool.animationView.center = CGPointMake(w/2, h/2);
    }else{
        animationTool.animationView.frame = CGRectMake(0, 0, animationTool.kConfiguration.kSize.width/2, animationTool.kConfiguration.kSize.width/2);
        animationTool.animationView.center = CGPointMake(w/2, animationTool.kConfiguration.kSize.width/2);
        CGFloat xh = animationTool.kConfiguration.kSize.width / 3;
        animationTool.animationLabel.frame = CGRectMake(0, h - xh, w, xh);
        animationTool.animationLabel.text = animationTool.kConfiguration.kDisplayString;
        animationTool.animationLabel.textColor = animationTool.kConfiguration.kTitleColor;
        animationTool.animationLabel.font = animationTool.kConfiguration.kDisplayTitleFont;
        [animationTool.maskingView addSubview:animationTool.animationLabel];
    }
    if (type == KJProgressHUDTypeCustom) {
        
    }else if (type == KJProgressHUDTypeCustom){
        
    }
    return nil;
}
/// 获取对应的动画素材类
+ (KJProgressDeploy*)kGetAnimationMaterialWithAnimationType:(KJProgressHUDAnimationType)type{
    switch (type) {
        case KJProgressHUDAnimationTypeCustom: return [KJProgressRight new];
    }
}

+ (void)kRemove{
    dispatch_source_cancel(_LoadingAnimation.gcdTimer);
    _LoadingAnimation.gcdTimer = nil;
    _LoadingAnimation.animationView.layer.speed = 0.0f;
    _LoadingAnimation.animationView.layer.sublayers = nil;
    [_LoadingAnimation.maskingView removeFromSuperview];
    [_LoadingAnimation.coverView removeFromSuperview];
}

#pragma mark - lazy
- (UIView*)kCoverView{ return _coverView; }
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
