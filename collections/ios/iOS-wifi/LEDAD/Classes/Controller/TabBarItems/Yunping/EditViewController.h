//
//  EditViewController.h
//  云屏
//
//  Created by LDY on 14-7-30.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface EditViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ASIHTTPRequestDelegate, UIPopoverControllerDelegate>
{
    UITableView *editTableView;
    
    UIImageView *headImageView;
    UITextField *editName;
    UITextField *editTel;
    UITextField *editQQ;
    UITextView *editDescription;
    
    UIActionSheet *sheet;
}

@property (nonatomic, retain) NSString *telString;
@property (nonatomic, retain) NSString *nameString;
@property (nonatomic, retain) NSString *qqString;
@property (nonatomic, retain) NSString *descriptionString;
@property (nonatomic, retain) UIImage *headImage;

@end
