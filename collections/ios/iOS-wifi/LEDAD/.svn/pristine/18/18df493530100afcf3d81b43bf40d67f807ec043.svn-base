//
//  AccountManagerViewController.m
//  ZDEC
//  账号管理,退出登录和修改密码
//  modify yxm 2013年09月29日17:06:41 //增加我的资料按钮
//  Created by yixingman on 9/11/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import "AccountManagerViewController.h"
#import "ModifyPassViewController.h"
#import "SGInfoAlert.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "Config.h"
//#import "LHHEditUserInfoViewController.h"
#import "JsonToObjectAdapter.h"
#import "AppDelegate.h"

@interface AccountManagerViewController ()

@end

@implementation AccountManagerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//获取用户信息
-(void)sendAsynchronous{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *keyString = [ud objectForKey:@"key"];
    if ([keyString length]<8) {
        keyString = @"";
    }
    DLog(@"keyString = %@",[ud objectForKey:@"key"]);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?key=%@",URL_FOR_IP_OR_DOMAIN,URL_ZDEC_MAIN_GET_USERINFO,keyString]];
    httpRequest_sale = [[ASIHTTPRequest alloc]initWithURL:url];
    httpRequest_sale.delegate = self;
    httpRequest_sale.tag = TAG_RQUEST_GET_USERINFO;
    [httpRequest_sale startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSString *responseString = [request responseString];
    DLog(@"responseString = %@",responseString);
    [self refreshTable:request];
}
-(void)refreshTable:(ASIHTTPRequest*)request{
    if (request.tag==TAG_RQUEST_GET_USERINFO) {
        NSString *responseStr = [request responseString];
        DLog(@"responseStr=%@",responseStr);
        NSArray *userArray = [[responseStr JSONValue] objectForKey:@"user_list"];
        NSDictionary *userDict = [userArray lastObject];
        [JsonToObjectAdapter saveLoginInformation:userDict];
    }
    [self getUserInfo];
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    [self refreshTable:request];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackGround.png"]]];
    self.title = NSLocalizedString(@"NsstringMyaccount",@"我的账号");
    [self sendAsynchronous];
    
    //我的资料按钮
//    UIButton *userInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [userInfoButton setFrame:CGRectMake(SCREEN_CGSIZE_WIDTH-7.0f-75.0f, 7.0f, 75.0f, 30.0f)];
//    [userInfoButton addTarget:self action:@selector(userInfoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    userInfoButton.backgroundColor = [UIColor clearColor];
//    [userInfoButton setImage:[UIImage imageNamed:@"getUserInfoButton.png"] forState:UIControlStateNormal];
    //ZDEC中需要屏蔽用户信息这个按钮
//    [self.view addSubview:userInfoButton];
    

    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, [Config currentNavigateHeight] + 5, self.view.frame.size.width-10, 90)];
    bgView.image = [UIImage imageNamed:@"whitebackground.png"];
    
    headImageButton = [[BaseButton alloc] initWithFrame:CGRectMake(5, 5, 80, 80) andNorImg:@"Account.png" andHigImg:nil andTitle:nil];
    nameLabel = [[BaseUILabel alloc] initWithFrame:CGRectMake(90, 5, 225, 40) andTitle:@""];
    positionLabel = [[BaseUILabel alloc] initWithFrame:CGRectMake(90, 45, 225, 40) andTitle:@""];
    
    [bgView addSubview:headImageButton];
    [bgView addSubview:nameLabel];
    [bgView addSubview:positionLabel];
    [self.view addSubview:bgView];

    exitLoginButton = [[BaseButton alloc]initWithFrame:CGRectMake(5, [Config currentNavigateHeight] + 100, SCREEN_CGSIZE_WIDTH/3, 40) andNorImg:@"navi_button1_l.png" andHigImg:@"navi_button1_l.png" andTitle:NSLocalizedString(@"NSStringExit",@"退出登陆")];
    [exitLoginButton addTarget:self action:@selector(exitLoginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitLoginButton];
    
    modifyLoginButton = [[BaseButton alloc]initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH-SCREEN_CGSIZE_WIDTH/3-5, [Config currentNavigateHeight] + 100, SCREEN_CGSIZE_WIDTH/3, 40) andNorImg:@"navi_button1_l.png" andHigImg:@"navi_button1_l.png" andTitle:NSLocalizedString(@"NSStringModifyPass",@"修改密码")];
    [modifyLoginButton addTarget:self action:@selector(modifyLoginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modifyLoginButton];
    
    [self getUserInfo];
}

