//
//  EDUCourseListBaseClass.m
//
//  Created by xingguo ren on 16/9/1
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUCourseListBaseClass.h"
#import "EDUCourseListInfo.h"


NSString *const kEDUCourseListBaseClassMessage = @"message";
NSString *const kEDUCourseListBaseClassInfo = @"info";
NSString *const kEDUCourseListBaseClassCode = @"code";


@interface EDUCourseListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseListBaseClass

@synthesize message = _message;
@synthesize info = _info;
@synthesize code = _code;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.message = [self objectOrNilForKey:kEDUCourseListBaseClassMessage fromDictionary:dict];
            self.info = [EDUCourseListInfo modelObjectWithDictionary:[dict objectForKey:kEDUCourseListBaseClassInfo]];
            self.code = [[self objectOrNilForKey:kEDUCourseListBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUCourseListBaseClassMessage];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kEDUCourseListBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUCourseListBaseClassCode];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.message = [aDecoder decodeObjectForKey:kEDUCourseListBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUCourseListBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUCourseListBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUCourseListBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUCourseListBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUCourseListBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUCourseListBaseClass *copy = [[EDUCourseListBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
