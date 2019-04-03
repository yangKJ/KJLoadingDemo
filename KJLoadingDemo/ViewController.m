//
//  ViewController.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/25.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "ViewController.h"
#import "KJLoadingAnimation.h" /// 加载动画工具

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 1; i <= 24 ; i++) {
        NSString *name = [NSString stringWithFormat:@"as_10%.2ld",i];
        [arr addObject:[UIImage imageNamed:name]];
    }
    
    KJLoadingAnimation *tool = [[KJLoadingAnimation alloc]init];
    KJLoadingConfiguration *loadingConfig = [KJLoadingConfiguration defaultLoadingConfiguration];
    loadingConfig.kDisplayString = @"测试数据加载中...";
//    loadingConfig.class_name = @"KJCustom";
    loadingConfig.kType = KJLoadingAnimationTypeCircleStrokeSpin;
//    loadingConfig.kImages = arr;
    [tool kLoadingAnimationStartAnimatingWithView:self.view1 Configuration:loadingConfig];
    
    [self xxx];
}

- (void)xxx{
    KJLoadingConfiguration *loadingConfig = [KJLoadingConfiguration defaultLoadingConfiguration];
    loadingConfig.kDisplayString = @"";
    loadingConfig.kOpenRandomType = YES;
    loadingConfig.kSize = CGSizeMake(100, 100);
    loadingConfig.kDismiss = YES;
    [[KJLoadingAnimation kLoadingAnimation] kLoadingAnimationStartAnimatingWithView:self.view2 Configuration:loadingConfig];
}

- (IBAction)start:(UIButton *)sender {
    [self xxx];
}
- (IBAction)end:(UIButton *)sender {
    [[KJLoadingAnimation kLoadingAnimation] kLoadingAnimationStopAnimating];
}

@end
