//
//  MCStopView.m
//  MCStopTableView
//
//  Created by MC on 16/3/30.
//  Copyright © 2016年 MC. All rights reserved.
//
// MainScreen Height&Width

#import "MCStopView.h"
#import "HMSegmentedControl.h"
#import "AppDelegate.h"
#import "UINavigationBar+Background.h"
#import "UIImage+Tint.h"
#import "UIScrollView+Scroll.h"

#define NAV_H 64

@interface MCStopView ()<UIScrollViewDelegate>{
    CGRect _selfView_frame;//self的frame
  
    CGFloat _headerView_Height;//
    CGFloat _segmentBarHeight;
    
    UIScrollView* _mainScrollView;
   UIScrollView* _currentScrollView;

    UIView *_segmentView;
    
    UIView * _headerView;
    CGRect initialFrame;
    CGFloat defaultViewHeight;

    HMSegmentedControl *_SegmentView;
    UIView * _headerImg;
    UIViewController * _selfCtl;
    

}
@property (nonatomic, strong) NSArray            *contentViews;
@property (nonatomic, strong) NSArray            *segmentsTitles;
@property (nonatomic, strong) UIScrollView   *subScrollView;

@end

@implementation MCStopView




-(instancetype)initWithFrame:(CGRect)frame HeaderViewHeight:(CGFloat)headerView_Height SegmentBarHeight:(CGFloat)segmentBarHeight HeaderView:(UIView*)headerView ContentViews:(NSArray*)contentViews SegmentsTitles:(NSArray*)segmentsTitles HeaderImg:(UIImageView*)headerImg{

    self = [super initWithFrame:frame];
    if (self) {
        _selfView_frame = frame;

        _headerView_Height = headerView_Height;
        _segmentBarHeight = segmentBarHeight;
        _headerView = headerView;
        _contentViews = contentViews;
        _segmentsTitles = segmentsTitles;
        _headerImg = headerImg;
        [self prepareCurrentScrollView];
        [self prepareHeaderView];
//        [_mainScrollView addSubview:_headerView];
//        [self prepareSegmentView];
        [self prepareContentViews];
        
    }
    
    return self;
    
}
-(void)prepareHeaderView{
     [_mainScrollView addSubview:_headerView];
    initialFrame       = _headerView.frame;
    defaultViewHeight  = initialFrame.size.height;
    
    
}
-(void)prepareCurrentScrollView{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, _selfView_frame.size.height)];
    
    _mainScrollView.contentSize = CGSizeMake(0, _selfView_frame.size.height + _headerView_Height - NAV_H);
    _mainScrollView.backgroundColor = [UIColor whiteColor];
//    _currentScrollView.bounces = NO;
       _mainScrollView.scrollEnabled = NO;

    _mainScrollView.delegate =self;
    _mainScrollView.tag = 700;
    [self addSubview:_mainScrollView];
    
    
}
-(void)prepareSegmentView{
    //选择框
    _SegmentView = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, _headerView_Height, Main_Screen_Width, _segmentBarHeight)];
    
    //add a bottom line
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0,_SegmentView.frame.size.height,Main_Screen_Width,1)];
    lbl.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [_SegmentView addSubview:lbl];

    /**
    _SegmentView.sectionImages = @[ [UIImage imageNamed:@"nav_list"],
                                    [UIImage imageNamed:@"nav_group"],
                                    [UIImage imageNamed:@"nav_download"],
                                    [UIImage imageNamed:@"nav_me"]
                                    ];
    
    _SegmentView.sectionSelectedImages = @[ [[UIImage imageNamed:@"nav_list"] imageWithTintColor:COLOR_RED],
                                            [[UIImage imageNamed:@"nav_group"] imageWithTintColor:COLOR_RED],
                                            [[UIImage imageNamed:@"nav_download"] imageWithTintColor:COLOR_RED],
                                            [[UIImage imageNamed:@"nav_me"] imageWithTintColor:COLOR_RED]
                                            ];
    
    _SegmentView.type = HMSegmentedControlTypeImages;
     */
    _SegmentView.sectionTitles = @[@"相关视频",@"  相关评论  ",@"随堂练习"];
    _SegmentView.type = HMSegmentedControlTypeText;
    _SegmentView.selectedSegmentIndex = 0;
    _SegmentView.backgroundColor = [UIColor whiteColor];
    _SegmentView.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor grayColor], NSFontAttributeName : [UIFont systemFontOfSize:14]};
    _SegmentView.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : COLOR_LITLE_GREE,NSFontAttributeName : [UIFont systemFontOfSize:14]};

    _SegmentView.selectionIndicatorHeight = 2;
    _SegmentView.selectionIndicatorColor = COLOR_LITLE_GREE;
    _SegmentView.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    _SegmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(UIScrollView*) weakScrollView = _mainScrollView;
    __weak typeof(UIViewController*) weakselfCtl = _selfCtl;

    __block typeof(CGFloat) weakHeight = _headerView_Height - NAV_H;

    //  __block typeof(NSInteger) weakisBianji = _isBianji;
    
    [_SegmentView setIndexChangeBlock:^(NSInteger index) {
        weakSelf.subScrollView.contentOffset =CGPointMake(index * Main_Screen_Width, 0);
            UIScrollView * v = (UIScrollView*)[weakSelf viewWithTag:800 + index];
        
        if (v.contentOffset.y >weakHeight) {
            weakScrollView.contentOffset = CGPointMake(0, weakHeight);

        }
        else if(v.contentOffset.y <= weakHeight){
            weakScrollView.contentOffset = CGPointMake(0, v.contentOffset.y);

        }
//        UIColor *color = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1];
//        CGFloat offsetY = v.contentOffset.y;
//
//        if (offsetY >=0) {
//            CGFloat alpha = MIN(1, offsetY/(weakHeight - 64));
//            
//            [weakselfCtl.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
//            
//            //_descriptionView.alpha = 1 - alpha;
//        }
//        else {
//            [weakselfCtl.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
//        }

        
    }];
    
    [_mainScrollView addSubview:_SegmentView];
}

