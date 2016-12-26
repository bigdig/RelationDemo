//
//  FMRelationListRelation.h
//
//  Created by   on 2016/12/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMRelationListFaUser;

@interface FMRelationListRelation : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) FMRelationListFaUser *faUser;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *relationWithMe;
@property (nonatomic, assign) double relationIdentifier;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *birthdayShow;
@property (nonatomic, assign) double birthday;
@property (nonatomic, strong) NSArray *myFamily;
@property (nonatomic, assign) double sex;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
