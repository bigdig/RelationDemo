//
//  EDUCourseTaskInfo.m
//
//  Created by   on 2016/11/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUCourseTaskInfo.h"
#import "EDUCourseTaskResCourse.h"


NSString *const kEDUCourseTaskInfoId = @"id";
NSString *const kEDUCourseTaskInfoMemo = @"memo";
NSString *const kEDUCourseTaskInfoTitle = @"title";
NSString *const kEDUCourseTaskInfoQuestion = @"question";
NSString *const kEDUCourseTaskInfoTag = @"tag";
NSString *const kEDUCourseTaskInfoAnswerShow = @"answerShow";
NSString *const kEDUCourseTaskInfoResCourse = @"resCourse";
NSString *const kEDUCourseTaskInfoState = @"state";


@interface EDUCourseTaskInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseTaskInfo

@synthesize infoIdentifier = _infoIdentifier;
@synthesize memo = _memo;
@synthesize title = _title;
@synthesize question = _question;
@synthesize tag = _tag;
@synthesize answerShow = _answerShow;
@synthesize resCourse = _resCourse;
@synthesize state = _state;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.infoIdentifier = [[self objectOrNilForKey:kEDUCourseTaskInfoId fromDictionary:dict] doubleValue];
            self.memo = [self objectOrNilForKey:kEDUCourseTaskInfoMemo fromDictionary:dict];
            self.title = [self objectOrNilForKey:kEDUCourseTaskInfoTitle fromDictionary:dict];
            self.question = [self objectOrNilForKey:kEDUCourseTaskInfoQuestion fromDictionary:dict];
            self.tag = [[self objectOrNilForKey:kEDUCourseTaskInfoTag fromDictionary:dict] doubleValue];
            self.answerShow = [self objectOrNilForKey:kEDUCourseTaskInfoAnswerShow fromDictionary:dict];
            self.resCourse = [EDUCourseTaskResCourse modelObjectWithDictionary:[dict objectForKey:kEDUCourseTaskInfoResCourse]];
            self.state = [[self objectOrNilForKey:kEDUCourseTaskInfoState fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.infoIdentifier] forKey:kEDUCourseTaskInfoId];
    [mutableDict setValue:self.memo forKey:kEDUCourseTaskInfoMemo];
    [mutableDict setValue:self.title forKey:kEDUCourseTaskInfoTitle];
    [mutableDict setValue:self.question forKey:kEDUCourseTaskInfoQuestion];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tag] forKey:kEDUCourseTaskInfoTag];
    [mutableDict setValue:self.answerShow forKey:kEDUCourseTaskInfoAnswerShow];
    [mutableDict setValue:[self.resCourse dictionaryRepresentation] forKey:kEDUCourseTaskInfoResCourse];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kEDUCourseTaskInfoState];

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

    self.infoIdentifier = [aDecoder decodeDoubleForKey:kEDUCourseTaskInfoId];
    self.memo = [aDecoder decodeObjectForKey:kEDUCourseTaskInfoMemo];
    self.title = [aDecoder decodeObjectForKey:kEDUCourseTaskInfoTitle];
    self.question = [aDecoder decodeObjectForKey:kEDUCourseTaskInfoQuestion];
    self.tag = [aDecoder decodeDoubleForKey:kEDUCourseTaskInfoTag];
    self.answerShow = [aDecoder decodeObjectForKey:kEDUCourseTaskInfoAnswerShow];
    self.resCourse = [aDecoder decodeObjectForKey:kEDUCourseTaskInfoResCourse];
    self.state = [aDecoder decodeDoubleForKey:kEDUCourseTaskInfoState];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_infoIdentifier forKey:kEDUCourseTaskInfoId];
    [aCoder encodeObject:_memo forKey:kEDUCourseTaskInfoMemo];
    [aCoder encodeObject:_title forKey:kEDUCourseTaskInfoTitle];
    [aCoder encodeObject:_question forKey:kEDUCourseTaskInfoQuestion];
    [aCoder encodeDouble:_tag forKey:kEDUCourseTaskInfoTag];
    [aCoder encodeObject:_answerShow forKey:kEDUCourseTaskInfoAnswerShow];
    [aCoder encodeObject:_resCourse forKey:kEDUCourseTaskInfoResCourse];
    [aCoder encodeDouble:_state forKey:kEDUCourseTaskInfoState];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUCourseTaskInfo *copy = [[EDUCourseTaskInfo alloc] init];
    
    
    
    if (copy) {

        copy.infoIdentifier = self.infoIdentifier;
        copy.memo = [self.memo copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.question = [self.question copyWithZone:zone];
        copy.tag = self.tag;
        copy.answerShow = [self.answerShow copyWithZone:zone];
        copy.resCourse = [self.resCourse copyWithZone:zone];
        copy.state = self.state;
    }
    
    return copy;
}


@end
