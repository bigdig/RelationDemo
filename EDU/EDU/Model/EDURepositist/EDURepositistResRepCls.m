//
//  EDURepositistResRepCls.m
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import "EDURepositistResRepCls.h"


NSString *const kEDURepositistResRepClsId = @"id";
NSString *const kEDURepositistResRepClsIcon = @"icon";
NSString *const kEDURepositistResRepClsName = @"name";
NSString *const kEDURepositistResRepClsDescr = @"descr";


@interface EDURepositistResRepCls ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDURepositistResRepCls

@synthesize resRepClsIdentifier = _resRepClsIdentifier;
@synthesize icon = _icon;
@synthesize name = _name;
@synthesize descr = _descr;


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
            self.resRepClsIdentifier = [[self objectOrNilForKey:kEDURepositistResRepClsId fromDictionary:dict] doubleValue];
            self.icon = [self objectOrNilForKey:kEDURepositistResRepClsIcon fromDictionary:dict];
            self.name = [self objectOrNilForKey:kEDURepositistResRepClsName fromDictionary:dict];
            self.descr = [self objectOrNilForKey:kEDURepositistResRepClsDescr fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resRepClsIdentifier] forKey:kEDURepositistResRepClsId];
    [mutableDict setValue:self.icon forKey:kEDURepositistResRepClsIcon];
    [mutableDict setValue:self.name forKey:kEDURepositistResRepClsName];
    [mutableDict setValue:self.descr forKey:kEDURepositistResRepClsDescr];

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

    self.resRepClsIdentifier = [aDecoder decodeDoubleForKey:kEDURepositistResRepClsId];
    self.icon = [aDecoder decodeObjectForKey:kEDURepositistResRepClsIcon];
    self.name = [aDecoder decodeObjectForKey:kEDURepositistResRepClsName];
    self.descr = [aDecoder decodeObjectForKey:kEDURepositistResRepClsDescr];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_resRepClsIdentifier forKey:kEDURepositistResRepClsId];
    [aCoder encodeObject:_icon forKey:kEDURepositistResRepClsIcon];
    [aCoder encodeObject:_name forKey:kEDURepositistResRepClsName];
    [aCoder encodeObject:_descr forKey:kEDURepositistResRepClsDescr];
}

- (id)copyWithZone:(NSZone *)zone
{
    EDURepositistResRepCls *copy = [[EDURepositistResRepCls alloc] init];
    
    if (copy) {

        copy.resRepClsIdentifier = self.resRepClsIdentifier;
        copy.icon = [self.icon copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.descr = [self.descr copyWithZone:zone];
    }
    
    return copy;
}


@end
