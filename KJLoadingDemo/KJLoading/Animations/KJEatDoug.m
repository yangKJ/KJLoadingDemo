//
//  KJEatDougAnimation.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/20.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJEatDoug.h"

@implementation KJEatDoug

- (void)kj_setAnimationFromLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)tintColor {
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CGFloat cookieTerminatorSize =  ceilf(size.width / 3.0f);
    CGFloat oX = (layer.bounds.size.width - size.width) / 2.0f + cookieTerminatorSize * .25;
    CGFloat oY = layer.bounds.size.height / 2.0f;
    CGPoint cookieTerminatorCenter = CGPointMake(oX, oY);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:cookieTerminatorCenter radius:cookieTerminatorSize startAngle:M_PI_4 endAngle:M_PI * 1.75f clockwise:YES];
    [path addLineToPoint:cookieTerminatorCenter];
    [path closePath];
    
    CAShapeLayer *cookieTerminatorLayer = [CAShapeLayer layer];
    cookieTerminatorLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    cookieTerminatorLayer.fillColor = tintColor.CGColor;
    cookieTerminatorLayer.path = path.CGPath;
    [layer addSublayer:cookieTerminatorLayer];
    
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0.0f, 0.0f) radius:cookieTerminatorSize startAngle:M_PI_2 endAngle:M_PI * 1.5f clockwise:YES];
    [path closePath];
    for (int i = 0; i < 2; i++) {
        CAShapeLayer *jawLayer = [CAShapeLayer layer];
        jawLayer.path = path.CGPath;
        jawLayer.fillColor = tintColor.CGColor;
        jawLayer.position = cookieTerminatorCenter;
        jawLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
        jawLayer.opacity = 1.0f;
        jawLayer.transform = CATransform3DMakeRotation((1.0f - 2.0f * i) * M_PI_4, 0.0f, 0.0f, 1.0f);
        
        CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        transformAnimation.removedOnCompletion = NO;
        transformAnimation.beginTime = beginTime;
        transformAnimation.duration = 0.3f;
        transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation((1.0f - 2.0f * i) * M_PI_4, 0.0f, 0.0f, 1.0f)];
        transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation((1.0f - 2.0f * i) * M_PI_2, 0.0f, 0.0f, 1.0f)];
        transformAnimation.autoreverses = YES;
        transformAnimation.repeatCount = HUGE_VALF;
        transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
        
        [layer addSublayer:jawLayer];
        [jawLayer addAnimation:transformAnimation forKey:@"animation"];
    }
    
    CGFloat cookieSize = ceilf(size.width / 6.0f);
    CGFloat cookiePadding = cookieSize * 2.0f;
    for (int i = 0; i < 3; i++) {
        CALayer *cookieLayer = [CALayer layer];
        cookieLayer.frame = CGRectMake(cookieTerminatorCenter.x + (cookieSize + cookiePadding) * 3.0f - cookieTerminatorSize, oY - cookieSize / 2.0f, cookieSize, cookieSize);
        cookieLayer.backgroundColor = tintColor.CGColor;
        cookieLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
        cookieLayer.opacity = 1.0f;
        cookieLayer.cornerRadius = cookieSize / 2.0f;
        
        CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        transformAnimation.duration = 1.8f;
        transformAnimation.beginTime = beginTime - (i * transformAnimation.duration / 3.0f);
        transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, 0.0f, 0.0f)];
        transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-3.0f * (cookieSize + cookiePadding), 0.0f, 0.0f)];
        transformAnimation.repeatCount = HUGE_VALF;
        transformAnimation.removedOnCompletion = NO;
        transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
        
        [layer addSublayer:cookieLayer];
        [cookieLayer addAnimation:transformAnimation forKey:@"animation"];
    }
}


@end
