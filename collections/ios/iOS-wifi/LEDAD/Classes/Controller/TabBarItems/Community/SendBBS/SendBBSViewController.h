//
//  SendBBSViewController.h
//  LED2Buy
//
//  Created by LDY on 14-7-18.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendBBSViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>
{
    UILabel *titleLabel;
    UILabel *contentLabel;
    UITextField *titleTextField;
    UITextField *contentTextField;
    UITextView *contentTextView;
    UIToolbar *toolbar;//隐藏键盘
}

@property (nonatomic, retain) NSString *parent_id;

@end
