//
//  KJProgressHUD.h
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/4/5.
//  Copyright © 2019 杨科军. All rights reserved.
//

/* 一款动画的HUD
 使用方法：KJLoadingConfiguration 设置相关配置信息
 */

#import <Foundation/Foundation.h>
#import "KJProgressConfiguration.h"
NS_ASSUME_NONNULL_BEGIN

@interface KJProgressHUD : NSObject

/// HUD  __nullable 可以为空 view为空展示在KeyWindow
+ (void)kProgressHUDWithView:(UIView*__nullable)view Configuration:(KJProgressConfiguration*__nullable)configuration;

@end

NS_ASSUME_NONNULL_END
