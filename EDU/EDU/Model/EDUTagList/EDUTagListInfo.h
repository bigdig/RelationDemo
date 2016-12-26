//
//  EDUTagListInfo.h
//
//  Created by   on 2016/12/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUTagListInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *myProperty1;
@property (nonatomic, strong) NSArray *myProperty2;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
