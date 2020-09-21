//
//  KJLoading.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/20.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJLoading.h"
#import "KJEatDoug.h"
#import "KJWritingEffect.h"
#import "KJThreeDots.h"
#import "KJBallClipRotate.h"
#import "KJLineScalePulseOut.h"
#import "KJTurnedAround.h"
#import "KJTwoDots.h"
#import "KJOutwardWaves.h"
#import "KJLoveHeart.h"
#import "KJElectrocardiogram.h"
#import "KJPlayImages.h"
#import "KJHourGlass.h"
#import "KJMalpositionRotate.h"
#import "KJGradientSnake.h"
#import "KJCircleStrokeSpin.h"

@interface KJLoading ()<CAAnimationDelegate>
@property(nonatomic,strong) KJLoadingDeploy *deploy;
@property(nonatomic,strong) UIView *superView;
@property(nonatomic,strong) UIView *coverView;/// 蒙版
@property(nonatomic,strong) UIView *maskingView;/// 动画后面的背景框
@property(nonatomic,strong) UIView *animationView;/// 动画图
@property(nonatomic,strong) UILabel *animationLabel;/// 文字
@end
@implementation KJLoading
static KJLoading *_tools = nil;
static CGFloat kAnimationWidth  = 0.0;
static CGFloat kAnimationHeight = 0.0;
#pragma mark - 初始化方法
+ (instancetype)kj_initLoadingAnimation{
    @synchronized (self) {
        if (!_tools) _tools = [[KJLoading alloc]init];
    }
    return _tools;
}
/// 初始化
+ (KJLoading*)initWithLoadingAnmationConfiguration:(KJLoadingDeploy*__nullable)configuration{
    @synchronized (self) { if (!_tools) _tools = [KJLoading new]; }
    _tools.deploy = configuration == nil ? [KJLoadingDeploy kj_default] : configuration;
    return _tools;
}
#pragma mark - public method
/// 开始动画
+ (void)kj_loadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingDeploy *__nullable)configuration{
    KJLoading *xx = [self initWithLoadingAnmationConfiguration:configuration];
    [self kj_setup:xx SuperView:view];
}
/// 开始动画
- (void)kj_loadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingDeploy *__nullable)configuration{
    self.deploy = configuration == nil ? [KJLoadingDeploy kj_default] : configuration;
    [KJLoading kj_setup:self SuperView:view];
}
/// 停止
+ (void)kj_loadingAnimationStopAnimating{
    if (_tools.deploy.kDismiss) {
        [_tools kj_dissmissAnimation];
        return;
    }
    [_tools kj_remove];
}
/// 停止
- (void)kj_loadingAnimationStopAnimating{
    [KJLoading kj_loadingAnimationStopAnimating];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation*)anim finished:(BOOL)flag{
    [self kj_remove];
}

