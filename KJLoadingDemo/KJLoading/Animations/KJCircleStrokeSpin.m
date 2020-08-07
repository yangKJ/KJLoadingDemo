//
//  KJCircleStrokeSpin.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/29.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJCircleStrokeSpin.h"

@implementation KJCircleStrokeSpin

- (void)kj_setAnimationFromLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)tintColor {
    CGFloat beginTime = 0.5;
    CGFloat strokeStartDuration = 1.2;
    CGFloat strokeEndDuration = 0.7;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.byValue = @(M_PI * 2);
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = strokeEndDuration;
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0];
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(1);
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.duration = strokeStartDuration;
    strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0];
    strokeStartAnimation.fromValue = @(0);
    strokeStartAnimation.toValue = @(1);
    strokeStartAnimation.beginTime = beginTime;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[rotationAnimation,
                                  strokeEndAnimation,
                                  strokeStartAnimation];
    groupAnimation.duration = strokeStartDuration + beginTime;
    groupAnimation.repeatCount = INFINITY;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    CAShapeLayer *circle = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat lineWidth = 2.f;
    [path addArcWithCenter:CGPointMake(size.width / 2.f, size.height / 2.f) radius:size.width / 2.f startAngle:-M_PI / 2.f endAngle:M_PI + M_PI / 2.f clockwise:YES];
    circle.fillColor = nil;
    circle.strokeColor = tintColor.CGColor;
    circle.lineWidth = lineWidth;
    circle.backgroundColor = nil;
    circle.path = path.CGPath;
    circle.frame = CGRectMake(0, 0, size.width, size.height);
    [circle addAnimation:groupAnimation forKey:@"animation"];
    
    CGRect rect = layer.bounds;
    circle.frame = CGRectMake((rect.size.width - size.width) / 2.f, (rect.size.height - size.height) / 2.f, size.width, size.height);
    [layer addSublayer:circle];

}

@end
