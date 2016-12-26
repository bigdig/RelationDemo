//
//  EDUCourseListInfo.h
//
//  Created by xingguo ren on 16/9/1
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUCourseListInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *list;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
