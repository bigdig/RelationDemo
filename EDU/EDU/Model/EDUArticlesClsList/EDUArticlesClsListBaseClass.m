//
//  EDUArticlesClsListBaseClass.m
//
//  Created by   on 2016/10/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUArticlesClsListBaseClass.h"
#import "EDUArticlesClsListInfo.h"


NSString *const kEDUArticlesClsListBaseClassMessage = @"message";
NSString *const kEDUArticlesClsListBaseClassInfo = @"info";
NSString *const kEDUArticlesClsListBaseClassCode = @"code";


@interface EDUArticlesClsListBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUArticlesClsListBaseClass

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
            self.message = [self objectOrNilForKey:kEDUArticlesClsListBaseClassMessage fromDictionary:dict];
    NSObject *receivedEDUArticlesClsListInfo = [dict objectForKey:kEDUArticlesClsListBaseClassInfo];
    NSMutableArray *parsedEDUArticlesClsListInfo = [NSMutableArray array];
    
    if ([receivedEDUArticlesClsListInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUArticlesClsListInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUArticlesClsListInfo addObject:[EDUArticlesClsListInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUArticlesClsListInfo isKindOfClass:[NSDictionary class]]) {
       [parsedEDUArticlesClsListInfo addObject:[EDUArticlesClsListInfo modelObjectWithDictionary:(NSDictionary *)receivedEDUArticlesClsListInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedEDUArticlesClsListInfo];
            self.code = [[self objectOrNilForKey:kEDUArticlesClsListBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUArticlesClsListBaseClassMessage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kEDUArticlesClsListBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUArticlesClsListBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUArticlesClsListBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUArticlesClsListBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUArticlesClsListBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUArticlesClsListBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUArticlesClsListBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUArticlesClsListBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUArticlesClsListBaseClass *copy = [[EDUArticlesClsListBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
