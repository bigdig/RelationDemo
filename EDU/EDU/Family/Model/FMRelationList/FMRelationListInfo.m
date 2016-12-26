//
//  FMRelationListInfo.m
//
//  Created by   on 2016/12/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FMRelationListInfo.h"
#import "FMRelationListRelation.h"


NSString *const kFMRelationListInfoRecode = @"recode";
NSString *const kFMRelationListInfoRedesc = @"redesc";
NSString *const kFMRelationListInfoRelation = @"relation";


@interface FMRelationListInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FMRelationListInfo

@synthesize recode = _recode;
@synthesize redesc = _redesc;
@synthesize relation = _relation;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.recode = [self objectOrNilForKey:kFMRelationListInfoRecode fromDictionary:dict];
            self.redesc = [self objectOrNilForKey:kFMRelationListInfoRedesc fromDictionary:dict];
    NSObject *receivedFMRelationListRelation = [dict objectForKey:kFMRelationListInfoRelation];
    NSMutableArray *parsedFMRelationListRelation = [NSMutableArray array];
    
    if ([receivedFMRelationListRelation isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFMRelationListRelation) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFMRelationListRelation addObject:[FMRelationListRelation modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFMRelationListRelation isKindOfClass:[NSDictionary class]]) {
       [parsedFMRelationListRelation addObject:[FMRelationListRelation modelObjectWithDictionary:(NSDictionary *)receivedFMRelationListRelation]];
    }

    self.relation = [NSArray arrayWithArray:parsedFMRelationListRelation];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.recode forKey:kFMRelationListInfoRecode];
    [mutableDict setValue:self.redesc forKey:kFMRelationListInfoRedesc];
    NSMutableArray *tempArrayForRelation = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.relation) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRelation addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRelation addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRelation] forKey:kFMRelationListInfoRelation];

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

    self.recode = [aDecoder decodeObjectForKey:kFMRelationListInfoRecode];
    self.redesc = [aDecoder decodeObjectForKey:kFMRelationListInfoRedesc];
    self.relation = [aDecoder decodeObjectForKey:kFMRelationListInfoRelation];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_recode forKey:kFMRelationListInfoRecode];
    [aCoder encodeObject:_redesc forKey:kFMRelationListInfoRedesc];
    [aCoder encodeObject:_relation forKey:kFMRelationListInfoRelation];
}

- (id)copyWithZone:(NSZone *)zone {
    FMRelationListInfo *copy = [[FMRelationListInfo alloc] init];
    
    
    
    if (copy) {

        copy.recode = [self.recode copyWithZone:zone];
        copy.redesc = [self.redesc copyWithZone:zone];
        copy.relation = [self.relation copyWithZone:zone];
    }
    
    return copy;
}


@end
