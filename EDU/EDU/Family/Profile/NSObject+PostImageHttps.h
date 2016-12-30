//
//  NSObject+PostImageHttps.h
//  EDU
//
//  Created by renxingguo on 2016/12/30.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PostImageHttps)

- (void)requestPostUrlWithImage: (NSString *)serviceName parameters:(NSDictionary *)dictParams image:(UIImage *)image success:(void (^)(NSDictionary *responce))success failure:(void (^)(NSError *error))failure;
    
@end
