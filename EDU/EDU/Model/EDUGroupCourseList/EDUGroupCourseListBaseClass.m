//
//  EDUGroupCourseListBaseClass.m
//
//  Created by   on 2016/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUGroupCourseListBaseClass.h"
#import "EDUGroupCourseListInfo.h"


NSString *const kEDUGroupCourseListBaseClassMessage = @"message";
NSString *const kEDUGroupCourseListBaseClassInfo = @"info";
NSString *const kEDUGroupCourseListBaseClassCode = @"code";


@interface EDUGroupCourseListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupCourseListBaseClass

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
            self.message = [self objectOrNilForKey:kEDUGroupCourseListBaseClassMessage fromDictionary:dict];
            self.info = [EDUGroupCourseListInfo modelObjectWithDictionary:[dict objectForKey:kEDUGroupCourseListBaseClassInfo]];
            self.code = [[self objectOrNilForKey:kEDUGroupCourseListBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUGroupCourseListBaseClassMessage];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kEDUGroupCourseListBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUGroupCourseListBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUGroupCourseListBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUGroupCourseListBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUGroupCourseListBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUGroupCourseListBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUGroupCourseListBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUGroupCourseListBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUGroupCourseListBaseClass *copy = [[EDUGroupCourseListBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
