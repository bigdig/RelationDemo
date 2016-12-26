//
//  EDUCourseCommentSacUser.h
//
//  Created by   on 2016/10/27
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUCourseCommentSacRole;

@interface EDUCourseCommentSacUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double sacUserIdentifier;
@property (nonatomic, assign) id rememberPwd;
@property (nonatomic, strong) NSString *award;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *school;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) EDUCourseCommentSacRole *sacRole;
@property (nonatomic, assign) double loginResult;
@property (nonatomic, strong) NSString *train;
@property (nonatomic, strong) NSString *specialty;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *pwd;
@property (nonatomic, strong) NSString *qq;
@property (nonatomic, strong) NSString *logname;
@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSString *email;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
