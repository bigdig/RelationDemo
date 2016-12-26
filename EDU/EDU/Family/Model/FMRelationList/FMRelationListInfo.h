//
//  FMRelationListInfo.h
//
//  Created by   on 2016/12/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FMRelationListInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *recode;
@property (nonatomic, strong) NSString *redesc;
@property (nonatomic, strong) NSArray *relation;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
