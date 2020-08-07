//
//  KJWritingEffectAnimation.h
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/26.
//  Copyright © 2019 杨科军. All rights reserved.
//  写文字

#import "KJLoadingDeploy.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJWritingEffect : KJLoadingDeploy

@property(nonatomic,strong) NSString *writeString;
@property (nonatomic,strong) UIFont *writeFont;
@property (nonatomic,strong) UIImage *writingPencil;

@end

NS_ASSUME_NONNULL_END
