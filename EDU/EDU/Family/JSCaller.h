//
//  JSCaller.h
//  EDU
//
//  Created by renxingguo on 2016/12/26.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSCaller : NSObject

@property(strong,nonatomic) JSValue *relationFunction;
@property(strong,nonatomic) JSValue *getFilterRelativeFunction;

+ (JSCaller *) ShareInstance;

@end
