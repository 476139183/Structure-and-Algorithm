//
//  BBSDetailViewController.h
//  LED2Buy
//
//  Created by LDY on 14-7-17.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface BBSDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate, UIScrollViewDelegate>
{
    UITableView *bbsDetailTableView;
    UIScrollView *bbsDetailScrollView;
    UITextView *textView;
    UIImageView *leftImageView;
    UILabel *dateLabel;
    UILabel *textLabel;
    
    NSMutableArray *followArray;
    
    UIView *commentView;
    UITextField *commentTextField;
    UIButton *commentButton;
}


@property (nonatomic, retain) NSString *BBSTitle;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *publishtime;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *headimg;
@property (nonatomic, retain) NSString *contentid;

@property (nonatomic, retain) NSString *item_id;

@end
