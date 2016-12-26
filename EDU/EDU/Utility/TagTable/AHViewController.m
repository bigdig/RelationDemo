//
//  ViewController.m
//  AutomaticHeightTagTableViewCell
//
//  Created by WEI-JEN TU on 2016-07-16.
//  Copyright © 2016 Cold Yam. All rights reserved.
//

#import "AHViewController.h"
#import "AHTagTableViewCell.h"
#import "ReactiveCocoa.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "EDUTagListDataModels.h"

@interface AHViewController ()

@property(nonatomic,strong) EDUTagListBaseClass *model;

@end

@implementation NSArray (Extensions)

- (NSArray *)map:(id (^)(id obj))block {
    NSMutableArray *mutableArray = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [mutableArray addObject:block(obj)];
    }];
    return mutableArray;
}

@end

@implementation AHViewController {
//    NSArray<NSArray<AHTag *> *> *_dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"分类";
    
    //_dataSource = [self parseJSON];

    
    UINib *nib = [UINib nibWithNibName:@"AHTagTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.tableView.allowsSelection = FALSE;
    
    [JSONHTTPClient getJSONFromURLWithString:[NSString stringWithFormat:@"%@/resTagList.json",BASEURL] params:nil completion:^(id json, JSONModelError *err) {
        //
        self.model = [EDUTagListBaseClass modelObjectWithDictionary:json];
        [self.tableView reloadData];
    }];
    
    [[RACObserve([Configuration Instance], tagName) skip:1] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全部" style:UIBarButtonItemStylePlain target:self action:@selector(showAll)];
}

- (void)showAll
{
    [Configuration Instance].tagID = @"0";
    [Configuration Instance].tagName = @"全部";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSArray *)parseJSON {
//    NSError *error;
//    NSURL *URL= [[NSBundle mainBundle] URLForResource:@"TagGroups" withExtension:@"json"];
//    NSData *data = [NSData dataWithContentsOfURL:URL];
//    NSArray *objects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//    
//    return [objects map:^id(id obj) {
//        return [(NSArray *)obj map:^id(id obj) { return [(NSDictionary *)obj tag]; }];
//    }];
//}

#pragma mark - UITableViewDataSource

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return @"表演基础训练";
    }
    return @"台词基础训练";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.model) {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(id)object atIndexPath:(NSIndexPath *)indexPath {
    
    if (![object isKindOfClass:[AHTagTableViewCell class]]) {
        return;
    }
    AHTagTableViewCell *cell = (AHTagTableViewCell *)object;
    
    if (indexPath.section==0) {
        cell.label.tags = [self.model.info.myProperty1 map:^id(EDUTagListInternalBaseClass1* obj) {
            AHTag *tag = [[AHTag alloc] init];
            tag.category = @"表演基础训练";
            tag.title = obj.name;
            tag.enabled = [NSNumber numberWithBool:TRUE];
            tag.color = [UIColor clearColor];
            tag.groupID = [NSString stringWithFormat:@"%.0f", obj.groupId];
            tag.ID = [NSString stringWithFormat:@"%.0f", obj.internalBaseClass1Identifier];
            return tag;
        }];
    }
    else
    {
        cell.label.tags = [self.model.info.myProperty2 map:^id(EDUTagListInternalBaseClass2* obj) {
            AHTag *tag = [[AHTag alloc] init];
            tag.category = @"台词基础训练";
            tag.title = obj.name;
            tag.enabled = [NSNumber numberWithBool:TRUE];
            tag.color = [UIColor clearColor];
            tag.groupID = [NSString stringWithFormat:@"%.0f", obj.groupId];
            tag.ID = [NSString stringWithFormat:@"%.0f", obj.internalBaseClass2Identifier];
            return tag;
            
        }];
    }
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.textLabel.textColor = [UIColor darkGrayColor];
}

@end
