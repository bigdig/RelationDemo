//
//  UICollectionView+Empty.m
//  DressingCollection
//
//  Created by renxingguo on 15/12/14.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "UICollectionView+Empty.h"
#include "SDRefreshHeaderView.h"
#import "UIScrollView+EmptyDataSet.h"
#include <objc/runtime.h>


@interface UICollectionView ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation UICollectionView (Empty)

static char kSignalKey;
static char kSignalHintKey;

- (void)setRefreshCommand:(RACCommand *)refreshCommand
{
    objc_setAssociatedObject(self, &kSignalKey, refreshCommand, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setupHeader];
    
}

- (RACCommand*)refreshCommand
{
    return objc_getAssociatedObject(self, &kSignalKey);
}


- (void)setupHeader
{
    
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    // 进入页面自动加载一次数据
    [refreshHeader autoRefreshWhenViewDidAppear];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:self];
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    __weak typeof(self) weakSelf = self;
    
    refreshHeader.beginRefreshingOperation = ^{
        
        [[weakSelf.refreshCommand execute:nil] subscribeNext:^(id x) {
            //
        } error:^(NSError *error) {
            [weakRefreshHeader endRefreshing];
        } completed:^{
            [weakRefreshHeader endRefreshing];
        }
         ];
    };
    
    //delive on mainthread ,避免reload 与endrefresh效果重叠
    [[[weakRefreshHeader rac_signalForSelector:@selector(endRefreshing)] deliverOnMainThread] subscribeNext:^(id x) {
        //reload
//        self.emptyDataSetSource = self;
//        self.emptyDataSetDelegate = self;
        [self reloadData];
    }];
    
//    [[self.refreshCommand.executing deliverOnMainThread] subscribeNext:^(id x) {
//        if ([x boolValue]) {
//            self.emptyDataSetSource = nil;
//            self.emptyDataSetDelegate = nil;
//        }
//        else
//        {
//            self.emptyDataSetSource = self;
//            self.emptyDataSetDelegate = self;
//        }
//    }];
    
    [self setEmptyHint:@""];
}

- (void)setEmptyHint:(NSString *)emptyHint
{
    objc_setAssociatedObject(self, &kSignalHintKey, emptyHint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //set empty infomation
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
    // A little trick for removing the cell separators
}

- (NSString*)emptyHint
{
    return objc_getAssociatedObject(self, &kSignalHintKey);
}


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    text = @"暂无数据";
    font = [UIFont systemFontOfSize:20.0];
    textColor = HEXCOLOR(0x808080);
    
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    //text = @"您可以看看其它主题的博文！";
    text = self.emptyHint;
    font = [UIFont systemFontOfSize:15.0];
    textColor = HEXCOLOR(0x989898);
    
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    return attributedString;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return nil;
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return HEXCOLOR(0xF2F2F2);
}


#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

@end
