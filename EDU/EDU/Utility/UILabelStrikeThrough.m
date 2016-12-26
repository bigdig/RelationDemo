//
//  UILabelStrikeThrough.m
//  DressingCollection
//
//  Created by Jin XuDong on 13-7-8.
//  Copyright (c) 2013年 fan junChao. All rights reserved.
//

#import"UILabelStrikeThrough.h"

@implementation UILabelStrikeThrough

@synthesize isWithStrikeThrough;

- (void)drawRect:(CGRect)rect
{
    if (isWithStrikeThrough)
    {
        CGContextRef c = UIGraphicsGetCurrentContext();
        
        CGFloat red[4] = {1.0f,0.0f, 0.0f,0.8f}; //红色
        //CGFloat black[4] = {0.0f, 0.0f, 0.0f, 0.5f};//黑色
        CGContextSetStrokeColor(c, red);
        CGContextSetLineWidth(c, 2);
        CGContextBeginPath(c);
        //画直线
        CGFloat halfWayUp = rect.size.height/2 + rect.origin.y;
        CGContextMoveToPoint(c, rect.origin.x, halfWayUp );//开始点
        CGContextAddLineToPoint(c, rect.origin.x + rect.size.width, halfWayUp);//结束点
        //画斜线
        //CGContextMoveToPoint(c, rect.origin.x, rect.origin.y+5 );
        //CGContextAddLineToPoint(c, (rect.origin.x + rect.size.width)*0.5, rect.origin.y+rect.size.height-5); //斜线
        CGContextStrokePath(c);
    }
    
    [super drawRect:rect];
}

- (void)dealloc
{
}

@end