#pragma mark - privately method
/// 消失动画
- (void)kj_dissmissAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.delegate = self;
    animation.values = @[@(0.9),@(0.8),@(0.7),@(0.6),@(0.5),@(0.4),@(0.3),@(0.2),@(0.1),@(0.0)];
    animation.duration = self.deploy.kDismissTime;
    animation.autoreverses = NO;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    [self.coverView.layer addAnimation:animation forKey:@"zoom"];
    [self.maskingView.layer addAnimation:animation forKey:@"zoom"];
}
- (void)kj_remove{
    _maskingView.hidden = _coverView.hidden = YES;
    _animationView.layer.speed = 0.0f;
    _animationView.layer.sublayers = nil;
    [_maskingView removeFromSuperview];
    [_coverView removeFromSuperview];
    _maskingView = _coverView = nil;
}
/// 布局subview
+ (void)kj_setup:(KJLoading*)loading SuperView:(UIView*)superview{
    loading.superView = superview;
    [_tools kj_remove];
    kAnimationWidth  = loading.deploy.kSize.width;
    kAnimationHeight = loading.deploy.kSize.height;
    /// 有文字的情况
    if (![loading.deploy.kDisplayString isEqualToString:@""] && loading.deploy.kDisplayString != nil) {
        NSDictionary *attribute = @{NSFontAttributeName : loading.deploy.kDisplayTitleFont};
        CGFloat xx = [loading.deploy.kDisplayString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width + 20;
        kAnimationWidth = kAnimationWidth >= xx ? kAnimationWidth : xx;
    }
    [loading.maskingView addSubview:loading.animationView];
    [loading.coverView addSubview:loading.maskingView];
    [superview addSubview:loading.coverView];
    
    /// 没有文字显示的状态
    if ([loading.deploy.kDisplayString isEqualToString:@""] || loading.deploy.kDisplayString == nil) {
        CGFloat xw = kAnimationWidth >= kAnimationHeight ? kAnimationHeight/2 : kAnimationWidth/2;
        loading.animationView.frame = CGRectMake(0, 0, xw, xw);
        loading.animationView.center = CGPointMake(kAnimationWidth/2, kAnimationHeight/2);
    }else{
        loading.animationView.frame = CGRectMake(0, 0, loading.deploy.kSize.width/2, loading.deploy.kSize.width/2);
        loading.animationView.center = CGPointMake(kAnimationWidth/2, loading.deploy.kSize.width/2);
        [loading.maskingView addSubview:loading.animationLabel];
    }
    KJLoadingDeploy *deploy = [self kj_getDeployFromAnimationType:loading.deploy.kType ClassName:loading.deploy.class_name];
    if (loading.deploy.kType == KJLoadingAnimationTypeWriting) {
        ((KJWritingEffect*)deploy).writeString = loading.deploy.kDisplayString;
        ((KJWritingEffect*)deploy).writeFont = loading.deploy.kDisplayTitleFont;
        ((KJWritingEffect*)deploy).writingPencil = loading.deploy.writingPencil;
    }else if (loading.deploy.kType == KJLoadingAnimationTypePlayImages){
        if (loading.deploy.kImages == nil || loading.deploy.kImages.count == 0) {
            loading.deploy.kImages = [self kj_getImagesWithName:@"images"];
        }
        ((KJPlayImages*)deploy).images = loading.deploy.kImages;
        ((KJPlayImages*)deploy).durat = loading.deploy.kDuration;
    }
    loading.animationView.layer.speed = loading.deploy.kSpeed;
    [deploy kj_setAnimationFromLayer:loading.animationView.layer Size:loading.animationView.frame.size Color:loading.deploy.kAnmationColor];
    
    _tools.maskingView.hidden = _tools.coverView.hidden = NO;
}
/// 获取对应的动画素材类
+ (KJLoadingDeploy*)kj_getDeployFromAnimationType:(KJLoadingAnimationType)type ClassName:(NSString*)clazz{
    switch (type) {
        case KJLoadingAnimationTypeCustom: return [[NSClassFromString(clazz) alloc] init];
        case KJLoadingAnimationTypeEatDouh: return [[KJEatDoug alloc] init];
        case KJLoadingAnimationTypeThreeDots: return [[KJThreeDots alloc] init];
        case KJLoadingAnimationTypeBallClipRotate: return [[KJBallClipRotate alloc] init];
        case KJLoadingAnimationTypeLineScalePulseOut: return [[KJLineScalePulseOut alloc] init];
        case KJLoadingAnimationTypeTurnedAround: return [[KJTurnedAround alloc] init];
        case KJLoadingAnimationTypeTwoDots: return [[KJTwoDots alloc] init];
        case KJLoadingAnimationTypeOutwardWaves: return [[KJOutwardWaves alloc] init];
        case KJLoadingAnimationTypeWriting: return [[KJWritingEffect alloc] init];
        case KJLoadingAnimationTypeLoveHeart: return [[KJLoveHeart alloc] init];
        case KJLoadingAnimationTypeElectrocardiogram: return [[KJElectrocardiogram alloc] init];
        case KJLoadingAnimationTypePlayImages: return [[KJPlayImages alloc] init];
        case KJLoadingAnimationTypeHourGlass: return [KJHourGlass new];
        case KJLoadingAnimationTypeMalpositionRotate: return [KJMalpositionRotate new];
        case KJLoadingAnimationTypeGradientSnake: return [KJGradientSnake new];
        case KJLoadingAnimationTypeCircleStrokeSpin: return [KJCircleStrokeSpin new];
    }
}
/// 获取某个文件夹下面图片张数
+ (NSArray*)kj_getImagesWithName:(NSString*)name{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"KJLoading" ofType:@"bundle"];
    NSString *filePath = [bundlePath stringByAppendingPathComponent:name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:filePath];
    NSMutableArray *imageNameArray = [NSMutableArray array];
    NSString *imageName;
    while((imageName = [enumerator nextObject]) != nil) {
        [imageNameArray addObject:imageName];
    }
    /// 对数组进行排序
    NSArray *result = [imageNameArray sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序
    }];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSString *imagePath in result) {
        UIImage *image = [UIImage imageWithContentsOfFile:[filePath stringByAppendingPathComponent:imagePath]];
        [imageArray addObject:image];
    }
    return imageArray;
}
#pragma mark - lazy
- (UIView*)kCoverView{ return _coverView; }
- (UIView*)coverView{
    if (!_coverView) {
        _coverView = [UIView new];
        _coverView.frame = self.superView.bounds;
        _coverView.backgroundColor = self.deploy.kCoverBackgroundColor;
    }
    return _coverView;
}
- (UIView*)maskingView{
    if (!_maskingView) {
        _maskingView = [UIView new];
        _maskingView.frame = CGRectMake(0, 0, kAnimationWidth, kAnimationHeight);
        _maskingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _maskingView.backgroundColor = self.deploy.kMaskingBackgroundColor;
        _maskingView.center = self.coverView.center;
        _maskingView.layer.masksToBounds = YES;
        _maskingView.layer.cornerRadius = self.deploy.kMaskingCircular;
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
        CGFloat xh = self.deploy.kSize.width / 3;
        _animationLabel.frame = CGRectMake(0, kAnimationHeight - xh, kAnimationWidth, xh);
        _animationLabel.text = self.deploy.kDisplayString;
        _animationLabel.textColor = self.deploy.kTitleColor;
        _animationLabel.font = self.deploy.kDisplayTitleFont;
    }
    return _animationLabel;
}
@end
