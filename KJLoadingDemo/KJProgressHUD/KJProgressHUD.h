//
//  KJProgressHUD.h
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/4/5.
//  Copyright © 2019 杨科军. All rights reserved.
//

/* 一款动画的HUD
 使用方法：KJProgressDeploy 设置相关配置信息
 */

#import <Foundation/Foundation.h>
#import "KJProgressDeploy.h"
NS_ASSUME_NONNULL_BEGIN

@interface KJProgressHUD : NSObject

/// HUD  为空时展示在KeyWindow
+ (void)kProgressHUDWithView:(UIView*__nullable)view Configuration:(KJProgressDeploy*__nullable)configuration;

@end

NS_ASSUME_NONNULL_END
