//
//  LoginViewController.h
//  SideBarDemo
//
//  Created by LDY on 13-8-9.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "ConfirmViewController.h"
#import "MHTextField.h"

@class MainRightViewController;
@class RegisterViewController;
@class BaseButton;

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    MHTextField *usernameField;
    MHTextField *passwordField;
    
    UIImageView *emailImageView;
    UIImageView *passwordImageView;
    
    CGRect frameRect;
    
    NSString *postString;
    
    RegisterViewController *registerViewController;
    UINavigationController *registerNav;
    
    ConfirmViewController *confirmViewController;
    UINavigationController *confirmNav;
    
    MainRightViewController *mrViewController;
    UINavigationController *mrNav;
    
    
    NSDictionary *confirmDict;
    
    //登录按钮
    BaseButton *_loginButton;
}
@property (nonatomic,retain) MainRightViewController *mrViewController;
@property (nonatomic,retain) NSDictionary *confirmDict;

//- (id) initWithFrame;
//- (id) initWithFramewithInfo:(NSString *)userInfo;

extern LoginViewController *loginViewController;
@end
