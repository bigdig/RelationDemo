//
//  EDUDramaListShaArticlesCls.h
//
//  Created by   on 2016/10/14
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUDramaListShaArticlesCls : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double shaArticlesClsIdentifier;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double sort;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
