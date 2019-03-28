//
//  KJLoadingAnimation.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/20.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJLoadingAnimation.h"

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

@interface KJLoadingAnimation ()
@property(nonatomic,strong) KJLoadingAnmationConfiguration *kConfiguration;
@property(nonatomic,strong) UIView *coverView;
@property(nonatomic,strong) UIView *maskingView;
@property(nonatomic,strong) UIView *animationView;
@property(nonatomic,strong) UILabel *animationLabel;

@end

@implementation KJLoadingAnimation
static KJLoadingAnimation *_LoadingAnimation = nil;

#pragma mark - 初始化方法
+ (instancetype)kLoadingAnimation{
    @synchronized (self) {
        if (!_LoadingAnimation) {
            _LoadingAnimation = [[KJLoadingAnimation alloc]init];
        }
    }
    return _LoadingAnimation;
}

+ (KJLoadingAnimation*)initWithLoadingAnmationConfiguration:(KJLoadingAnmationConfiguration*__nullable)configuration{
    @synchronized (self) {
        if (!_LoadingAnimation) {
            _LoadingAnimation = [[KJLoadingAnimation alloc]init];
        }
    }
    _LoadingAnimation.kConfiguration = configuration == nil ? [KJLoadingAnmationConfiguration defaultLoadingAnmationConfiguration] : configuration;
    return _LoadingAnimation;
}

/// 开始动画
+ (void)kLoadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingAnmationConfiguration*__nullable)configuration{
    KJLoadingAnimation *_tool = [self initWithLoadingAnmationConfiguration:configuration];
    [self kSetupWithTool:_tool View:view];
}
/// 开始动画  __nullable 可以为空
- (void)kLoadingAnimationStartAnimatingWithView:(UIView*)view Configuration:(KJLoadingAnmationConfiguration*__nullable)configuration{
    self.kConfiguration = configuration == nil ? [KJLoadingAnmationConfiguration defaultLoadingAnmationConfiguration] : configuration;
    [KJLoadingAnimation kSetupWithTool:self View:view];
}
/// 停止
+ (void)kLoadingAnimationStopAnimating{
    //    [UIView animateWithDuration:0.2 animations:^{
    //        _LoadingAnimationTool.coverView.hidden = YES;
    //    } completion:^(BOOL finished) {
    [self kRemove];
    //    }];
}
/// 停止
- (void)kLoadingAnimationStopAnimating{
    [KJLoadingAnimation kLoadingAnimationStopAnimating];
}

#pragma mark - 内部方法
/// 布局subview
+ (void)kSetupWithTool:(KJLoadingAnimation*)animationTool View:(UIView*)superview{
    /// 先移出之前的
    [self kRemove];
    
    CGFloat w = animationTool.kConfiguration.kSize.width;
    CGFloat h = animationTool.kConfiguration.kSize.height;
    
    NSDictionary *attribute = @{NSFontAttributeName : animationTool.kConfiguration.kDisplayTitleFont};
    CGFloat xx = [animationTool.kConfiguration.kDisplayString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.width + 20;
    
    w = w >= xx ? w : xx;
    
    animationTool.coverView.frame = superview.bounds;
    animationTool.coverView.backgroundColor = animationTool.kConfiguration.kCoverBackgroundColor;
    [superview addSubview:animationTool.coverView];
    
    animationTool.maskingView.backgroundColor = animationTool.kConfiguration.kMaskingBackgroundColor;
    animationTool.maskingView.frame = CGRectMake(0, 0, w, h);
    animationTool.maskingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    animationTool.maskingView.center = animationTool.coverView.center;
    animationTool.maskingView.layer.masksToBounds = YES;
    animationTool.maskingView.layer.cornerRadius = animationTool.kConfiguration.kMaskingCircular;
    [animationTool.coverView addSubview:animationTool.maskingView];
    
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
    
    [animationTool.maskingView addSubview:animationTool.animationView];
    
    KJLoadingAnmationConfiguration *anmation = [self kGetAnimationMaterialWithAnimationType:animationTool.kConfiguration.kType ClassName:animationTool.kConfiguration.class_name];
    if (animationTool.kConfiguration.kType == KJLoadingAnimationTypeWritingEffect) {
        ((KJWritingEffectAnimation*)anmation).writeString = animationTool.kConfiguration.kDisplayString;
        ((KJWritingEffectAnimation*)anmation).writeFont = animationTool.kConfiguration.kDisplayTitleFont;
        ((KJWritingEffectAnimation*)anmation).writingPencil = animationTool.kConfiguration.writingPencil;
    }else if (animationTool.kConfiguration.kType == KJLoadingAnimationTypePlayImages){
        if (animationTool.kConfiguration.kImages == nil || animationTool.kConfiguration.kImages.count == 0) {
            animationTool.kConfiguration.kImages = [self kGetFileImageNumsWithAnimationName:@"images"];
        }
        ((KJPlayImageAnimation*)anmation).images = animationTool.kConfiguration.kImages;
        ((KJPlayImageAnimation*)anmation).durat = animationTool.kConfiguration.kDuration;
    }
    animationTool.animationView.layer.speed = animationTool.kConfiguration.kSpeed;
    [anmation setupAnimationInLayer:animationTool.animationView.layer withSize:animationTool.animationView.frame.size tintColor:animationTool.kConfiguration.kAnmationColor];
}

/// 获取对应的动画素材类
+ (KJLoadingAnmationConfiguration*)kGetAnimationMaterialWithAnimationType:(KJLoadingAnimationType)type ClassName:(NSString*)class_name{
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

+ (void)kRemove{
    _LoadingAnimation.animationView.layer.speed = 0.0f;
    _LoadingAnimation.animationView.layer.sublayers = nil;
    [_LoadingAnimation.maskingView removeFromSuperview];
    [_LoadingAnimation.coverView removeFromSuperview];
}

/// 获取某个文件夹下面图片张数
+ (NSArray*)kGetFileImageNumsWithAnimationName:(NSString*)name{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"KJLoadingAnimation" ofType:@"bundle"];
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
    //    NSLog(@"%@",result);
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSString *imagePath in result) {
        UIImage *image = [UIImage imageWithContentsOfFile:[filePath stringByAppendingPathComponent:imagePath]];
        [imageArray addObject:image];
    }
    return imageArray;
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
