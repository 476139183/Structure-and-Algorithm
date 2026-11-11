//
//  ModifyPassViewController.h
//  ZDEC
//
//  Created by yixingman on 9/11/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseButton;
@class BaseUILabel;
@class BaseTextField;

@interface ModifyPassViewController : UIViewController<UITextFieldDelegate>
{
    BaseUILabel *originalLabel;
    BaseTextField *originalTextField;
    BaseButton *originalButton;
    
    BaseUILabel *new1Label;
    BaseTextField *new1TextField;
    BaseButton *new1Button;
    
    BaseUILabel *new2Label;
    BaseTextField *new2TextField;
    BaseButton *new2Button;
    
    BaseButton *confirmButton;
}

@end
