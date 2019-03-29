//
//  KJElectrocardiogramAnimation.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/26.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJElectrocardiogram.h"

@implementation KJElectrocardiogram
- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat w = size.width;
    CGFloat h = size.height;
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame         = CGRectMake(0, 0, w, h);
        shapeLayer.path          = [self pathWithSize:size].CGPath;
        
        shapeLayer.fillColor   = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor grayColor].CGColor;
        shapeLayer.lineWidth   = 0.5f;
        shapeLayer.opacity     = 0.5f;
        shapeLayer.position    = CGPointMake(w/2, h/2);
        [shapeLayer setTransform:CATransform3DMakeScale(1, 1, 1.f)];
        
        [layer addSublayer:shapeLayer];
    }
    // Red line animation.
    {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame         = CGRectMake(0, 0, w, h);
        shapeLayer.path          = [self pathWithSize:size].CGPath;
        shapeLayer.strokeEnd     = 0.f;
        shapeLayer.fillColor     = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor   = tintColor.CGColor;
        shapeLayer.lineWidth     = 2.f;
        shapeLayer.position      = CGPointMake(w/2, h/2);
        //        shapeLayer.shadowColor   = [UIColor redColor].CGColor;  // 阴影颜色
        //        shapeLayer.shadowOpacity = 1.f;
        //        shapeLayer.shadowRadius  = 1.f;
        //        shapeLayer.shadowOffset = CGSizeMake(5, 5);
        //        shapeLayer.lineCap       = kCALineCapSquare; //
        //        [shapeLayer setTransform:CATransform3DMakeScale(1, 1, 1.f)];
        [layer addSublayer:shapeLayer];
        
        CGFloat MAX = 0.98f;
        CGFloat GAP = 0.02;
        
        CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        aniStart.fromValue         = [NSNumber numberWithFloat:0.f];
        aniStart.toValue           = [NSNumber numberWithFloat:MAX];
        
        CABasicAnimation *aniEnd   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        aniEnd.fromValue           = [NSNumber numberWithFloat:0.f + GAP];
        aniEnd.toValue             = [NSNumber numberWithFloat:MAX + GAP];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration          = 1.f;  // 持续时间
        group.repeatCount       = CGFLOAT_MAX;  // 重复次数
        group.autoreverses      = YES; // 动画结束时是否执行逆动画
        group.animations        = @[aniEnd, aniStart];
        
        [shapeLayer addAnimation:group forKey:nil];
    }
}

- (UIBezierPath *)pathWithSize:(CGSize)size {  // 绘制路径
    CGFloat w = size.width;
    CGFloat h = size.height / 2;
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint   : CGPointMake(0, h)];
    [bezierPath addLineToPoint: CGPointMake(w/6, h)];
    [bezierPath addLineToPoint: CGPointMake(w/3, h + h/5)];
    [bezierPath addLineToPoint: CGPointMake(w/2, h - h/2)];
    [bezierPath addLineToPoint: CGPointMake(w/6 + w/2, h)];
    [bezierPath addLineToPoint: CGPointMake(w/3 + w/2, h - h/5)];
    [bezierPath addLineToPoint: CGPointMake(w, h)];
    
    return bezierPath;
}

@end
