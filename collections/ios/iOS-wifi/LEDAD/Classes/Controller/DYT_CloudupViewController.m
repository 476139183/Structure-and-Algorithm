//
//  DYT_CloudupViewController.m
//  LEDAD
//
//  Created by laidiya on 15/7/21.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_CloudupViewController.h"
#import "DYT_LoginPage.h"
#import "DYT_RegisteredPageview.h"
#import "DYT_ClouduploadViewController.h"
#import "Config.h"
@interface DYT_CloudupViewController ()
{
    DYT_LoginPage *LoginPageview;
    DYT_RegisteredPageview *registeredPageview;
    DYT_ClouduploadViewController *uploadViewVC;
    UILabel *title;
}
@end

@implementation DYT_CloudupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setbaseview];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)setbaseview
{
     NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *str= [ud objectForKey:@"userID"];
    DLog(@"====%@",str);
    if (str!=nil) {
        [self uploadViewVCview:str];
        return;
    }
    
    
    
    title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    title.text = [Config DPLocalizedString:@"adedit_ybfdl"];
    title.textColor = [UIColor lightGrayColor];
    title.backgroundColor = [UIColor grayColor];
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];

    
    
    
    
    
//    登陆界面
    LoginPageview = [[DYT_LoginPage alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-100)];
    
    LoginPageview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:LoginPageview];

    __block   DYT_CloudupViewController *VC = self;
    
    LoginPageview.userName_text = ^(NSString *userName_text){
        
        
        NSLog(@"获取登陆名字%@",userName_text);
        VC.loginUserNameString = userName_text;
        
    };

    LoginPageview.passWord_text = ^(NSString *passWord_text){
        
        
        NSLog(@"获取登陆密码%@",passWord_text);
        
        VC.loginPassWordString = passWord_text;
    };
    
    LoginPageview.loginButtonOnClick = ^(void){
        //        登陆
        [VC landing];
        
    };
    
    LoginPageview.registeredButtonOnClick = ^(void){
        
        //            注册
        [VC registeredView_load];
    };
    
    LoginPageview.message_text = ^(NSString *message_text){
        //
        VC.loginMessageString = message_text;
        
    };
    

    
    
    

}

//登陆
-(void)landing
{
    
    if (_loginUserNameString.length == 0) {
        [self showAlertView:[Config DPLocalizedString:@"Login_ts4"]];
        return;
    }
    if (_loginPassWordString.length == 0) {
        [self showAlertView:[Config DPLocalizedString:@"Login_ts4"]];
        return;
    }
    DLog(@"验证 ＝＝＝＝＝%@  和  %@",self.loginMessageString,LoginPageview.pooCodeView.changeString)
    if ([_loginMessageString isEqualToString:LoginPageview.pooCodeView.changeString]) {
        
        
    }else{
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [LoginPageview.pooCodeView.layer addAnimation:anim forKey:nil];
        [LoginPageview.messageTextField.layer addAnimation:anim forKey:nil];
        
        return;
    }
    
    [self landingRequst];
    
    
    
}


