//
//  FMRelationListBaseClass.m
//
//  Created by   on 2016/12/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FMRelationListBaseClass.h"
#import "FMRelationListInfo.h"


NSString *const kFMRelationListBaseClassMessage = @"message";
NSString *const kFMRelationListBaseClassInfo = @"info";
NSString *const kFMRelationListBaseClassCode = @"code";


@interface FMRelationListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FMRelationListBaseClass

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
            self.message = [self objectOrNilForKey:kFMRelationListBaseClassMessage fromDictionary:dict];
            self.info = [FMRelationListInfo modelObjectWithDictionary:[dict objectForKey:kFMRelationListBaseClassInfo]];
            self.code = [[self objectOrNilForKey:kFMRelationListBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kFMRelationListBaseClassMessage];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kFMRelationListBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kFMRelationListBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kFMRelationListBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kFMRelationListBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kFMRelationListBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kFMRelationListBaseClassMessage];
    [aCoder encodeObject:_info forKey:kFMRelationListBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kFMRelationListBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    FMRelationListBaseClass *copy = [[FMRelationListBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