//退出登陆
-(void)exitLoginButtonClicked:(UIButton*)sneder{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //网址拼接分为域名和访问路径两部分,域名前后不带斜线,路径的前后也不带斜线,统一在拼接的时候加入斜线
    NSString *keyString = [ud objectForKey:@"key"];
    if ([keyString length]<8) {
        keyString = @"";
    }
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",URL_FOR_IP_OR_DOMAIN,URL_ZDEC_LOGOUT,keyString]];
    //
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?key=%@",URL_FOR_IP_OR_DOMAIN,URL_ZDEC_LOGOUT,keyString]];
    DLog(@"退出登录 = %@",url);
    ASIFormDataRequest *loginRequest = [ASIFormDataRequest requestWithURL:url];
    [loginRequest startSynchronous];
    NSError *error = [loginRequest error];
    if (!error) {
        NSString *response = [loginRequest responseString];
        DLog(@"退出登录 response is %@",response);
        NSDictionary *responDict = [[response JSONValue] objectForKey:@"message"];
        DLog(@"responDict is %@",responDict);
        DLog(@"%@",[responDict objectForKey:@"msg"]);
        if ([[responDict objectForKey:@"error"] isEqualToString:@"0"]) {
            DLog(@"退出成功");
            [ud removeObjectForKey:KEY_USER_MAIL];
            [ud removeObjectForKey:KEY_USER_PHONE];
            [ud setObject:nil forKey:@"user_alias"];
            [ud removeObjectForKey:@"user_alias"];
            [ud removeObjectForKey:@"user_name"];
            [ud removeObjectForKey:KEY_USER_HEADIMG];
            [ud removeObjectForKey:@"user_status"];
            [ud removeObjectForKey:@"role_id"];
            [ud removeObjectForKey:@"user_company"];
            [ud setObject:@"" forKey:@"key"];
            [ud synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGE_HEADVIEW object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGE_MENU object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGE_SALEBUTTON object:nil userInfo:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:NSLocalizedString(@"NSStringNetExecption",@"网络异常，请稍后再试！") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @""), nil];
            [alert show];
            [alert release];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:NSLocalizedString(@"NSStringNetExecption",@"网络异常，请稍后再试！") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @""), nil];
        [alert show];
        [alert release];
    }
}

//修改密码
-(void)modifyLoginButtonClicked:(UIButton*)sneder{
    if (modifyViewController == nil) {
        modifyViewController= [[ModifyPassViewController alloc] init];
    }
    [self.navigationController pushViewController:modifyViewController animated:YES];
}

//-(UIView*)getCellView{
//    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_CGSIZE_WIDTH,90)];
//    headImageButton = [[BaseButton alloc]initWithFrame:CGRectMake(5, 3, 80, 80-3-3)];
//    
//    nameLabel = [[BaseUILabel alloc]initWithFrame:CGRectMake(headImageButton.frame.size.width+5+5, 3, SCREEN_CGSIZE_WIDTH-headImageButton.frame.size.width+5+5-10, 30)];
//    positionLabel = [[BaseUILabel alloc]initWithFrame:CGRectMake(headImageButton.frame.size.width+5+5, 3+40, SCREEN_CGSIZE_WIDTH-headImageButton.frame.size.width+5+5-10, 30)];
//    
//    
//    [cellView addSubview:positionLabel];
//    [cellView addSubview:headImageButton];
//    [cellView addSubview:nameLabel];
//    return cellView;
//}

/*
 BaseButton *headImageButton;
 BaseUILabel *nameLabel;
 BaseUILabel *positionLabel;
 */
-(void)getUserInfo{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    DLog(@"userKey=%@",[ud objectForKey:@"key"]);
    NSURL *url = [NSURL URLWithString:[ud objectForKey:KEY_USER_HEADIMG]];
    [headImageButton setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:DEFAULT_HEAD_IMAGE]];
    if ([ud objectForKey:KEY_USER_NUM]==nil){
        [nameLabel setText:[ud objectForKey:KEY_USER_MAIL]];
    }else{
        [nameLabel setText:[ud objectForKey:KEY_USER_PHONE]];
    }
    if ([ud objectForKey:KEY_USER_NAME]!=nil) {
        [nameLabel setText:[ud objectForKey:KEY_USER_NAME]];
    }

    
    [positionLabel setText:@""];
}


//获得用户资料
//-(void)userInfoButtonClicked:(UIButton*)sender{
//    if (editUserInfoCtrl==nil) {
//        editUserInfoCtrl = [[LHHEditUserInfoViewController alloc]init];
//    }
//    [editUserInfoCtrl initWithCustomer:oneCompanyContactEnti];
//    editUserInfoNav = [[UINavigationController alloc] initWithRootViewController:editUserInfoCtrl];
//    NSString *topnavistr=[[NSString alloc]initWithFormat:@"topnavigata.png"];
//    [editUserInfoNav.navigationBar setBackgroundImage:[UIImage imageNamed:topnavistr] forBarMetrics:UIBarMetricsDefault];
//    editUserInfoNav.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    [self.view addSubview:editUserInfoNav.view];
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
