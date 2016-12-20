//
//  OCCallJSViewController.h
//  family
//
//  Created by renxingguo on 2016/12/20.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface OCCallJSViewController : UIViewController

- (IBAction)sendToJS:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *showLable;
@property (strong, nonatomic) JSContext *context;

@end
