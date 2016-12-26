//
//  UITableView+RereshHead.h
//  DressingCollection
//
//  Created by renxingguo on 15/11/4.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa/ReactiveCocoa.h"

@interface UITableView (RereshHead)

@property (strong,nonatomic) RACCommand * refreshCommand;
@property (strong,nonatomic) NSString *emptyHint;
@property (strong,nonatomic) RACSignal *dataRefreshingSignal;

@end
