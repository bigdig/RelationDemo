//
//  FMUserEntityEntityUser.h
//
//  Created by   on 2016/12/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMUserEntityFaUser;

@interface FMUserEntityEntityUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) FMUserEntityFaUser *faUser;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) id relationWithMe;
@property (nonatomic, assign) double entityUserIdentifier;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSArray *myFamily;
@property (nonatomic, strong) NSString *birthdayShow;
@property (nonatomic, assign) double sex;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
