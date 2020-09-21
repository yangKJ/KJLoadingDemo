//
//  KJThreeBallSpin.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/29.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJHourGlass.h"

@implementation KJHourGlass

- (void)kj_setAnimationFromLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)tintColor {
    CFTimeInterval duration = 2;
    CGFloat kw = size.width / 3.0 * 2;
    CGFloat kh = size.height / 2;
    
    CALayer *containerLayer = [CALayer layer];
    containerLayer.backgroundColor = [UIColor clearColor].CGColor;
    containerLayer.frame = CGRectMake(0, 0, kw, kh * 2);
    containerLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    containerLayer.position = CGPointMake(kw - kw/3, size.width / 3.0);
    [layer addSublayer:containerLayer];
    
    // BezierPath
    UIBezierPath *topPath = [UIBezierPath bezierPath];
    [topPath moveToPoint:CGPointMake(0, 0)];
    [topPath addLineToPoint:CGPointMake(kw, 0)];
    [topPath addLineToPoint:CGPointMake(kw / 2.0f, kh)];
    [topPath addLineToPoint:CGPointMake(0, 0)];
    [topPath closePath];
    
    // Top Layer
    CAShapeLayer*topLayer = [CAShapeLayer layer];
    topLayer.frame = CGRectMake(0, 0, kw, kh);
    topLayer.path = topPath.CGPath;
    topLayer.fillColor = tintColor.CGColor;
    topLayer.strokeColor = tintColor.CGColor;
    topLayer.lineWidth = 0.0f;
    topLayer.anchorPoint = CGPointMake(0.5f, 1);
    topLayer.position = CGPointMake(kw / 2.0f, kh);
    [containerLayer addSublayer:topLayer];
    
    // BezierPath
    UIBezierPath *bottomPath = [UIBezierPath bezierPath];
    [bottomPath moveToPoint:CGPointMake(kw / 2, 0)];
    [bottomPath addLineToPoint:CGPointMake(kw, kh)];
    [bottomPath addLineToPoint:CGPointMake(0, kh )];
    [bottomPath addLineToPoint:CGPointMake(kw / 2, 0)];
    [bottomPath closePath];
    
    // bottom Layer
    CAShapeLayer*bottomLayer = [CAShapeLayer layer];
    bottomLayer.frame = CGRectMake(0, kh, kw, kh);
    bottomLayer.path = bottomPath.CGPath;
    bottomLayer.fillColor = tintColor.CGColor;
    bottomLayer.strokeColor = tintColor.CGColor;
    bottomLayer.lineWidth = 0.0f;
    bottomLayer.anchorPoint = CGPointMake(0.5f, 1.0f);
    bottomLayer.position = CGPointMake(kw / 2.0f, kh * 2.0f);
    bottomLayer.transform = CATransform3DMakeScale(0, 0, 0);
    [containerLayer addSublayer:bottomLayer];
    
    // BezierPath
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(kw / 2, 0)];
    [linePath addLineToPoint:CGPointMake(kw / 2, kh)];
    
    // Line Layer
    CAShapeLayer*lineLayer = [CAShapeLayer layer];
    lineLayer.frame = CGRectMake(0, kh, kw, kh);
    lineLayer.strokeColor = tintColor.CGColor;
    lineLayer.lineWidth = 1.0;
    lineLayer.lineJoin = kCALineJoinMiter;
    lineLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:1], nil];
    lineLayer.lineDashPhase = 3.0f;
    lineLayer.path = linePath.CGPath;
    lineLayer.strokeEnd = 0.0f;
    [containerLayer addSublayer:lineLayer];
    
    // Top Animation
    CAKeyframeAnimation*topAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    topAnimation.duration = duration;
    topAnimation.repeatCount = HUGE_VAL;
    topAnimation.keyTimes = @[@0.0f, @0.9f, @1.0f];
    topAnimation.values = @[@1.0f, @0.0f, @0.0f];
    
    // Bottom Animation
    CAKeyframeAnimation*bottomAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bottomAnimation.duration = duration;
    bottomAnimation.repeatCount = HUGE_VAL;
    bottomAnimation.keyTimes = @[@0.1f, @0.9f, @1.0f];
    bottomAnimation.values = @[@0.0f, @1.0f, @1.0f];
    
    CAKeyframeAnimation*lineAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    lineAnimation.duration = duration;
    lineAnimation.repeatCount = HUGE_VAL;
    lineAnimation.keyTimes = @[@0.0f, @0.1f, @0.9f, @1.0f];
    lineAnimation.values = @[@0.0f, @1.0f, @1.0f, @1.0f];
    
    // Container Animation
    CAKeyframeAnimation*containerAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    containerAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2f :1 :0.8f :0.0f];
    containerAnimation.duration = duration;
    containerAnimation.repeatCount = HUGE_VAL;
    containerAnimation.keyTimes = @[@0.8f, @1.0f];
    containerAnimation.values = @[[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:M_PI]];
    containerAnimation.calculationMode = kCAAnimationCubic;
    
    [topLayer addAnimation:topAnimation forKey:@"TopAnimatin"];
    [bottomLayer addAnimation:bottomAnimation forKey:@"BottomAnimation"];
    [lineLayer addAnimation:lineAnimation forKey:@"LineAnimation"];
    [containerLayer addAnimation:containerAnimation forKey:@"ContainerAnimation"];
}

@end

