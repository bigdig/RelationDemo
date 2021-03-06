//
//  EDUTagListInternalBaseClass2.h
//
//  Created by   on 2016/12/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDUTagListInternalBaseClass2 : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double internalBaseClass2Identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double groupId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
