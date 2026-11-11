//
//  RegisterViewController.h
//  SideBarDemo
//
//  Created by LDY on 13-8-13.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIWebViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    //邮箱地址
    UITextField *emailField;
    //手机号码
    UITextField *phonenumField;
    //密码
    UITextField *passwordField;
    //确认密码
    UITextField *confirmField;
    //公司名称
    UITextField *companyField;
    //昵称
    UITextField *nicknameField;
    //地址
    UITextField *addressField;
    //注册成功
    NSDictionary *messageDict;
    
//    UIWebView *regWebView;
}

@end
