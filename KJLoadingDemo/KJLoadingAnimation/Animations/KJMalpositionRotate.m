//
//  KJAA.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/29.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJMalpositionRotate.h"

@interface KJMalpositionRotate (){
    CGFloat kcw;
}

@end

@implementation KJMalpositionRotate

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat w = size.width;
    CGFloat h = size.height;
    kcw = w;
    
    // Circle
    CAShapeLayer*_circleLayer = [CAShapeLayer layer];
    _circleLayer.frame = CGRectMake(0, 0, kcw, kcw);
    _circleLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    _circleLayer.position = CGPointMake(w/2, h/2);
    
    // Shape
    CGFloat shapeLength = kcw / 2.0f;
    CGPathRef path = [self pathRefForCornerRectWithTopLeftRadius:0.85f * shapeLength topRight:0.95f * shapeLength bottomLeft:0.85f * shapeLength bottomRight:0.95f * shapeLength];
    
    // Set Path
    _circleLayer.path = path;
    _circleLayer.masksToBounds = YES;
    _circleLayer.fillColor = tintColor.CGColor;
    
    // Add
    [layer addSublayer:_circleLayer];
    
    // Path 0
    CGFloat length = kcw / 2;
    CGPathRef path_0 = [self pathRefForCornerRectWithTopLeftRadius:0.65f * length topRight:0.85f * length bottomLeft:0.85f * length bottomRight:0.65f * length];
    // Path 25
    CGPathRef path_25 = [self pathRefForCornerRectWithTopLeftRadius:0.75f * length topRight:0.85f * length bottomLeft:0.85f * length bottomRight:0.75f * length];
    // Path 50
    CGPathRef path_50 = [self pathRefForCornerRectWithTopLeftRadius:0.95f * length topRight:0.75f * length bottomLeft:0.75f * length bottomRight:0.95f * length];
    // Path 75
    CGPathRef path_75 = [self pathRefForCornerRectWithTopLeftRadius:0.95f * length topRight:0.95f * length bottomLeft:0.95f * length bottomRight:0.95f * length];
    // Paht 1-00
    CGPathRef path_100 = [self pathRefForCornerRectWithTopLeftRadius:0.65f * length topRight:0.85f * length bottomLeft:0.85f * length bottomRight:0.65f * length];
    CAKeyframeAnimation*_keyframePath = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    _keyframePath.keyTimes = @[@0.0f, @0.25f, @0.5f, @0.75f, @1.0f];
    _keyframePath.values = @[(__bridge id) path_0, (__bridge id) path_25, (__bridge id) path_50, (__bridge id) path_75, (__bridge id) path_100];
    _keyframePath.duration = 1.3f;
    _keyframePath.repeatCount = MAXFLOAT;
    
    CAKeyframeAnimation*_keyframeBackground = [CAKeyframeAnimation animationWithKeyPath:@"fillColor"];
    _keyframeBackground.keyTimes = @[@0.0f, @0.25f, @0.5f, @0.75f, @1.0f];
    UIColor *color = [tintColor colorWithAlphaComponent:0.8];
    _keyframeBackground.values = @[(id)tintColor.CGColor,
                                   (id)color.CGColor,
                                   (id)tintColor.CGColor,
                                   (id)color.CGColor,
                                   (id)tintColor.CGColor];
    _keyframeBackground.duration = 1.3f;
    _keyframeBackground.repeatCount = MAXFLOAT;
    
    CABasicAnimation*_animationTransfrom = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [_animationTransfrom setFromValue:[NSNumber numberWithDouble:0.0f]];
    [_animationTransfrom setToValue:[NSNumber numberWithDouble:(M_PI * 2.0f)]];
    
    // Group
    CAAnimationGroup*_groupAnimation = [CAAnimationGroup animation];
    _groupAnimation.duration = 1.3f;
    _groupAnimation.repeatCount = MAXFLOAT;
    _groupAnimation.animations = @[_keyframePath, _keyframeBackground, _animationTransfrom];
    
    [_circleLayer addAnimation:_groupAnimation forKey:@"rolling"];
}

#pragma mark - Private
- (CGPathRef)pathRefForCornerRectWithTopLeftRadius:(CGFloat)topLeftRadius topRight:(CGFloat)topRightRadius bottomLeft:(CGFloat)bottomLeftRadius bottomRight:(CGFloat)bottomRightRadius{
    CGRect rect = CGRectMake(0, 0, kcw, kcw);
    CGFloat minx = CGRectGetMinX( rect );
    CGFloat midx = CGRectGetMidX( rect );
    CGFloat maxx = CGRectGetMaxX( rect );
    CGFloat miny = CGRectGetMinY( rect );
    CGFloat midy = CGRectGetMidY( rect );
    CGFloat maxy = CGRectGetMaxY( rect );
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, minx, midy);
    CGPathAddArcToPoint(pathRef, NULL, minx, miny, midx, miny, bottomLeftRadius);
    CGPathAddArcToPoint(pathRef, NULL, maxx, miny, maxx, midy, bottomRightRadius);
    CGPathAddArcToPoint(pathRef, NULL, maxx, maxy, midx, maxy, topRightRadius);
    CGPathAddArcToPoint(pathRef, NULL, minx, maxy, minx, midy, topLeftRadius);
    return pathRef;
}

@end

