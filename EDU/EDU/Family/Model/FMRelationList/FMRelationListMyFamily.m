//
//  FMRelationListMyFamily.m
//
//  Created by   on 2016/12/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FMRelationListMyFamily.h"


NSString *const kFMRelationListMyFamilyFaUser = @"faUser";
NSString *const kFMRelationListMyFamilyMobile = @"mobile";
NSString *const kFMRelationListMyFamilyRelationWithMe = @"relationWithMe";
NSString *const kFMRelationListMyFamilyId = @"id";
NSString *const kFMRelationListMyFamilyPic = @"pic";
NSString *const kFMRelationListMyFamilyBirthdayShow = @"birthdayShow";
NSString *const kFMRelationListMyFamilyBirthday = @"birthday";
NSString *const kFMRelationListMyFamilyMyFamily = @"myFamily";
NSString *const kFMRelationListMyFamilySex = @"sex";
NSString *const kFMRelationListMyFamilyName = @"name";


@interface FMRelationListMyFamily ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FMRelationListMyFamily

@synthesize faUser = _faUser;
@synthesize mobile = _mobile;
@synthesize relationWithMe = _relationWithMe;
@synthesize myFamilyIdentifier = _myFamilyIdentifier;
@synthesize pic = _pic;
@synthesize birthdayShow = _birthdayShow;
@synthesize birthday = _birthday;
@synthesize myFamily = _myFamily;
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
            self.faUser = [self objectOrNilForKey:kFMRelationListMyFamilyFaUser fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kFMRelationListMyFamilyMobile fromDictionary:dict];
            self.relationWithMe = [self objectOrNilForKey:kFMRelationListMyFamilyRelationWithMe fromDictionary:dict];
            self.myFamilyIdentifier = [[self objectOrNilForKey:kFMRelationListMyFamilyId fromDictionary:dict] doubleValue];
            self.pic = [self objectOrNilForKey:kFMRelationListMyFamilyPic fromDictionary:dict];
            self.birthdayShow = [self objectOrNilForKey:kFMRelationListMyFamilyBirthdayShow fromDictionary:dict];
            self.birthday = [[self objectOrNilForKey:kFMRelationListMyFamilyBirthday fromDictionary:dict] doubleValue];
            self.myFamily = [self objectOrNilForKey:kFMRelationListMyFamilyMyFamily fromDictionary:dict];
            self.sex = [[self objectOrNilForKey:kFMRelationListMyFamilySex fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kFMRelationListMyFamilyName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.faUser forKey:kFMRelationListMyFamilyFaUser];
    [mutableDict setValue:self.mobile forKey:kFMRelationListMyFamilyMobile];
    [mutableDict setValue:self.relationWithMe forKey:kFMRelationListMyFamilyRelationWithMe];
    [mutableDict setValue:[NSNumber numberWithDouble:self.myFamilyIdentifier] forKey:kFMRelationListMyFamilyId];
    [mutableDict setValue:self.pic forKey:kFMRelationListMyFamilyPic];
    [mutableDict setValue:self.birthdayShow forKey:kFMRelationListMyFamilyBirthdayShow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.birthday] forKey:kFMRelationListMyFamilyBirthday];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMyFamily] forKey:kFMRelationListMyFamilyMyFamily];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kFMRelationListMyFamilySex];
    [mutableDict setValue:self.name forKey:kFMRelationListMyFamilyName];

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

    self.faUser = [aDecoder decodeObjectForKey:kFMRelationListMyFamilyFaUser];
    self.mobile = [aDecoder decodeObjectForKey:kFMRelationListMyFamilyMobile];
    self.relationWithMe = [aDecoder decodeObjectForKey:kFMRelationListMyFamilyRelationWithMe];
    self.myFamilyIdentifier = [aDecoder decodeDoubleForKey:kFMRelationListMyFamilyId];
    self.pic = [aDecoder decodeObjectForKey:kFMRelationListMyFamilyPic];
    self.birthdayShow = [aDecoder decodeObjectForKey:kFMRelationListMyFamilyBirthdayShow];
    self.birthday = [aDecoder decodeDoubleForKey:kFMRelationListMyFamilyBirthday];
    self.myFamily = [aDecoder decodeObjectForKey:kFMRelationListMyFamilyMyFamily];
    self.sex = [aDecoder decodeDoubleForKey:kFMRelationListMyFamilySex];
    self.name = [aDecoder decodeObjectForKey:kFMRelationListMyFamilyName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_faUser forKey:kFMRelationListMyFamilyFaUser];
    [aCoder encodeObject:_mobile forKey:kFMRelationListMyFamilyMobile];
    [aCoder encodeObject:_relationWithMe forKey:kFMRelationListMyFamilyRelationWithMe];
    [aCoder encodeDouble:_myFamilyIdentifier forKey:kFMRelationListMyFamilyId];
    [aCoder encodeObject:_pic forKey:kFMRelationListMyFamilyPic];
    [aCoder encodeObject:_birthdayShow forKey:kFMRelationListMyFamilyBirthdayShow];
    [aCoder encodeDouble:_birthday forKey:kFMRelationListMyFamilyBirthday];
    [aCoder encodeObject:_myFamily forKey:kFMRelationListMyFamilyMyFamily];
    [aCoder encodeDouble:_sex forKey:kFMRelationListMyFamilySex];
    [aCoder encodeObject:_name forKey:kFMRelationListMyFamilyName];
}

- (id)copyWithZone:(NSZone *)zone {
    FMRelationListMyFamily *copy = [[FMRelationListMyFamily alloc] init];
    
    
    
    if (copy) {

        copy.faUser = [self.faUser copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.relationWithMe = [self.relationWithMe copyWithZone:zone];
        copy.myFamilyIdentifier = self.myFamilyIdentifier;
        copy.pic = [self.pic copyWithZone:zone];
        copy.birthdayShow = [self.birthdayShow copyWithZone:zone];
        copy.birthday = self.birthday;
        copy.myFamily = [self.myFamily copyWithZone:zone];
        copy.sex = self.sex;
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
