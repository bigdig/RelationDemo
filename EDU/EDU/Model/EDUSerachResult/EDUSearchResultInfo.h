//
//  EDUSearchResultInfo.h
//
//  Created by   on 2016/10/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUSearchResultInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) double curPage;
@property (nonatomic, assign) double type;
@property (nonatomic, assign) double curNum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
