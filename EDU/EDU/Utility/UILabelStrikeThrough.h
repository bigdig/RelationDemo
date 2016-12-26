//
//  UILabelStrikeThrough.h
//  DressingCollection
//
//  Created by Jin XuDong on 13-7-8.
//  Copyright (c) 2013年 fan junChao. All rights reserved.
//

/*
 *  用于在UILabel上画删除线
 */
#import<Foundation/Foundation.h>

@interface UILabelStrikeThrough :UILabel
{
    BOOL isWithStrikeThrough;
}

@property (nonatomic,assign) BOOL isWithStrikeThrough;
@end