//
//  UIView+KJLoading.h
//  KJLoadingDemo
//
//  Created by 杨科军 on 2020/9/9.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJLoading.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIView (KJLoading)
/// 显示加载框
- (void)kj_displayLoading;
- (void)kj_displayLoadingWithTitle:(NSString*)title;
/// 隐藏加载框
- (void)kj_dismissLodaing;

@end

NS_ASSUME_NONNULL_END
