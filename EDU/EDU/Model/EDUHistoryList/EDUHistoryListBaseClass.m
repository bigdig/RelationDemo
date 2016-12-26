//
//  EDUHistoryListBaseClass.m
//
//  Created by   on 2016/10/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUHistoryListBaseClass.h"
#import "EDUHistoryListInfo.h"


NSString *const kEDUHistoryListBaseClassMessage = @"message";
NSString *const kEDUHistoryListBaseClassInfo = @"info";
NSString *const kEDUHistoryListBaseClassCode = @"code";


@interface EDUHistoryListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUHistoryListBaseClass

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
            self.message = [self objectOrNilForKey:kEDUHistoryListBaseClassMessage fromDictionary:dict];
    NSObject *receivedEDUHistoryListInfo = [dict objectForKey:kEDUHistoryListBaseClassInfo];
    NSMutableArray *parsedEDUHistoryListInfo = [NSMutableArray array];
    
    if ([receivedEDUHistoryListInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUHistoryListInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUHistoryListInfo addObject:[EDUHistoryListInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUHistoryListInfo isKindOfClass:[NSDictionary class]]) {
       [parsedEDUHistoryListInfo addObject:[EDUHistoryListInfo modelObjectWithDictionary:(NSDictionary *)receivedEDUHistoryListInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedEDUHistoryListInfo];
            self.code = [[self objectOrNilForKey:kEDUHistoryListBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUHistoryListBaseClassMessage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kEDUHistoryListBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUHistoryListBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUHistoryListBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUHistoryListBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUHistoryListBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUHistoryListBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUHistoryListBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUHistoryListBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUHistoryListBaseClass *copy = [[EDUHistoryListBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
