//
//  ViewController.m
//  Tableview动画
//
//  Created by Yutian Duan on 2018/3/26.
//  Copyright © 2018年 duanyutian. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () < UITableViewDataSource, UITableViewDelegate > {
  UINavigationBar *navBar;
}

/// 上一个cell的下标
@property (nonatomic, assign) long lastCellIndex;
/// tableview是否已经显示完毕
@property (nonatomic, assign) BOOL isApper;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  UITableView *tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
  tableview.dataSource = self;
  tableview.delegate = self;
  [self.view addSubview:tableview];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  self.isApper = true;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    navBar = self.navigationController.navigationBar;
//    CGFloat alpha = scrollView.contentOffset.y > 0 ? scrollView.contentOffset.y /scrollView.contentSize.height:0;
//    NSLog(@"------%f-------",alpha);
//    // 导航栏不透明时，显示原本的shadowImage
//    UIImage*img = nil;
//    if (alpha > 0.5) {
//        img = [UIImage imageNamed:@"123"];
//
//    } else {
//       img = [UIImage new];
//    }
//
//      [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellID = @"123";
  UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
  if (cell == nil) {
    cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.backgroundColor = [UIColor orangeColor];
  }
  cell.textLabel.text=@"xsahbadbvds";
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80;
  
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (indexPath.row > self.lastCellIndex && self.isApper) {
//        CATransform3D rotation;
//        rotation = CATransform3DMakeTranslation(0.0, 70, 0.0);
//        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
//        cell.layer.shadowOffset = CGSizeMake(10, 10);
//        cell.alpha = 0;
//        cell.layer.transform = rotation;
//        rotation.m43 = 1.0/ -600;
//
//        [UIView animateWithDuration:0.5 animations:^{
//            cell.layer.transform = CATransform3DIdentity;
//            cell.alpha = 1;
//            cell.layer.shadowOffset = CGSizeMake(0, 0);
//        }];
//
//
//
//    }
//    self.lastCellIndex = indexPath.row;
//}




//tableView的代理方法。
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //转动特效
  CATransform3D rotation;
  rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
  rotation.m34 = 1.0/ -600;
  
  cell.layer.shadowColor = [[UIColor blackColor]CGColor];
  cell.layer.shadowOffset = CGSizeMake(10, 10);
  cell.alpha = 0;
  cell.layer.transform = rotation;
  cell.layer.anchorPoint = CGPointMake(0, 0.5);
  
  
  [UIView beginAnimations:@"rotation" context:NULL];
  
  [UIView setAnimationDuration:0.8];
  cell.layer.transform = CATransform3DIdentity;
  cell.alpha = 1;
  cell.layer.shadowOffset = CGSizeMake(0, 0);
  [UIView commitAnimations];
  
  
  [UIView animateWithDuration:0.5 animations:^{
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
  }];
  
}




@end
