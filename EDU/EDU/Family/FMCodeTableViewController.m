//
//  FMCodeTableViewController.m
//  EDU
//
//  Created by renxingguo on 2016/12/22.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "FMCodeTableViewController.h"
#import "AHTagTableViewCell.h"
#import "ReactiveCocoa.h"
#import "UITableView+RereshHead.h"
#import "JSONHTTPClient.h"
#import "JSCaller.h"

@interface FMCodeTableViewController ()

@property (nonatomic,strong) NSDictionary *tagDictionary;
@property (nonatomic,strong) NSArray *tagSectionArray;

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

@interface FMCodeTableViewController ()

@property (nonatomic,strong) JSContext * context;

@end

@implementation FMCodeTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"分类";
    
    JSValue *function = [JSCaller ShareInstance].getFilterRelativeFunction;

    self.tagDictionary = @{
                           @"常用":@[@"爷爷",@"奶奶",@"父亲",@"母亲",@"丈夫",@"妻子",@"哥哥",@"弟弟",@"姐姐",@"妹妹",@"女儿",@"儿子"],
                           @"本家":[[function callWithArguments:@[@"f"]] toArray],
                           @"外家":[[function callWithArguments:@[@"m"]] toArray],
                           @"婆家":[[function callWithArguments:@[@"h"]] toArray],
                           @"岳家":[[function callWithArguments:@[@"w"]] toArray],
                           @"自家":[[function callWithArguments:@[@"s"]] toArray],
                           @"亲家":[[function callWithArguments:@[@"d"]] toArray],
                           };
    self.tagSectionArray = @[@"常用",@"本家",@"外家",@"婆家",@"岳家",@"自家",@"亲家"];
    
    UINib *nib = [UINib nibWithNibName:@"AHTagTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.tableView.allowsSelection = FALSE;
    
    [[RACObserve([Configuration Instance], tagName) skip:1] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
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
   
    return self.tagSectionArray[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return [self.tagSectionArray count];
    return 1;
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
    cell.label.tags = [[self.tagDictionary objectForKey:[self.tagSectionArray objectAtIndex:indexPath.section]] map:^id(NSString* obj) {
        AHTag *tag = [[AHTag alloc] init];
        tag.category = @"表演基础训练";
        tag.title = obj;
        tag.enabled = [NSNumber numberWithBool:TRUE];
        tag.color = [UIColor clearColor];
        tag.groupID = obj;
        tag.ID = obj;
        return tag;
    }];
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

