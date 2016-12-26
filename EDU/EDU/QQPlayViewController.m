//
//  QQPlayViewController.m
//  EDU
//
//  Created by renxingguo on 16/9/1.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "QQPlayViewController.h"
#import "WKWebViewJavascriptBridge.h"
#import "Configuration.h"

@interface QQPlayViewController ()

@property WKWebViewJavascriptBridge* bridge;

@end

@implementation QQPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
    //remove shadow
    self.navigationController.navigationBar.clipsToBounds = YES;
     */
    self.navigationItem.title = [Configuration Instance].current_video_url_title;
    
}
//
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    if (_bridge) { return; }
    
    CGRect rect = self.view.bounds;
//    rect.origin.y -= 64;
//    rect.size.height += 64;
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    WKWebView* webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.view.bounds];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    //[WKWebViewJavascriptBridge enableLogging];
    //_bridge = [WKWebViewJavascriptBridge bridgeForWebView:webView];
    //[_bridge setWebViewDelegate:self];
    
//    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"testObjcCallback called: %@", data);
//        responseCallback(@"Response from testObjcCallback");
//    }];
//    
//    [_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
    
 //   [self loadExamplePage:webView];
    NSURL *url = [NSURL URLWithString:[Configuration Instance].current_video_url];;
    if (url) {
         [webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
   
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidStartLoad");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidFinishLoad");
}


- (void)callHandler:(id)sender {
    id data = @{ @"greetingFromObjC": @"Hi there, JS!" };
    [_bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];
}

- (void)loadExamplePage:(WKWebView*)webView {
    
    //NSString *url = @"http://v.qq.com/iframe/player.html?vid=r03229pbopg&amp;auto=1";
    NSString *url = [Configuration Instance].current_video_url;
    NSString *appHtml = [[NSString alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]] encoding:NSUTF8StringEncoding];
    
    NSURL *baseURL = [NSURL URLWithString:url];
    [webView loadHTMLString:appHtml baseURL:baseURL];
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


