//
//  FMUserEntityInfo.m
//
//  Created by   on 2016/12/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FMUserEntityInfo.h"
#import "FMUserEntityEntityUser.h"


NSString *const kFMUserEntityInfoRecode = @"recode";
NSString *const kFMUserEntityInfoRedesc = @"redesc";
NSString *const kFMUserEntityInfoEntityUser = @"entityUser";


@interface FMUserEntityInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FMUserEntityInfo

@synthesize recode = _recode;
@synthesize redesc = _redesc;
@synthesize entityUser = _entityUser;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.recode = [[self objectOrNilForKey:kFMUserEntityInfoRecode fromDictionary:dict] doubleValue];
            self.redesc = [self objectOrNilForKey:kFMUserEntityInfoRedesc fromDictionary:dict];
            self.entityUser = [FMUserEntityEntityUser modelObjectWithDictionary:[dict objectForKey:kFMUserEntityInfoEntityUser]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.recode] forKey:kFMUserEntityInfoRecode];
    [mutableDict setValue:self.redesc forKey:kFMUserEntityInfoRedesc];
    [mutableDict setValue:[self.entityUser dictionaryRepresentation] forKey:kFMUserEntityInfoEntityUser];

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

    self.recode = [aDecoder decodeDoubleForKey:kFMUserEntityInfoRecode];
    self.redesc = [aDecoder decodeObjectForKey:kFMUserEntityInfoRedesc];
    self.entityUser = [aDecoder decodeObjectForKey:kFMUserEntityInfoEntityUser];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_recode forKey:kFMUserEntityInfoRecode];
    [aCoder encodeObject:_redesc forKey:kFMUserEntityInfoRedesc];
    [aCoder encodeObject:_entityUser forKey:kFMUserEntityInfoEntityUser];
}

- (id)copyWithZone:(NSZone *)zone {
    FMUserEntityInfo *copy = [[FMUserEntityInfo alloc] init];
    
    
    
    if (copy) {

        copy.recode = self.recode;
        copy.redesc = [self.redesc copyWithZone:zone];
        copy.entityUser = [self.entityUser copyWithZone:zone];
    }
    
    return copy;
}


@end