-(void)prepareContentViews{
    _subScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _headerView_Height + _segmentBarHeight, Main_Screen_Width, _mainScrollView.contentSize.height - _headerView_Height + _segmentBarHeight)];
    _subScrollView.bounces = NO;
    _subScrollView.showsHorizontalScrollIndicator = NO;
    _subScrollView.showsVerticalScrollIndicator = NO;
    _subScrollView.backgroundColor = [UIColor whiteColor];
    CGFloat x = 0;
    CGFloat w = _subScrollView.frame.size.width;

    for (NSInteger i = 0; i<_contentViews.count; i++) {
        UIScrollView * v = _contentViews[i];
        v.frame = CGRectMake(x, v.frame.origin.y, v.frame.size.width , v.frame.size.height);
        v.showsHorizontalScrollIndicator = NO;
        v.showsVerticalScrollIndicator = NO;
        v.scrollEnabled = YES;
        v.tag = 800 + i;
        //v.bounces = NO;
        //hack, 第二页需要代理
        if(i!=1&&i!=2&&i!=3)
            v.delegate =self;
        else
            v.scrollDelegate = self;
        if (i == 0) {
            _currentScrollView = v;
        }
        [_subScrollView addSubview:v];
        x +=w;
        
    }
    _subScrollView.contentSize = CGSizeMake(w * _contentViews.count, 0);
    _subScrollView.delegate = self;
    _subScrollView.pagingEnabled = YES;
    [_mainScrollView addSubview:_subScrollView];

    
}
-(void)didMoveToSuperview
{
    
    [super didMoveToSuperview];
    _selfCtl = [self getCurrentVC];
    if (!_SegmentView) {
        [self prepareSegmentView];
    }
    
    
}
#pragma mark - UIScrollViewDelegate
- (void)viewDidLayoutSubviews
{
    if (_headerImg)
    [self resizeView];

}
- (void)resizeView
{
    initialFrame.size.width = _mainScrollView.frame.size.width;
    _headerImg.frame = initialFrame;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (scrollView == _subScrollView) {
        return;
    }
    if (scrollView == _mainScrollView && _headerImg) {
        
        CGRect f     = _headerImg.frame;
        f.size.width = _mainScrollView.frame.size.width;
        _headerImg.frame  = f;
        
//        if(scrollView.contentOffset.y < 0)
//        {
//           CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
//            initialFrame.origin.y = - offsetY * 1;
//            initialFrame.origin.x = - offsetY / 2;
//            initialFrame.size.width  = _mainScrollView.frame.size.width + offsetY;
//            initialFrame.size.height = defaultViewHeight + offsetY;
//            _headerImg.frame = initialFrame;
//        }
        return;
    }
    
//    CGFloat offh = _headerView_Height - 64;
//    NSLog(@"---- %f ----",scrollView.contentOffset.y);
    //CGFloat offh = _headerView_Height + _segmentBarHeight - 3;
    
    CGFloat offh = _headerView_Height;
    
    if(scrollView.contentOffset.y <offh ){
        _mainScrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
//        _mainScrollView.scrollEnabled = YES;
    }
    
    if (scrollView.contentOffset.y >=offh) {
        _mainScrollView.contentOffset = CGPointMake(0, offh);
//        _mainScrollView.scrollEnabled = NO;
        
    }

    
    //UIColor *color = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
//    UIColor *color = [UIColor clearColor];
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY >0) {
//        CGFloat alpha = MIN(1, offsetY/(_headerView_Height - 64));
//        
//        [_selfCtl.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
//        
//        //_descriptionView.alpha = 1 - alpha;
//    } else {
//        [_selfCtl.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
//    }
    

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView != _subScrollView) {
        return;
    }

    NSInteger currentPage = scrollView.contentOffset.x/_subScrollView.frame.size.width;
    
    _SegmentView.selectedSegmentIndex = currentPage;
    
    UIScrollView * v = (UIScrollView*)[self viewWithTag:800 + currentPage];
    
    if (v.contentOffset.y >_headerView_Height) {
        _mainScrollView.contentOffset = CGPointMake(0, _headerView_Height - NAV_H);
        
    }
    else if(v.contentOffset.y <= _headerView_Height){
        _mainScrollView.contentOffset = CGPointMake(0, v.contentOffset.y);
        
    }
    
    //UIColor *color = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1];
//    UIColor *color = [UIColor clearColor];
//    CGFloat offsetY = _mainScrollView.contentOffset.y;
//    if (offsetY >0) {
//        CGFloat alpha = MIN(1, offsetY/(_headerView_Height - 64));
//        
//        [_selfCtl.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
//        
//        //_descriptionView.alpha = 1 - alpha;
//    } else {
//        [_selfCtl.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
//    }
//    

    
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
        for (UIView* next = [self superview]; next; next = next.superview)
        {
            UIResponder *nextResponder = [next nextResponder];
            if ([nextResponder isKindOfClass:[UIViewController class]]) {
                return (UIViewController *)nextResponder;
            }
        }
        return nil;
    



}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
