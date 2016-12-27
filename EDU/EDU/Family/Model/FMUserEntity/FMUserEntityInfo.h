//
//  FMUserEntityInfo.h
//
//  Created by   on 2016/12/26
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMUserEntityEntityUser;

@interface FMUserEntityInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double recode;
@property (nonatomic, strong) NSString *redesc;
@property (nonatomic, strong) FMUserEntityEntityUser *entityUser;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
