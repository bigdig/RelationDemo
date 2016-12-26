//
//  FMRelationListRelation.m
//
//  Created by   on 2016/12/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FMRelationListRelation.h"
#import "FMRelationListFaUser.h"
#import "FMRelationListMyFamily.h"


NSString *const kFMRelationListRelationFaUser = @"faUser";
NSString *const kFMRelationListRelationMobile = @"mobile";
NSString *const kFMRelationListRelationRelationWithMe = @"relationWithMe";
NSString *const kFMRelationListRelationId = @"id";
NSString *const kFMRelationListRelationPic = @"pic";
NSString *const kFMRelationListRelationBirthdayShow = @"birthdayShow";
NSString *const kFMRelationListRelationBirthday = @"birthday";
NSString *const kFMRelationListRelationMyFamily = @"myFamily";
NSString *const kFMRelationListRelationSex = @"sex";
NSString *const kFMRelationListRelationName = @"name";


@interface FMRelationListRelation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FMRelationListRelation

@synthesize faUser = _faUser;
@synthesize mobile = _mobile;
@synthesize relationWithMe = _relationWithMe;
@synthesize relationIdentifier = _relationIdentifier;
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
            self.faUser = [FMRelationListFaUser modelObjectWithDictionary:[dict objectForKey:kFMRelationListRelationFaUser]];
            self.mobile = [self objectOrNilForKey:kFMRelationListRelationMobile fromDictionary:dict];
            self.relationWithMe = [self objectOrNilForKey:kFMRelationListRelationRelationWithMe fromDictionary:dict];
            self.relationIdentifier = [[self objectOrNilForKey:kFMRelationListRelationId fromDictionary:dict] doubleValue];
            self.pic = [self objectOrNilForKey:kFMRelationListRelationPic fromDictionary:dict];
            self.birthdayShow = [self objectOrNilForKey:kFMRelationListRelationBirthdayShow fromDictionary:dict];
            self.birthday = [[self objectOrNilForKey:kFMRelationListRelationBirthday fromDictionary:dict] doubleValue];
    NSObject *receivedFMRelationListMyFamily = [dict objectForKey:kFMRelationListRelationMyFamily];
    NSMutableArray *parsedFMRelationListMyFamily = [NSMutableArray array];
    
    if ([receivedFMRelationListMyFamily isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFMRelationListMyFamily) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFMRelationListMyFamily addObject:[FMRelationListMyFamily modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFMRelationListMyFamily isKindOfClass:[NSDictionary class]]) {
       [parsedFMRelationListMyFamily addObject:[FMRelationListMyFamily modelObjectWithDictionary:(NSDictionary *)receivedFMRelationListMyFamily]];
    }

    self.myFamily = [NSArray arrayWithArray:parsedFMRelationListMyFamily];
            self.sex = [[self objectOrNilForKey:kFMRelationListRelationSex fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kFMRelationListRelationName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.faUser dictionaryRepresentation] forKey:kFMRelationListRelationFaUser];
    [mutableDict setValue:self.mobile forKey:kFMRelationListRelationMobile];
    [mutableDict setValue:self.relationWithMe forKey:kFMRelationListRelationRelationWithMe];
    [mutableDict setValue:[NSNumber numberWithDouble:self.relationIdentifier] forKey:kFMRelationListRelationId];
    [mutableDict setValue:self.pic forKey:kFMRelationListRelationPic];
    [mutableDict setValue:self.birthdayShow forKey:kFMRelationListRelationBirthdayShow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.birthday] forKey:kFMRelationListRelationBirthday];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMyFamily] forKey:kFMRelationListRelationMyFamily];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kFMRelationListRelationSex];
    [mutableDict setValue:self.name forKey:kFMRelationListRelationName];

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

    self.faUser = [aDecoder decodeObjectForKey:kFMRelationListRelationFaUser];
    self.mobile = [aDecoder decodeObjectForKey:kFMRelationListRelationMobile];
    self.relationWithMe = [aDecoder decodeObjectForKey:kFMRelationListRelationRelationWithMe];
    self.relationIdentifier = [aDecoder decodeDoubleForKey:kFMRelationListRelationId];
    self.pic = [aDecoder decodeObjectForKey:kFMRelationListRelationPic];
    self.birthdayShow = [aDecoder decodeObjectForKey:kFMRelationListRelationBirthdayShow];
    self.birthday = [aDecoder decodeDoubleForKey:kFMRelationListRelationBirthday];
    self.myFamily = [aDecoder decodeObjectForKey:kFMRelationListRelationMyFamily];
    self.sex = [aDecoder decodeDoubleForKey:kFMRelationListRelationSex];
    self.name = [aDecoder decodeObjectForKey:kFMRelationListRelationName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_faUser forKey:kFMRelationListRelationFaUser];
    [aCoder encodeObject:_mobile forKey:kFMRelationListRelationMobile];
    [aCoder encodeObject:_relationWithMe forKey:kFMRelationListRelationRelationWithMe];
    [aCoder encodeDouble:_relationIdentifier forKey:kFMRelationListRelationId];
    [aCoder encodeObject:_pic forKey:kFMRelationListRelationPic];
    [aCoder encodeObject:_birthdayShow forKey:kFMRelationListRelationBirthdayShow];
    [aCoder encodeDouble:_birthday forKey:kFMRelationListRelationBirthday];
    [aCoder encodeObject:_myFamily forKey:kFMRelationListRelationMyFamily];
    [aCoder encodeDouble:_sex forKey:kFMRelationListRelationSex];
    [aCoder encodeObject:_name forKey:kFMRelationListRelationName];
}

- (id)copyWithZone:(NSZone *)zone {
    FMRelationListRelation *copy = [[FMRelationListRelation alloc] init];
    
    
    
    if (copy) {

        copy.faUser = [self.faUser copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.relationWithMe = [self.relationWithMe copyWithZone:zone];
        copy.relationIdentifier = self.relationIdentifier;
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
