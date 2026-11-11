//
//  DYT_ScreenupgradeViewController.h
//  LEDAD
//   更多 －－－升级
//  Created by laidiya on 15/7/22.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootVC.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "YXM_FTPManager.h"
#import "AsyncUdpSocketReceiveUpgradeBroadcastIp.h"
#import "AsyncUdpSocketReceiveUpgradeTranscationBroadcastIp.h"
#import "CollapseClick.h"
#import "BFPaperButton.h"
#import "UIColor+BFPaperColors.h"

#import "DYT_AsyModel.h"
#import "AGAlertViewWithProgressbar.h"
#import "DYT_FTPmodel.h"

@interface DYT_ScreenupgradeViewController : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UploadResultDelegate,AsyncSocketDelegate,myasydelete,UIAlertViewDelegate,ASIHTTPRequestDelegate,ftpprogressdelegate>
{

    UICollectionView *mycollectCV;
    
    NSMutableArray *AddressArr;
    NSMutableArray *NameArr;
    NSMutableArray *myselect;
    
    AsyncUdpSocketReceivePlayerBroadcastIp *_playerBroadcast;
    
    DYT_AsyModel *mymodel;
    
    NSString *version;
    NSTimer *myTimer;
    //检查版本号出错
    BOOL isCheckVersionNoError;
    //从升级服务器获取的版本号,本地升级包的版本号
    NSString *myUpgradePackageVersion;
    
    //需要下载的文件
    NSMutableArray *myURLArray;
    NSMutableArray *myURLArrayV3;
    
    
    NSInteger _currentDataAreaIndex;
    
    ASINetworkQueue *networkQueue;
    //记录下载过程中的错误
    BOOL isDownloadingError;
    
    //ftp管理对象
    YXM_FTPManager *_ftpMgr;
    //文件列表
    NSMutableArray *_myFileListArray;
    //上传的文件的总长度
    long long _uploadFileTotalSize;
    //上传的文件的长度
    long long _sendFileCountSize;
    BOOL unftp;
    BOOL show;

    NSInteger tago;
    NSInteger numberl;
    UIProgressView *progressview;
    
    UIView *firstview;

}
@property (nonatomic,strong) AGAlertViewWithProgressbar *alertViewWithProgressbar;


@end
