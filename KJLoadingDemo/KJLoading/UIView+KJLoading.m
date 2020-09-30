//
//  UIView+KJLoading.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2020/9/9.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "UIView+KJLoading.h"

@implementation UIView (KJLoading)
/// 显示加载框
- (void)kj_displayLoading{
    [self kj_displayLoadingWithTitle:@""];
}
- (void)kj_displayLoadingWithTitle:(NSString*)title{
    KJLoadingDeploy *con = [KJLoadingDeploy kj_default];
    con.kSize = CGSizeMake(70, 70);
    con.kDisplayString = title;
    con.kType = KJLoadingAnimationTypeCircleStrokeSpin;
    [KJLoading kj_loadingAnimationStartAnimatingWithView:self Configuration:con];
}
/// 隐藏加载框
- (void)kj_dismissLodaing{
    [KJLoading kj_loadingAnimationStopAnimating];
}

@end
