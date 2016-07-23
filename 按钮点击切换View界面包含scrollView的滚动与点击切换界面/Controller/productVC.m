//
//  productVC.m
//  申购基金界面
//
//  Created by 王奥东 on 16/6/27.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "productVC.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "CustomButtonView.h"

#define W   [UIScreen mainScreen].bounds.size.width
#define H   [UIScreen mainScreen].bounds.size.height
@interface productVC ()<CustomButtonViewDelegate>
@property(nonatomic,strong)CustomButtonView  *customBtnView;
@end

@implementation productVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomButtonView *btnView = [[CustomButtonView alloc]initWithFrame:CGRectMake(0, 66, W, H)];
    [self.view addSubview:btnView];
    [self createCustomButton];
    
    [self addChildVCs];
    
    //默认先选择第一个控制器
    [self CustomView:nil didSelectButtonFrom:0 to:0];
}
- (void)createCustomButton
{
    self.customBtnView = [[CustomButtonView alloc] initWithFrame:CGRectMake(0,64, W, 49)];
    self.customBtnView.delegate = self;
    [self.view addSubview:self.customBtnView];
    
}

- (void)CustomView:(CustomButtonView *)tabBar didSelectButtonFrom:(int)from to:(int)to
{
    
    
    UIViewController *oldVc = self.childViewControllers[from%3];
    
    [oldVc.view removeFromSuperview];
    
    UIViewController *newVc = self.childViewControllers[to%3];
    
    newVc.view.frame = CGRectMake(0,64+49, W, H-64-49);
    [self.view addSubview:newVc.view];
    
}
- (void)addChildVCs
{
    FirstViewController *discountVc=[[FirstViewController alloc]init];
    [self addChildViewController:discountVc];
    
    SecondViewController *historyVc=[[SecondViewController alloc]init];
    [self addChildViewController:historyVc];
    
    ThirdViewController *part =[[ThirdViewController alloc]init];
    [self addChildViewController:part];
    
}

@end
