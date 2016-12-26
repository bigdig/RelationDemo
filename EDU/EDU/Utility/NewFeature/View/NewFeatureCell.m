//
//  NewFeatureCell.m
//  VMovie
//
//  Created by wyz on 16/3/13.
//  Copyright © 2016年 wyz. All rights reserved.
//

#import "NewFeatureCell.h"
#import "Masonry.h"

@interface NewFeatureCell()

/** 图片 */
@property (nonatomic, weak) UIImageView *imageView;

/** 按钮 */
@property (nonatomic, weak) UIButton *startButton;

@end

@implementation NewFeatureCell

+ (instancetype)newFeatureCell {
    
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        self.imageView = imageView;
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        CGFloat buttonWidth = Main_Screen_Width;
        CGFloat buttonHeight = Main_Screen_Height;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
             [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchRootViewControllerNotification" object:nil];
        }];
        
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [button setTitle:@"" forState:UIControlStateNormal];
        //[button setTitle:@"开始使用" forState:UIControlStateNormal];
        /**
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = buttonHeight/2;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [UIColor redColor].CGColor;
         */
        
//        [button setBackgroundImage:[UIImage imageNamed:@"yd_button"] forState:UIControlStateNormal];
        
        [self addSubview:button];
        self.startButton = button;
        button.hidden = YES;
        
      
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
            make.centerX.equalTo(self);
            //make.bottom.equalTo(self).offset(-ScaleFrom_iPhone5_Desgin(60));
            make.bottom.equalTo(self).offset(0);
        }];
    }
    return self;
}


- (void)setImageIndex:(NSInteger)imageIndex {
    
    _imageIndex = imageIndex;
    
    self.imageView.image = [self imageWithIndex:imageIndex];
    
    self.startButton.hidden = (imageIndex != 2);
}

- (UIImage *) imageWithIndex:(NSInteger) index {
    
    NSString *imageName = nil;
    if (Device_Is_iPhone4) {
        imageName = [NSString stringWithFormat:@"640%zd",index + 1];
    } else if (Device_Is_iPhone5) {
        imageName = [NSString stringWithFormat:@"640%zd",index + 1];
    } else if (Device_Is_iPhone6) {
        imageName = [NSString stringWithFormat:@"750%zd",index + 1];
    } else if (Device_Is_iPhone6Plus) {
        imageName = [NSString stringWithFormat:@"1080%zd",index + 1];
    } else {
        imageName = [NSString stringWithFormat:@"1080%zd",index + 1];
    }
    
    return JPGIMAGE(imageName);
}


@end
