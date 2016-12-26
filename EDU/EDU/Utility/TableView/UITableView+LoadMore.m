//
//  UITableView+LoadMore.m
//  DressingCollection
//
//  Created by renxingguo on 15/12/24.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "UITableView+LoadMore.h"
#import "UITableView+RereshHead.h"
#include "SDRefreshFooterView.h"
#include <objc/runtime.h>

static char kSignalKey;
static char kSignalPageKey;

@implementation UITableView (LoadMore)

- (void)setLoadPageCommand:(RACCommand *)loadMoreCommand
{
    self.pageIndex = @2;
    objc_setAssociatedObject(self, &kSignalKey, loadMoreCommand, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setupFooter];
}

- (RACCommand*)loadPageCommand
{
    return objc_getAssociatedObject(self, &kSignalKey);
}

- (void)setPageIndex:(NSNumber*)pageIndex
{
    objc_setAssociatedObject(self, &kSignalPageKey, pageIndex, OBJC_ASSOCIATION_ASSIGN);
}

- (NSNumber*)pageIndex
{
    return objc_getAssociatedObject(self, &kSignalPageKey);
}

- (void)setupFooter
{
    
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];

    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshFooter addToScrollView:self];
    
    __weak SDRefreshFooterView *weakRefreshFooter = refreshFooter;
    __weak typeof(self) weakSelf = self;
    weakRefreshFooter.beginRefreshingOperation = ^{
        
        [[weakSelf.loadPageCommand execute:weakSelf.pageIndex] subscribeNext:^(id x) {
            //
        } error:^(NSError *error) {
            [weakRefreshFooter endRefreshing];
        } completed:^{
            weakSelf.pageIndex = @([weakSelf.pageIndex intValue] + 1);
            [weakRefreshFooter endRefreshing];
        }
         ];
    };
    
    [[[weakRefreshFooter rac_signalForSelector:@selector(endRefreshing)] deliverOnMainThread] subscribeNext:^(id x) {
        //reload
        [self reloadData];
    }];
}

@end
