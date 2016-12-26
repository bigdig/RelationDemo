//
//  CourseDetailResAuth.h
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CourseDetailResAuth : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resAuthIdentifier;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
