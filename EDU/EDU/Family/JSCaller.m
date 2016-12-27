//
//  JSCaller.m
//  EDU
//
//  Created by renxingguo on 2016/12/26.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "JSCaller.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSCaller ()

@property(strong,nonatomic) JSContext *context;

@end

@implementation JSCaller

static JSCaller * instance = nil;
//获取单例
+ (JSCaller *) ShareInstance
{
    @synchronized(self)
    {
        if(nil == instance)
        {
            [self new];
            [instance bind];
        }
    }
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}



- (void)bind
{
    self.context = [[JSContext alloc] init];
    [self.context evaluateScript:[self loadJsFile:@"relationship"]];
    self.relationFunction = [[self.context objectForKeyedSubscript:@"relationship"] objectForKeyedSubscript:@"relationship"];
    self.getFilterRelativeFunction = [[self.context objectForKeyedSubscript:@"relationship"] objectForKeyedSubscript:@"getFilterRelative"];
    JSValue *result = [self.relationFunction callWithArguments:@[@{@"text":@"爸爸的爸爸",@"sex":[NSNumber numberWithInt:0],
                                                      @"reverse":[NSNumber numberWithBool:true]
                                                      }]];
    NSLog(@"%@",[result toString]);
}

- (NSString *)loadJsFile:(NSString*)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"js"];
    NSString *jsScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return jsScript;
}

@end
