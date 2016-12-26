//
//  SearchTableViewCell_Blog.h
//  DressingCollection
//
//  Created by renxingguo on 15/11/17.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell_Blog : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *thumbnailButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong,nonatomic) NSDictionary *info;

@property (strong,nonatomic) RACCommand *homePageCommand;
@end
