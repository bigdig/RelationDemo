//
//  EDUSearchResultInfo.m
//
//  Created by   on 2016/10/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "EDUSearchResultInfo.h"
#import "EDUSearchResultList.h"


NSString *const kEDUSearchResultInfoList = @"list";
NSString *const kEDUSearchResultInfoCurPage = @"curPage";
NSString *const kEDUSearchResultInfoType = @"type";
NSString *const kEDUSearchResultInfoCurNum = @"curNum";


@interface EDUSearchResultInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EDUSearchResultInfo

@synthesize list = _list;
@synthesize curPage = _curPage;
@synthesize type = _type;
@synthesize curNum = _curNum;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedEDUSearchResultList = [dict objectForKey:kEDUSearchResultInfoList];
    NSMutableArray *parsedEDUSearchResultList = [NSMutableArray array];
    
    if ([receivedEDUSearchResultList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedEDUSearchResultList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedEDUSearchResultList addObject:[EDUSearchResultList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedEDUSearchResultList isKindOfClass:[NSDictionary class]]) {
       [parsedEDUSearchResultList addObject:[EDUSearchResultList modelObjectWithDictionary:(NSDictionary *)receivedEDUSearchResultList]];
    }

    self.list = [NSArray arrayWithArray:parsedEDUSearchResultList];
            self.curPage = [[self objectOrNilForKey:kEDUSearchResultInfoCurPage fromDictionary:dict] doubleValue];
            self.type = [[self objectOrNilForKey:kEDUSearchResultInfoType fromDictionary:dict] doubleValue];
            self.curNum = [[self objectOrNilForKey:kEDUSearchResultInfoCurNum fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.list) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kEDUSearchResultInfoList];
    [mutableDict setValue:[NSNumber numberWithDouble:self.curPage] forKey:kEDUSearchResultInfoCurPage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kEDUSearchResultInfoType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.curNum] forKey:kEDUSearchResultInfoCurNum];

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

    self.list = [aDecoder decodeObjectForKey:kEDUSearchResultInfoList];
    self.curPage = [aDecoder decodeDoubleForKey:kEDUSearchResultInfoCurPage];
    self.type = [aDecoder decodeDoubleForKey:kEDUSearchResultInfoType];
    self.curNum = [aDecoder decodeDoubleForKey:kEDUSearchResultInfoCurNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_list forKey:kEDUSearchResultInfoList];
    [aCoder encodeDouble:_curPage forKey:kEDUSearchResultInfoCurPage];
    [aCoder encodeDouble:_type forKey:kEDUSearchResultInfoType];
    [aCoder encodeDouble:_curNum forKey:kEDUSearchResultInfoCurNum];
}

- (id)copyWithZone:(NSZone *)zone {
    EDUSearchResultInfo *copy = [[EDUSearchResultInfo alloc] init];
    
    
    
    if (copy) {

        copy.list = [self.list copyWithZone:zone];
        copy.curPage = self.curPage;
        copy.type = self.type;
        copy.curNum = self.curNum;
    }
    
    return copy;
}


@end
