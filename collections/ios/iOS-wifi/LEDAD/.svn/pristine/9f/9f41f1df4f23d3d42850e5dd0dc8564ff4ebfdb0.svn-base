//
//  YXM_ RegisteredPage.h
//  LEDAD
//
//  Created by 安静。 on 15/7/1.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PooCodeView.h"
//账号
typedef void(^UserName_text)(NSString *userName_text);

//密码
typedef void(^PassWord_text)(NSString *passWord_text);

//再次输入密码
typedef void(^AgainPassWord_text)(NSString *againPassWord_text);

//message验证码
typedef void(^Message_text)(NSString *message_text);

//确定按钮
typedef void(^DetermineButtonOnClick)(void);

//返回按钮
typedef void(^ReturnButtonOnClick)(void);

@interface YXM_RegisteredPage : UIView<UITextFieldDelegate>

//账号Block属性
@property (nonatomic,copy) UserName_text userName_text;

//密码block属性
@property (nonatomic,copy) PassWord_text passWord_text;

//再次输入密码block属性
@property (nonatomic,copy) AgainPassWord_text againPassWord_text;

//message验证block
@property (nonatomic,copy) Message_text message_text;

//提交block
@property (nonatomic,copy) DetermineButtonOnClick determineButtonOnClick;

//返回按钮
@property (nonatomic,copy) ReturnButtonOnClick returnButtonOnClick;

//账号text
@property (nonatomic,strong) UITextField *userNameTextField;

//密码text
@property (nonatomic,strong) UITextField *passWordTextField;

//再次输入密码text
@property (nonatomic,strong) UITextField *againPassWordTextField;

//message TEXT
@property (nonatomic,strong) UITextField *messageTextField;

//验证码
@property (nonatomic,strong) PooCodeView *pooCodeView;
//确认button
@property (nonatomic,strong) UIButton *determineButton;
//返回button
@property (nonatomic,strong) UIButton *returnButton;

@end
