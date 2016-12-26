//
//  FMRelationListFaUser.h
//
//  Created by   on 2016/12/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FMRelationListFaUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, assign) id wxnick;
@property (nonatomic, assign) id wxid;
@property (nonatomic, assign) double faUserIdentifier;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, assign) id wxpic;
@property (nonatomic, assign) double sex;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) id pwd;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
