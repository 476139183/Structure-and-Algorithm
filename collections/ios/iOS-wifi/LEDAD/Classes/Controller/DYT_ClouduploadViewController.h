//
//  DYT_ClouduploadViewController.h
//  LEDAD
//
//  Created by laidiya on 15/7/22.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STAlertView.h"
#import "AGAlertViewWithProgressbar.h"
#import "DYT_progresstableview.h"
@protocol MRProgressOverlayTableViewControllerDelegate;

//上传
typedef void(^UploadButtonOnClick)(void);

//下载
typedef void(^DownloadButtonOnClick)(void);

//注销
typedef void(^LogoutButtonOnClick)(void);

//删除
typedef void(^DeleteButtonOnClick)(void);


@interface DYT_ClouduploadViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


{
//    NSString *nametime;
//    NSString   *stringpath;
//    NSString *xmlfilePath;
    DYT_progresstableview *dyt_tablewview;
    NSInteger upnumber;

    UITableView *xmltabview;
    
    UITableView *locaxmltable;
     
}

@property (nonatomic, assign) id<MRProgressOverlayTableViewControllerDelegate> delegate;

@property(nonatomic,strong)NSString *usename;
//上传block
@property (nonatomic,copy) UploadButtonOnClick uploadButtonOnClick;

//下载block
@property (nonatomic,copy) DownloadButtonOnClick downloadButtonOnClick;

//注销block
@property (nonatomic,copy) LogoutButtonOnClick logoutButtonOnClick;

//删除block
@property (nonatomic,copy) DeleteButtonOnClick deleteButtonOnClick;

//云数据tableview
@property (nonatomic,strong) UITableView *dataTableview;

//本地tableview
@property (nonatomic,strong) UITableView *localTableview;
//stAlertView
@property (nonatomic, strong) STAlertView *stAlertView;
//NewGroup名字
//@property (nonatomic,strong) NSString *newGroupName;
@property (nonatomic,strong) AGAlertViewWithProgressbar *alertViewWithProgressbar;


@end
