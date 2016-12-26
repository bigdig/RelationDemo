//
//  UICollectionView+Empty.h
//  DressingCollection
//
//  Created by renxingguo on 15/12/14.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (Empty)

@property (strong,nonatomic) RACCommand * refreshCommand;
@property (strong,nonatomic) NSString *emptyHint;

@end
