//
//  CourseDetailBaseClass.m
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CourseDetailBaseClass.h"
#import "CourseDetailInfo.h"


NSString *const kCourseDetailBaseClassMessage = @"message";
NSString *const kCourseDetailBaseClassInfo = @"info";
NSString *const kCourseDetailBaseClassCode = @"code";


@interface CourseDetailBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CourseDetailBaseClass

@synthesize message = _message;
@synthesize info = _info;
@synthesize code = _code;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.message = [self objectOrNilForKey:kCourseDetailBaseClassMessage fromDictionary:dict];
            self.info = [CourseDetailInfo modelObjectWithDictionary:[dict objectForKey:kCourseDetailBaseClassInfo]];
            self.code = [[self objectOrNilForKey:kCourseDetailBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kCourseDetailBaseClassMessage];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kCourseDetailBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kCourseDetailBaseClassCode];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.message = [aDecoder decodeObjectForKey:kCourseDetailBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kCourseDetailBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kCourseDetailBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kCourseDetailBaseClassMessage];
    [aCoder encodeObject:_info forKey:kCourseDetailBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kCourseDetailBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    CourseDetailBaseClass *copy = [[CourseDetailBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
