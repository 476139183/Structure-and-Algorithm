//
//  HomepageViewController.h
//  LED2Buy
//
//  Created by LDY on 14-7-3.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "EScrollerView.h"
#import "ListPullViewController.h"
#import "KKProgressTimer.h"
//云屏
#import "YGPSegmentedController.h"
#import "ImageListViewController.h"
#import "MyProjectListViewController.h"
#import "MRProgressOverlayView.h"
#import "YXM_FTPManager.h"
#import "LayoutYXMViewController.h"
#import "AsyncUdpSocketReceivePlayerBroadcastIp.h"
#import "AsyncUdpSocketReceiveUpgradeBroadcastIp.h"
#import "AsyncUdpSocketReceiveUpgradeTranscationBroadcastIp.h"
#import "PlayView.h"
#import "CTMasterViewController.h"

@class MyButton;
@class NLViewController;
@class SearchViewController;
@class VideosCenterCollectionPullViewController;


@interface HomepageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate, EScrollerViewDelegate, KKProgressTimerDelegate, YGPSegmentedControllerDelegate,MyProjectListSelectDelegate,UITextFieldDelegate,UploadResultDelegate,SelectPhotoDelegate>
{
//    UITableView *homepageTableView;
    //项目列表
    MyProjectListViewController *_myProjectCtrl;

    ASIHTTPRequest *asiHttpRequest;
    ASINetworkQueue *networkQueue;
    
    CTMasterViewController *myMasterCtrl;
    //广告链接数据
    NSMutableArray *adDataArray;
    NSMutableArray *adIntroduceArray;
    
    /**
     *@brief 焦点图的高度
     */
    NSInteger _adModelScrollHeight;
    
    /**
     *@brief 详细页面或列表页面
     */
    ListPullViewController *_detailsController;
    //二级目录的菜单
    NSMutableArray *secondMenuArray;
    
    //语言环境
    NSString* strLanguage;
    //刷新按钮
    UIButton *refreshButton;
    
    SearchViewController *searchVC;
    
    //2014年07月19日17:44:45云屏项目
    NSInteger admoduleHeight;
    //横向侧滑菜单
    YGPSegmentedController * _ygp;
    NSMutableArray *YGPtitleArray;
    NSString *_firstPageUrl;
    //下一页的URL
    NSMutableString *_nextPageUrl;
    NSMutableArray *_newsList;
    ImageListViewController *imageListVC;
    
    //左侧按钮
    UIView *leftBttonView;
    UIButton *newestButton;//最新设计按钮
    UIButton *homePageButton;//显示首页按钮
    UIButton *loginButton;//登录按钮
    UIButton *marketButton;//显示屏体市场页面按钮
    UIButton *selectPhotoButton;//显示选取照片页面按钮
    NLViewController *selectPhotoVC;//选取照片页面

    UIButton *trainingButton;//培训视频页面
    UIButton *ForumButton;//论坛中心页面
    VideosCenterCollectionPullViewController *videoCenterCollectionPullViewCtrl;
    NSUserDefaults *ud;
    
    UILabel *loadingLabel;
    EScrollerView *adEScrollerView;//滚动图片
    
    NSString *currentColumId;
    NSString *currentClickUrl;


    NSTimer *myPublishCompleteTimer;
    //存储用户选择的项目对象
    NSMutableArray *mySelectedProjectArray;
    //当前播放的项目对象
    ProjectListObject *currentPlayProObject;
    //是否是连续播放
    BOOL isContinusPlay;

//    是否在播放
    BOOL isPlay;
    //当前选中的项目的索引
    NSIndexPath *_currentPlayProjIndex;

    //当前播放项目的文件名字
    NSString *_currentPlayProjectFilename;
    //当前播放项目名字
    NSString *_currentPlayProjectName;
    //设置一个清理定时器的定时器，用于项目播放完毕的时候停止画面
    NSTimer *stopPhotoTimer;

    //临时存储项目名称
    NSString *myProjectTextString;

    //当前项目所在路径
    NSString *_currentProjectPathRoot;

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

    //发送给服务端的xml配置文件
    NSString *xmlfilePath;
    //文件的大小
    NSInteger fileSize;
    //发布进度
    UIProgressView *myProgressView;
    //当前数据区域的索引
    NSInteger _currentDataAreaIndex;
    //当前数据仓库
    NSMutableArray *_currentDataArray;
    //发送配置文件的总次数
    int totalPage;
    //是否连接中
    BOOL isConnect;
    //当前发送为配置文件
    BOOL isSendConfig;
    //当前发送为数据文件
    BOOL isSendContent;
    //全部发送完成
    BOOL isAllSend;
    //发送中
    BOOL isSendState;
    //是否完成了数据的上传
    BOOL isComplete;
    //soket连接
    AsyncSocket *_sendPlayerSocket;
    //监听广播
    AsyncUdpSocketReceivePlayerBroadcastIp *_playerBroadcast;
    //网络状态的按钮
    BaseButton *_netStateButton;
    
    BaseButton *_leftviewButton;
    //重新连接网络
    BOOL isReconnect;

    //音乐的名称
    UILabel *musicNameLabel;
    //音乐的播放时间
    UILabel *musicPlaytimeLabel;
    //音乐的路径
    NSString *_musicFilePath;
    //音乐的名称
    NSString *_musicName;
    //音乐的音量
    NSString *_musicVolume;
    //音乐的时间
    NSString *_musicDuration;
    //所有画面的总时间
    float myPhotoTotalDuration;
    //音乐播放的总时间
    float myMusicTotalPlayTime;
    //当前选择区域的索引
    NSInteger _currentSelectIndex;
    //已经添加到项目的素材列表中被选择的索引
    NSInteger _currentSelectRow;
    //项目素材字典,按照区域编号去索引区域内的素材列表
    NSMutableDictionary *_projectMaterialDictionary;
    //设置按钮
    MyButton *settingButton;
}

@end
