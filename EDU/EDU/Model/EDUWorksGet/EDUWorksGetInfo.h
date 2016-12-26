//
//  EDUWorksGetInfo.h
//
//  Created by ScanZen Workgroup on 2016/10/12
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUWorksGetInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double sort;
@property (nonatomic, strong) NSString *sfrom;
@property (nonatomic, assign) double infoIdentifier;
@property (nonatomic, strong) NSString *addTimeShow;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, assign) double duration;
@property (nonatomic, strong) NSString *timeShow;
@property (nonatomic, assign) id memo;
@property (nonatomic, strong) NSString *url;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
