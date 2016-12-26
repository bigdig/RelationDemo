//
//  EDUArticlesBaseClass.m
//
//  Created by ScanZen Workgroup on 2016/10/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUArticlesBaseClass.h"
#import "EDUArticlesInfo.h"


NSString *const kEDUArticlesBaseClassMessage = @"message";
NSString *const kEDUArticlesBaseClassInfo = @"info";
NSString *const kEDUArticlesBaseClassCode = @"code";


@interface EDUArticlesBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUArticlesBaseClass

@synthesize message = _message;
@synthesize info = _info;
@synthesize code = _code;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.message = [self objectOrNilForKey:kEDUArticlesBaseClassMessage fromDictionary:dict];
    NSObject *receivedEDUArticlesInfo = [dict objectForKey:kEDUArticlesBaseClassInfo];
    NSMutableArray *parsedEDUArticlesInfo = [NSMutableArray array];
    if ([receivedEDUArticlesInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUArticlesInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUArticlesInfo addObject:[EDUArticlesInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUArticlesInfo isKindOfClass:[NSDictionary class]]) {
       [parsedEDUArticlesInfo addObject:[EDUArticlesInfo modelObjectWithDictionary:(NSDictionary *)receivedEDUArticlesInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedEDUArticlesInfo];
            self.code = [[self objectOrNilForKey:kEDUArticlesBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUArticlesBaseClassMessage];
    NSMutableArray *tempArrayForInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.info) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kEDUArticlesBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUArticlesBaseClassCode];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.message = [aDecoder decodeObjectForKey:kEDUArticlesBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUArticlesBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUArticlesBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUArticlesBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUArticlesBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUArticlesBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUArticlesBaseClass *copy = [[EDUArticlesBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
