//
//  EDUUserFavouriteInfo.h
//
//  Created by xingguo ren on 16/9/22
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUUserFavouriteSacUser, EDUUserFavouriteResCourse;

@interface EDUUserFavouriteInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) EDUUserFavouriteSacUser *sacUser;
@property (nonatomic, assign) double infoIdentifier;
@property (nonatomic, strong) NSString *addTimeShow;
@property (nonatomic, strong) EDUUserFavouriteResCourse *resCourse;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
