//
//  FMRelationListMyFamily.h
//
//  Created by   on 2016/12/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FMRelationListMyFamily : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) id faUser;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) id relationWithMe;
@property (nonatomic, assign) double myFamilyIdentifier;
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
