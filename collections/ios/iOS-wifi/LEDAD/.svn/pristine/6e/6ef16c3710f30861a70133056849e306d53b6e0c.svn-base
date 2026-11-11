//
//  YXM_uploadViewController.h
//  LEDAD
//
//  Created by 安静。 on 15/7/6.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STAlertView.h"
#import "AGAlertViewWithProgressbar.h"
@protocol MRProgressOverlayTableViewControllerDelegate;

//上传
typedef void(^UploadButtonOnClick)(void);

//下载
typedef void(^DownloadButtonOnClick)(void);

//注销
typedef void(^LogoutButtonOnClick)(void);

//删除
typedef void(^DeleteButtonOnClick)(void);

@interface YXM_uploadViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<MRProgressOverlayTableViewControllerDelegate> delegate;

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
