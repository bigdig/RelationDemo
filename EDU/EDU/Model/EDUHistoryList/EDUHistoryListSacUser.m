//
//  EDUHistoryListSacUser.m
//
//  Created by   on 2016/10/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUHistoryListSacUser.h"
#import "EDUHistoryListSacRole.h"


NSString *const kEDUHistoryListSacUserId = @"id";
NSString *const kEDUHistoryListSacUserRememberPwd = @"rememberPwd";
NSString *const kEDUHistoryListSacUserAward = @"award";
NSString *const kEDUHistoryListSacUserGrade = @"grade";
NSString *const kEDUHistoryListSacUserSchool = @"school";
NSString *const kEDUHistoryListSacUserMobile = @"mobile";
NSString *const kEDUHistoryListSacUserPhoto = @"photo";
NSString *const kEDUHistoryListSacUserSacRole = @"sacRole";
NSString *const kEDUHistoryListSacUserLoginResult = @"loginResult";
NSString *const kEDUHistoryListSacUserTrain = @"train";
NSString *const kEDUHistoryListSacUserSpecialty = @"specialty";
NSString *const kEDUHistoryListSacUserRole = @"role";
NSString *const kEDUHistoryListSacUserPwd = @"pwd";
NSString *const kEDUHistoryListSacUserQq = @"qq";
NSString *const kEDUHistoryListSacUserLogname = @"logname";
NSString *const kEDUHistoryListSacUserStatus = @"status";
NSString *const kEDUHistoryListSacUserEmail = @"email";


@interface EDUHistoryListSacUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUHistoryListSacUser

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
            self.sacUserIdentifier = [[self objectOrNilForKey:kEDUHistoryListSacUserId fromDictionary:dict] doubleValue];
            self.rememberPwd = [self objectOrNilForKey:kEDUHistoryListSacUserRememberPwd fromDictionary:dict];
            self.award = [self objectOrNilForKey:kEDUHistoryListSacUserAward fromDictionary:dict];
            self.grade = [self objectOrNilForKey:kEDUHistoryListSacUserGrade fromDictionary:dict];
            self.school = [self objectOrNilForKey:kEDUHistoryListSacUserSchool fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kEDUHistoryListSacUserMobile fromDictionary:dict];
            self.photo = [self objectOrNilForKey:kEDUHistoryListSacUserPhoto fromDictionary:dict];
            self.sacRole = [EDUHistoryListSacRole modelObjectWithDictionary:[dict objectForKey:kEDUHistoryListSacUserSacRole]];
            self.loginResult = [[self objectOrNilForKey:kEDUHistoryListSacUserLoginResult fromDictionary:dict] doubleValue];
            self.train = [self objectOrNilForKey:kEDUHistoryListSacUserTrain fromDictionary:dict];
            self.specialty = [self objectOrNilForKey:kEDUHistoryListSacUserSpecialty fromDictionary:dict];
            self.role = [self objectOrNilForKey:kEDUHistoryListSacUserRole fromDictionary:dict];
            self.pwd = [self objectOrNilForKey:kEDUHistoryListSacUserPwd fromDictionary:dict];
            self.qq = [self objectOrNilForKey:kEDUHistoryListSacUserQq fromDictionary:dict];
            self.logname = [self objectOrNilForKey:kEDUHistoryListSacUserLogname fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kEDUHistoryListSacUserStatus fromDictionary:dict] doubleValue];
            self.email = [self objectOrNilForKey:kEDUHistoryListSacUserEmail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sacUserIdentifier] forKey:kEDUHistoryListSacUserId];
    [mutableDict setValue:self.rememberPwd forKey:kEDUHistoryListSacUserRememberPwd];
    [mutableDict setValue:self.award forKey:kEDUHistoryListSacUserAward];
    [mutableDict setValue:self.grade forKey:kEDUHistoryListSacUserGrade];
    [mutableDict setValue:self.school forKey:kEDUHistoryListSacUserSchool];
    [mutableDict setValue:self.mobile forKey:kEDUHistoryListSacUserMobile];
    [mutableDict setValue:self.photo forKey:kEDUHistoryListSacUserPhoto];
    [mutableDict setValue:[self.sacRole dictionaryRepresentation] forKey:kEDUHistoryListSacUserSacRole];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loginResult] forKey:kEDUHistoryListSacUserLoginResult];
    [mutableDict setValue:self.train forKey:kEDUHistoryListSacUserTrain];
    [mutableDict setValue:self.specialty forKey:kEDUHistoryListSacUserSpecialty];
    [mutableDict setValue:self.role forKey:kEDUHistoryListSacUserRole];
    [mutableDict setValue:self.pwd forKey:kEDUHistoryListSacUserPwd];
    [mutableDict setValue:self.qq forKey:kEDUHistoryListSacUserQq];
    [mutableDict setValue:self.logname forKey:kEDUHistoryListSacUserLogname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kEDUHistoryListSacUserStatus];
    [mutableDict setValue:self.email forKey:kEDUHistoryListSacUserEmail];

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

    self.sacUserIdentifier = [aDecoder decodeDoubleForKey:kEDUHistoryListSacUserId];
    self.rememberPwd = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserRememberPwd];
    self.award = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserAward];
    self.grade = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserGrade];
    self.school = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserSchool];
    self.mobile = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserMobile];
    self.photo = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserPhoto];
    self.sacRole = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserSacRole];
    self.loginResult = [aDecoder decodeDoubleForKey:kEDUHistoryListSacUserLoginResult];
    self.train = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserTrain];
    self.specialty = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserSpecialty];
    self.role = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserRole];
    self.pwd = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserPwd];
    self.qq = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserQq];
    self.logname = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserLogname];
    self.status = [aDecoder decodeDoubleForKey:kEDUHistoryListSacUserStatus];
    self.email = [aDecoder decodeObjectForKey:kEDUHistoryListSacUserEmail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sacUserIdentifier forKey:kEDUHistoryListSacUserId];
    [aCoder encodeObject:_rememberPwd forKey:kEDUHistoryListSacUserRememberPwd];
    [aCoder encodeObject:_award forKey:kEDUHistoryListSacUserAward];
    [aCoder encodeObject:_grade forKey:kEDUHistoryListSacUserGrade];
    [aCoder encodeObject:_school forKey:kEDUHistoryListSacUserSchool];
    [aCoder encodeObject:_mobile forKey:kEDUHistoryListSacUserMobile];
    [aCoder encodeObject:_photo forKey:kEDUHistoryListSacUserPhoto];
    [aCoder encodeObject:_sacRole forKey:kEDUHistoryListSacUserSacRole];
    [aCoder encodeDouble:_loginResult forKey:kEDUHistoryListSacUserLoginResult];
    [aCoder encodeObject:_train forKey:kEDUHistoryListSacUserTrain];
    [aCoder encodeObject:_specialty forKey:kEDUHistoryListSacUserSpecialty];
    [aCoder encodeObject:_role forKey:kEDUHistoryListSacUserRole];
    [aCoder encodeObject:_pwd forKey:kEDUHistoryListSacUserPwd];
    [aCoder encodeObject:_qq forKey:kEDUHistoryListSacUserQq];
    [aCoder encodeObject:_logname forKey:kEDUHistoryListSacUserLogname];
    [aCoder encodeDouble:_status forKey:kEDUHistoryListSacUserStatus];
    [aCoder encodeObject:_email forKey:kEDUHistoryListSacUserEmail];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUHistoryListSacUser *copy = [[EDUHistoryListSacUser alloc] init];
    
    
    
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