//提交登陆请求
-(void)landingRequst{
    
    
    
    NSMutableDictionary *params = [@{@"Name":self.loginUserNameString,
                                     @"Password":self.loginPassWordString}mutableCopy];
    
    
     __block   DYT_CloudupViewController *VC = self;
    
    [ForumWXDataServer requestURL:@"Ledad/LedadLogin_api.aspx"
                       httpMethod:@"POST"
                           params:params
                             file:nil
                          success:^(id data){
                              
                              DLog(@"用户登陆%@",data);
                              NSString *dict= data[@"msg"];
                              
                              
                              //                              NSDictionary *
                              NSLog(@"登陆获取的消息 成功 就是 0 ＝＝＝%@",dict);
                              if([dict isEqualToString:@"0"]){
                                  
                                  [self showAlertView:[Config DPLocalizedString:@"NSString42"]];
                                  
                                  NSString *ID = data[@"ID"];
                                  
                                  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                                  
                                  [ud setObject:ID forKey:@"userID"];
                                  
                                  [ud synchronize];
                                  
                                  
                                  
                                  if (registeredPageview != NULL) {
                                      
                                      [registeredPageview removeFromSuperview];
                                      
                                  }
                                  if (LoginPageview != NULL) {
                                      
                                      [LoginPageview removeFromSuperview];
                                      
                                  }
                                  
//                            用户界面
                                  [VC uploadViewVCview:ID];
                                  
                              }
                              
                              if ([dict isEqualToString:@"1"]){
                                  
                                  [self showAlertView:[Config DPLocalizedString:@"Login_ts7"]];
                                  
                                  //                                  [registeredPage removeFromSuperview];
                                  //                                  [loginPage removeFromSuperview];
                                  
                              }
                              if ([dict isEqualToString:@"2"]) {
                                  [self showAlertView:[Config DPLocalizedString:@"Login_ts6"]];
                                  
                                  //                                  [registeredPage removeFromSuperview];
                                  //                                  [loginPage removeFromSuperview];
                              }
                              
                          } fail:^(NSError *error){
                              
                              NSLog(@"无网络连接%@",error);
                              [self showAlertView:[Config DPLocalizedString:@"NSString25"]];
                              
                          }];
    
    
    
    
}

-(void)uploadViewVCview:(NSString *)string
{
    
    __block   DYT_CloudupViewController *VC = self;

    uploadViewVC = [[DYT_ClouduploadViewController alloc]init];
    uploadViewVC.usename = string;
    uploadViewVC.view.frame = self.view.bounds;
    uploadViewVC.uploadButtonOnClick = ^(void){
        
        [VC upload];
        
    };
    
    
    uploadViewVC.logoutButtonOnClick = ^(void){
        
        [VC logout];
        
    };
    
    
    
    
    [self.view addSubview:uploadViewVC.view];



}



//注册
-(void)registeredView_load
{
    
    LoginPageview.hidden = YES;
    
    
    __block DYT_CloudupViewController *VC = self;
    
    registeredPageview = [[DYT_RegisteredPageview alloc]initWithFrame:CGRectMake(self.view.frame.size.width-320, 50, 320, 240)];
    
    registeredPageview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:registeredPageview];
    
    registeredPageview.userName_text = ^(NSString *userName_text){
        
        NSLog(@"%@",userName_text);
        VC.registeredUserNameString = userName_text;
        
        
    };
    registeredPageview.passWord_text = ^(NSString *passWord_text){
        
        NSLog(@"%@",passWord_text);
        VC.registeredPassWordString = passWord_text;
    };
    
    registeredPageview.againPassWord_text = ^(NSString *againPassWord_text){
        
        NSLog(@"%@",againPassWord_text);
        VC.registeredNextPassWordString = againPassWord_text;
        
    };
    
    registeredPageview.message_text = ^(NSString *message_text){
        
        NSLog(@"%@",message_text);
        
        
        VC.messageTextString = message_text;
        NSLog(@"%@",VC.messageTextString);
        
        
        
    };
    
    registeredPageview.determineButtonOnClick = ^(void){
        
        
        [VC submit];
        
    };
    
    registeredPageview.returnButtonOnClick = ^(void){
        
        [VC returnButtonOnClcik];
        
    };
    
    
    
}


#pragma mark - showAlertView
-(void)showAlertView:(NSString*)showString
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[Config DPLocalizedString:@"Login_ts3"] message:showString delegate:nil  cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:2.0];
    
    
    
}//温馨提示
- (void)dimissAlert:(UIAlertView *)alert
{
    if(alert)
    {
        
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
        
    }
}//温馨提示


-(void)upload{
    NSLog(@"上传按钮");
    
    
}//上传方法

//注销方法
-(void)logout{
    
    [uploadViewVC.view removeFromSuperview ];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userID"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    
    [self setbaseview];
    
}//注销方法


