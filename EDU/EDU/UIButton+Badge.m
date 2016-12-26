//
//  UIButton+Badge.m
//  EDU
//
//  Created by renxingguo on 16/9/12.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "UIButton+Badge.h"

@implementation UIButton (Badge)

- (void)setBadgeWithNumber:(NSInteger)number center:(CGPoint)center {
    UILabel *badge = [self viewWithTag:88];
    if (badge == nil) {
        badge = [[UILabel alloc] init];
        [self addSubview:badge];
        CGFloat width = 0;
        if (number > 0 & number <= 9) {
            width = 15;
        } else if (number > 9 & number <= 99) {
            width = 21;
        } else if (number > 99 & number <= 999) {
            width = 25;
        } else if (number > 999 & number <= 9999) {
            width = 32;
        }
        badge.frame = CGRectMake(0, 0, width, 15);
        if (CGPointEqualToPoint(center, CGPointZero)) {
            badge.center = CGPointMake(self.bounds.size.width, 0);
        } else {
            badge.center = center;
        }
        //        [badge mas_makeConstraints:^(MASConstraintMaker *make) {
        //            if (CGPointEqualToPoint(center, CGPointZero)) {
        //                make.centerX.equalTo(self.mas_right);
        //                make.centerY.equalTo(self.mas_top);
        //            }else {
        //                make.center.equalTo([NSValue valueWithCGPoint:center]);
        //            }
        //            make.height.equalTo(@15);
        //            CGFloat width = 0;
        //            if (number > 0 & number <= 9) {
        //                width = 15;
        //            } else if (number > 9 & number <= 99) {
        //                width = 21;
        //            } else if (number > 99 & number <= 999) {
        //                width = 25;
        //            } else if (number > 999 & number <= 9999) {
        //                width = 32;
        //            }
        //            make.width.equalTo(@(width));
        //        }];
        badge.textAlignment = NSTextAlignmentCenter;
        badge.backgroundColor = [UIColor redColor];
        badge.textColor = [UIColor whiteColor];
        badge.font = [UIFont systemFontOfSize:11];
        badge.layer.cornerRadius = 8.0f;
        badge.layer.masksToBounds = YES;
        self.clipsToBounds = NO;
    }
    badge.text = [NSString stringWithFormat:@"%ld", number];
}
- (void)setBadgeWithNumber:(NSInteger)number {
    [self setBadgeWithNumber:number center:CGPointZero];
}

@end
