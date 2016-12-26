//
//  EDUBaiduSchoolLocation.h
//
//  Created by   on 2016/11/9
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUBaiduSchoolLocation : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
