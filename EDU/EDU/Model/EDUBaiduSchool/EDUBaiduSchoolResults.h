//
//  EDUBaiduSchoolResults.h
//
//  Created by   on 2016/11/9
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUBaiduSchoolLocation;

@interface EDUBaiduSchoolResults : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double detail;
@property (nonatomic, strong) NSString *streetId;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) EDUBaiduSchoolLocation *location;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
