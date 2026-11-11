//
//  SearchViewController.h
//  LED2Buy
//
//  Created by LDY on 14-7-11.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchDatabase;

@interface SearchViewController : UIViewController<UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    UISearchBar *mySearchBar;//搜索
//    UISearchDisplayController *searchController;//test
    UITableView *historyTableView;//搜索历史列表
    NSMutableArray *searchContents;//搜索内容
    SearchDatabase *searchDatabase;
    UITableView *keywordsListTV;//关键字列表
    NSString *keywordsUrl;//搜索产品的接口
}

@end
