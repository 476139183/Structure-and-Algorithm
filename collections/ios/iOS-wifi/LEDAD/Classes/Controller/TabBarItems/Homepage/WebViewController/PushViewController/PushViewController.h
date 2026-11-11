//
//  PushViewController.h
//  ZDEC
//  推送资源的页面
//  Created by LDY on 13-9-9.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"
@class PushDetailViewController;

@class DataItems;
@class BaseButton;
@class MyToolBar;

@interface PushViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    
    PushDetailViewController *pushDetailViewController;
    UIScrollView *scrollView;
    

    
    //销售员所属的客户的列表
    UITableView *salerOfCustomerTableView;
    
    //销售员的key
    NSString *keyString;
    
    //获得客户列表的请求
    ASIHTTPRequest *httpRequest_sale;
    
    //存储获取过来的客户列表数据
    NSMutableArray *salesMutableArray;
    NSMutableArray *filterDataArray;
    
    BaseButton *filterCompanyButton;
    BaseButton *filterPositionButton;
    
    NSMutableArray *menuItems1;
    NSMutableArray *menuItems2;
    
    NSString *filterCompanyStr;
    NSString *filterPositionStr;
    
    
    
    MyToolBar *toolbar;
    DataItems *shareItem;

}
@property (nonatomic,retain) NSString *keyString;


- (id)initWithItem:(DataItems*)item;

@end
