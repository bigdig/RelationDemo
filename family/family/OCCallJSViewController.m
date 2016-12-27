//
//  OCCallJSViewController.m
//  family
//
//  Created by renxingguo on 2016/12/20.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "OCCallJSViewController.h"

@interface OCCallJSViewController ()

@end

@implementation OCCallJSViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"oc call js";
    self.context = [[JSContext alloc] init];
    [self.context evaluateScript:[self loadJsFile:@"relationship"]];
    
    
}
- (NSString *)loadJsFile:(NSString*)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"js"];
    NSString *jsScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return jsScript;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendToJS:(id)sender {
    //relationship({text:'爸爸的舅舅',sex:0,reverse:true}),['外甥孙女']);
    
    JSValue *function = [[self.context objectForKeyedSubscript:@"relationship"] objectForKeyedSubscript:@"relationship"];
    //@"爸爸的舅舅"
    
    JSValue *result = [function callWithArguments:@[@{@"text":@"爸爸的爸爸",@"sex":[NSNumber numberWithInt:0],
                                                      @"reverse":[NSNumber numberWithBool:true]
                                                      }]];
    self.showLable.text = [result toString];
    
    {
        JSValue *function = [[self.context objectForKeyedSubscript:@"relationship"] objectForKeyedSubscript:@"getFilterRelative"];
        //@"爸爸的舅舅"
        
        JSValue *result = [function callWithArguments:@[@"m"]];
        NSDictionary * dic = [result toArray];
        NSLog(@"%@", [result toString]);
    }
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
