//
//  AccountViewController.h
//  LED2Buy
//
//  Created by LDY on 14-7-3.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginViewController;
@class AccountManagerViewController;

@interface AccountViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *AccountTableView;
    LoginViewController *loginVC;//登陆页面
    AccountManagerViewController *accountMVC;//修改密码
}

@end

