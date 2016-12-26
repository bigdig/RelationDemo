//
//  EDUTagListInfo.m
//
//  Created by   on 2016/12/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUTagListInfo.h"
#import "EDUTagListInternalBaseClass1.h"
#import "EDUTagListInternalBaseClass2.h"


NSString *const kEDUTagListInfo2 = @"台词基础训练";
NSString *const kEDUTagListInfo1 = @"表演基础训练";


@interface EDUTagListInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUTagListInfo

@synthesize myProperty1 = _myProperty1;
@synthesize myProperty2 = _myProperty2;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedEDUTagListInternalBaseClass1 = [dict objectForKey:kEDUTagListInfo1];
    NSMutableArray *parsedEDUTagListInternalBaseClass1 = [NSMutableArray array];
    
    if ([receivedEDUTagListInternalBaseClass1 isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUTagListInternalBaseClass1) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUTagListInternalBaseClass1 addObject:[EDUTagListInternalBaseClass1 modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUTagListInternalBaseClass1 isKindOfClass:[NSDictionary class]]) {
       [parsedEDUTagListInternalBaseClass1 addObject:[EDUTagListInternalBaseClass1 modelObjectWithDictionary:(NSDictionary *)receivedEDUTagListInternalBaseClass1]];
    }

    self.myProperty1 = [NSArray arrayWithArray:parsedEDUTagListInternalBaseClass1];
    NSObject *receivedEDUTagListInternalBaseClass2 = [dict objectForKey:kEDUTagListInfo2];
    NSMutableArray *parsedEDUTagListInternalBaseClass2 = [NSMutableArray array];
    
    if ([receivedEDUTagListInternalBaseClass2 isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUTagListInternalBaseClass2) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUTagListInternalBaseClass2 addObject:[EDUTagListInternalBaseClass2 modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUTagListInternalBaseClass2 isKindOfClass:[NSDictionary class]]) {
       [parsedEDUTagListInternalBaseClass2 addObject:[EDUTagListInternalBaseClass2 modelObjectWithDictionary:(NSDictionary *)receivedEDUTagListInternalBaseClass2]];
    }

    self.myProperty2 = [NSArray arrayWithArray:parsedEDUTagListInternalBaseClass2];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForMyProperty1 = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.myProperty1) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMyProperty1 addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMyProperty1 addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMyProperty1] forKey:kEDUTagListInfo1];
    NSMutableArray *tempArrayForMyProperty2 = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.myProperty2) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMyProperty2 addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMyProperty2 addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMyProperty2] forKey:kEDUTagListInfo2];

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

    self.myProperty1 = [aDecoder decodeObjectForKey:kEDUTagListInfo1];
    self.myProperty2 = [aDecoder decodeObjectForKey:kEDUTagListInfo2];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_myProperty1 forKey:kEDUTagListInfo1];
    [aCoder encodeObject:_myProperty2 forKey:kEDUTagListInfo2];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUTagListInfo *copy = [[EDUTagListInfo alloc] init];
    
    
    
    if (copy) {

        copy.myProperty1 = [self.myProperty1 copyWithZone:zone];
        copy.myProperty2 = [self.myProperty2 copyWithZone:zone];
    }
    
    return copy;
}


@end
