//
//  NSString+AttributeString.m
//  EDU
//
//  Created by renxingguo on 2016/12/27.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "NSString+AttributeString.h"
#import "YYText/YYText.h"

@implementation NSString (AttributeString)

+ (NSMutableAttributedString*)getNameSex:(NSString*)name sex:(NSInteger)sex
{
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:name  ];
    one.yy_font = [UIFont boldSystemFontOfSize:13];
    one.yy_color = [UIColor darkGrayColor];
    [text appendAttributedString:one];
    
    UIImage *image = [UIImage imageNamed:sex==0?@"female":@"male"];
    image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
    UIFont *font = [UIFont systemFontOfSize:12.0];
    NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    
    //add tap action
    
    {
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor whiteColor]];
        //                [highlight setBackgroundBorder:highlightBorder];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text1, NSRange range, CGRect rect) {
     
            /**
            [self.tableView reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath
                                  atScrollPosition:UITableViewScrollPositionTop
                                          animated:YES];
             */
     
        };
        [attachText yy_setTextHighlight:highlight range:attachText.yy_rangeOfAll];
    }
    
    [text appendAttributedString:attachText];
    return text;
}


@end
