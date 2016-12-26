//
//  DBSearchViewController.m
//  DressingCollection
//
//  Created by renxingguo on 15/11/16.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "DBSearchViewController.h"
#import "UIButton+WebCache.h"
#import "UIButton+SetCropImage.h"
#import "Toast.h"
#import "UITableView+RereshHead.h"
#import "SearchTableViewCell.h"
#import "SearchTableViewCell_Blog.h"
#import "UITableView+LoadMore.h"

#import "EDUSearchResultDataModels.h"
#import "ProgressHUD.h"
#import "JSONHttpClient.h"

@interface DBSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (strong,nonatomic) NSArray *resultArray;
@property (strong,nonatomic) NSString *keywords;
@property (strong,nonatomic) NSNumber *modelType;
@end

@implementation DBSearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UITextField *txfSearchField = [_searchBar valueForKey:@"_searchField"];
    txfSearchField.backgroundColor = [UIColor whiteColor];
    txfSearchField.borderStyle = UITextBorderStyleLine;
    txfSearchField.layer.borderWidth = 0.5;
    
    self.resultArray = [NSArray array];
    self.modelType = [NSNumber numberWithInt:100];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    
    //enter keyword:
    self.searchBar.delegate = self;
    [[self rac_signalForSelector:@selector(searchBar:textDidChange:)fromProtocol:@protocol(UISearchBarDelegate)] subscribeNext:^(RACTuple *x)
    {
        self.keywords = x.second;
        self.modelType = [NSNumber numberWithInt:100];
        [self.tableView reloadData];
    }];

    //select
    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(RACTuple *x) {

        if ([self.modelType integerValue]==1) {
            NSIndexPath *indexPath = x.second;
            //todo
            //AttireTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            //[cell.buyButton.rac_command execute:nil];
        }
        
        
        if ([self.modelType integerValue]==100) {
            NSIndexPath *indexPath = x.second;
            self.modelType = [NSNumber numberWithInt:(indexPath.row + 1)];
            [self.searchBar resignFirstResponder];
        }
    }];
    
    //query & reload
    [RACObserve(self, modelType) subscribeNext:^(id x) {
        //
        //search
        switch ([self.modelType integerValue]) {
            case 1:
            case 2:
            case 3:
            case 4:
                break;
                
            default:
                return;
                break;
        }
        self.resultArray = [NSArray array];
        [self loadPage:1];
        
        
        self.tableView.loadPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *pageIndex) {
            //
            /**
             * **Parameters:**
             * `type` — 【必须】搜索的单元类型  1:课程，2：精彩专题，3：戏剧社，4：作品赏析
             * `keywords` — 【必须】关键字，多个关键字以逗号分隔
             * `pageNum` — 当前页码 （从1开始，默认为1）
             * `user_id` — (默认为非注册用户)
             * **Returns:** info{
             
             curPage    当前页码
             
             curNum     当前结果数
             
             list       结果集（最多20条记录）	
             
             }
             */
            NSDictionary *para = @{@"type":[self.modelType stringValue],
                                   @"keywords":self.keywords,
                                   @"pageNum":pageIndex
                                   };
            
            [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/indexSearchList.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
                //
                
                EDUSearchResultBaseClass *model = [[EDUSearchResultBaseClass alloc] initWithDictionary:json];
                
                if (!model.code)
                {
                    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"系统提示" message:model.message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alter show];
                }
                else
                {
                    NSMutableArray *array = [NSMutableArray arrayWithArray:self.resultArray];
                    [array addObjectsFromArray:model.info.list];
                    self.resultArray = array;
                }

            }];
            
            return [RACSignal empty];
            
            
        }];
    }];
    
    

}

- (void)loadPage:(int)pageNumber
{
    /**
     * 通用搜索接口，包括品牌、服装、顾问师、博文
     * @param paramMap
     * @param model 1品牌，2服装，3顾问师，4博文
     * @param keyword 搜索关键字
     * @return
     * @throws Exception
     * @author fengym
     完整调用示例
     http://115.28.139.3:8080/commSearch.json?model=1&keyword=女&page_index=1&page_size=10
     */
    
    [ProgressHUD show:@"正在检索"];
    
    NSDictionary *para = @{@"type":[self.modelType stringValue],
                           @"keywords":self.keywords,
                           @"pageNum": [NSNumber numberWithInt:pageNumber]
                           };
    
    [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/indexSearchList.json",BASEURL] params:para completion:^(id json, JSONModelError *err) {
        //
        
        EDUSearchResultBaseClass *model = [[EDUSearchResultBaseClass alloc] initWithDictionary:json];
        
        if (!model.code)
        {
            UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"系统提示" message:model.message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
        else
        {
            self.resultArray = model.info.list;
            [self.tableView reloadData];
        }
        [ProgressHUD dismiss];
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
    
    switch ([self.modelType integerValue]) {
        case 100:
            
            if ([self.keywords length]) {
                return 4;
            }
            else
                return 0;
            break;
            
        default:
            break;
    }
    return [self.resultArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch ([self.modelType integerValue])
    {
        case 100:
        {
            NSString *identifier = @"SearchCell_1";
            switch (indexPath.row) {
                case 0:
                    identifier = @"SearchCell_1";
                    break;
                case 1:
                    identifier = @"SearchCell_2";
                    break;
                case 2:
                    identifier = @"SearchCell_3";
                    break;
                case 3:
                    identifier = @"SearchCell_4";
                    break;
                default:
                    break;
                    
            }
            SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
            cell.keyWordsLable.text = self.keywords;
            return cell;
            
        }
            
            break;
            
        case 1:
            //show attire search result
        {
            NSString *identifier = @"SearchTableViewCell_Blog";
            SearchTableViewCell_Blog *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
            cell.info = [self.resultArray objectAtIndex:indexPath.row];
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return Nil;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if ([self.modelType integerValue] != 100) {
//        if (indexPath.row == [self.resultArray count] - 1 ) {
//            [self loadPage:++self.currentPage];
//        }
//    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

#pragma mark search bar instance

- (UISearchBar*)searchBar
{
    if (!_searchBar) {
        
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        //searchController.delegate = self;
        //searchController.searchResultsUpdater = resultsController;
        [searchController.searchBar sizeToFit];
        searchController.dimsBackgroundDuringPresentation = YES;        //是否添加半透明覆盖层
        searchController.hidesNavigationBarDuringPresentation = NO;    //是否隐藏导航栏
        
        // 这里还可以自定义searchController.searchBar。UISearchBar的属性都可以设置
        searchController.searchBar.placeholder = @"自定义搜索提示";
        
        _searchBar = searchController.searchBar;
        self.navigationItem.titleView = _searchBar;
        self.definesPresentationContext = YES;
    }
    return _searchBar;
}

@end
