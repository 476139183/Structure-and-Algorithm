//
//  PushDetailViewController.h
//  ZDEC
//
//  Created by LDY on 13-9-9.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DataItems;
@class BaseButton;
@class BaseUILabel;
@class MyToolBar;

@interface PushDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    MyToolBar *toolbar;
    
    BaseUILabel *titleLabel;//销售员为<已选客户> 客户为<已选用户>
    
    UIScrollView *customerScrollView;
    UITableView *customerTableView;
    
    BaseUILabel *contentLabel;
    
    UIScrollView *contentScrollView;
    
    BaseButton *confirmPushButton;
    
    UIWebView *webview;
    DataItems *shareItem;
    
    UIScrollView *backgroundScrollView;
}

@property (nonatomic, retain) NSArray *titleList;
@property (nonatomic, retain) UITableView *customerTableView;

- (id)initWithItem:(DataItems*)item andContactItem:(NSArray *)customer;

@end
