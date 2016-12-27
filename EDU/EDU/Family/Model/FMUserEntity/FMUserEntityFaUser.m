//
//  FMUserEntityFaUser.m
//
//  Created by   on 2016/12/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FMUserEntityFaUser.h"


NSString *const kFMUserEntityFaUserMobile = @"mobile";
NSString *const kFMUserEntityFaUserWxnick = @"wxnick";
NSString *const kFMUserEntityFaUserWxid = @"wxid";
NSString *const kFMUserEntityFaUserId = @"id";
NSString *const kFMUserEntityFaUserPic = @"pic";
NSString *const kFMUserEntityFaUserWxpic = @"wxpic";
NSString *const kFMUserEntityFaUserSex = @"sex";
NSString *const kFMUserEntityFaUserName = @"name";
NSString *const kFMUserEntityFaUserPwd = @"pwd";


@interface FMUserEntityFaUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FMUserEntityFaUser

@synthesize mobile = _mobile;
@synthesize wxnick = _wxnick;
@synthesize wxid = _wxid;
@synthesize faUserIdentifier = _faUserIdentifier;
@synthesize pic = _pic;
@synthesize wxpic = _wxpic;
@synthesize sex = _sex;
@synthesize name = _name;
@synthesize pwd = _pwd;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.mobile = [self objectOrNilForKey:kFMUserEntityFaUserMobile fromDictionary:dict];
            self.wxnick = [self objectOrNilForKey:kFMUserEntityFaUserWxnick fromDictionary:dict];
            self.wxid = [self objectOrNilForKey:kFMUserEntityFaUserWxid fromDictionary:dict];
            self.faUserIdentifier = [[self objectOrNilForKey:kFMUserEntityFaUserId fromDictionary:dict] doubleValue];
            self.pic = [self objectOrNilForKey:kFMUserEntityFaUserPic fromDictionary:dict];
            self.wxpic = [self objectOrNilForKey:kFMUserEntityFaUserWxpic fromDictionary:dict];
            self.sex = [[self objectOrNilForKey:kFMUserEntityFaUserSex fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kFMUserEntityFaUserName fromDictionary:dict];
            self.pwd = [self objectOrNilForKey:kFMUserEntityFaUserPwd fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mobile forKey:kFMUserEntityFaUserMobile];
    [mutableDict setValue:self.wxnick forKey:kFMUserEntityFaUserWxnick];
    [mutableDict setValue:self.wxid forKey:kFMUserEntityFaUserWxid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.faUserIdentifier] forKey:kFMUserEntityFaUserId];
    [mutableDict setValue:self.pic forKey:kFMUserEntityFaUserPic];
    [mutableDict setValue:self.wxpic forKey:kFMUserEntityFaUserWxpic];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kFMUserEntityFaUserSex];
    [mutableDict setValue:self.name forKey:kFMUserEntityFaUserName];
    [mutableDict setValue:self.pwd forKey:kFMUserEntityFaUserPwd];

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

    self.mobile = [aDecoder decodeObjectForKey:kFMUserEntityFaUserMobile];
    self.wxnick = [aDecoder decodeObjectForKey:kFMUserEntityFaUserWxnick];
    self.wxid = [aDecoder decodeObjectForKey:kFMUserEntityFaUserWxid];
    self.faUserIdentifier = [aDecoder decodeDoubleForKey:kFMUserEntityFaUserId];
    self.pic = [aDecoder decodeObjectForKey:kFMUserEntityFaUserPic];
    self.wxpic = [aDecoder decodeObjectForKey:kFMUserEntityFaUserWxpic];
    self.sex = [aDecoder decodeDoubleForKey:kFMUserEntityFaUserSex];
    self.name = [aDecoder decodeObjectForKey:kFMUserEntityFaUserName];
    self.pwd = [aDecoder decodeObjectForKey:kFMUserEntityFaUserPwd];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mobile forKey:kFMUserEntityFaUserMobile];
    [aCoder encodeObject:_wxnick forKey:kFMUserEntityFaUserWxnick];
    [aCoder encodeObject:_wxid forKey:kFMUserEntityFaUserWxid];
    [aCoder encodeDouble:_faUserIdentifier forKey:kFMUserEntityFaUserId];
    [aCoder encodeObject:_pic forKey:kFMUserEntityFaUserPic];
    [aCoder encodeObject:_wxpic forKey:kFMUserEntityFaUserWxpic];
    [aCoder encodeDouble:_sex forKey:kFMUserEntityFaUserSex];
    [aCoder encodeObject:_name forKey:kFMUserEntityFaUserName];
    [aCoder encodeObject:_pwd forKey:kFMUserEntityFaUserPwd];
}

- (id)copyWithZone:(NSZone *)zone {
    FMUserEntityFaUser *copy = [[FMUserEntityFaUser alloc] init];
    
    
    
    if (copy) {

        copy.mobile = [self.mobile copyWithZone:zone];
        copy.wxnick = [self.wxnick copyWithZone:zone];
        copy.wxid = [self.wxid copyWithZone:zone];
        copy.faUserIdentifier = self.faUserIdentifier;
        copy.pic = [self.pic copyWithZone:zone];
        copy.wxpic = [self.wxpic copyWithZone:zone];
        copy.sex = self.sex;
        copy.name = [self.name copyWithZone:zone];
        copy.pwd = [self.pwd copyWithZone:zone];
    }
    
    return copy;
}


@end
