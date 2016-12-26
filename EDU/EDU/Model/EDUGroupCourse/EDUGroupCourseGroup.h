//
//  EDUGroupCourseGroup.h
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUGroupCourseGroup : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *totalTimeShow;
@property (nonatomic, assign) double groupIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *titlePic;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, assign) double cnt;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
