//
//  EDUGroupCourseListResAuth.h
//
//  Created by   on 2016/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUGroupCourseListResAuth : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resAuthIdentifier;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
