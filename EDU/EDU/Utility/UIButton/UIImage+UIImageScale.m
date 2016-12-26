//
//  UIImage+UIImageScale.m
//  DressingCollection
//
//  Created by renxingguo on 15/10/28.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "UIImage+UIImageScale.h"
#import "UIImage+Orientation.h"

@implementation UIImage (UIImageScale)

//截取部分图像
-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *newImage   = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    subImageRef = nil;
    return newImage;
}

-(UIImage*)getSubImageFitToWH:(CGFloat)w Height:(CGFloat)h
{
    UIImage *fix = [self fixOrientation];
    
    CGFloat width = CGImageGetWidth(fix.CGImage);
    CGFloat height = CGImageGetHeight(fix.CGImage);
    
    CGFloat imageRadio = width/height;
    CGFloat wantRadio = w/h;
    
    if (imageRadio>wantRadio) {
        //过宽
        CGFloat wantWidth = height*w/h;
        CGFloat wantHeight = height;
        return [fix getSubImage:CGRectMake((width-wantWidth)/2, 0, wantWidth, wantHeight)];
    }
    else
    {
        CGFloat wantWidth = width;
        CGFloat wantHeight = width*h/w;
        return [fix getSubImage:CGRectMake(0, (height-wantHeight)/2, wantWidth, wantHeight)];
    }
}

@end
