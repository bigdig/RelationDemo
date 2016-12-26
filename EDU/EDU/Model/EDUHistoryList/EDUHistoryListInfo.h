//
//  EDUHistoryListInfo.h
//
//  Created by   on 2016/10/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUHistoryListResCourse, EDUHistoryListSacUser;

@interface EDUHistoryListInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) EDUHistoryListResCourse *resCourse;
@property (nonatomic, assign) double infoIdentifier;
@property (nonatomic, strong) EDUHistoryListSacUser *sacUser;
@property (nonatomic, assign) double playTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
