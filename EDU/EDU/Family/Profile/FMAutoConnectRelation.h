//
//  FMAutoConnectRelation.h
//  EDU
//
//  Created by renxingguo on 2016/12/22.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *自动联接关系
 */
@class FMRelationListBaseClass;
@interface FMAutoConnectRelation : NSObject

@property (nonatomic, strong, readonly) RACCommand *command;

@end
