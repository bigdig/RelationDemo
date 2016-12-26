//
//  EDUBaiduSchoolBaseClass.m
//
//  Created by   on 2016/11/9
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUBaiduSchoolBaseClass.h"
#import "EDUBaiduSchoolResults.h"


NSString *const kEDUBaiduSchoolBaseClassStatus = @"status";
NSString *const kEDUBaiduSchoolBaseClassMessage = @"message";
NSString *const kEDUBaiduSchoolBaseClassResults = @"results";


@interface EDUBaiduSchoolBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUBaiduSchoolBaseClass

@synthesize status = _status;
@synthesize message = _message;
@synthesize results = _results;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.status = [[self objectOrNilForKey:kEDUBaiduSchoolBaseClassStatus fromDictionary:dict] doubleValue];
            self.message = [self objectOrNilForKey:kEDUBaiduSchoolBaseClassMessage fromDictionary:dict];
    NSObject *receivedEDUBaiduSchoolResults = [dict objectForKey:kEDUBaiduSchoolBaseClassResults];
    NSMutableArray *parsedEDUBaiduSchoolResults = [NSMutableArray array];
    
    if ([receivedEDUBaiduSchoolResults isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUBaiduSchoolResults) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUBaiduSchoolResults addObject:[EDUBaiduSchoolResults modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUBaiduSchoolResults isKindOfClass:[NSDictionary class]]) {
       [parsedEDUBaiduSchoolResults addObject:[EDUBaiduSchoolResults modelObjectWithDictionary:(NSDictionary *)receivedEDUBaiduSchoolResults]];
    }

    self.results = [NSArray arrayWithArray:parsedEDUBaiduSchoolResults];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kEDUBaiduSchoolBaseClassStatus];
    [mutableDict setValue:self.message forKey:kEDUBaiduSchoolBaseClassMessage];
    NSMutableArray *tempArrayForResults = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.results) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResults addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResults addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResults] forKey:kEDUBaiduSchoolBaseClassResults];

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

    self.status = [aDecoder decodeDoubleForKey:kEDUBaiduSchoolBaseClassStatus];
    self.message = [aDecoder decodeObjectForKey:kEDUBaiduSchoolBaseClassMessage];
    self.results = [aDecoder decodeObjectForKey:kEDUBaiduSchoolBaseClassResults];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kEDUBaiduSchoolBaseClassStatus];
    [aCoder encodeObject:_message forKey:kEDUBaiduSchoolBaseClassMessage];
    [aCoder encodeObject:_results forKey:kEDUBaiduSchoolBaseClassResults];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUBaiduSchoolBaseClass *copy = [[EDUBaiduSchoolBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.status = self.status;
        copy.message = [self.message copyWithZone:zone];
        copy.results = [self.results copyWithZone:zone];
    }
    
    return copy;
}


@end
