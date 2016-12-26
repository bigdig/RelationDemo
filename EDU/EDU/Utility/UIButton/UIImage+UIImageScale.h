//
//  UIImage+UIImageScale.h
//  DressingCollection
//
//  Created by renxingguo on 15/10/28.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)

-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)getSubImageFitToWH:(CGFloat)w Height:(CGFloat)h;

@end
