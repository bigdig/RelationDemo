//
//  EDUUserFavouriteSacUser.m
//
//  Created by xingguo ren on 16/9/22
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDUUserFavouriteSacUser.h"
#import "EDUUserFavouriteSacRole.h"


NSString *const kEDUUserFavouriteSacUserId = @"id";
NSString *const kEDUUserFavouriteSacUserLogname = @"logname";
NSString *const kEDUUserFavouriteSacUserAward = @"award";
NSString *const kEDUUserFavouriteSacUserSacRole = @"sacRole";
NSString *const kEDUUserFavouriteSacUserSchool = @"school";
NSString *const kEDUUserFavouriteSacUserMobile = @"mobile";
NSString *const kEDUUserFavouriteSacUserTrain = @"train";
NSString *const kEDUUserFavouriteSacUserSpecialty = @"specialty";
NSString *const kEDUUserFavouriteSacUserRole = @"role";
NSString *const kEDUUserFavouriteSacUserQq = @"qq";
NSString *const kEDUUserFavouriteSacUserPwd = @"pwd";
NSString *const kEDUUserFavouriteSacUserEmail = @"email";
NSString *const kEDUUserFavouriteSacUserStatus = @"status";
NSString *const kEDUUserFavouriteSacUserGrade = @"grade";


@interface EDUUserFavouriteSacUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUUserFavouriteSacUser

