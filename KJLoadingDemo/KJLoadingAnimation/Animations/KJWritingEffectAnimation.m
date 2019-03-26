//
//  KJWritingEffectAnimation.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/26.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJWritingEffectAnimation.h"
#import <CoreText/CoreText.h>

@implementation KJWritingEffectAnimation
@dynamic writingPencil;
- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    UIBezierPath *bezierPath = [self transformToBezierPath:self.writeString withSize:size];
    [self kLayer:layer withSize:size tintColor:tintColor bezierPath:bezierPath];
}

- (void)kLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor bezierPath:(UIBezierPath*)bezierPath{
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
    
    UIImage *penImage = self.writingPencil;
    CALayer *penLayer = [CALayer layer];
    penLayer.contents = (id)penImage.CGImage;
    penLayer.anchorPoint = CGPointZero;
    penLayer.frame = CGRectMake(0.0f, 0.0f, penImage.size.width, penImage.size.height);
    [shapeLayer addSublayer:penLayer];
    
    CAKeyframeAnimation *penAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    penAnimation.duration = animation.duration;
    penAnimation.path = shapeLayer.path;
    penAnimation.calculationMode = kCAAnimationPaced;
    penAnimation.removedOnCompletion = YES;
//    penAnimation.repeatCount = HUGE_VALF;
    penAnimation.fillMode = kCAFillModeForwards;
    [penLayer addAnimation:penAnimation forKey:@"position"];
    
    [penLayer performSelector:@selector(removeFromSuperlayer) withObject:nil afterDelay:penAnimation.duration];
}

- (UIBezierPath *)transformToBezierPath:(NSString *)string withSize:(CGSize)size{
    CGMutablePathRef paths = CGPathCreateMutable();
    NSString *name = self.writeFont.fontName; /// 字体
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
