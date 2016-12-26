//
//  PopoverViewController1.m
//  EDU
//
//  Created by renxingguo on 2016/11/29.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "PopoverViewController1.h"

@interface PopoverViewController1 ()

@end

@implementation PopoverViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setPreferredContentSize:)]) {
        self.preferredContentSize = CGSizeMake(115, 60);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
