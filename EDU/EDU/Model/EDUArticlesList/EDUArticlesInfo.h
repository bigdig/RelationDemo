//
//  EDUArticlesInfo.h
//
//  Created by ScanZen Workgroup on 2016/10/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUArticlesInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double infoIdentifier;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double sort;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
