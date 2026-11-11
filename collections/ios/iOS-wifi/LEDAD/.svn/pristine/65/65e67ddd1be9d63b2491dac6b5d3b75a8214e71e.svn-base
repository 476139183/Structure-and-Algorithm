//
//  DYT_LoginPage.h
//  LEDAD
//  登陆界面 
//  Created by laidiya on 15/7/22.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PooCodeView.h"

//账号
typedef void(^UserName_text)(NSString *userName_text);
//密码
typedef void(^PassWord_text)(NSString *passWord_text);

//登陆
typedef void(^LoginButtonOnClick)(void);

//注册
typedef void(^RegisteredButtonOnClick)(void);

//message验证码
typedef void(^Message_text)(NSString *message_text);


@interface DYT_LoginPage : UIView<UITextFieldDelegate>
//账号
@property (nonatomic,copy) UserName_text userName_text;

//密码
@property (nonatomic,copy) PassWord_text passWord_text;

//登陆
@property (nonatomic,copy) LoginButtonOnClick loginButtonOnClick;

//注册
@property (nonatomic,copy) RegisteredButtonOnClick registeredButtonOnClick;

//message验证block
@property (nonatomic,copy) Message_text message_text;

//message TEXT
@property (nonatomic,strong) UITextField *messageTextField;

//验证码
@property (nonatomic,strong) PooCodeView *pooCodeView;

//用户名
@property (nonatomic,strong) UITextField *usernameTextField;
//密码
@property (nonatomic,strong) UITextField *passwordTextField;

//登陆按钮
@property (nonatomic,strong) UIButton *loginButton;

//注册按钮
@property (nonatomic,strong) UIButton *registeredButton;
//注销第一响应者
-(void)resignAllTextFieldResponder;

@end
