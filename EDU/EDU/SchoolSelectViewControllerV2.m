//
//  SchoolSelectViewControllerV2.m
//  EDU
//
//  Created by renxingguo on 2016/11/24.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "SchoolSelectViewControllerV2.h"
#import "ReactiveCocoa.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "EDUBaiduSchoolDataModels.h"
#import "UIImageView+WebCache.h"
#import "QQPlayViewController.h"

#import "UIButton+Badge.h"
#import "UIButton+ZanAnimation.h"
#import "UIImage+Tint.h"
#import "UIButton+SetCropImage.h"
#import "UIImage+Mask.h"

#import "ZYKeyboardUtil.h"
#import <CoreLocation/CoreLocation.h>
#import "Toast.h"
#import "UIScrollView+EmptyDataSet.h"

@interface SchoolSelectViewControllerV2 ()<UITableViewDelegate,UITableViewDataSource, UITextInputDelegate,CLLocationManagerDelegate,UISearchBarDelegate>
@property (nonatomic,strong) EDUBaiduSchoolBaseClass * model;
@property (nonatomic,strong) EDUBaiduSchoolBaseClass * sourceModel;
@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation SchoolSelectViewControllerV2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    /**
     self.navigationController.navigationBar.translucent = YES;
     //    self.navigationController.navigationBar.alpha = 0;
     [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
     //remove shadow
     self.navigationController.navigationBar.clipsToBounds = YES;
     */
    
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    // Set the estimatedRowHeight to a non-0 value to enable auto layout.
    self.tableview.estimatedRowHeight = 10;
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    // 判断的手机的定位功能是否开启
    // 开启定位:设置 > 隐私 > 位置 > 定位服务
    if ([CLLocationManager locationServicesEnabled]) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        
        // 设置定位精度
        // kCLLocationAccuracyNearestTenMeters:精度10米
        // kCLLocationAccuracyHundredMeters:精度100 米
        // kCLLocationAccuracyKilometer:精度1000 米
        // kCLLocationAccuracyThreeKilometers:精度3000米
        // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
        // kCLLocationAccuracyBestForNavigation:导航情况下最高精度，一般要有外接电源时才能使用
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
        // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
        self.locationManager.distanceFilter = 100.0f; // 如果设为kCLDistanceFilterNone，则每秒更新一次;
        
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [self.locationManager startUpdatingLocation];
        
        [self.locationManager requestWhenInUseAuthorization];
    }
    else {
        NSLog(@"请开启定位功能！");
        [[[Toast alloc] initWithMessage:@"请开启定位功能！"] show];
    }
    
    //http://api.map.baidu.com/place/v2/search?q=小学&bounds=39.915,116.404,39.975,116.414&output=json&ak=1y50hOne4XngFRF3SrsXvPHzXS5Y0dYp"
    
    self.tableview.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        //self.tableview.dataRefreshingSignal = [[RACSignal alloc] init];
        //[self.tableView reloadData];
        return [RACSignal empty];
    }];
    
    [[RACObserve(self, model) deliverOnMainThread] subscribeNext:^(id x) {
        [self.tableview reloadData];
    }];
    
    self.searchBar.delegate = self;
    self.saveWidthConstraint.constant = 0.0;
    [[self rac_signalForSelector:@selector(searchBar:textDidChange:)] subscribeNext:^(id x) {
        if ([self.searchBar.text length]) {
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",self.searchBar.text];
            self.model.results = [self.sourceModel.results filteredArrayUsingPredicate:predicate];
            [self.tableview reloadData];
            if ([self.model.results count]) {
                self.saveWidthConstraint.constant = 0.0;
            }
            else
            {
                self.saveWidthConstraint.constant = 60.0;
            }
        }
        else
        {
            self.model.results = self.sourceModel.results;
            self.saveWidthConstraint.constant = 0.0;
            [self.tableview reloadData];
        }
    }];
    
    @weakify(self);
    self.saveButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SCHOOL_SELECT" object:self.searchBar.text];
        [self.navigationController popViewControllerAnimated:YES];
        return [RACSignal empty];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model.results count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"comment_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    EDUBaiduSchoolResults *item = [self.model.results objectAtIndex:indexPath.row];
    {
        //address
        {
            UILabel *text = [cell viewWithTag:100];
            text.text = item.name;
        }
        {
            UILabel *text = [cell viewWithTag:110];
            text.text = item.address;
        }
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchBar resignFirstResponder];
    EDUBaiduSchoolResults *item = [self.model.results objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BAIDU_SCHOOL_SELECT" object:item];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark - GET school
- (void)getSchool:(CLLocation *)newLocation
{
    // 1. URL
    NSString *urlStr = [NSString stringWithFormat:@"http://api.map.baidu.com/place/v2/search?q=小学$中学&bounds=%f,%f,%f,%f&output=json&ak=%@",
                        newLocation.coordinate.latitude-0.05,
                        newLocation.coordinate.longitude-0.05,
                        newLocation.coordinate.latitude+0.05,
                        newLocation.coordinate.longitude+0.05,
                        @"Mg9h1C8ftNpvGpUSeXaMHGY8ctqQXTtE"];
    
    NSURL *url = [NSURL URLWithString:[urlStr URLEncodedStringFix]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"http://xingguangedu.com" forHTTPHeaderField: @"Referer"];
    
    // 3. Connection
    // 1> 登录完成之前,不能做后续工作!
    // 2> 登录进行中,可以允许用户干点别的会更好!
    // 3> 让登录操作在其他线程中进行,就不会阻塞主线程的工作
    // 4> 结论:登陆也是异步访问,中间需要阻塞住
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil) {
            // 网络请求结束之后执行!
            // 将Data转换成字符串
            NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            // num = 2
            NSLog(@"%@ %@", json, [NSThread currentThread]);
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
            
            self.tableview.dataRefreshingSignal = nil;
            self.model = [EDUBaiduSchoolBaseClass modelObjectWithDictionary:dic];
            self.sourceModel = [EDUBaiduSchoolBaseClass modelObjectWithDictionary:dic];
            
            // 更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //self.logonResult.text = @"登录完成";
            }];
        }
    }];
    
}

#pragma mark - Actions
- (IBAction)buttonClicked:(id)sender
{
    // 判断的手机的定位功能是否开启
    // 开启定位:设置 > 隐私 > 位置 > 定位服务
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [self.locationManager startUpdatingLocation];
    }
    else {
        NSLog(@"请开启定位功能！");
    }
}

#pragma mark - CLLocationManagerDelegate
// 地理位置发生改变时触发
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    // 获取经纬度
//    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
//    NSLog(@"经度:%f",newLocation.coordinate.longitude);
//    [self getSchool:newLocation];
//    // 停止位置更新
//    [manager stopUpdatingLocation];
//}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation * newLocation = [locations lastObject];
    
    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
    NSLog(@"经度:%f",newLocation.coordinate.longitude);
    [self getSchool:newLocation];
    // 停止位置更新
    [manager stopUpdatingLocation];
}


// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}

@end
