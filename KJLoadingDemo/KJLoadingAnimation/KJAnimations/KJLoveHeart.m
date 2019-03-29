//
//  KJLoveHeartAnimation.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/26.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJLoveHeart.h"
#import <CoreText/CoreText.h>
@implementation KJLoveHeart
- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat ox = -layer.bounds.size.width/3;
    CGFloat cy = layer.bounds.size.width/8;
    CGFloat ky = -layer.bounds.size.width/3;
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 首先设置一个起始点
    CGPoint startPoint = CGPointMake(layer.bounds.size.width/2, cy);
    // 设置一个终点
    CGPoint endPoint = CGPointMake(layer.bounds.size.width/2, layer.bounds.size.height);
    
    //// 左半边爱心
    // 以起始点为路径的起点
    [path moveToPoint:CGPointMake(layer.bounds.size.width/2, cy)];
    // 设置第一个控制点
    CGPoint controlPoint1 = CGPointMake(ox, ky);
    // 设置第二个控制点
    CGPoint controlPoint2 = CGPointMake(0, layer.bounds.size.width);
    // 添加二次贝塞尔曲线
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    //// 右半边爱心
    // 设置另一个起始点
    [path moveToPoint:endPoint];
    // 设置第三个控制点
    CGPoint controlPoint3 = CGPointMake(layer.bounds.size.width, layer.bounds.size.width);
    // 设置第四个控制点
    CGPoint controlPoint4 = CGPointMake(layer.bounds.size.width - ox, ky);
    // 添加二次贝塞尔曲线
    [path addCurveToPoint:startPoint controlPoint1:controlPoint3 controlPoint2:controlPoint4];
    
    // 设置线断面类型
    path.lineCapStyle = kCGLineCapRound;
    // 设置连接类型
    path.lineJoinStyle = kCGLineJoinRound;
    
    CAShapeLayer *animLayer = [CAShapeLayer layer];
    animLayer.path = path.CGPath;
    animLayer.lineWidth = 2.f;
    animLayer.strokeColor = tintColor.CGColor;
    animLayer.fillColor = [UIColor clearColor].CGColor;
    animLayer.strokeStart = 0;
    animLayer.strokeEnd = 1.;
    [layer addSublayer:animLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1.f);
    animation.duration = 2.0f;
    animation.removedOnCompletion = NO;
//    animation.repeatCount = CGFLOAT_MAX;  // 重复次数;
//    animation.autoreverses = YES; // 动画结束时是否执行逆动画
    animation.fillMode  = kCAFillModeForwards;
    [animLayer addAnimation:animation forKey:@"strokeEnd"];
    
    
    UIBezierPath *bezierPath = [self transformToBezierPath:@"LOVE" withSize:CGSizeMake(size.width - 10, size.height)];
    [self kLayer:layer withSize:size tintColor:tintColor bezierPath:bezierPath];
}

- (void)kLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor bezierPath:(UIBezierPath*)bezierPath{
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = CGPathGetBoundingBox(bezierPath.CGPath);
    shapeLayer.position = CGPointMake(layer.bounds.size.width/2, layer.bounds.size.height/2);
    shapeLayer.geometryFlipped = YES;
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 1.5;
    shapeLayer.strokeColor = tintColor.CGColor;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = floorf(shapeLayer.bounds.size.width / 20); /// 向下取整，保证动画完整性
    [shapeLayer addAnimation:animation forKey:nil];
    [layer addSublayer:shapeLayer];
    
//    UIImage *penImage = self.writingPencil;
    UIView *pen = [UIView new];
    pen.backgroundColor = UIColor.redColor;
    CALayer *penLayer = [CALayer layer];
    penLayer.contents = (id)pen;
    penLayer.anchorPoint = CGPointZero;
    penLayer.frame = CGRectMake(0.0f, 0.0f, 3, 3);
    [shapeLayer addSublayer:penLayer];
    
    CAKeyframeAnimation *penAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    penAnimation.duration = animation.duration;
    penAnimation.path = shapeLayer.path;
    penAnimation.calculationMode = kCAAnimationPaced;
    penAnimation.removedOnCompletion = YES;
//    penAnimation.repeatCount = HUGE_VALF;
    penAnimation.beginTime = beginTime - 2.2;
    penAnimation.fillMode = kCAFillModeForwards;
    [penLayer addAnimation:penAnimation forKey:@"position"];
    
//    [penLayer performSelector:@selector(removeFromSuperlayer) withObject:nil afterDelay:penAnimation.duration];
}


- (UIBezierPath *)transformToBezierPath:(NSString *)string withSize:(CGSize)size{
    CGMutablePathRef paths = CGPathCreateMutable();
    NSString *name = [UIFont systemFontOfSize:(14)].fontName; /// 字体
    CFStringRef fontNameRef = (__bridge CFStringRef)name;
    CTFontRef fontRef = CTFontCreateWithName(fontNameRef, size.width/2.9, nil);
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:@{(__bridge NSString *)kCTFontAttributeName: (__bridge UIFont *)fontRef}];
    CTLineRef lineRef = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArrRef = CTLineGetGlyphRuns(lineRef);
    
    for (int runIndex = 0; runIndex < CFArrayGetCount(runArrRef); runIndex++) {
        const void *run = CFArrayGetValueAtIndex(runArrRef, runIndex);
        CTRunRef runb = (CTRunRef)run;
        const void *CTFontName = kCTFontAttributeName;
        const void *runFontC = CFDictionaryGetValue(CTRunGetAttributes(runb), CTFontName);
        CTFontRef runFontS = (CTFontRef)runFontC;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        int temp = 0;
        CGFloat offset = .0;
        for (int i = 0; i < CTRunGetGlyphCount(runb); i++) {
            CFRange range = CFRangeMake(i, 1);
            CGGlyph glyph = 0;
            CTRunGetGlyphs(runb, range, &glyph);
            CGPoint position = CGPointZero;
            CTRunGetPositions(runb, range, &position);
            CGFloat temp3 = position.x;
            int temp2 = (int)temp3/width;
            CGFloat temp1 = 0;
            if (temp2 > temp1) {
                temp = temp2;
                offset = position.x - (CGFloat)temp;
            }
            CGPathRef path = CTFontCreatePathForGlyph(runFontS, glyph, nil);
            CGFloat x = position.x - (CGFloat)temp*width - offset;
            CGFloat y = position.y - (CGFloat)temp * 80;
            CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
            CGPathAddPath(paths, &transform, path);
            CGPathRelease(path);
        }
        CFRelease(runb);
        CFRelease(runFontS);
    }
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointZero];
    [bezierPath appendPath:[UIBezierPath bezierPathWithCGPath:paths]];
    
    CGPathRelease(paths);
    CFRelease(fontNameRef);
    CFRelease(fontRef);
    
    return bezierPath;
}


@end
