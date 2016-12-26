//
//  Toast.m
//  零用贷
//
//  Created by chyjoyboy on 14-10-11.
//  Copyright (c) 2014年 chyjoyboy. All rights reserved.
//

#import "Toast.h"
//#import <QuartzCore/QuartzCore.h>

//获取屏幕宽高
#define HEIGHT [[UIScreen mainScreen] bounds].size.height
#define WIDTH [[UIScreen mainScreen] bounds].size.width

//@interface Toast()
//{
//    UIView* _view ;
//}
//@end

@implementation Toast

+(Toast*) sharedToast
{
    static Toast* _singleton = nil ;
    if (_singleton == nil)
    {
        _singleton = [[Toast alloc]init] ;
    }
    return _singleton ;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (instancetype)init{
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithMessage:(NSString*) message
{
    _message = message ;
    CGSize messageSize ;
//    if (iosVersion < 7.0)
//    {
//        messageSize = CGSizeMake(WIDTH-20, 55) ;
//    }
//    else
    {
        messageSize = [message sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}] ;
    }
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, messageSize.width, 40)] ;
    label.text = message ;
    label.textColor = [UIColor whiteColor] ;
    label.backgroundColor = [UIColor clearColor] ;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15] ; //sizeWithAttributes size may not fit the true size, so use small size font
    label.numberOfLines = 2 ;
    label.textAlignment = NSTextAlignmentCenter ;
    
    self = [super initWithFrame:CGRectMake(0, 0, messageSize.width+10, 40)] ;
    self.center = CGPointMake(WIDTH/2, HEIGHT) ;
    self.alpha = 0 ;
    
    if (self)
    {
        self.layer.cornerRadius = 10 ;
        self.layer.shadowOpacity = 0.6 ;
        self.layer.shadowOffset = CGSizeMake(1, 1) ;
        self.layer.shadowColor = [UIColor whiteColor].CGColor ;
        self.backgroundColor = [UIColor blackColor] ;
        [self addSubview:label] ;
    }
    return self ;
}

-(void) show
{
    [[[UIApplication sharedApplication] delegate].window addSubview:self] ;
    [UIView animateWithDuration:0.3 animations:^{
        self.center = CGPointMake(WIDTH/2, HEIGHT-180) ;
        self.alpha = 0.8 ;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.center = CGPointMake(WIDTH/2, HEIGHT-150) ;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.center = CGPointMake(WIDTH/2, HEIGHT-160) ;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:2 animations:^{
                    self.center = CGPointMake(WIDTH/2, HEIGHT-160.1) ; // 显示2秒
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.2 animations:^{
                        self.center = CGPointMake(WIDTH/2, HEIGHT-170) ;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.3 animations:^{
                            self.center = CGPointMake(WIDTH/2, HEIGHT) ;
                            self.alpha = 0 ;
                        } completion:^(BOOL finished) {
                            [self removeFromSuperview] ;
                        }] ;
                    }] ;
                }] ;
            }] ;
        }] ;
    }] ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
