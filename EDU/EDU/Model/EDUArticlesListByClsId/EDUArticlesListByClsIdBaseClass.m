//
//  EDUArticlesListByClsIdBaseClass.m
//
//  Created by   on 2016/10/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUArticlesListByClsIdBaseClass.h"
#import "EDUArticlesListByClsIdInfo.h"


NSString *const kEDUArticlesListByClsIdBaseClassMessage = @"message";
NSString *const kEDUArticlesListByClsIdBaseClassInfo = @"info";
NSString *const kEDUArticlesListByClsIdBaseClassCode = @"code";


@interface EDUArticlesListByClsIdBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUArticlesListByClsIdBaseClass

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
            self.message = [self objectOrNilForKey:kEDUArticlesListByClsIdBaseClassMessage fromDictionary:dict];
    NSObject *receivedEDUArticlesListByClsIdInfo = [dict objectForKey:kEDUArticlesListByClsIdBaseClassInfo];
    NSMutableArray *parsedEDUArticlesListByClsIdInfo = [NSMutableArray array];
    
    if ([receivedEDUArticlesListByClsIdInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUArticlesListByClsIdInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUArticlesListByClsIdInfo addObject:[EDUArticlesListByClsIdInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUArticlesListByClsIdInfo isKindOfClass:[NSDictionary class]]) {
       [parsedEDUArticlesListByClsIdInfo addObject:[EDUArticlesListByClsIdInfo modelObjectWithDictionary:(NSDictionary *)receivedEDUArticlesListByClsIdInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedEDUArticlesListByClsIdInfo];
            self.code = [[self objectOrNilForKey:kEDUArticlesListByClsIdBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUArticlesListByClsIdBaseClassMessage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kEDUArticlesListByClsIdBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUArticlesListByClsIdBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUArticlesListByClsIdBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUArticlesListByClsIdBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUArticlesListByClsIdBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUArticlesListByClsIdBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUArticlesListByClsIdBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUArticlesListByClsIdBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUArticlesListByClsIdBaseClass *copy = [[EDUArticlesListByClsIdBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
