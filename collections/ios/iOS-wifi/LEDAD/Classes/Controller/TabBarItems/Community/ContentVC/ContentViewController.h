//
//  ContentViewController.h
//  LED2Buy
//
//  Created by LDY on 14-7-16.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKProgressTimer.h"
#import "ASIHTTPRequest.h"
#import "MJRefresh.h"

@interface ContentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, KKProgressTimerDelegate, ASIHTTPRequestDelegate>
{
    UITableView *contentTableView;
    NSMutableArray *contentArray;
    NSMutableArray *tmpContentArray;
    NSURL *requestUrl;
    //下拉刷新
    MJRefreshHeaderView *header;
    //上拉加载
    MJRefreshFooterView *_footer;
    
    //下拉刷新
    MJRefreshBaseView *mjRefreshBaseView;
    
    //下一页的URL
    NSMutableString *_nextPageUrl;
}

- (void)requestData:(NSString *)m_id;

@end
