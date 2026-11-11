//
//  ViewController.m
//  YTPullRefresh
//
//  Created by 段雨田 on 2020/5/6.
//  Copyright © 2020 段雨田. All rights reserved.
//

#import "ViewController.h"
#import "YTPullRefreshHeader.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  YTPullRefreshHeader *headerView = [YTPullRefreshHeader headerWithRefreshingBlock:^{
    
    double delayInSeconds = 3.0;
     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
       NSLog(@"Header - ActionHandler");
       [self.tableView.mj_header endRefreshing];
     });
    
  }];
  
  self.tableView.mj_header = headerView;
  
}



#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"
                                                            forIndexPath:indexPath];
  
  cell.textLabel.text = [NSString stringWithFormat:@"第%ld条",(long)indexPath.row];
   
  return cell;
}

#pragma mark getter&setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
      [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
