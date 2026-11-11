//
//  RootVC.m
//  LEDAD
//
//  yixingman on 11-10-22.
//  ledmedia All rights reserved.
//

#import "RootVC.h"
#import "MenuTableCell.h"
#import "SoftVersionViewController.h"
#import "LanguageSettingViewController.h"
#import "ScreenOptionsViewController.h"
#import "Config.h"
#import <QuartzCore/QuartzCore.h>
#import "LayoutYXMViewController.h"
#import "AppDelegate.h"
#import "UpgradeViewController.h"
#import "HomepageViewController.h"
#import "AccountViewController.h"
#import "SettingViewController.h"
#import "YXM_ReportMailViewController.h"
#import "YXM_SettingViewController.h"
#import "YXM_ClientServerViewController.h"

@implementation RootVC

@synthesize splitViewController;
- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark 旋屏支持及UISplitViewControllerDelegate协议实现
// 支持旋屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"左侧背景"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_button1_l.png"] forBarMetrics:UIControlStateNormal];
}

#pragma mark -
#pragma mark Table view data source method


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section{
     return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"RootViewControllerCellIdentifier";
    MenuTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (indexPath.row !=0) {
            cell = [[MenuTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withFrame:CGRectMake(1, 0, self.view.frame.size.width-2, 55)];
        }else {
            cell = [[MenuTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        }
    }
    if (indexPath.row == 0) {
        cell.backgroundImageView.image = [UIImage imageNamed:@"userlogo"];
        cell.titleButton.frame = CGRectMake(self.view.frame.size.width-50, self.view.frame.size.height-35, 30, 30);
    }
//        else if (indexPath.row == 1) {
//        [cell.titleButton setTitle:[Config DPLocalizedString:@"Root_ScreenOptions"] forState:UIControlStateNormal]; //@"屏体选项"
//        cell.backgroundImageView.image = [UIImage imageNamed:@"屏体选择"];
//    }
//    else if(indexPath.row == 2){
//        [cell.titleButton setTitle:[Config DPLocalizedString:@"adedit_yunpinMarket"] forState:UIControlStateNormal];//@"广告市场"
//        cell.backgroundImageView.image = [UIImage imageNamed:@"广告市场"];
//    }
    else if(indexPath.row == 1){
        [cell.titleButton setTitle:[Config DPLocalizedString:@"Root_LEDADEditer"] forState:UIControlStateNormal];//@"广告编辑器"
        cell.backgroundImageView.image = [UIImage imageNamed:@"广告编辑器"];
    }else if(indexPath.row == 2){
        [cell.titleButton setTitle:[Config DPLocalizedString:@"Root_LEDADSheZhi"] forState:UIControlStateNormal];//@"广告编辑器"
        cell.backgroundImageView.image = [UIImage imageNamed:@"设置"];
    }else if(indexPath.row == 3){
        [cell.titleButton setTitle:[Config DPLocalizedString:@"Root_LEDADKeFu"] forState:UIControlStateNormal];//@"广告编辑器"
        cell.backgroundImageView.image = [UIImage imageNamed:@"客服"];
    }

    UIViewController <SubstitutableDetailViewController> *detailViewController = [[SoftVersionViewController alloc] init];
    [detailViewController.view setBackgroundColor:[UIColor whiteColor]];
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, detailViewController, nil];
    splitViewController.viewControllers = viewControllers;
    [viewControllers release];
    
    if (indexPath.row != 0) {
        UIView *myf = [[UIView alloc]initWithFrame:cell.frame];
        [myf setBackgroundColor:[UIColor yellowColor]];
        [cell setSelectedBackgroundView:myf];
    }
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES  scrollPosition:UITableViewScrollPositionTop];
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate method



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;
    
    UIViewController <SubstitutableDetailViewController> *detailViewController = nil;
    
    if (row == 0) {
        detailViewController = [[SoftVersionViewController alloc] init];
		[detailViewController.view setBackgroundColor:[UIColor whiteColor]];
        //通过email报告错误
//        YXM_ReportMailViewController *myReportCtrl = [[YXM_ReportMailViewController alloc]init];
//        [myReportCtrl sendEMail];
//        [detailViewController.view addSubview:myReportCtrl.view];
    }
//    else if (row == 1) {//信号选择
//
//
//
//        detailViewController = [[ScreenOptionsViewController alloc] init];
//		[detailViewController.view setBackgroundColor:[UIColor whiteColor]];
//    }
//    else if (row == 2) {//云屏升级
//
//
//
//        detailViewController = [[UpgradeViewController alloc] init];
//		[detailViewController.view setBackgroundColor:[UIColor whiteColor]];
//    }
//    else if (row == 2) {//云屏市场
//
//
//        detailViewController = [[SoftVersionViewController alloc] init];
//        DLog(@"%f,%f",detailViewController.view.frame.size.height,detailViewController.view.frame.size.height);
//		[detailViewController.view setBackgroundColor:[UIColor whiteColor]];
//        
//        AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//        myDelegate.rootCtrl = (SplitVCDemoViewController*)myDelegate.window.rootViewController;
//        
//        if (homepageVC) {
//            [homepageVC release],homepageVC = nil;
//        }
//        homepageVC = [[HomepageViewController alloc] init];
//        myDelegate.window.rootViewController = homepageVC;
//    }
//    else if (row == 3) {//语言设置
//
//
//        detailViewController = [[LanguageSettingViewController alloc] init];
//		[detailViewController.view setBackgroundColor:[UIColor whiteColor]];
//
//
//    }
    else if(row == 1){//编辑上传



        detailViewController = [[SoftVersionViewController alloc] init];
		[detailViewController.view setBackgroundColor:[UIColor whiteColor]];
        AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        myDelegate.rootCtrl = (SplitVCDemoViewController*)myDelegate.window.rootViewController;

        //广告编辑器界面
        LayoutYXMViewController *layoutCtrl = [[LayoutYXMViewController alloc]init];
        UINavigationController *layoutNav = [[UINavigationController alloc]initWithRootViewController:layoutCtrl];
        [myDelegate.window setRootViewController:layoutNav];
        [layoutCtrl release];
        [layoutNav release];

    }else if (row == 2){//云屏设置



        detailViewController = [[YXM_SettingViewController alloc] init];


        [detailViewController.view setBackgroundColor:[UIColor whiteColor]];

    }
    else if (row == 3){//联系客服

        detailViewController = [[YXM_ClientServerViewController alloc] init];

        [detailViewController.view setBackgroundColor:[UIColor whiteColor]];

    }
    // 修改 split view controller的viewControllers属性.
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, detailViewController, nil];
    splitViewController.viewControllers = viewControllers;
    [viewControllers release];

    [detailViewController release];
}

@end
