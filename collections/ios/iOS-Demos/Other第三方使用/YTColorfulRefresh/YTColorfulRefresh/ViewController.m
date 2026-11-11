//
//  ViewController.m
//  YTColorfulRefresh
//
//  Created by 段雨田 on 2020/4/27.
//  Copyright © 2020 段雨田. All rights reserved.
//

#import "ViewController.h"
#import "ColorfulRefreshHeader.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *data;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.title = @"DEMO";
  self.view.backgroundColor = [UIColor whiteColor];
  self.automaticallyAdjustsScrollViewInsets = NO;
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"End" style:UIBarButtonItemStyleDone target:self action:@selector(endRefreshing)],
    
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Refresh" style:UIBarButtonItemStyleDone target:self action:@selector(beginRefresh)];
  
  self.data = @[[UIImage imageNamed:@"1.jpg"],
                [UIImage imageNamed:@"2.jpg"],
                [UIImage imageNamed:@"3.jpg"]];
  

  self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
  self.tableView.rowHeight = 235.0;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.view addSubview:self.tableView];
  
  
  self.tableView.mj_header = [ColorfulRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginRefresh)];
  
  
  
  
}

- (void)beginRefresh {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     NSLog(@"begin");
     [self.tableView.mj_header endRefreshing];
   });
}

- (void)endRefreshing {
    
  [self.tableView.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 235.0)];
        image.clipsToBounds = YES;
        image.tag = 10000;
        [cell.contentView addSubview:image];
    }
    UIImageView *image = [cell.contentView viewWithTag:10000];
    image.image = self.data[indexPath.row];
    return cell;
}

@end
