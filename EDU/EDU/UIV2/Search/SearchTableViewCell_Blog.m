//
//  SearchTableViewCell_Blog.m
//  DressingCollection
//
//  Created by renxingguo on 15/11/17.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "SearchTableViewCell_Blog.h"
#import "UIButton+WebCache.h"

@implementation SearchTableViewCell_Blog

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.thumbnailButton = UIButtonTypeCustom;
    @weakify(self);
    [RACObserve(self, info) subscribeNext:^(id x) {
        @strongify(self);
        if (self.info) {
            NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@",Prefix, [self.info valueForKeyPath:@"userAvatar"]  ] ];
            [self.thumbnailButton sd_setImageWithURL:url forState:UIControlStateNormal];
            
            self.nameLabel.text = self.info[@"userName"];
            self.levelLabel.text = self.info[@"userLevel"];
            self.titleLabel.text = self.info[@"title"];
            self.timeLabel.text = self.info[@"addTimeShow"];
            
            self.homePageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                //set tbk url
                @strongify(self);
                /**
                BlogContentVC *blog = [[UIStoryboard storyboardWithName:@"Chat" bundle:nil] instantiateViewControllerWithIdentifier:@"BlogContentVC"];
                blog.posts_id = [self.info[@"id"] description];
                [self.thumbnailButton.viewController.navigationController pushViewController:blog animated:YES];
                */
                return [RACSignal empty];
            }];
            
            
            
        }
    }];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
