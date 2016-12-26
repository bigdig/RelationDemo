//
//  EDUCourseTaskBaseClass.m
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUCourseTaskBaseClass.h"
#import "EDUCourseTaskInfo.h"


NSString *const kEDUCourseTaskBaseClassMessage = @"message";
NSString *const kEDUCourseTaskBaseClassInfo = @"info";
NSString *const kEDUCourseTaskBaseClassCode = @"code";


@interface EDUCourseTaskBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseTaskBaseClass

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
            self.message = [self objectOrNilForKey:kEDUCourseTaskBaseClassMessage fromDictionary:dict];
    NSObject *receivedEDUCourseTaskInfo = [dict objectForKey:kEDUCourseTaskBaseClassInfo];
    NSMutableArray *parsedEDUCourseTaskInfo = [NSMutableArray array];
    
    if ([receivedEDUCourseTaskInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUCourseTaskInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUCourseTaskInfo addObject:[EDUCourseTaskInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUCourseTaskInfo isKindOfClass:[NSDictionary class]]) {
       [parsedEDUCourseTaskInfo addObject:[EDUCourseTaskInfo modelObjectWithDictionary:(NSDictionary *)receivedEDUCourseTaskInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedEDUCourseTaskInfo];
            self.code = [[self objectOrNilForKey:kEDUCourseTaskBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUCourseTaskBaseClassMessage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kEDUCourseTaskBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUCourseTaskBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUCourseTaskBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUCourseTaskBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUCourseTaskBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUCourseTaskBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUCourseTaskBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUCourseTaskBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUCourseTaskBaseClass *copy = [[EDUCourseTaskBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
