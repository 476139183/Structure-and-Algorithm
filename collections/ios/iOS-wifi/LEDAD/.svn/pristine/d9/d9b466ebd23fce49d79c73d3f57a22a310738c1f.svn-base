//
//  LoginViewController.m
//  SideBarDemo
//  Modify 2013年09月12日18:08:07 yxm
//  增加推送功能，登陆成功之后开始设置别名
//  Created by LDY on 13-8-9.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "LoginViewController.h"
#import "BaseButton.h"
#import "SVStatusHUD.h"

#import "LedNewConfig.h"
#import "RegisterViewController.h"
#import "NSString+SBJSON.h"
#import "NSString+MD5.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "Config.h"
#import "SGInfoAlert.h"
#import "Toast+UIView.h"
#import "AHAlertView.h"
#import "MyTool.h"
#import "MyUILabel.h"
#import "FDLabelView.h"
#import "UIView+MGEasyFrame.h"

@interface LoginViewController ()

@end

LoginViewController *loginViewController;

@implementation LoginViewController
@synthesize confirmDict;
@synthesize mrViewController;


- (void)viewDidLoad
{
    [super viewDidLoad];
    //顶部导航栏偏移适配
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"NSString36",@"登录账号");
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"NSString17",@"取消") style:UIBarButtonItemStyleBordered target:self action:@selector(cancelLogin)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"NSString39",@"注册") style:UIBarButtonItemStyleBordered target:self action:@selector(userRegistEvent)];
    NSInteger topoffSetHeight=0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"ispresentViewController"] isEqualToString:@"ispresentViewController"]) {
            topoffSetHeight = 20;
            if (SCREEN_CGSIZE_HEIGHT>568&&[[ud objectForKey:@"fromServersCenter"] isEqualToString:@"fromServersCenter"]) {
                topoffSetHeight=0;
            }
        }else{
            topoffSetHeight = 0;
        }
    }else{
        topoffSetHeight = 0;
    }
    
    //登陆的输入字段和按钮的容器
    //容器的宽度
    NSInteger loginContainerWidth = SCREEN_CGSIZE_WIDTH;
    //容器的起始位置
    NSInteger loginContainerX = 0;
    if (DEVICE_IS_IPAD) {
        loginContainerWidth = LOGIN_REGISTER_VIEW_WIDTH;
        loginContainerWidth = loginContainerWidth*0.6;
        loginContainerX = LOGIN_REGISTER_VIEW_WIDTH/2-loginContainerWidth/2;
    }
    DLog(@"loginContainerWidth = %d",loginContainerWidth);
    //容器的高度
    NSInteger loginContainerHeight = 200;
    
    CGRect loginContainerFrame = CGRectMake( loginContainerX , [Config currentNavigateHeight] + GAP_VIEW_VIEW,loginContainerWidth, loginContainerHeight );
    UIView *loginContainerView = [[UIView alloc]initWithFrame:loginContainerFrame];
    
    //用户名输入框
    emailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ContactUs.png"]];
    emailImageView.frame = CGRectMake(7, 7, 30, 30);
    [emailImageView setUserInteractionEnabled:YES];
    usernameField = [[MHTextField alloc] initWithFrame:CGRectMake( 20 , 0 , loginContainerFrame.size.width-2*20, 44)];
    usernameField.background = [UIImage imageNamed:@"Customer_Up.png"];
    usernameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //非中文的情况则使用邮箱登陆,中文用手机号码登陆
    NSString* strLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    if (![strLanguage isEqualToString:@"zh-Hans"]) {
        usernameField.placeholder = NSLocalizedString(@"NSStringemailLabelPlaceholder", @"邮箱地址");
        [usernameField setEmailField:YES];
    }else{
        usernameField.placeholder = NSLocalizedString(@"NSStringTelSample", @"电话号码");
        [usernameField setPhoneField:YES];
    }
    usernameField.tag=TAG_USER_NAME_TEXTFIELD;
    usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameField.textAlignment = NSTextAlignmentCenter;
    [usernameField setText:@""];
    usernameField.adjustsFontSizeToFitWidth = YES;
    usernameField.delegate = self;
    [usernameField setRequired:YES];
    [usernameField addSubview:emailImageView];
    [loginContainerView addSubview:usernameField];
    
    //密码输入框
    passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Password.png"]];
    passwordImageView.frame = CGRectMake(7, 7, 30, 30);
    [passwordImageView setUserInteractionEnabled:YES];
    
    passwordField = [[MHTextField alloc] initWithFrame:CGRectMake(20,usernameField.frame.origin.y+usernameField.frame.size.height ,loginContainerView.frame.size.width-2*20, 44)];
    passwordField.background = [UIImage imageNamed:@"Customer_Down.png"];
    passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [passwordField setSecureTextEntry:YES];
    passwordField.placeholder = NSLocalizedString(@"NSString38", @"密码");
    passwordField.tag=TAG_USER_NAME_TEXTFIELD+1;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.textAlignment = NSTextAlignmentCenter;
    passwordField.adjustsFontSizeToFitWidth = YES;
    [passwordField setText:@""];
    passwordField.delegate = self;
    [passwordField setRequired:YES];
    [passwordField addSubview:passwordImageView];
    [loginContainerView addSubview:passwordField];
    
    //登陆按钮
    _loginButton = [[BaseButton alloc] initWithFrame:CGRectMake(20,passwordField.frame.origin.y+passwordField.frame.size.height+GAP_VIEW_VIEW , loginContainerView.frame.size.width-2*20, 44) andNorImg:@"navi_button1_l.png" andHigImg:@"navi_button1_l.png" andTitle:NSLocalizedString(@"NSString40", @"")];
    [_loginButton addTarget:self action:@selector(userLoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginContainerView addSubview:_loginButton];
    
    [self.view addSubview:loginContainerView];

    //注册成功的通知提示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSucessToast:) name:NOTI_SHOW_LOGIN_SUCCESS_TOASTVIEW object:nil];
}

