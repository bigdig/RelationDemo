//
//  FMUserEntityEntityUser.m
//
//  Created by   on 2016/12/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FMUserEntityEntityUser.h"
#import "FMUserEntityFaUser.h"


NSString *const kFMUserEntityEntityUserFaUser = @"faUser";
NSString *const kFMUserEntityEntityUserMobile = @"mobile";
NSString *const kFMUserEntityEntityUserRelationWithMe = @"relationWithMe";
NSString *const kFMUserEntityEntityUserId = @"id";
NSString *const kFMUserEntityEntityUserPic = @"pic";
NSString *const kFMUserEntityEntityUserMyFamily = @"myFamily";
NSString *const kFMUserEntityEntityUserBirthdayShow = @"birthdayShow";
NSString *const kFMUserEntityEntityUserSex = @"sex";
NSString *const kFMUserEntityEntityUserName = @"name";


@interface FMUserEntityEntityUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FMUserEntityEntityUser

@synthesize faUser = _faUser;
@synthesize mobile = _mobile;
@synthesize relationWithMe = _relationWithMe;
@synthesize entityUserIdentifier = _entityUserIdentifier;
@synthesize pic = _pic;
@synthesize myFamily = _myFamily;
@synthesize birthdayShow = _birthdayShow;
@synthesize sex = _sex;
@synthesize name = _name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.faUser = [FMUserEntityFaUser modelObjectWithDictionary:[dict objectForKey:kFMUserEntityEntityUserFaUser]];
            self.mobile = [self objectOrNilForKey:kFMUserEntityEntityUserMobile fromDictionary:dict];
            self.relationWithMe = [self objectOrNilForKey:kFMUserEntityEntityUserRelationWithMe fromDictionary:dict];
            self.entityUserIdentifier = [[self objectOrNilForKey:kFMUserEntityEntityUserId fromDictionary:dict] doubleValue];
            self.pic = [self objectOrNilForKey:kFMUserEntityEntityUserPic fromDictionary:dict];
            self.myFamily = [self objectOrNilForKey:kFMUserEntityEntityUserMyFamily fromDictionary:dict];
            self.birthdayShow = [self objectOrNilForKey:kFMUserEntityEntityUserBirthdayShow fromDictionary:dict];
            self.sex = [[self objectOrNilForKey:kFMUserEntityEntityUserSex fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kFMUserEntityEntityUserName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.faUser dictionaryRepresentation] forKey:kFMUserEntityEntityUserFaUser];
    [mutableDict setValue:self.mobile forKey:kFMUserEntityEntityUserMobile];
    [mutableDict setValue:self.relationWithMe forKey:kFMUserEntityEntityUserRelationWithMe];
    [mutableDict setValue:[NSNumber numberWithDouble:self.entityUserIdentifier] forKey:kFMUserEntityEntityUserId];
    [mutableDict setValue:self.pic forKey:kFMUserEntityEntityUserPic];
    NSMutableArray *tempArrayForMyFamily = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.myFamily) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMyFamily addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMyFamily addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMyFamily] forKey:kFMUserEntityEntityUserMyFamily];
    [mutableDict setValue:self.birthdayShow forKey:kFMUserEntityEntityUserBirthdayShow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kFMUserEntityEntityUserSex];
    [mutableDict setValue:self.name forKey:kFMUserEntityEntityUserName];

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

    self.faUser = [aDecoder decodeObjectForKey:kFMUserEntityEntityUserFaUser];
    self.mobile = [aDecoder decodeObjectForKey:kFMUserEntityEntityUserMobile];
    self.relationWithMe = [aDecoder decodeObjectForKey:kFMUserEntityEntityUserRelationWithMe];
    self.entityUserIdentifier = [aDecoder decodeDoubleForKey:kFMUserEntityEntityUserId];
    self.pic = [aDecoder decodeObjectForKey:kFMUserEntityEntityUserPic];
    self.myFamily = [aDecoder decodeObjectForKey:kFMUserEntityEntityUserMyFamily];
    self.birthdayShow = [aDecoder decodeObjectForKey:kFMUserEntityEntityUserBirthdayShow];
    self.sex = [aDecoder decodeDoubleForKey:kFMUserEntityEntityUserSex];
    self.name = [aDecoder decodeObjectForKey:kFMUserEntityEntityUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_faUser forKey:kFMUserEntityEntityUserFaUser];
    [aCoder encodeObject:_mobile forKey:kFMUserEntityEntityUserMobile];
    [aCoder encodeObject:_relationWithMe forKey:kFMUserEntityEntityUserRelationWithMe];
    [aCoder encodeDouble:_entityUserIdentifier forKey:kFMUserEntityEntityUserId];
    [aCoder encodeObject:_pic forKey:kFMUserEntityEntityUserPic];
    [aCoder encodeObject:_myFamily forKey:kFMUserEntityEntityUserMyFamily];
    [aCoder encodeObject:_birthdayShow forKey:kFMUserEntityEntityUserBirthdayShow];
    [aCoder encodeDouble:_sex forKey:kFMUserEntityEntityUserSex];
    [aCoder encodeObject:_name forKey:kFMUserEntityEntityUserName];
}

- (id)copyWithZone:(NSZone *)zone {
    FMUserEntityEntityUser *copy = [[FMUserEntityEntityUser alloc] init];
    
    
    
    if (copy) {

        copy.faUser = [self.faUser copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.relationWithMe = [self.relationWithMe copyWithZone:zone];
        copy.entityUserIdentifier = self.entityUserIdentifier;
        copy.pic = [self.pic copyWithZone:zone];
        copy.myFamily = [self.myFamily copyWithZone:zone];
        copy.birthdayShow = [self.birthdayShow copyWithZone:zone];
        copy.sex = self.sex;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
