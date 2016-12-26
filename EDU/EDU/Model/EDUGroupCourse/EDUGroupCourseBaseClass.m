//
//  EDUGroupCourseBaseClass.m
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUGroupCourseBaseClass.h"
#import "EDUGroupCourseInfo.h"


NSString *const kEDUGroupCourseBaseClassMessage = @"message";
NSString *const kEDUGroupCourseBaseClassInfo = @"info";
NSString *const kEDUGroupCourseBaseClassCode = @"code";


@interface EDUGroupCourseBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUGroupCourseBaseClass

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
            self.message = [self objectOrNilForKey:kEDUGroupCourseBaseClassMessage fromDictionary:dict];
            self.info = [EDUGroupCourseInfo modelObjectWithDictionary:[dict objectForKey:kEDUGroupCourseBaseClassInfo]];
            self.code = [[self objectOrNilForKey:kEDUGroupCourseBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUGroupCourseBaseClassMessage];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kEDUGroupCourseBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUGroupCourseBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUGroupCourseBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUGroupCourseBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUGroupCourseBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUGroupCourseBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUGroupCourseBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUGroupCourseBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUGroupCourseBaseClass *copy = [[EDUGroupCourseBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
