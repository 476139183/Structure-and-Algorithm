//
//  SettingViewController.m
//  LED2Buy
//
//  Created by LDY on 14-7-3.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "SettingViewController.h"
#import "AccountTableViewCell.h"
#import "AboutViewController.h"
#import "MyTool.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    settingTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
    settingTableView.scrollEnabled = NO;
    [self.view addSubview:settingTableView];
    
    imageArray = [[NSArray alloc] initWithObjects:@"pushmsg",@"update",@"clear",@"about", nil];
    labelArray = [[NSArray alloc] initWithObjects:@"推送消息",@"检查更新",@"清除缓存",@"关于LED2Buy", nil];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier%d",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[AccountTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MyIdentifier] autorelease];
    }
    cell.imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    cell.textLabel.text = [labelArray objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        UISwitch *pushMSGSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH - 60, 10, 50, 30)];
        if (OS_VERSION_FLOAT < 7.0) {
            pushMSGSwitch.frame = CGRectMake(SCREEN_CGSIZE_WIDTH - 90, 10, 50, 30);
        }
        [pushMSGSwitch addTarget:self action:@selector(switchTapped) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:pushMSGSwitch];
    }
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = @"v1.0.0";
    }
    if (indexPath.row == 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        [self checkVersion];
    }
    if (indexPath.row == 2) {
        [self clearCaches];
    }
    if (indexPath.row == 3) {
        if (!aboutVC) {
            aboutVC = [[AboutViewController alloc] init];
        }
        aboutVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}

//推送开关
- (void)switchTapped
{
    DLog(@"Test");
}

//检查版本更新
- (void)checkVersion
{
    if (!alert) {
        alert = [[UIAlertView alloc] init];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *trackName = [ud objectForKey:@"trackName"];
    if ([MyTool updateApp]) {
        [alert initWithTitle:trackName
                     message:NSLocalizedString(@"GotNewVersion", @"有新版本，是否升级！")
                    delegate: self
           cancelButtonTitle:NSLocalizedString(@"NSString17", @"")
           otherButtonTitles:NSLocalizedString(@"Update", @"") , nil];//@"升级"
        alert.tag = 1001;
        [alert show];
    }else{
        [alert initWithTitle:trackName
                     message:NSLocalizedString(@"NoNewVersion", @"无新版本！")
                    delegate: self
           cancelButtonTitle:NSLocalizedString(@"NSStringYes", @"") otherButtonTitles:nil, nil];//@"确定"
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001 && buttonIndex==1) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        DLog(@"%@",[ud objectForKey:@"trackViewUrl"]);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ud objectForKey:@"trackViewUrl"]]];
    }
}

//清除缓存
- (void)clearCaches
{
    //清除cookie
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    //清除缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSString *cachedir=[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    NSString *cachedir1=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    NSLog(@"cachedir=%@",cachedir);
    NSFileManager *filemanager=[NSFileManager defaultManager];
    //读取文件内容
    if([filemanager fileExistsAtPath:cachedir])
    {
        DLog(@"清除缓存");
        [filemanager removeItemAtPath:cachedir error:nil];
        [filemanager removeItemAtPath:cachedir1 error:nil];
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NSString24", @"") message:NSLocalizedString(@"NSStringClearCacheSuc", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"NSStringYes", @"") otherButtonTitles: nil];
    [alertView show];
    [alertView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