/**
 *@brief 注册成功的通知提示
 */
-(void)showSucessToast:(NSNotification*)noti{
    NSDictionary *messageDict = [noti userInfo];
    NSString *messageString = [[NSString alloc]initWithFormat:@"%@",[messageDict objectForKey:@"message"]];
    DLog(@"messageString = %@,noti=%@",messageString,noti);
    [self.view makeToast:messageString
                duration:3.0
                position:@"center"
                   image:[MyTool scale:[UIImage imageNamed:@"smiletoast.png"] toSize:CGSizeMake(40, 40)]];
}

-(void)serverSystembackMainSettingView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 取消登录 */
- (void)cancelLogin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGE_BUTTONCOLOR object:nil userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *@brief 用户注册按钮的处理事件
 */
- (void)userRegistEvent
{
    if (registerViewController == nil) {
        registerViewController= [[RegisterViewController alloc] init];
    }
    DLog(@"用户注册按钮的处理事件");
    [self.navigationController pushViewController:registerViewController animated:NO];
    [MyTool viewSwitcher:@"oglFlip" owner:registerViewController transitionFromStyle:kCATransitionFromLeft];
}


//用户登录按钮点击事件
- (void)userLoginButtonClick:(UIButton *)sender
{
    //禁用登录按钮
    [_loginButton setEnabled:NO];
    //登陆的用户名
    NSString *YXM_userNmae = usernameField.text;
    //密码
    NSString *YXM_passwrod = passwordField.text;
    

    //邮箱作为账号
    NSString *YXM_email = nil;
    //手机作为账号
    NSString *YXM_phoneNum = nil;
    
    
    //用户名是否为空
    if ([YXM_userNmae length]<1) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:NSLocalizedString(@"NSStringAccountNotNull",@"账号不能为空") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @"确定"), nil];
        [alert show];
        [alert release];
        //使输入用户名的输入框获得焦点
        [usernameField becomeFirstResponder];
        [_loginButton setEnabled:YES];
        return;
    }
    //密码不能为空
    if ([YXM_passwrod length]<1) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:NSLocalizedString(@"NSStringPasswordNotNull",@"密码不能为空") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @"确定"), nil];
        [alert show];
        [alert release];
        //使输入密码的输入框获得焦点
        [passwordField becomeFirstResponder];
        [_loginButton setEnabled:YES];
        return;
    }

    
    //判断是否输入的是email
    if ([MyTool localRegexEmail:YXM_userNmae]) {
        YXM_email = YXM_userNmae;
        YXM_phoneNum = @"";
    }else if ([MyTool localRegexPhone:YXM_userNmae]){
        YXM_email = @"";
        YXM_phoneNum = YXM_userNmae;
    }else{
        YXM_email = @"";
        YXM_phoneNum = @"";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:NSLocalizedString(@"LocalStringAccountFormatError",@"账号格式错误") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @"确定"), nil];
        [alert show];
        [alert release];
        //使输入用户名的输入框获得焦点
        [usernameField becomeFirstResponder];
        [_loginButton setEnabled:YES];
        return;
    }


    //网址拼接分为域名和访问路径两部分,宏定义域名前后不带斜线,宏定义路径的前后也不带斜线,统一在拼接的时候加入斜线
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",URL_FOR_IP_OR_DOMAIN,URL_ZDEC_LOGIN]];
    DLog(@"登录的访问的url = %@",url);
    ASIFormDataRequest *loginRequest = [ASIFormDataRequest requestWithURL:url];
    DLog(@"\n登录的账号 = %@%@\n密码=%@",YXM_phoneNum,YXM_email,YXM_passwrod);
    [loginRequest addPostValue:YXM_phoneNum forKey:KEY_LOGIN_NUM];
    [loginRequest addPostValue:YXM_email forKey:KEY_LOGIN_MAIL];
    [loginRequest addPostValue:[YXM_passwrod md5EncryptLower] forKey:KEY_LOGIN_PASS];
    [loginRequest addPostValue:KEY_COMPANY_ID forKey:KEY_CID];
    
    DLog(@"提交的字段以及值\n%@=%@\n%@=%@\n%@=%@\n%@=%@\n",KEY_LOGIN_NUM,YXM_phoneNum,KEY_LOGIN_MAIL,YXM_email,KEY_LOGIN_PASS,[YXM_passwrod md5Encrypt],KEY_CID,KEY_COMPANY_ID);
    
    
    [loginRequest setCompletionBlock:^{
        [_loginButton setEnabled:YES];
        NSString *responseString = [loginRequest responseString];
        DLog(@"登录请求成功返回数据 %@",responseString);

        NSDictionary *responDict = [[responseString JSONValue] objectForKey:@"message"];
        DLog(@"responDict = %@\nmsg = %@",responDict, [responDict objectForKey:@"msg"]);
        if (responDict==nil||![responDict isKindOfClass:[NSDictionary class]]) {
            DLog(@"返回的message为空");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:NSLocalizedString(@"NSStringServiceReturnExecption",@"服务器异常，请稍后再试！") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @""), nil];
            [alert show];
            [alert release];
        }

        if ([[responDict objectForKey:@"error"] isEqualToString:@"0"]) {
            NSString *keyString = [responDict objectForKey:@"key"];
             DLog(@"返回的error为0表示登录成功,保存用户的key = %@",keyString);
            NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
            [ud setObject:keyString forKey:@"key"];
            [ud synchronize];
            [self loginSuccessAndGetUserInfo:keyString];
        }else{
            [_loginButton setEnabled:YES];
            [passwordField resignFirstResponder];
            NSString *message = [[NSString alloc]initWithFormat:@"\n%@",[responDict objectForKey:@"msg"]];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:message delegate:self cancelButtonTitle:NSLocalizedString(@"NSStringOKButtonTitle", @"") otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }];
    [loginRequest setFailedBlock:^{
        DLog(@"登录请求失败");
        [_loginButton setEnabled:YES];
        
        NSString *message = [[NSString alloc]initWithFormat:@"\n%@",NSLocalizedString(@"NSString25",@"无网络连接")];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:message delegate:self cancelButtonTitle:NSLocalizedString(@"NSStringOKButtonTitle", @"") otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }];
    [loginRequest startAsynchronous];
}


