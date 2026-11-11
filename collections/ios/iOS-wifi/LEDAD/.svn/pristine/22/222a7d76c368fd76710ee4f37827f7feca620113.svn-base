//
//  ImageListViewController.h
//  云屏
//
//  Created by LDY on 7/21/14.
//  Copyright (c) 2014 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataItems.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "MyProjectListViewController.h"
#import "KKProgressTimer.h"
#import "MRProgressOverlayView.h"
#import "YXM_FTPManager.h"
#import "MRProgressOverlayView.h"

@interface ImageListViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, ASIHTTPRequestDelegate,MyProjectListSelectDelegate,KKProgressTimerDelegate,UploadResultDelegate>
{
    NSDictionary *itemsDataDictionary;
    UIView *headView;
    UIImageView *mainImageView;//作品缩略图
    UIButton *backToMainButton;//返回按钮
    UILabel *productionTitleLabel;//产品名称
    NSString *productionTitle;
    NSString *productionIntroduce;
    UIImageView *authorImageView;//设计师头像
    UILabel *authorNameLabel;//设计师名称
    UILabel *productionDateLabel;
    UIButton *aboutDesignerButton;//查看设计师作品按钮
    UIImageView *aboutButtonCurve;
    NSString *designerProcuctionUrl;//设计师相关作品的链接
    NSString *nameString;//设计师名称
    NSString *telString;//设计师电话
    NSString *qqString;//设计师QQ
    NSString *descriptionString;//设计师介绍
    NSString *photoUrl;//设计师头像
    UIButton *aboutCommentButton;//转到论坛页面按钮
    
    UICollectionView *thumbnailCV;//图片网格视图
    
    NSMutableArray *thumbnailList;
    NSMutableArray *bigImageList;
    NSMutableArray *imageEntities;
    
    NSString *itemId;
    NSString *parentId;

    /**
     *  项目内的文件列表
     */
    NSMutableArray *projectFileListArray;
    NSInteger projectDownloadListCount;

    //提示右滑动隐藏列表的标签
    UILabel *promptSwipeHidenLabel;

    //是否已经提示
    BOOL _isShowPrompt;

    ASINetworkQueue *_myNetworkQueue;

    UIButton *aboutDesignerButton2;//上传播放项目
    UIButton *aboutDesignerButton3;//下载播放项目

    MyProjectListViewController *myProjectCtrl;

    NSArray *myFilenameArray;
    NSArray *xmlfilenameArray;

    DataItems *_yxmDataItem;

    NSInteger _countPu;

    //浮动的进度条
    MRProgressOverlayView *myMRProgressView;

    //当前项目所需要发送到服务端的文件列表
    NSMutableArray *_waitForUploadFilesArray;

    //ftp管理对象
    YXM_FTPManager *_ftpMgr;

    //当前文件发送的索引
    NSInteger _fileSendIndex;

    //上传的文件的长度
    long long _sendFileCountSize;

    //上传的文件的总长度
    long long _uploadFileTotalSize;
    //当前数据区域的索引
    NSInteger _currentDataAreaIndex;
}

@property (nonatomic, retain) NSString *mainImageName;


/** 请求图片数据 */
- (void)requestImageData:(DataItems *)oneDataItem;
/** 跳转页面请求图片数据 */
- (void)requestImageDataFromUrl:(NSString *)urlString;

@end
