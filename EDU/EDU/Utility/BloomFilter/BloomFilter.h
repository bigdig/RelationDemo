//
//  BloomFilter.h
//  BloomFilter
//
//  Created by Ryan on 6/4/13.
//  Copyright (c) 2013 Pickmoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BloomFilter : NSObject

@property CFMutableBitVectorRef bitvector;

+ (BloomFilter *) Instance;

- (id)initWithNumberOfBits:(NSInteger)bits andWithNumberOfHashes:(NSInteger)hashes;
-(void)addToSet:(NSString *)word;
-(BOOL)lookup:(NSString *)word;

- (void)series;
- (void)deseries;

+ (id)transformedValue:(id)value;
+ (id)reverseTransformedValue:(id)value;

@end
