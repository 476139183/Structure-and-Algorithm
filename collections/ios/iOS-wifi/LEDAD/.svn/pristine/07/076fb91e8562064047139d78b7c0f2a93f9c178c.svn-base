//
//  AccountViewController.m
//  LED2Buy
//
//  Created by LDY on 14-7-3.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountTableViewCell.h"
#import "LoginViewController.h"
#import "AccountManagerViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

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
    AccountTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    AccountTableView.dataSource = self;
    AccountTableView.delegate = self;
    [self.view addSubview:AccountTableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 1:
            return 2;
            break;
        default:
            return 1;
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    CGFloat heightOfCell = cell.frame.size.height;
    DLog(@"heightOfCell = %f",heightOfCell);
    if (indexPath.section == 0) {
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
        }
        cell.textLabel.text = @"登录";
    }
    else{
        if (cell == nil) {
            cell = [[[AccountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
        }
        if (indexPath.section == 1){
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"favorite"];
                cell.textLabel.text = @"收藏";
            }else{
                cell.imageView.image = [UIImage imageNamed:@"download"];
                cell.textLabel.text = @"下载";
            }
        }
        else {
            cell.imageView.image = [UIImage imageNamed:@"about_red"];
            cell.textLabel.text = @"推送";
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - UITableViewDelegate
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 1;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        if ([ud objectForKey:@"user_alias"]) {
            if (!accountMVC) {
                accountMVC = [[AccountManagerViewController alloc] init];
            }
            accountMVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:accountMVC animated:YES];
        }else{
            if (!loginVC) {
                loginVC = [[LoginViewController alloc] init];
            }
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }
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
