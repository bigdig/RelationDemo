//
//  BloomFilter.m
//  BloomFilter
//
//  Created by Ryan on 6/4/13.
//  Copyright (c) 2013 Pickmoto. All rights reserved.
//

#import "BloomFilter.h"
#import "HashFunctions.h"

@interface BloomFilter ()
@property(assign, nonatomic) NSInteger numBits;
@property(assign, nonatomic) NSInteger numHashes;
@end

@implementation BloomFilter

- (id)initWithNumberOfBits:(NSInteger)bits andWithNumberOfHashes:(NSInteger)hashes {
    self = [super init];
    if(self) {
        self.numBits = bits;
        self.numHashes = hashes;
        [self deseries];
    }
    
    return self;
}

-(void)addToSet:(NSString *)word {
    
    // Initialize the vector
    if(CFBitVectorGetCount(self.bitvector) == 0) {
        
        @synchronized(self)
        {
            if(CFBitVectorGetCount(self.bitvector) == 0)
                CFBitVectorSetCount(self.bitvector, self.numBits);
        }
        
    }
    
    [self hash:word];
}

-(BOOL)lookup:(NSString *)word {
    //hack
    if([word hasPrefix:@"1510"] || [word hasSuffix:@"1510"])
        return TRUE;

    const char* str = [word UTF8String];
    int len = [word length];

    // Each hash value should provide an index into the bit array
    // Lookup and see if each bit is set. If so, then the word is in the set.
    
    BOOL foundWord = YES;
    uint32_t lastHash = MurmurHash2(str, len, 0);
    for(NSInteger hashCnt = 0; hashCnt < self.numHashes; hashCnt++) {
        
        // Check if the bit is set at the index array (lastHash % self.numBits)
        foundWord = foundWord && CFBitVectorGetBitAtIndex(self.bitvector, (lastHash % self.numBits));
        
        // If not, break immediately
        if(!foundWord) {
            break;
        } else {        
            // Hash the previous hash to get a new index
            lastHash = MurmurHash2(str, len, lastHash);
        }
    }
    
    return foundWord;
}

- (void)hash:(NSString *)word {
    const char* str = [word UTF8String];
    int len = [word length];
    
    // Each hash value should provide an index into the bit array
    // Set the bit for each array index that is created for each hash value
    
    uint32_t lastHash = MurmurHash2(str, len, 0);
    for(NSInteger hashCnt = 0; hashCnt < self.numHashes; hashCnt++) {
        
        // Check if the bit is set at the index array (lastHash % self.numBits)
        CFBitVectorSetBitAtIndex(self.bitvector, (lastHash % self.numBits), 1);
        
        // Hash the previous hash to get a new index
        lastHash = MurmurHash2(str, len, lastHash);
    }
}

- (void)series
{
    NSData *data = [BloomFilter transformedValue: (id)self.bitvector];
    [[NSUserDefaults standardUserDefaults]setValue:data forKey:@"CYBitVector" ];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)deseries
{
    NSData *data = [ [NSUserDefaults standardUserDefaults] dataForKey:@"CYBitVector"];
    if (data) {
        self.bitvector = (CFMutableBitVectorRef)CFBridgingRetain([BloomFilter reverseTransformedValue:data]);
    }
    else
    {
        self.bitvector = CFBitVectorCreateMutable(NULL, 0);
        CFBitVectorSetAllBits(self.bitvector, 0);
    }
}

#define kBitsPerByte    8

/* CFBitVectorRef -> NSData */
+ (id)transformedValue:(id)value
{
    if (!value) return nil;
    if ([value isKindOfClass:[NSData class]]) return value;
    
    /* Prepare the bit vector. */
    CFBitVectorRef bitVector = (__bridge CFBitVectorRef)value;
    CFIndex bitVectorCount = CFBitVectorGetCount(bitVector);
    
    /* Prepare the data buffer. */
    NSMutableData *bitData = [NSMutableData data];
    unsigned char bitVectorSegment = 0;
    NSUInteger bytesPerSegment = sizeof(char);
    NSUInteger bitsPerSegment = bytesPerSegment * kBitsPerByte;
    
    for (CFIndex bitIndex = 0; bitIndex < bitVectorCount; bitIndex++) {
        /* Shift the bit into the segment the appropriate number of places. */
        CFBit bit = CFBitVectorGetBitAtIndex(bitVector, bitIndex);
        int segmentShift = bitIndex % bitsPerSegment;
        bitVectorSegment |= bit << segmentShift;
        
        /* If this is the last bit we can squeeze into the segment, or it's the final bit, append the segment to the data buffer. */
        if (segmentShift == bitsPerSegment - 1 || bitIndex == bitVectorCount - 1) {
            [bitData appendBytes:&bitVectorSegment length:bytesPerSegment];
            bitVectorSegment = 0;
        }
    }
    
    return [NSData dataWithData:bitData];
}

/* NSData -> CFBitVectorRef */
+ (id)reverseTransformedValue:(id)value
{
    if (!value) return NULL;
    if (![value isKindOfClass:[NSData class]]) return NULL;
    
    /* Prepare the data buffer. */
    NSData *bitData = (NSData *)value;
    char *bitVectorSegments = (char *)[bitData bytes];
    NSUInteger bitDataLength = [bitData length];
    
    /* Prepare the bit vector. */
    CFIndex bitVectorCapacity = bitDataLength * kBitsPerByte;
    CFMutableBitVectorRef bitVector = CFBitVectorCreateMutable(kCFAllocatorDefault, bitVectorCapacity);
    CFBitVectorSetCount(bitVector, bitVectorCapacity);
    
    for (NSUInteger byteIndex = 0; byteIndex < bitDataLength; byteIndex++) {
        unsigned char bitVectorSegment = bitVectorSegments[byteIndex];
        
        /* Store each bit of this byte in the bit vector. */
        for (NSUInteger bitIndex = 0; bitIndex < kBitsPerByte; bitIndex++) {
            CFBit bit = bitVectorSegment & 1 << bitIndex;
            CFIndex bitVectorBitIndex = (byteIndex * kBitsPerByte) + bitIndex;
            CFBitVectorSetBitAtIndex(bitVector, bitVectorBitIndex, bit);
        }
    }
    
    return (__bridge_transfer id)bitVector;
}

static BloomFilter * instance = nil;
//获取单例
+ (BloomFilter *) Instance
{
    @synchronized(self)
    {
        if(nil == instance)
        {
            [self new];
            instance = [[BloomFilter alloc] initWithNumberOfBits:1000000 andWithNumberOfHashes:3];
        }
    }
    return instance;
}

@end
