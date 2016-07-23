//
//  CustomButtonView.h
//  控制器的选择
//  Created by 王奥东 on 16/3/12.
//  Copyright © 2016年 王奥东. All rights reserved.

#import <UIKit/UIKit.h>

@class CustomButtonView;
@protocol CustomButtonViewDelegate <NSObject>
- (void)CustomView:(CustomButtonView *)top didSelectButtonFrom:(int)from to:(int)to;
@end

@interface CustomButtonView : UIView

@property (nonatomic,assign)id<CustomButtonViewDelegate>delegate;


@end
