//
//  KJProgressRight.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/4/5.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJProgressRight.h"

static CGFloat lineWidth = 4.0f;
static CGFloat circleDuriation = 0.5f;
static CGFloat checkDuration = 0.2f;
@interface KJProgressRight ()<CAAnimationDelegate>{
    CALayer *_animationLayer;
}
@end

@implementation KJProgressRight

- (void)kj_setAnimationFromLayer:(CALayer*)layer Size:(CGSize)size Color:(UIColor*)tintColor{
    CGFloat w = size.width;
    CGFloat h = size.height;
    _animationLayer = [CALayer layer];
    _animationLayer.frame = CGRectMake(0, 0, w, w);
    _animationLayer.position = CGPointMake(w/2, h/2);
    [layer addSublayer:_animationLayer];
}

/// 画圆
- (void)circleAnimationColor:(UIColor *)tintColor {
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = _animationLayer.bounds;
    [_animationLayer addSublayer:circleLayer];
    circleLayer.fillColor =  [[UIColor clearColor] CGColor];
    circleLayer.strokeColor  = tintColor.CGColor;
    circleLayer.lineWidth = lineWidth;
    circleLayer.lineCap = kCALineCapRound;
    CGFloat lineWidth = 5.0f;
    CGFloat radius = _animationLayer.bounds.size.width/2.0f - lineWidth/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleLayer.position radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:true];
    circleLayer.path = path.CGPath;
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleAnimation.duration = circleDuriation;
    circleAnimation.fromValue = @(0.0f);
    circleAnimation.toValue = @(1.0f);
    circleAnimation.delegate = self;
    [circleAnimation setValue:@"circleAnimation" forKey:@"animationName"];
    [circleLayer addAnimation:circleAnimation forKey:nil];
}
/// 对号
- (void)checkAnimationColor:(UIColor *)tintColor {
    CGFloat a = _animationLayer.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(a*2.7/10,a*5.4/10)];
    [path addLineToPoint:CGPointMake(a*4.5/10,a*7/10)];
    [path addLineToPoint:CGPointMake(a*7.8/10,a*3.8/10)];
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = tintColor.CGColor;
    checkLayer.lineWidth = lineWidth;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [_animationLayer addSublayer:checkLayer];
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = checkDuration;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    checkAnimation.delegate = self;
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:nil];
}

@end
