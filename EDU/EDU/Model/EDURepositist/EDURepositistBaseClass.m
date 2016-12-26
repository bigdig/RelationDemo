//
//  EDURepositistBaseClass.m
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDURepositistBaseClass.h"
#import "EDURepositistInfo.h"


NSString *const kEDURepositistBaseClassMessage = @"message";
NSString *const kEDURepositistBaseClassInfo = @"info";
NSString *const kEDURepositistBaseClassCode = @"code";


@interface EDURepositistBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDURepositistBaseClass

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
            self.message = [self objectOrNilForKey:kEDURepositistBaseClassMessage fromDictionary:dict];
            self.info = [EDURepositistInfo modelObjectWithDictionary:[dict objectForKey:kEDURepositistBaseClassInfo]];
            self.code = [[self objectOrNilForKey:kEDURepositistBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDURepositistBaseClassMessage];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kEDURepositistBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDURepositistBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDURepositistBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDURepositistBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDURepositistBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDURepositistBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDURepositistBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDURepositistBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDURepositistBaseClass *copy = [[EDURepositistBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
