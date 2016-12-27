//
//  FMUserEntityBaseClass.m
//
//  Created by   on 2016/12/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FMUserEntityBaseClass.h"
#import "FMUserEntityInfo.h"


NSString *const kFMUserEntityBaseClassMessage = @"message";
NSString *const kFMUserEntityBaseClassInfo = @"info";
NSString *const kFMUserEntityBaseClassCode = @"code";


@interface FMUserEntityBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FMUserEntityBaseClass

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
            self.message = [self objectOrNilForKey:kFMUserEntityBaseClassMessage fromDictionary:dict];
            self.info = [FMUserEntityInfo modelObjectWithDictionary:[dict objectForKey:kFMUserEntityBaseClassInfo]];
            self.code = [[self objectOrNilForKey:kFMUserEntityBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kFMUserEntityBaseClassMessage];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kFMUserEntityBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kFMUserEntityBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kFMUserEntityBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kFMUserEntityBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kFMUserEntityBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kFMUserEntityBaseClassMessage];
    [aCoder encodeObject:_info forKey:kFMUserEntityBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kFMUserEntityBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    FMUserEntityBaseClass *copy = [[FMUserEntityBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
