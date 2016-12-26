//
//  EDUTagListBaseClass.m
//
//  Created by   on 2016/12/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUTagListBaseClass.h"
#import "EDUTagListInfo.h"


NSString *const kEDUTagListBaseClassMessage = @"message";
NSString *const kEDUTagListBaseClassInfo = @"info";
NSString *const kEDUTagListBaseClassCode = @"code";


@interface EDUTagListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUTagListBaseClass

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
            self.message = [self objectOrNilForKey:kEDUTagListBaseClassMessage fromDictionary:dict];
            self.info = [EDUTagListInfo modelObjectWithDictionary:[dict objectForKey:kEDUTagListBaseClassInfo]];
            self.code = [[self objectOrNilForKey:kEDUTagListBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUTagListBaseClassMessage];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kEDUTagListBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUTagListBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUTagListBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUTagListBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUTagListBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUTagListBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUTagListBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUTagListBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUTagListBaseClass *copy = [[EDUTagListBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
