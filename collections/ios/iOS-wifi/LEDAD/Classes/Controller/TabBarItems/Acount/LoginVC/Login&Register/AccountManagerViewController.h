//
//  AccountManagerViewController.h
//  ZDEC
//
//  Created by yixingman on 9/11/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseButton.h"
#import "BaseTextField.h"
#import "BaseUILabel.h"
#import "ASIHTTPRequest.h"
@class LoginViewController;
@class ModifyPassViewController;
//@class LHHEditUserInfoViewController;
@class CompanyContactsEntity;

@interface AccountManagerViewController : UIViewController
{
    ASIHTTPRequest *httpRequest_sale;
    
    BaseButton *exitLoginButton;
    BaseButton *modifyLoginButton;
    LoginViewController *loginViewController;
    
    BaseButton *headImageButton;
    BaseUILabel *nameLabel;
    BaseUILabel *positionLabel;
    
    ModifyPassViewController *modifyViewController;
    UINavigationController *modifyNav;
    
//    LHHEditUserInfoViewController *editUserInfoCtrl;
    UINavigationController *editUserInfoNav;
    
    CompanyContactsEntity *oneCompanyContactEnti;
}
@end
