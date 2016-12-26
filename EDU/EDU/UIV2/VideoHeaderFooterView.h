//
//  VideoHeaderFooterView.h
//  EDU
//
//  Created by renxingguo on 2016/12/2.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoHeaderFooterView : UITableViewHeaderFooterView

-(void)setItemChangedAction:(void(^)(NSInteger index))action;

@end
