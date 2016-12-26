//
//  EDUUserFavouriteSacUser.h
//
//  Created by xingguo ren on 16/9/22
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUUserFavouriteSacRole;

@interface EDUUserFavouriteSacUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double sacUserIdentifier;
@property (nonatomic, strong) NSString *logname;
@property (nonatomic, strong) NSString *award;
@property (nonatomic, strong) EDUUserFavouriteSacRole *sacRole;
@property (nonatomic, strong) NSString *school;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *train;
@property (nonatomic, strong) NSString *specialty;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *qq;
@property (nonatomic, strong) NSString *pwd;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSString *grade;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
