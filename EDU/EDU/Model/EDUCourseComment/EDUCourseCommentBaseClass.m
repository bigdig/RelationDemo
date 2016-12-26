//
//  EDUCourseCommentBaseClass.m
//
//  Created by   on 2016/10/27
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUCourseCommentBaseClass.h"
#import "EDUCourseCommentInfo.h"


NSString *const kEDUCourseCommentBaseClassMessage = @"message";
NSString *const kEDUCourseCommentBaseClassInfo = @"info";
NSString *const kEDUCourseCommentBaseClassCode = @"code";


@interface EDUCourseCommentBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseCommentBaseClass

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
            self.message = [self objectOrNilForKey:kEDUCourseCommentBaseClassMessage fromDictionary:dict];
    NSObject *receivedEDUCourseCommentInfo = [dict objectForKey:kEDUCourseCommentBaseClassInfo];
    NSMutableArray *parsedEDUCourseCommentInfo = [NSMutableArray array];
    
    if ([receivedEDUCourseCommentInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUCourseCommentInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUCourseCommentInfo addObject:[EDUCourseCommentInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUCourseCommentInfo isKindOfClass:[NSDictionary class]]) {
       [parsedEDUCourseCommentInfo addObject:[EDUCourseCommentInfo modelObjectWithDictionary:(NSDictionary *)receivedEDUCourseCommentInfo]];
    }

    self.info = [NSArray arrayWithArray:parsedEDUCourseCommentInfo];
            self.code = [[self objectOrNilForKey:kEDUCourseCommentBaseClassCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kEDUCourseCommentBaseClassMessage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForInfo] forKey:kEDUCourseCommentBaseClassInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kEDUCourseCommentBaseClassCode];

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

    self.message = [aDecoder decodeObjectForKey:kEDUCourseCommentBaseClassMessage];
    self.info = [aDecoder decodeObjectForKey:kEDUCourseCommentBaseClassInfo];
    self.code = [aDecoder decodeDoubleForKey:kEDUCourseCommentBaseClassCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kEDUCourseCommentBaseClassMessage];
    [aCoder encodeObject:_info forKey:kEDUCourseCommentBaseClassInfo];
    [aCoder encodeDouble:_code forKey:kEDUCourseCommentBaseClassCode];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUCourseCommentBaseClass *copy = [[EDUCourseCommentBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
