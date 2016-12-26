//
//  EDUCourseCommentSacUser.m
//
//  Created by   on 2016/10/27
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUCourseCommentSacUser.h"
#import "EDUCourseCommentSacRole.h"


NSString *const kEDUCourseCommentSacUserId = @"id";
NSString *const kEDUCourseCommentSacUserRememberPwd = @"rememberPwd";
NSString *const kEDUCourseCommentSacUserAward = @"award";
NSString *const kEDUCourseCommentSacUserGrade = @"grade";
NSString *const kEDUCourseCommentSacUserSchool = @"school";
NSString *const kEDUCourseCommentSacUserMobile = @"mobile";
NSString *const kEDUCourseCommentSacUserPhoto = @"photo";
NSString *const kEDUCourseCommentSacUserSacRole = @"sacRole";
NSString *const kEDUCourseCommentSacUserLoginResult = @"loginResult";
NSString *const kEDUCourseCommentSacUserTrain = @"train";
NSString *const kEDUCourseCommentSacUserSpecialty = @"specialty";
NSString *const kEDUCourseCommentSacUserRole = @"role";
NSString *const kEDUCourseCommentSacUserPwd = @"pwd";
NSString *const kEDUCourseCommentSacUserQq = @"qq";
NSString *const kEDUCourseCommentSacUserLogname = @"logname";
NSString *const kEDUCourseCommentSacUserStatus = @"status";
NSString *const kEDUCourseCommentSacUserEmail = @"email";


@interface EDUCourseCommentSacUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUCourseCommentSacUser

