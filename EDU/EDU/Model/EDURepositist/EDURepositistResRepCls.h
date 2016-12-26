//
//  EDURepositistResRepCls.h
//
//  Created by xingguo ren on 16/9/2
//  Copyright (c) 2016 伊人依美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface EDURepositistResRepCls : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double resRepClsIdentifier;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *descr;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
