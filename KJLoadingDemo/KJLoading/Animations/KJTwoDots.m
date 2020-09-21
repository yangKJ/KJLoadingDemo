//
//  KJTwoDotsAnimation.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/20.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJTwoDots.h"

@implementation KJTwoDots
- (void)kj_setAnimationFromLayer:(CALayer *)layer Size:(CGSize)size Color:(UIColor *)tintColor {
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CGFloat circleSize = size.width * 0.92f;
    CGFloat oX = (layer.bounds.size.width - size.width * 1.25f);
    CGFloat oY = (layer.bounds.size.height - circleSize) / 2.0f;
    for (int i = 0; i < 2; i++) {
        CALayer *circle = [CALayer layer];
        CGFloat offset = circleSize / 2.0f * i;
        circle.frame = CGRectMake((offset + size.width - circleSize) * i + oX, oY, circleSize, circleSize);
        circle.cornerRadius = circle.bounds.size.height / 2.0f;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.transform = CATransform3DMakeScale(0.0f, 0.0f, 0.0f);
        circle.backgroundColor = tintColor.CGColor;
        
        CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnimation.removedOnCompletion = NO;
        transformAnimation.repeatCount = HUGE_VALF;
        transformAnimation.duration = 1.8f;
        transformAnimation.beginTime = beginTime - (transformAnimation.duration / 2.0f * i);
        transformAnimation.keyTimes = @[@(0.0), @(0.5), @(1.0)];
        
        transformAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        transformAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)],
                                      [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)],
                                      [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)]];
        
        [layer addSublayer:circle];
        [circle addAnimation:transformAnimation forKey:@"animation"];
    }
}

@end