@synthesize sacUserIdentifier = _sacUserIdentifier;
@synthesize rememberPwd = _rememberPwd;
@synthesize award = _award;
@synthesize grade = _grade;
@synthesize school = _school;
@synthesize mobile = _mobile;
@synthesize photo = _photo;
@synthesize sacRole = _sacRole;
@synthesize loginResult = _loginResult;
@synthesize train = _train;
@synthesize specialty = _specialty;
@synthesize role = _role;
@synthesize pwd = _pwd;
@synthesize qq = _qq;
@synthesize logname = _logname;
@synthesize status = _status;
@synthesize email = _email;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.sacUserIdentifier = [[self objectOrNilForKey:kEDUCourseCommentSacUserId fromDictionary:dict] doubleValue];
            self.rememberPwd = [self objectOrNilForKey:kEDUCourseCommentSacUserRememberPwd fromDictionary:dict];
            self.award = [self objectOrNilForKey:kEDUCourseCommentSacUserAward fromDictionary:dict];
            self.grade = [self objectOrNilForKey:kEDUCourseCommentSacUserGrade fromDictionary:dict];
            self.school = [self objectOrNilForKey:kEDUCourseCommentSacUserSchool fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kEDUCourseCommentSacUserMobile fromDictionary:dict];
            self.photo = [self objectOrNilForKey:kEDUCourseCommentSacUserPhoto fromDictionary:dict];
            self.sacRole = [EDUCourseCommentSacRole modelObjectWithDictionary:[dict objectForKey:kEDUCourseCommentSacUserSacRole]];
            self.loginResult = [[self objectOrNilForKey:kEDUCourseCommentSacUserLoginResult fromDictionary:dict] doubleValue];
            self.train = [self objectOrNilForKey:kEDUCourseCommentSacUserTrain fromDictionary:dict];
            self.specialty = [self objectOrNilForKey:kEDUCourseCommentSacUserSpecialty fromDictionary:dict];
            self.role = [self objectOrNilForKey:kEDUCourseCommentSacUserRole fromDictionary:dict];
            self.pwd = [self objectOrNilForKey:kEDUCourseCommentSacUserPwd fromDictionary:dict];
            self.qq = [self objectOrNilForKey:kEDUCourseCommentSacUserQq fromDictionary:dict];
            self.logname = [self objectOrNilForKey:kEDUCourseCommentSacUserLogname fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kEDUCourseCommentSacUserStatus fromDictionary:dict] doubleValue];
            self.email = [self objectOrNilForKey:kEDUCourseCommentSacUserEmail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sacUserIdentifier] forKey:kEDUCourseCommentSacUserId];
    [mutableDict setValue:self.rememberPwd forKey:kEDUCourseCommentSacUserRememberPwd];
    [mutableDict setValue:self.award forKey:kEDUCourseCommentSacUserAward];
    [mutableDict setValue:self.grade forKey:kEDUCourseCommentSacUserGrade];
    [mutableDict setValue:self.school forKey:kEDUCourseCommentSacUserSchool];
    [mutableDict setValue:self.mobile forKey:kEDUCourseCommentSacUserMobile];
    [mutableDict setValue:self.photo forKey:kEDUCourseCommentSacUserPhoto];
    [mutableDict setValue:[self.sacRole dictionaryRepresentation] forKey:kEDUCourseCommentSacUserSacRole];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loginResult] forKey:kEDUCourseCommentSacUserLoginResult];
    [mutableDict setValue:self.train forKey:kEDUCourseCommentSacUserTrain];
    [mutableDict setValue:self.specialty forKey:kEDUCourseCommentSacUserSpecialty];
    [mutableDict setValue:self.role forKey:kEDUCourseCommentSacUserRole];
    [mutableDict setValue:self.pwd forKey:kEDUCourseCommentSacUserPwd];
    [mutableDict setValue:self.qq forKey:kEDUCourseCommentSacUserQq];
    [mutableDict setValue:self.logname forKey:kEDUCourseCommentSacUserLogname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kEDUCourseCommentSacUserStatus];
    [mutableDict setValue:self.email forKey:kEDUCourseCommentSacUserEmail];

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

    self.sacUserIdentifier = [aDecoder decodeDoubleForKey:kEDUCourseCommentSacUserId];
    self.rememberPwd = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserRememberPwd];
    self.award = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserAward];
    self.grade = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserGrade];
    self.school = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserSchool];
    self.mobile = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserMobile];
    self.photo = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserPhoto];
    self.sacRole = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserSacRole];
    self.loginResult = [aDecoder decodeDoubleForKey:kEDUCourseCommentSacUserLoginResult];
    self.train = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserTrain];
    self.specialty = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserSpecialty];
    self.role = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserRole];
    self.pwd = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserPwd];
    self.qq = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserQq];
    self.logname = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserLogname];
    self.status = [aDecoder decodeDoubleForKey:kEDUCourseCommentSacUserStatus];
    self.email = [aDecoder decodeObjectForKey:kEDUCourseCommentSacUserEmail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sacUserIdentifier forKey:kEDUCourseCommentSacUserId];
    [aCoder encodeObject:_rememberPwd forKey:kEDUCourseCommentSacUserRememberPwd];
    [aCoder encodeObject:_award forKey:kEDUCourseCommentSacUserAward];
    [aCoder encodeObject:_grade forKey:kEDUCourseCommentSacUserGrade];
    [aCoder encodeObject:_school forKey:kEDUCourseCommentSacUserSchool];
    [aCoder encodeObject:_mobile forKey:kEDUCourseCommentSacUserMobile];
    [aCoder encodeObject:_photo forKey:kEDUCourseCommentSacUserPhoto];
    [aCoder encodeObject:_sacRole forKey:kEDUCourseCommentSacUserSacRole];
    [aCoder encodeDouble:_loginResult forKey:kEDUCourseCommentSacUserLoginResult];
    [aCoder encodeObject:_train forKey:kEDUCourseCommentSacUserTrain];
    [aCoder encodeObject:_specialty forKey:kEDUCourseCommentSacUserSpecialty];
    [aCoder encodeObject:_role forKey:kEDUCourseCommentSacUserRole];
    [aCoder encodeObject:_pwd forKey:kEDUCourseCommentSacUserPwd];
    [aCoder encodeObject:_qq forKey:kEDUCourseCommentSacUserQq];
    [aCoder encodeObject:_logname forKey:kEDUCourseCommentSacUserLogname];
    [aCoder encodeDouble:_status forKey:kEDUCourseCommentSacUserStatus];
    [aCoder encodeObject:_email forKey:kEDUCourseCommentSacUserEmail];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUCourseCommentSacUser *copy = [[EDUCourseCommentSacUser alloc] init];
    
    
    
    if (copy) {

        copy.sacUserIdentifier = self.sacUserIdentifier;
        copy.rememberPwd = [self.rememberPwd copyWithZone:zone];
        copy.award = [self.award copyWithZone:zone];
        copy.grade = [self.grade copyWithZone:zone];
        copy.school = [self.school copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.photo = [self.photo copyWithZone:zone];
        copy.sacRole = [self.sacRole copyWithZone:zone];
        copy.loginResult = self.loginResult;
        copy.train = [self.train copyWithZone:zone];
        copy.specialty = [self.specialty copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.pwd = [self.pwd copyWithZone:zone];
        copy.qq = [self.qq copyWithZone:zone];
        copy.logname = [self.logname copyWithZone:zone];
        copy.status = self.status;
        copy.email = [self.email copyWithZone:zone];
    }
    
    return copy;
}


@end
