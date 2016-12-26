//
//  UIButton+SetCropImage.m
//  DressingCollection
//
//  Created by renxingguo on 15/11/5.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "UIButton+SetCropImage.h"
#import "UIButton+WebCache.h"
#import "UIImage+UIImageScale.h"
//#import "ClickImage.h"

@implementation UIButton (SetCropImage)

-(void)setCropImageForNormalState:(NSURL*)url
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        ;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (image) {
            UIImage *imgScale = [image getSubImageFitToWH:self.frame.size.width Height:self.frame.size.height];
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self setImage:imgScale forState:UIControlStateNormal];
//            self.imageView.bigImage = image;
//            self.imageView.canClick = TRUE;
        }
    }];
}
@end

@implementation UIImageView (SetCropImage)

-(void)setCropImageForNormalState:(NSURL*)url
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        ;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (image) {
            UIImage *imgScale = [image getSubImageFitToWH:self.frame.size.width Height:self.frame.size.height];
            self.contentMode = UIViewContentModeScaleAspectFit;
            [self setImage:imgScale];
        }
    }];
}
@end
