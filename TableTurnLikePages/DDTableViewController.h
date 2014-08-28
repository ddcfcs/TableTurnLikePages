//
//  XHTableViewController.h
//  Production
//
//  Created by Cruise on 14-6-30.
//  Copyright (c) 2014年 Ding. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DDTableViewController : UITableViewController

/**
 *  大量数据的数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL showPushDetail;

@end