-(void)submit
{
    
    [self haveNULL:self.registeredUserNameString];
    [self haveNULL:self.registeredPassWordString];
    [self haveNULL:self.registeredNextPassWordString];
    
    
    if(self.registeredUserNameString.length == 0){
        
        [self showAlertView:[Config DPLocalizedString:@"adedit_zc6"]];
        
        return;
    }
    
    if(self.registeredUserNameString.length < 6){
        [self showAlertView:[Config DPLocalizedString:@"adedit_zc7"]];
        
        return;
    }
    
    if(self.registeredUserNameString.length > 16){
        
        [self showAlertView:[Config DPLocalizedString:@"adedit_zc8"]];
        
        return;
    }
    
    if (self.registeredPassWordString.length == 0) {
        
        [self showAlertView:[Config DPLocalizedString:@"adedit_zc9"]];
        
        return;
    }
    
    if (self.registeredPassWordString.length < 6) {
        
        [self showAlertView:[Config DPLocalizedString:@"adedit_zc10"]];
        
        return;
    }
    
    
    if (self.registeredPassWordString.length > 16) {
        [self showAlertView:[Config DPLocalizedString:@"adedit_zc11"]];
        
        return;
    }
    
    if (self.registeredNextPassWordString.length == 0) {
        
        [self showAlertView:[Config DPLocalizedString:@"adedit_zc12"]];
        
        return;
    }
    
    if (self.registeredNextPassWordString.length < 6) {
        
        [self showAlertView:[Config DPLocalizedString:@"adedit_zc13"]];
        
        return;
    }
    
    
    if (self.registeredNextPassWordString.length > 16) {
        [self showAlertView:[Config DPLocalizedString:@"adedit_zc14"]];
        
        return;
    }
    
    if ([self.registeredPassWordString isEqualToString: self.registeredNextPassWordString]) {
        
    }else{
        
        [self showAlertView:[Config DPLocalizedString:@"adedit_zc15"]];
        
        return;
        
        
    }
    
    NSLog(@"提交提交提交");
    
    if ([_messageTextString isEqualToString:registeredPageview.pooCodeView.changeString]) {
        
        
    }else{
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [registeredPageview.pooCodeView.layer addAnimation:anim forKey:nil];
        [registeredPageview.messageTextField.layer addAnimation:anim forKey:nil];
        
        return;
    }
    
    
    [self submitRequst];
    
    
    
}//提交

-(void)submitRequst
{
    
    
    
    NSMutableDictionary *params = [@{@"Name":self.registeredUserNameString,
                                     @"Password":self.registeredPassWordString}mutableCopy];
    
    
    
    
    [ForumWXDataServer requestURL:@"Ledad/LedadUserAdd_api.aspx"
                       httpMethod:@"POST"
                           params:params
                             file:nil
                          success:^(id data){
                              
                              DLog(@"%@",data);
                              NSString *dict= data[@"msg"];
                              //                              NSDictionary *
                              NSLog(@"%@",dict);
                              if([dict isEqualToString:@"0"]){
                                  
                                  [self showAlertView:[Config DPLocalizedString:@"adedit_zc4"]];
                                  [registeredPageview removeFromSuperview];
                                  [LoginPageview removeFromSuperview];
                                  
                              }else {
                                  
                                  [self showAlertView:[Config DPLocalizedString:@"adedit_zc3"]];
                                  
                                  [registeredPageview removeFromSuperview];
                                  [LoginPageview removeFromSuperview];
                                  
                              }
                              
                          } fail:^(NSError *error){
                              
                              NSLog(@"%@",error);
                              [self showAlertView:[Config DPLocalizedString:@"NSString25"]];
                              
                          }];
    
    
    
    
}//提交注册请求




-(void)returnButtonOnClcik
{
    
    [registeredPageview removeFromSuperview];
    
    LoginPageview.hidden = NO;
    
}//返回


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)haveNULL:(NSString *)string{
    
    
    NSRange _range = [string rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        [self showAlertView:[Config DPLocalizedString:@"adedit_zc5"]];
        
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
