//
//  ViewController.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/25.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "ViewController.h"
#import "KJLoading.h" /// 加载动画工具

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSMutableArray *arr = [NSMutableArray array];
//    for (NSInteger i = 1; i <= 40 ; i++) {
//        NSString *name = [NSString stringWithFormat:@"KJLoadingAnimation.bundle/loading_10%.2ld",i];
//        [arr addObject:[UIImage imageNamed:name]];
//    }
    
    KJLoading *tool = [[KJLoading alloc]init];
    KJLoadingDeploy *loadingConfig = [KJLoadingDeploy kj_default];
    loadingConfig.kDisplayString = @"测试数据加载中...";
//    loadingConfig.class_name = @"KJCustom";
    loadingConfig.kType = KJLoadingAnimationTypeCircleStrokeSpin;
//    loadingConfig.kImages = arr;
    [tool kLoadingAnimationStartAnimatingWithView:self.view1 Configuration:loadingConfig];
}

- (void)setNeedsFocusUpdate{
    [self xxx];
}

- (void)xxx{
    KJLoadingDeploy *loadingConfig = [KJLoadingDeploy kj_default];
    loadingConfig.kDisplayString = @"";
    loadingConfig.kOpenRandomType = YES;
    loadingConfig.kSize = CGSizeMake(120, 100);
    loadingConfig.kDismiss = YES;
    [[KJLoading kLoadingAnimation] kLoadingAnimationStartAnimatingWithView:self.view2 Configuration:loadingConfig];
}

- (IBAction)start:(UIButton *)sender {
    [self xxx];
}
- (IBAction)end:(UIButton *)sender {
    [[KJLoading kLoadingAnimation] kLoadingAnimationStopAnimating];
}

@end
