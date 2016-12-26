//
//  UITableView+LoadMore.h
//  DressingCollection
//
//  Created by renxingguo on 15/12/24.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@interface UITableView (LoadMore)

@property (nonatomic,strong) NSNumber *pageIndex;
@property (nonatomic,strong) RACCommand *loadPageCommand;

@end
