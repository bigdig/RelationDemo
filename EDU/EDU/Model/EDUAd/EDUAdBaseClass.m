//
//  EDUAdBaseClass.m
//
//  Created by   on 2016/12/7
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUAdBaseClass.h"
#import "EDUAdInfo.h"


NSString *const kEDUAdBaseClassNum = @"num";
NSString *const kEDUAdBaseClassInfo = @"info";


@interface EDUAdBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUAdBaseClass

@synthesize num = _num;
@synthesize info = _info;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.num = [[self objectOrNilForKey:kEDUAdBaseClassNum fromDictionary:dict] doubleValue];
    NSObject *receivedEDUAdInfo = [dict objectForKey:kEDUAdBaseClassInfo];
    NSMutableArray *parsedEDUAdInfo = [NSMutableArray array];
    
    if ([receivedEDUAdInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUAdInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUAdInfo addObject:[EDUAdInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUAdInfo isKindOfClass:[NSDictionary class]]) {
       [parsedEDUAdInfo addObject:[EDUAdInfo modelObjectWithDictionary:(NSDictionary *)receivedEDUAdInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedEDUAdInfo];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.num] forKey:kEDUAdBaseClassNum];
    NSMutableArray *tempArrayForInfo = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.info) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kEDUAdBaseClassInfo];

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

    self.num = [aDecoder decodeDoubleForKey:kEDUAdBaseClassNum];
    self.info = [aDecoder decodeObjectForKey:kEDUAdBaseClassInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_num forKey:kEDUAdBaseClassNum];
    [aCoder encodeObject:_info forKey:kEDUAdBaseClassInfo];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUAdBaseClass *copy = [[EDUAdBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.num = self.num;
        copy.info = [self.info copyWithZone:zone];
    }
    
    return copy;
}


@end
