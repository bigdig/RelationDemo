//
//  EDURepositistList.m
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDURepositistList.h"
#import "EDURepositistResAuth.h"
#import "EDURepositistResRepCls.h"


NSString *const kEDURepositistListSort = @"sort";
NSString *const kEDURepositistListResAuth = @"resAuth";
NSString *const kEDURepositistListId = @"id";
NSString *const kEDURepositistListAddTimeShow = @"addTimeShow";
NSString *const kEDURepositistListDescr = @"descr";
NSString *const kEDURepositistListResRepCls = @"resRepCls";
NSString *const kEDURepositistListSize = @"size";
NSString *const kEDURepositistListPath = @"path";
NSString *const kEDURepositistListAuth = @"auth";
NSString *const kEDURepositistListName = @"name";
NSString *const kEDURepositistListCanShow = @"canShow";


@interface EDURepositistList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDURepositistList

@synthesize sort = _sort;
@synthesize resAuth = _resAuth;
@synthesize listIdentifier = _listIdentifier;
@synthesize addTimeShow = _addTimeShow;
@synthesize descr = _descr;
@synthesize resRepCls = _resRepCls;
@synthesize size = _size;
@synthesize path = _path;
@synthesize auth = _auth;
@synthesize name = _name;
@synthesize canShow = _canShow;


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
            self.sort = [[self objectOrNilForKey:kEDURepositistListSort fromDictionary:dict] doubleValue];
            self.resAuth = [EDURepositistResAuth modelObjectWithDictionary:[dict objectForKey:kEDURepositistListResAuth]];
            self.listIdentifier = [[self objectOrNilForKey:kEDURepositistListId fromDictionary:dict] doubleValue];
            self.addTimeShow = [self objectOrNilForKey:kEDURepositistListAddTimeShow fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDURepositistListDescr fromDictionary:dict];
            self.resRepCls = [EDURepositistResRepCls modelObjectWithDictionary:[dict objectForKey:kEDURepositistListResRepCls]];
            self.size = [[self objectOrNilForKey:kEDURepositistListSize fromDictionary:dict] doubleValue];
            self.path = [self objectOrNilForKey:kEDURepositistListPath fromDictionary:dict];
            self.auth = [self objectOrNilForKey:kEDURepositistListAuth fromDictionary:dict];
            self.name = [self objectOrNilForKey:kEDURepositistListName fromDictionary:dict];
            self.canShow = [[self objectOrNilForKey:kEDURepositistListCanShow fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sort] forKey:kEDURepositistListSort];
    [mutableDict setValue:[self.resAuth dictionaryRepresentation] forKey:kEDURepositistListResAuth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.listIdentifier] forKey:kEDURepositistListId];
    [mutableDict setValue:self.addTimeShow forKey:kEDURepositistListAddTimeShow];
    [mutableDict setValue:self.descr forKey:kEDURepositistListDescr];
    [mutableDict setValue:[self.resRepCls dictionaryRepresentation] forKey:kEDURepositistListResRepCls];
    [mutableDict setValue:[NSNumber numberWithDouble:self.size] forKey:kEDURepositistListSize];
    [mutableDict setValue:self.path forKey:kEDURepositistListPath];
    [mutableDict setValue:self.auth forKey:kEDURepositistListAuth];
    [mutableDict setValue:self.name forKey:kEDURepositistListName];
    [mutableDict setValue:[NSNumber numberWithBool:self.canShow] forKey:kEDURepositistListCanShow];

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

    self.sort = [aDecoder decodeDoubleForKey:kEDURepositistListSort];
    self.resAuth = [aDecoder decodeObjectForKey:kEDURepositistListResAuth];
    self.listIdentifier = [aDecoder decodeDoubleForKey:kEDURepositistListId];
    self.addTimeShow = [aDecoder decodeObjectForKey:kEDURepositistListAddTimeShow];
    self.descr = [aDecoder decodeObjectForKey:kEDURepositistListDescr];
    self.resRepCls = [aDecoder decodeObjectForKey:kEDURepositistListResRepCls];
    self.size = [aDecoder decodeDoubleForKey:kEDURepositistListSize];
    self.path = [aDecoder decodeObjectForKey:kEDURepositistListPath];
    self.auth = [aDecoder decodeObjectForKey:kEDURepositistListAuth];
    self.name = [aDecoder decodeObjectForKey:kEDURepositistListName];
    self.canShow = [aDecoder decodeBoolForKey:kEDURepositistListCanShow];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sort forKey:kEDURepositistListSort];
    [aCoder encodeObject:_resAuth forKey:kEDURepositistListResAuth];
    [aCoder encodeDouble:_listIdentifier forKey:kEDURepositistListId];
    [aCoder encodeObject:_addTimeShow forKey:kEDURepositistListAddTimeShow];
    [aCoder encodeObject:_descr forKey:kEDURepositistListDescr];
    [aCoder encodeObject:_resRepCls forKey:kEDURepositistListResRepCls];
    [aCoder encodeDouble:_size forKey:kEDURepositistListSize];
    [aCoder encodeObject:_path forKey:kEDURepositistListPath];
    [aCoder encodeObject:_auth forKey:kEDURepositistListAuth];
    [aCoder encodeObject:_name forKey:kEDURepositistListName];
    [aCoder encodeBool:_canShow forKey:kEDURepositistListCanShow];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDURepositistList *copy = [[EDURepositistList alloc] init];
    
    if (copy) {

        copy.sort = self.sort;
        copy.resAuth = [self.resAuth copyWithZone:zone];
        copy.listIdentifier = self.listIdentifier;
        copy.addTimeShow = [self.addTimeShow copyWithZone:zone];
        copy.descr = [self.descr copyWithZone:zone];
        copy.resRepCls = [self.resRepCls copyWithZone:zone];
        copy.size = self.size;
        copy.path = [self.path copyWithZone:zone];
        copy.auth = [self.auth copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.canShow = self.canShow;
    }
    
    return copy;
}


@end
