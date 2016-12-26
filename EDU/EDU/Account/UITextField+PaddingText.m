//
//  UITextField+PaddingText.m
//  EDU
//
//  Created by renxingguo on 2016/11/23.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "UITextField+PaddingText.h"

@implementation UITextField (PaddingText)

-(void) setLeftPadding:(int) paddingValue
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingValue, self.frame.size.height)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

-(void) setRightPadding:(int) paddingValue
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingValue, self.frame.size.height)];
    self.rightView = paddingView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

@end
