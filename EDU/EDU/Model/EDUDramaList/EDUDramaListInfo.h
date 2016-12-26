//
//  EDUDramaListInfo.h
//
//  Created by   on 2016/10/14
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDUDramaListShaArticlesCls;

@interface EDUDramaListInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double sort;
@property (nonatomic, assign) double infoIdentifier;
@property (nonatomic, strong) NSString *addTimeShow;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) EDUDramaListShaArticlesCls *shaArticlesCls;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSString *url;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