@synthesize sacUserIdentifier = _sacUserIdentifier;
@synthesize logname = _logname;
@synthesize award = _award;
@synthesize sacRole = _sacRole;
@synthesize school = _school;
@synthesize mobile = _mobile;
@synthesize train = _train;
@synthesize specialty = _specialty;
@synthesize role = _role;
@synthesize qq = _qq;
@synthesize pwd = _pwd;
@synthesize email = _email;
@synthesize status = _status;
@synthesize grade = _grade;


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
            self.sacUserIdentifier = [[self objectOrNilForKey:kEDUUserFavouriteSacUserId fromDictionary:dict] doubleValue];
            self.logname = [self objectOrNilForKey:kEDUUserFavouriteSacUserLogname fromDictionary:dict];
            self.award = [self objectOrNilForKey:kEDUUserFavouriteSacUserAward fromDictionary:dict];
            self.sacRole = [EDUUserFavouriteSacRole modelObjectWithDictionary:[dict objectForKey:kEDUUserFavouriteSacUserSacRole]];
            self.school = [self objectOrNilForKey:kEDUUserFavouriteSacUserSchool fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kEDUUserFavouriteSacUserMobile fromDictionary:dict];
            self.train = [self objectOrNilForKey:kEDUUserFavouriteSacUserTrain fromDictionary:dict];
            self.specialty = [self objectOrNilForKey:kEDUUserFavouriteSacUserSpecialty fromDictionary:dict];
            self.role = [self objectOrNilForKey:kEDUUserFavouriteSacUserRole fromDictionary:dict];
            self.qq = [self objectOrNilForKey:kEDUUserFavouriteSacUserQq fromDictionary:dict];
            self.pwd = [self objectOrNilForKey:kEDUUserFavouriteSacUserPwd fromDictionary:dict];
            self.email = [self objectOrNilForKey:kEDUUserFavouriteSacUserEmail fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kEDUUserFavouriteSacUserStatus fromDictionary:dict] doubleValue];
            self.grade = [self objectOrNilForKey:kEDUUserFavouriteSacUserGrade fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sacUserIdentifier] forKey:kEDUUserFavouriteSacUserId];
    [mutableDict setValue:self.logname forKey:kEDUUserFavouriteSacUserLogname];
    [mutableDict setValue:self.award forKey:kEDUUserFavouriteSacUserAward];
    [mutableDict setValue:[self.sacRole dictionaryRepresentation] forKey:kEDUUserFavouriteSacUserSacRole];
    [mutableDict setValue:self.school forKey:kEDUUserFavouriteSacUserSchool];
    [mutableDict setValue:self.mobile forKey:kEDUUserFavouriteSacUserMobile];
    [mutableDict setValue:self.train forKey:kEDUUserFavouriteSacUserTrain];
    [mutableDict setValue:self.specialty forKey:kEDUUserFavouriteSacUserSpecialty];
    [mutableDict setValue:self.role forKey:kEDUUserFavouriteSacUserRole];
    [mutableDict setValue:self.qq forKey:kEDUUserFavouriteSacUserQq];
    [mutableDict setValue:self.pwd forKey:kEDUUserFavouriteSacUserPwd];
    [mutableDict setValue:self.email forKey:kEDUUserFavouriteSacUserEmail];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kEDUUserFavouriteSacUserStatus];
    [mutableDict setValue:self.grade forKey:kEDUUserFavouriteSacUserGrade];

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

    self.sacUserIdentifier = [aDecoder decodeDoubleForKey:kEDUUserFavouriteSacUserId];
    self.logname = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacUserLogname];
    self.award = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacUserAward];
    self.sacRole = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacUserSacRole];
    self.school = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacUserSchool];
    self.mobile = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacUserMobile];
    self.train = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacUserTrain];
    self.specialty = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacUserSpecialty];
    self.role = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacUserRole];
    self.qq = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacUserQq];
    self.pwd = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacUserPwd];
    self.email = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacUserEmail];
    self.status = [aDecoder decodeDoubleForKey:kEDUUserFavouriteSacUserStatus];
    self.grade = [aDecoder decodeObjectForKey:kEDUUserFavouriteSacUserGrade];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sacUserIdentifier forKey:kEDUUserFavouriteSacUserId];
    [aCoder encodeObject:_logname forKey:kEDUUserFavouriteSacUserLogname];
    [aCoder encodeObject:_award forKey:kEDUUserFavouriteSacUserAward];
    [aCoder encodeObject:_sacRole forKey:kEDUUserFavouriteSacUserSacRole];
    [aCoder encodeObject:_school forKey:kEDUUserFavouriteSacUserSchool];
    [aCoder encodeObject:_mobile forKey:kEDUUserFavouriteSacUserMobile];
    [aCoder encodeObject:_train forKey:kEDUUserFavouriteSacUserTrain];
    [aCoder encodeObject:_specialty forKey:kEDUUserFavouriteSacUserSpecialty];
    [aCoder encodeObject:_role forKey:kEDUUserFavouriteSacUserRole];
    [aCoder encodeObject:_qq forKey:kEDUUserFavouriteSacUserQq];
    [aCoder encodeObject:_pwd forKey:kEDUUserFavouriteSacUserPwd];
    [aCoder encodeObject:_email forKey:kEDUUserFavouriteSacUserEmail];
    [aCoder encodeDouble:_status forKey:kEDUUserFavouriteSacUserStatus];
    [aCoder encodeObject:_grade forKey:kEDUUserFavouriteSacUserGrade];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDUUserFavouriteSacUser *copy = [[EDUUserFavouriteSacUser alloc] init];
    
    if (copy) {

        copy.sacUserIdentifier = self.sacUserIdentifier;
        copy.logname = [self.logname copyWithZone:zone];
        copy.award = [self.award copyWithZone:zone];
        copy.sacRole = [self.sacRole copyWithZone:zone];
        copy.school = [self.school copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.train = [self.train copyWithZone:zone];
        copy.specialty = [self.specialty copyWithZone:zone];
        copy.role = [self.role copyWithZone:zone];
        copy.qq = [self.qq copyWithZone:zone];
        copy.pwd = [self.pwd copyWithZone:zone];
        copy.email = [self.email copyWithZone:zone];
        copy.status = self.status;
        copy.grade = [self.grade copyWithZone:zone];
    }
    
    return copy;
}


@end
