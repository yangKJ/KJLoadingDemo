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
@property(nonatomic,strong) KJLoadingDeploy *kConfiguration;
@property(nonatomic,strong) UIView *kSuperView;
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
+ (instancetype)kLoadingAnimation{
    @synchronized (self) {
        if (!_tools) _tools = [[KJLoading alloc]init];
    }
    return _tools;
}
/// 初始化
+ (KJLoading*)initWithLoadingAnmationConfiguration:(KJLoadingDeploy*__nullable)configuration{
    @synchronized (self) { if (!_tools) _tools = [KJLoading new]; }
    _tools.kConfiguration = configuration == nil ? [KJLoadingDeploy kj_defaultLoadingDeploy] : configuration;
    return _tools;
}
#pragma mark - public method
/// 开始动画
+ (void)kLoadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingDeploy *__nullable)configuration{
    KJLoading *xx = [self initWithLoadingAnmationConfiguration:configuration];
    [self kSetupWithTool:xx View:view];
}
/// 开始动画
- (void)kLoadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingDeploy *__nullable)configuration{
    self.kConfiguration = configuration == nil ? [KJLoadingDeploy kj_defaultLoadingDeploy] : configuration;
    [KJLoading kSetupWithTool:self View:view];
}
/// 停止
+ (void)kLoadingAnimationStopAnimating{
    if (_tools.kConfiguration.kDismiss) {
        [_tools kDissmissAnimation];
        return;
    }
    [_tools kRemove];
}
/// 停止
- (void)kLoadingAnimationStopAnimating{
    [KJLoading kLoadingAnimationStopAnimating];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation*)anim finished:(BOOL)flag{
    [self kRemove];
}

#pragma mark - privately method
/// 消失动画
- (void)kDissmissAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.delegate = self;
    animation.values = @[@(0.9),@(0.8),@(0.7),@(0.6),@(0.5),@(0.4),@(0.3),@(0.2),@(0.1),@(0.0)];
    animation.duration = self.kConfiguration.kDismissTime;
    animation.autoreverses = NO;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    [self.coverView.layer addAnimation:animation forKey:@"zoom"];
    [self.maskingView.layer addAnimation:animation forKey:@"zoom"];
}
- (void)kRemove{
    _maskingView.hidden = _coverView.hidden = YES;
    _animationView.layer.speed = 0.0f;
    _animationView.layer.sublayers = nil;
    [_maskingView removeFromSuperview];
    [_coverView removeFromSuperview];
    _maskingView = _coverView = nil;
}
/// 布局subview
+ (void)kSetupWithTool:(KJLoading*)animationTool View:(UIView*)superview{
    animationTool.kSuperView = superview;
    [_tools kRemove];
    kAnimationWidth = animationTool.kConfiguration.kSize.width;
    kAnimationHeight = animationTool.kConfiguration.kSize.height;
    /// 有文字的情况
    if (![animationTool.kConfiguration.kDisplayString isEqualToString:@""] && animationTool.kConfiguration.kDisplayString != nil) {
        NSDictionary *attribute = @{NSFontAttributeName : animationTool.kConfiguration.kDisplayTitleFont};
        CGFloat xx = [animationTool.kConfiguration.kDisplayString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width + 20;
        kAnimationWidth = kAnimationWidth >= xx ? kAnimationWidth : xx;
    }
    [animationTool.maskingView addSubview:animationTool.animationView];
    [animationTool.coverView addSubview:animationTool.maskingView];
    [superview addSubview:animationTool.coverView];
    
    /// 没有文字显示的状态
    if ([animationTool.kConfiguration.kDisplayString isEqualToString:@""] || animationTool.kConfiguration.kDisplayString == nil) {
        CGFloat xw = kAnimationWidth >= kAnimationHeight ? kAnimationHeight/2 : kAnimationWidth/2;
        animationTool.animationView.frame = CGRectMake(0, 0, xw, xw);
        animationTool.animationView.center = CGPointMake(kAnimationWidth/2, kAnimationHeight/2);
    }else{
        animationTool.animationView.frame = CGRectMake(0, 0, animationTool.kConfiguration.kSize.width/2, animationTool.kConfiguration.kSize.width/2);
        animationTool.animationView.center = CGPointMake(kAnimationWidth/2, animationTool.kConfiguration.kSize.width/2);
        [animationTool.maskingView addSubview:animationTool.animationLabel];
    }
    KJLoadingDeploy *anmation = [self kGetAnimationMaterialWithAnimationType:animationTool.kConfiguration.kType ClassName:animationTool.kConfiguration.class_name];
    if (animationTool.kConfiguration.kType == KJLoadingAnimationTypeWriting) {
        ((KJWritingEffect*)anmation).writeString = animationTool.kConfiguration.kDisplayString;
        ((KJWritingEffect*)anmation).writeFont = animationTool.kConfiguration.kDisplayTitleFont;
        ((KJWritingEffect*)anmation).writingPencil = animationTool.kConfiguration.writingPencil;
    }else if (animationTool.kConfiguration.kType == KJLoadingAnimationTypePlayImages){
        if (animationTool.kConfiguration.kImages == nil || animationTool.kConfiguration.kImages.count == 0) {
            animationTool.kConfiguration.kImages = [self kGetFileImageNumsWithAnimationName:@"images"];
        }
        ((KJPlayImages*)anmation).images = animationTool.kConfiguration.kImages;
        ((KJPlayImages*)anmation).durat = animationTool.kConfiguration.kDuration;
    }
    animationTool.animationView.layer.speed = animationTool.kConfiguration.kSpeed;
    [anmation kj_setAnimationFromLayer:animationTool.animationView.layer Size:animationTool.animationView.frame.size Color:animationTool.kConfiguration.kAnmationColor];
    
    _tools.maskingView.hidden = _tools.coverView.hidden = NO;
}
/// 获取对应的动画素材类
+ (KJLoadingDeploy*)kGetAnimationMaterialWithAnimationType:(KJLoadingAnimationType)type ClassName:(NSString*)class_name{
    switch (type) {
        case KJLoadingAnimationTypeCustom: return [[NSClassFromString(class_name) alloc] init];
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
+ (NSArray*)kGetFileImageNumsWithAnimationName:(NSString*)name{
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
        _coverView.frame = self.kSuperView.bounds;
        _coverView.backgroundColor = self.kConfiguration.kCoverBackgroundColor;
    }
    return _coverView;
}
- (UIView*)maskingView{
    if (!_maskingView) {
        _maskingView = [UIView new];
        _maskingView.frame = CGRectMake(0, 0, kAnimationWidth, kAnimationHeight);
        _maskingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _maskingView.backgroundColor = self.kConfiguration.kMaskingBackgroundColor;
        _maskingView.center = self.coverView.center;
        _maskingView.layer.masksToBounds = YES;
        _maskingView.layer.cornerRadius = self.kConfiguration.kMaskingCircular;
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
        CGFloat xh = self.kConfiguration.kSize.width / 3;
        _animationLabel.frame = CGRectMake(0, kAnimationHeight - xh, kAnimationWidth, xh);
        _animationLabel.text = self.kConfiguration.kDisplayString;
        _animationLabel.textColor = self.kConfiguration.kTitleColor;
        _animationLabel.font = self.kConfiguration.kDisplayTitleFont;
    }
    return _animationLabel;
}
@end
