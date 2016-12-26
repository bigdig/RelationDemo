//
//  EDUGroupCourseListResTags.h
//
//  Created by   on 2016/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUGroupCourseListResTags : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resTagsIdentifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double groupId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
