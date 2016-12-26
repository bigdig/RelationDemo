//
//  EDUUserFavouriteBaseClass.h
//
//  Created by xingguo ren on 16/9/22
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUUserFavouriteBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *info;
@property (nonatomic, assign) double code;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
