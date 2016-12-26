//
//  EDUResGroupListInfo.h
//
//  Created by   on 2016/10/14
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUResGroupListInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, assign) double sort;
@property (nonatomic, assign) double infoIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *titlePic;
@property (nonatomic, assign) double cnt;
@property (nonatomic, strong) NSString *totalTimeShow;
@property (nonatomic, strong) NSString *longTitle;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