/**
 *@brief 登录成功的处理事件,使用请求成功返回的key来获取用户信息
 */
-(void)loginSuccessAndGetUserInfo:(NSString *)keyString{
    DLog(@"用户的key = %@",keyString);

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?key=%@",URL_FOR_IP_OR_DOMAIN,URL_ZDEC_MAIN_GET_USERINFO,keyString]];
    DLog(@"登陆后获取用户信息url = %@",url);
    ASIHTTPRequest *confirmRequest = [ASIHTTPRequest requestWithURL:url];
    [confirmRequest setCompletionBlock:^{
        [_loginButton setEnabled:YES];
        
        NSString *responseString = [confirmRequest responseString];
        DLog(@"登陆后获取用户信息返回的数据 = %@",responseString);
        NSDictionary *responseDict = [responseString JSONValue];
        NSArray *userArray = [responseDict objectForKey:@"user_list"];
        NSDictionary *userDict = [userArray lastObject];
        DLog(@"解析user数据 = %@",userDict);
        
        if ((!userDict)||(![userDict isKindOfClass:[NSDictionary class]])) {
            DLog(@"返回用户信息为空！");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:NSLocalizedString(@"LocalStringGetBaseInfoError",@"获取账号信息出错") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @"确定"), nil];
            [alert show];
            [alert release];
        }else{
            DLog(@"解析返回的数据并作存储");
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            //头像
            if (([userDict objectForKey:KEY_USER_HEADIMG])&&([[userDict objectForKey:KEY_USER_HEADIMG] length]>0)) {
                [ud setObject:[userDict objectForKey:KEY_USER_HEADIMG] forKey:KEY_USER_HEADIMG];
            }
            //电话号码
            if (([userDict objectForKey:KEY_USER_PHONE])&&([[userDict objectForKey:KEY_USER_PHONE] length]>0)) {
                [ud setObject:[userDict objectForKey:KEY_USER_PHONE] forKey:KEY_USER_PHONE];
            }
            //QQ
            if (([userDict objectForKey:KEY_USER_QQ])&&([[userDict objectForKey:KEY_USER_QQ] length]>0)) {
                [ud setObject:[userDict objectForKey:KEY_USER_QQ] forKey:KEY_USER_QQ];
            }
            //用户描述
            if (([userDict objectForKey:KEY_USER_DESCRIPTION])&&([[userDict objectForKey:KEY_USER_DESCRIPTION] length]>0)) {
                [ud setObject:[userDict objectForKey:KEY_USER_DESCRIPTION] forKey:KEY_USER_DESCRIPTION];
            }
            //邮箱
            if (([userDict objectForKey:KEY_USER_MAIL])&&([[userDict objectForKey:KEY_USER_MAIL] length]>0)) {
                [ud setObject:[userDict objectForKey:KEY_USER_MAIL] forKey:KEY_USER_MAIL];
            }
            //姓名
            if (([userDict objectForKey:KEY_USER_NAME])&&([[userDict objectForKey:KEY_USER_NAME] length]>0)) {
                [ud setObject:[userDict objectForKey:KEY_USER_NAME] forKey:KEY_USER_NAME];
            }
            //别名
            if (([userDict objectForKey:KEY_USER_ALIAS])&&([[userDict objectForKey:KEY_USER_ALIAS] length]>0)) {
                [ud setObject:[userDict objectForKey:KEY_USER_ALIAS] forKey:KEY_USER_ALIAS];
            }
            //角色
            if (([userDict objectForKey:KEY_USER_ROLE_ID])&&([[userDict objectForKey:KEY_USER_ROLE_ID] length]>0)) {
                [ud setObject:[userDict objectForKey:KEY_USER_ROLE_ID] forKey:KEY_USER_ROLE_ID];
            }else{
                [ud setObject:@"0" forKey:KEY_USER_ROLE_ID];
            }
            //状态
            if (([userDict objectForKey:KEY_USER_STATUS])&&([[userDict objectForKey:KEY_USER_STATUS] length]>0)) {
                [ud setObject:[userDict objectForKey:KEY_USER_STATUS] forKey:KEY_USER_STATUS];
            }
            //编号
            if (([userDict objectForKey:KEY_USER_ID])&&([[userDict objectForKey:KEY_USER_ID] length]>0)) {
                [ud setObject:[userDict objectForKey:KEY_USER_ID] forKey:KEY_USER_ID];
            }
            //二维码
            if (([userDict objectForKey:KEY_USER_CODE])&&([[userDict objectForKey:KEY_USER_CODE] length]>0)) {
                [ud setObject:[userDict objectForKey:KEY_USER_CODE] forKey:KEY_USER_CODE];
            }
            //公司
            if ([userDict objectForKey:KEY_USER_COMPANY]) {
                [ud setObject:[userDict objectForKey:KEY_USER_COMPANY] forKey:KEY_USER_COMPANY];
            }
            [ud synchronize];
                        
            DLog(@"返回到右边主菜单");
            //发出通知
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_ADD_PRODUCTION object:nil userInfo:nil];
            [self serverSystembackMainSettingView];
        }
        
    }];
    [confirmRequest setFailedBlock:^{
        [_loginButton setEnabled:YES];
        DLog(@"获取用户详细信息出错");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:NSLocalizedString(@"LocalStringGetBaseInfoError",@"获取账号信息出错") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @"确定"), nil];
        [alert show];
        [alert release];
    }];
    [confirmRequest startAsynchronous];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [passwordField setText:@""];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    DLog(@"ispresentViewController=%@",[ud objectForKey:@"ispresentViewController"]);
}
-(void)viewWillDisappear:(BOOL)animated{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"ispresentViewController"] isEqualToString:@"ispresentViewController"]) {
        [ud setObject:@"no" forKey:@"ispresentViewController"];
    }
    DLog(@"ispresentViewController=%@",[ud objectForKey:@"ispresentViewController"]);
}


- (BOOL)validateInputInView:(UIView*)view
{
    for(UIView *subView in view.subviews){
        if ([subView isKindOfClass:[UIScrollView class]])
            return [self validateInputInView:subView];
        
        if ([subView isKindOfClass:[MHTextField class]]){
            if (![(MHTextField*)subView validate]){
                return NO;
            }
        }
    }
    
    return YES;
}

-(BOOL)shouldAutorotate{
    return NO;
}

@end
