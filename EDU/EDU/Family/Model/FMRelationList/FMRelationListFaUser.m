//
//  FMRelationListFaUser.m
//
//  Created by   on 2016/12/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FMRelationListFaUser.h"


NSString *const kFMRelationListFaUserMobile = @"mobile";
NSString *const kFMRelationListFaUserWxnick = @"wxnick";
NSString *const kFMRelationListFaUserWxid = @"wxid";
NSString *const kFMRelationListFaUserId = @"id";
NSString *const kFMRelationListFaUserPic = @"pic";
NSString *const kFMRelationListFaUserWxpic = @"wxpic";
NSString *const kFMRelationListFaUserSex = @"sex";
NSString *const kFMRelationListFaUserName = @"name";
NSString *const kFMRelationListFaUserPwd = @"pwd";


@interface FMRelationListFaUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FMRelationListFaUser

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
            self.mobile = [self objectOrNilForKey:kFMRelationListFaUserMobile fromDictionary:dict];
            self.wxnick = [self objectOrNilForKey:kFMRelationListFaUserWxnick fromDictionary:dict];
            self.wxid = [self objectOrNilForKey:kFMRelationListFaUserWxid fromDictionary:dict];
            self.faUserIdentifier = [[self objectOrNilForKey:kFMRelationListFaUserId fromDictionary:dict] doubleValue];
            self.pic = [self objectOrNilForKey:kFMRelationListFaUserPic fromDictionary:dict];
            self.wxpic = [self objectOrNilForKey:kFMRelationListFaUserWxpic fromDictionary:dict];
            self.sex = [[self objectOrNilForKey:kFMRelationListFaUserSex fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kFMRelationListFaUserName fromDictionary:dict];
            self.pwd = [self objectOrNilForKey:kFMRelationListFaUserPwd fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mobile forKey:kFMRelationListFaUserMobile];
    [mutableDict setValue:self.wxnick forKey:kFMRelationListFaUserWxnick];
    [mutableDict setValue:self.wxid forKey:kFMRelationListFaUserWxid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.faUserIdentifier] forKey:kFMRelationListFaUserId];
    [mutableDict setValue:self.pic forKey:kFMRelationListFaUserPic];
    [mutableDict setValue:self.wxpic forKey:kFMRelationListFaUserWxpic];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kFMRelationListFaUserSex];
    [mutableDict setValue:self.name forKey:kFMRelationListFaUserName];
    [mutableDict setValue:self.pwd forKey:kFMRelationListFaUserPwd];

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

    self.mobile = [aDecoder decodeObjectForKey:kFMRelationListFaUserMobile];
    self.wxnick = [aDecoder decodeObjectForKey:kFMRelationListFaUserWxnick];
    self.wxid = [aDecoder decodeObjectForKey:kFMRelationListFaUserWxid];
    self.faUserIdentifier = [aDecoder decodeDoubleForKey:kFMRelationListFaUserId];
    self.pic = [aDecoder decodeObjectForKey:kFMRelationListFaUserPic];
    self.wxpic = [aDecoder decodeObjectForKey:kFMRelationListFaUserWxpic];
    self.sex = [aDecoder decodeDoubleForKey:kFMRelationListFaUserSex];
    self.name = [aDecoder decodeObjectForKey:kFMRelationListFaUserName];
    self.pwd = [aDecoder decodeObjectForKey:kFMRelationListFaUserPwd];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mobile forKey:kFMRelationListFaUserMobile];
    [aCoder encodeObject:_wxnick forKey:kFMRelationListFaUserWxnick];
    [aCoder encodeObject:_wxid forKey:kFMRelationListFaUserWxid];
    [aCoder encodeDouble:_faUserIdentifier forKey:kFMRelationListFaUserId];
    [aCoder encodeObject:_pic forKey:kFMRelationListFaUserPic];
    [aCoder encodeObject:_wxpic forKey:kFMRelationListFaUserWxpic];
    [aCoder encodeDouble:_sex forKey:kFMRelationListFaUserSex];
    [aCoder encodeObject:_name forKey:kFMRelationListFaUserName];
    [aCoder encodeObject:_pwd forKey:kFMRelationListFaUserPwd];
}

- (id)copyWithZone:(NSZone *)zone {
    FMRelationListFaUser *copy = [[FMRelationListFaUser alloc] init];
    
    
    
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
