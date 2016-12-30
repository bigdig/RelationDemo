//
//  FMAutoConnectRelation.m
//  EDU
//
//  Created by renxingguo on 2016/12/22.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FMAutoConnectRelation.h"
#import "NSString+MD5.h"
#import "JSONHTTPClient.h"
#import "BloomFilter.h"
#import "FMRelationListDataModels.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WtFaRelationAddMoreModel : JSONModel

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) NSString *message;

- (BOOL)isSuccess;
@end

@implementation WtFaRelationAddMoreModel

- (BOOL)isSuccess
{
    return self.code == 0;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"code": @"code",
                                                       @"message":@"message"
                                                       
                                                       }];
}

@end


@interface FMAutoConnectRelation ()

@property (nonatomic,strong) JSContext* context;

@end

@implementation FMAutoConnectRelation


- (instancetype)init
{
    if (self = [super init]) {
        [self initialBind];
    }
    
    return self;
}


- (NSString *)loadJsFile:(NSString*)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"js"];
    NSString *jsScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return jsScript;
}


// 初始化绑定
- (void)initialBind
{
    @weakify(self);
    
    
    self.context = [[JSContext alloc] init];
    [self.context evaluateScript:[self loadJsFile:@"relationship"]];
    JSValue *function = [[self.context objectForKeyedSubscript:@"relationship"] objectForKeyedSubscript:@"relationship"];
    
    
    // 处理登录业务逻辑
    _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
                {
                    
                    @strongify(self);
                    
                    NSDictionary* para= @{@"user_id": [Configuration Instance].userID,
                                          };
                    
                    [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/faRelationListByUser.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
                        //
                        FMRelationListBaseClass *model = [FMRelationListBaseClass modelObjectWithDictionary:json];
                        
                        NSMutableSet *existRelationSet = [NSMutableSet setWithCapacity:100];
                        [model.info.relation enumerateObjectsUsingBlock:^(FMRelationListRelation*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [existRelationSet addObject:[[NSNumber numberWithDouble:obj.relationIdentifier]  stringValue]];
                        }];
                        
                        
                        NSMutableSet *relationSet = [NSMutableSet setWithCapacity:100];
                        
                        [model.info.relation enumerateObjectsUsingBlock:^(FMRelationListRelation*  _Nonnull objA, NSUInteger idx, BOOL * _Nonnull stop) {
                            
                            [objA.myFamily enumerateObjectsUsingBlock:^(FMRelationListMyFamily*  _Nonnull objB, NSUInteger idx, BOOL * _Nonnull stop) {
                                
                                NSString *idcode = [[NSNumber numberWithDouble:objB.myFamilyIdentifier]  stringValue];
                                //connect it
                                if (![existRelationSet containsObject:idcode] ) {
                                    
                                    NSString *relation = [NSString stringWithFormat:@"%@的%@", objA.relationWithMe, objB.relationWithMe];
                                    JSValue *result = [function callWithArguments:@[@{@"text":relation,@"sex":[NSNumber numberWithInt:[[Configuration Instance].sex integerValue]]}]];
                                    NSString *r = [[result toArray] objectAtIndex:0];
                                    NSLog(@"%@",r);
                                    if([r length])
                                    {
                                        [relationSet addObject:[NSString stringWithFormat:@"%@@%@@%@",idcode,r,r]];
                                    }

                                }
                                
                                
                            }];
                        }];
                        
                        if ([relationSet count]) {
                            NSDictionary* para= @{@"user_id":[Configuration Instance].userID,                                                  @"params": [[relationSet allObjects] componentsJoinedByString:@","]
                                                  };
                            
                            [JSONHTTPClient postJSONFromURLWithString:[NSString stringWithFormat:@"%@/wtFaRelationAddMore.json",BASEURL]
                                                               params:para
                                                           completion:^(id json, JSONModelError *err) {
                                                               
                                                               //check err, process json ...
                                                               WtFaRelationAddMoreModel *model = [[WtFaRelationAddMoreModel alloc] initWithDictionary:json error:nil];
                                                               
                                                               if (!model.isSuccess)
                                                               {
                                                                   [subscriber sendNext:RACTuplePack(@(NO),model.message)];
                                                               }
                                                               else
                                                               {
                                                                   NSString *info = [NSString stringWithFormat:@"又找到了 %n 亲戚！",[relationSet count]];
                                                                   [subscriber sendNext:RACTuplePack(@(YES),info)];
                                                               }
                                                               [subscriber sendCompleted];
                                                           }];
                        }
                        
                    }];
                    
                    
                    return nil;
                }];
    }];
}


@end
