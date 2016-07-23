//
//  CustomButtonView.m
//  控制器的选择
//  Created by 王奥东 on 16/3/12.
//  Copyright © 2016年 王奥东. All rights reserved.
#import "CustomButtonView.h"

#define MainWidth [[UIScreen mainScreen] bounds].size.width
@interface CustomButtonView()

@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)UIView *animateView;

@end
@implementation CustomButtonView

- (id)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor =[UIColor whiteColor];
    }
    
    return self;
}

- (void)createUI
{
    NSArray *titleArr = @[@"保险",@"固收",@"基金",@"贷款",@"定期",@"众筹"];
    for (NSInteger i=0; i<6; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(MainWidth/6*i,0, MainWidth/6, 49);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i==0) {
            [self btnClick:button];
        }
    }
    
    _animateView = [[UIView alloc] init];
    _animateView.frame = CGRectMake(0, 43, MainWidth/6, 3);
    _animateView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_animateView];
    
    UIView *botLine = [[UIView alloc]initWithFrame:CGRectMake(0, 45, MainWidth, 2)];
    botLine.backgroundColor = [UIColor grayColor];
    [self addSubview:botLine];
    
    
}

- (void)btnClick:(UIButton *)sender
{
    
 
    if ([_delegate respondsToSelector:@selector(CustomView:didSelectButtonFrom:to:)]) {
        [_delegate CustomView:self didSelectButtonFrom:(int)_selectBtn.tag to:(int)sender.tag];
    }
    
    _selectBtn.selected = NO;
    sender.selected = YES;
    _selectBtn = sender;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _animateView.frame = CGRectMake(0+MainWidth/6*sender.tag,43, MainWidth/6, 3);
        
    } completion:^(BOOL finished) {
        
    }];

}


@end
