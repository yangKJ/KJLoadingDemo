//
//  KJPlayImageAnimation.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/26.
//  Copyright © 2019 杨科军. All rights reserved.
//
/* CAKeyframeAnimation 当中 animationwithkeypath 对应的值
transform.scale = 比例轉換
transform.scale.x = 闊的比例轉換
transform.scale.y = 高的比例轉換
transform.rotation.z = 平面圖的旋轉
opacity = 透明度
margin = 布局
 zPosition = 翻转
 backgroundColor = 背景颜色
 cornerRadius = 圆角
 borderWidth = 边框宽
 bounds = 大小
 contents = 内容
 contentsRect = 内容大小
 cornerRadius = 圆角
 frame = 大小位置
 hidden = 显示隐藏
*/
#import "KJPlayImageAnimation.h"

@interface KJPlayImageAnimation ()<CAAnimationDelegate>{
//    int _index;
    CALayer *_layer;
}

@end

@implementation KJPlayImageAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat w = size.width;
    //创建图像显示图层
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(0, 0, w + w / 2, w + w/3);
    _layer.position = CGPointMake(w/2, w/2 - w/8);
    [layer addSublayer:_layer];
    
//    //定义时钟对象
//    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
//    //添加时钟对象到主运行循环
//    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self kCGImages];
    [self xxxxLayer:_layer images:self.images];
}
- (NSArray*)kCGImages{
    //存放图片的数组
    NSMutableArray *array = [NSMutableArray array];
    for (UIImage *image in self.images) {
        CGImageRef cgimg = image.CGImage;
        [array addObject:(__bridge UIImage *)cgimg];
    }
    _images = array;
    return _images;
}

- (void)xxxxLayer:(CALayer*)layer images:(NSArray*)images{
    //创建CAKeyframeAnimation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];  /// 播放内容
    animation.duration = self.durat;
    animation.delegate = self;
    animation.values = images;
    [layer addAnimation:animation forKey:nil];
}

//#pragma mark - 每次屏幕刷新就会执行一次此方法(每秒接近60次)
//- (void)step{
//    //定义一个变量记录执行次数
//    static int s = 0;
//    // 每秒执行6次
//    if (++s % 10 == 0) {
//        UIImage *image = _images[_index];
//        _layer.contents = (id)image.CGImage; // 更新图片
//        _index = (_index + 1) % _images.count;
//    }
//}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    // 结束事件
    [self xxxxLayer:_layer images:self.images];
}

@end
