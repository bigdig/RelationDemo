//
//  EDUSearchResultBaseClass.m
//
//  Created by   on 2016/10/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUSearchResultBaseClass.h"
#import "EDUSearchResultInfo.h"


NSString *const kEDUSearchResultBaseClassMessage = @"message";
NSString *const kEDUSearchResultBaseClassInfo = @"info";
NSString *const kEDUSearchResultBaseClassCode = @"code";


@interface EDUSearchResultBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUSearchResultBaseClass

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
            self.message = [self objectOrNilForKey:kEDUSearchResultBaseClassMessage fromDictionary:dict];
            self.info = [EDUSearchResultInfo modelObjectWithDictionary:[dict objectForKey:kEDUSearchResultBaseClassInfo]];
            self.code = [[self objectOrNilForKey:kEDUSearchResultBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUSearchResultBaseClassMessage];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kEDUSearchResultBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUSearchResultBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUSearchResultBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUSearchResultBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUSearchResultBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUSearchResultBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUSearchResultBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUSearchResultBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUSearchResultBaseClass *copy = [[EDUSearchResultBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
