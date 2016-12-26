//
//  EDUCourseCommentInfo.m
//
//  Created by   on 2016/10/27
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUCourseCommentInfo.h"
#import "EDUCourseCommentSacUser.h"
#import "EDUCourseCommentResCourse.h"


NSString *const kEDUCourseCommentInfoWords = @"words";
NSString *const kEDUCourseCommentInfoId = @"id";
NSString *const kEDUCourseCommentInfoAddTimeShow = @"addTimeShow";
NSString *const kEDUCourseCommentInfoSacUser = @"sacUser";
NSString *const kEDUCourseCommentInfoResCourse = @"resCourse";


@interface EDUCourseCommentInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseCommentInfo

@synthesize words = _words;
@synthesize infoIdentifier = _infoIdentifier;
@synthesize addTimeShow = _addTimeShow;
@synthesize sacUser = _sacUser;
@synthesize resCourse = _resCourse;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.words = [self objectOrNilForKey:kEDUCourseCommentInfoWords fromDictionary:dict];
            self.infoIdentifier = [[self objectOrNilForKey:kEDUCourseCommentInfoId fromDictionary:dict] doubleValue];
            self.addTimeShow = [self objectOrNilForKey:kEDUCourseCommentInfoAddTimeShow fromDictionary:dict];
            self.sacUser = [EDUCourseCommentSacUser modelObjectWithDictionary:[dict objectForKey:kEDUCourseCommentInfoSacUser]];
            self.resCourse = [EDUCourseCommentResCourse modelObjectWithDictionary:[dict objectForKey:kEDUCourseCommentInfoResCourse]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.words forKey:kEDUCourseCommentInfoWords];
    [mutableDict setValue:[NSNumber numberWithDouble:self.infoIdentifier] forKey:kEDUCourseCommentInfoId];
    [mutableDict setValue:self.addTimeShow forKey:kEDUCourseCommentInfoAddTimeShow];
    [mutableDict setValue:[self.sacUser dictionaryRepresentation] forKey:kEDUCourseCommentInfoSacUser];
    [mutableDict setValue:[self.resCourse dictionaryRepresentation] forKey:kEDUCourseCommentInfoResCourse];

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

    self.words = [aDecoder decodeObjectForKey:kEDUCourseCommentInfoWords];
    self.infoIdentifier = [aDecoder decodeDoubleForKey:kEDUCourseCommentInfoId];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDUCourseCommentInfoAddTimeShow];
    self.sacUser = [aDecoder decodeObjectForKey:kEDUCourseCommentInfoSacUser];
    self.resCourse = [aDecoder decodeObjectForKey:kEDUCourseCommentInfoResCourse];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_words forKey:kEDUCourseCommentInfoWords];
    [aCoder encodeDouble:_infoIdentifier forKey:kEDUCourseCommentInfoId];
    [aCoder encodeObject:_addTimeShow forKey:kEDUCourseCommentInfoAddTimeShow];
    [aCoder encodeObject:_sacUser forKey:kEDUCourseCommentInfoSacUser];
    [aCoder encodeObject:_resCourse forKey:kEDUCourseCommentInfoResCourse];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUCourseCommentInfo *copy = [[EDUCourseCommentInfo alloc] init];
    
    
    
    if (copy) {

        copy.words = [self.words copyWithZone:zone];
        copy.infoIdentifier = self.infoIdentifier;
        copy.addTimeShow = [self.addTimeShow copyWithZone:zone];
        copy.sacUser = [self.sacUser copyWithZone:zone];
        copy.resCourse = [self.resCourse copyWithZone:zone];
    }
    
    return copy;
}


@end
