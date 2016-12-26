//
//  UIButton+SetCropImage.h
//  DressingCollection
//
//  Created by renxingguo on 15/11/5.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SetCropImage)

-(void)setCropImageForNormalState:(NSURL*)url;

@end


@interface UIImageView (SetCropImage)

-(void)setCropImageForNormalState:(NSURL*)url;

@end