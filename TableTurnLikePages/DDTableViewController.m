//
//  XHTableViewController.m
//  Production
//
//  Created by Cruise on 14-6-30.
//  Copyright (c) 2014年 Ding. All rights reserved.
//

#import "DDTableViewController.h"

@interface DDTableViewController ()

@end

@implementation DDTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadDataSource {
    self.dataSource = (NSMutableArray *)@[@"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer.", @"A twitter like navigation bar, page viewer."];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadDataSource];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    if (!self.showPushDetail) {
        UIEdgeInsets edgeInsets = self.tableView.contentInset;          //contentInset:tableView距离tableViewController的距离
        edgeInsets.top = 60;
        self.tableView.contentInset = edgeInsets;
//        self.tableView.scrollIndicatorInsets = edgeInsets;
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//下面三个方法都是dota source方法，分别返回section、row、cell

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];   //单元格出列，给单元格贴上标签
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_QPerson%d", (indexPath.row % 4)]];
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


//委托对象定义这个方法并制定如何对由用户发起的行为做出反应
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


@end
