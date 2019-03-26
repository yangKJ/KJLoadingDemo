//
//  ViewController.m
//  KJLoadingDemo
//
//  Created by 杨科军 on 2019/3/25.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "ViewController.h"
#import "KJLoadingAnimationTool.h" /// 加载动画工具

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KJLoadingAnimationTool *tool = [[KJLoadingAnimationTool alloc]init];
    KJLoadingAnmationConfiguration *loadingConfig = [KJLoadingAnmationConfiguration defaultLoadingAnmationConfiguration];
    loadingConfig.class_name = @"KJCustom";
    loadingConfig.kType = KJLoadingAnimationTypeCustom;
    [tool kLoadingAnimationStartAnimatingWithView:self.view1 Configuration:loadingConfig];
    
    [self xxx];
}

- (void)xxx{
    KJLoadingAnmationConfiguration *loadingConfig = [KJLoadingAnmationConfiguration defaultLoadingAnmationConfiguration];
    loadingConfig.kDisplayString = @"";
    loadingConfig.kOpenRandomType = YES;
    loadingConfig.kSize = CGSizeMake(100, 100);
    [[KJLoadingAnimationTool kLoadingAnimationTool] kLoadingAnimationStartAnimatingWithView:self.view2 Configuration:loadingConfig];
}

- (IBAction)start:(UIButton *)sender {
    [self xxx];
}
- (IBAction)end:(UIButton *)sender {
    [[KJLoadingAnimationTool kLoadingAnimationTool] kLoadingAnimationStopAnimating];
}

@end
