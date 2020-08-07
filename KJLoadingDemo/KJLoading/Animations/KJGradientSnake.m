//
//  KJSnake.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/29.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJGradientSnake.h"

@interface KJGradientSnake (){
    CAShapeLayer *shapeLayer1;
    CAShapeLayer *shapeLayer2;
    CAGradientLayer *gradientLayer;
    CGFloat radius,lineWidth; //半圆的半径 和 线条宽度
    CGFloat w,h;
}
@end

@implementation KJGradientSnake

- (void)kj_setAnimationFromLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)tintColor {
    w = size.width;
    h = size.height;
    radius = w / 6.0;
    lineWidth = w / 8.0;
    
    //渐变layer
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, w*2, w);
    gradientLayer.position = CGPointMake(w - w/4, h/2);
    UIColor *color = [tintColor colorWithAlphaComponent:0.2];
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[tintColor CGColor],(id)[color CGColor], nil]];
    [gradientLayer setStartPoint:CGPointMake(0, 0.5)];
    [gradientLayer setEndPoint:CGPointMake(1, 0.5)];
    [layer addSublayer:gradientLayer];

    //图形layer
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(0, 0, w, w);
    layer1.position = CGPointMake(w/2, h/2);
    shapeLayer1 = [self shapeLayer];
    shapeLayer2 = [self shapeLayer];
    [layer1 addSublayer:shapeLayer1];
    [layer1 addSublayer:shapeLayer2];
    
    gradientLayer.mask = layer1;
    
    [self starAnimation];
}

- (CAShapeLayer *)shapeLayer{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, w, w);
    shapeLayer.position = CGPointMake(w/2, h/2);
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    return shapeLayer;
}

//绘制图形路径
- (UIBezierPath *)sinPathWithProgress:(CGFloat)progress offsetX:(CGFloat)offsetX{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat angle = 0;
    CGPoint point = CGPointMake(0, 0);
    CGFloat lineHeight = 0.0;
    CGFloat lineHeight_Max = h - 2 * radius - lineWidth;
    CGFloat girth = (lineHeight_Max) * 3 + M_PI * radius * 3;
    BOOL clockwise = NO;
    BOOL isLine = NO;
    
    if (progress < 0.25) {
        isLine = NO;
        clockwise = YES;
        angle = M_PI + M_PI * progress / 0.25;
        if (progress > 0.125) {
            CGFloat angle1 = angle - M_PI_2 * 3;
            point.x = -radius * sin(angle1);
        }else{
            CGFloat angle1 = angle - M_PI;
            point.x = radius * cos(angle1);
        }
        point.x -= radius;
        point.y = radius;
    }else if (progress < 0.5) {
        isLine = YES;
        clockwise = YES;
        lineHeight = lineHeight_Max * (1 - (progress - 0.25) / 0.25);
        point.y = h - lineHeight - radius;
    }else if (progress < 0.75) {
        isLine = NO;
        clockwise = NO;
        angle = M_PI - M_PI * (progress - 0.5) / 0.25;
        
        if (progress > 0.625) {
            CGFloat angle1 = angle;
            point.x = -radius * cos(angle1);
            
        }else{
            CGFloat angle1 = angle - M_PI_2;
            point.x = radius * sin(angle1);
        }
        point.x -= radius;
        point.y = h - radius;
        
    }else {
        isLine = YES;
        clockwise = NO;
        lineHeight = lineHeight_Max * (1 - (progress - 0.75) / 0.25);
        point.y = lineHeight + radius;
    }
    
    point.x += offsetX;
    
    point.x += lineWidth/2.0;
    point.y += lineWidth/2.0;
    
    if (isLine) {
        [path moveToPoint:point];
    }
    
    CGFloat lineLenth = 0.0;
    BOOL filish = NO;
    
    do {
        if (isLine) {
            if (lineLenth + lineHeight >= girth) {
                lineHeight = girth - lineLenth;
                filish = YES;
            }
            
            lineLenth += lineHeight;
            
            if (!clockwise) {
                point.y -= lineHeight;
            }else {
                point.y += lineHeight;
            }
            [path addLineToPoint:point];
            angle = M_PI;
            clockwise = !clockwise;
        }else {
            CGFloat angleGirth;
            CGFloat endAngle = 0;
            if (!clockwise) {
                angleGirth = radius * angle;
                
                if (lineLenth + angleGirth >= girth) {
                    angleGirth = girth - lineLenth;
                    endAngle = M_PI - angleGirth / radius;
                    filish = YES;
                }
            }else {
                angleGirth = radius * (M_PI * 2 - angle);
                if (lineLenth + angleGirth >= girth) {
                    angleGirth = girth - lineLenth;
                    endAngle = M_PI + angleGirth / radius;;
                    filish = YES;
                }
            }
            
            point.x += radius;
            [path addArcWithCenter:point radius:radius startAngle:angle endAngle:endAngle clockwise:clockwise];
            point.x += radius;
            lineHeight = lineHeight_Max;
            lineLenth += angleGirth;
        }
        isLine = !isLine;
    } while (!filish);
    return path;
}

- (void)starAnimation{
    shapeLayer1.hidden = NO;
    shapeLayer2.hidden = NO;
    CGFloat offsetX = 4 * radius;
    shapeLayer1.path = [self sinPathWithProgress:0 offsetX:0].CGPath;
    shapeLayer2.path = [self sinPathWithProgress:0 offsetX:offsetX].CGPath;
    shapeLayer1.transform = CATransform3DTranslate(shapeLayer1.transform, -4*radius, 0, 0);
    shapeLayer2.transform = CATransform3DTranslate(shapeLayer2.transform, -4*radius, 0, 0);
    
    CABasicAnimation *animation1 = [CABasicAnimation animation];
    animation1.keyPath = @"transform";
    animation1.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(shapeLayer1.transform, 4*radius, 0, 0)];
    
    CABasicAnimation *animation4 = [CABasicAnimation animation];
    animation4.keyPath = @"transform";
    animation4.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(shapeLayer2.transform, 4*radius, 0, 0)];
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"strokeStart";
    animation2.fromValue = @(2 / 3.0);
    animation2.toValue = @(0);
    
    CABasicAnimation *animation3 = [CABasicAnimation animation];
    animation3.keyPath = @"strokeEnd";
    animation3.fromValue = @(1);
    animation3.toValue = @(1 / 3.0);
    
    CAAnimationGroup *group1 = [CAAnimationGroup animation];
    group1.animations = @[animation1, animation2];
    group1.duration = 0.7;
    group1.repeatCount = INT_MAX;
    
    CAAnimationGroup *group2 = [CAAnimationGroup animation];
    group2.animations = @[animation4, animation3];
    group2.duration = 0.7;
    group2.repeatCount = INT_MAX;
    
    [shapeLayer1 addAnimation:group1 forKey:nil];
    [shapeLayer2 addAnimation:group2 forKey:nil];
}

@end
