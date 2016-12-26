//
//  NSString+URL.h
//  DressingCollection
//
//  Created by renxingguo on 16/4/13.
//  Copyright © 2016年 北京伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

//网址有中文解决
- (NSString *)URLEncodedString;
- (NSString *)URLEncodedStringFix;
- (NSString *)urlDecode;
@end
