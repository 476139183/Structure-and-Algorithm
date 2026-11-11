//
//  UpgradeViewController.h
//  XCloudsManager
//
//  Created by yixingman on 14-7-14.
//
//

#import <UIKit/UIKit.h>
#import "CircularProgressView.h"
#import "RootVC.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "YXM_FTPManager.h"
#import "AsyncUdpSocketReceiveUpgradeBroadcastIp.h"
#import "AsyncUdpSocketReceiveUpgradeTranscationBroadcastIp.h"
#import "CollapseClick.h"
#import "BFPaperButton.h"
#import "UIColor+BFPaperColors.h"

@interface UpgradeViewController : UIViewController<SubstitutableDetailViewController,ASIHTTPRequestDelegate,UIAlertViewDelegate,UploadResultDelegate,AsyncSocketDelegate,CollapseClickDelegate>
{
    CircularProgressView *myCircularProgressView;
    
    float myProgress;
    
    NSTimer *myTimer;
    
    UILabel *promptLabel;
    
    //升级按钮
    BFPaperButton *myUpgradeButton;
    BFPaperButton *myUpgradeButton1;
    //升级按钮2
    BFPaperButton *myUpgradeButton2;
    //升级按钮3
    BFPaperButton *myUpgradeButton3;
    //升级提示文字
    UILabel *myUpgradePromptLabel;
    
    /*下载压缩包的请求*/
    ASIHTTPRequest *_bookDownloadRequest;
    
    UIProgressView *progressIndicator;
    //记录下载过程中的错误
    BOOL isDownloadingError;
    //检查版本号出错
    BOOL isCheckVersionNoError;
    
    //下载的队列
    ASINetworkQueue *networkQueue;
    
    //需要下载的文件
    NSMutableArray *myURLArray;
    NSMutableArray *myURLArrayV3;
    
    //soket连接
    AsyncSocket *_sendPlayerSocket;
    //是否连接中
    BOOL isConnect;
    
    //当前数据区域的索引
    NSInteger _currentDataAreaIndex;
    //当前数据仓库
    NSMutableArray *_currentDataArray;
    //发送配置文件的总次数
    int totalPage;
    
    //发送给服务端的xml配置文件
    NSString *xmlfilePath;
    //文件的大小
    NSInteger fileSize;
    
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
    
    //发布进度
    UIProgressView *myProgressView;
    
    //等待转换的图片列表
    NSMutableArray *waitFormatImageArray;
    
    //上传文件的索引；
    NSInteger uploadImageIndex;
    
    //等待下载的图片
    NSMutableArray *waitDownloadImageArray;
    
    
    //上传百分比
    UILabel *progressLabel;
    
    //默认图片的数组
    NSMutableArray *defaultImageArray;
    
    //分解图片资源为数据包,读取出错记录
    NSMutableArray *analyzeImageDataErrorPathArray;
    
    //重新连接网络
    BOOL isReconnect;
    
    //当前是否为多屏方案
    BOOL isMultiScreen;
    
    //视频播放区域
    MPMoviePlayerController *movewController;
    
    //图片循环是否是第一次加载
    BOOL isFirstRun;
    
    //是否处于编辑状态
    BOOL isEditProject;
    
    //是否已经加载了
    BOOL isAlreadyLoad;
    
    //素材加载中
    BOOL isLoading;
    
    
    //从升级服务器获取的版本号,本地升级包的版本号
    NSString *myUpgradePackageVersion;

    //ftp管理器
    YXM_FTPManager *_myFtpMgr;

    //文件列表
    NSMutableArray *_myFileListArray;

    //当前文件发送的索引
    NSInteger _fileSendIndex;

    //上传的文件的长度
    long long _sendFileCountSize;

    //上传的文件的总长度
    long long _uploadFileTotalSize;

    AsyncUdpSocketReceiveUpgradeBroadcastIp *_upgradeBroadcast;
    AsyncUdpSocketReceiveUpgradeTranscationBroadcastIp *_transcationBroadcast;


    CollapseClick *myCollapseClick;
    //下载升级包
    UIView *_downloadView;
    UIProgressView *_downloadProgress;
    //上传升级包到云屏
    UIView *_upgradeView;
    UIProgressView *_upgradeProgress;
    //重置云屏
    UIView *_resetView;
    UIProgressView *_resetProgress;
    NSString *version;
}

-(void)createProgressView:(float)myProgressView andFrame:(CGRect)myFrame andSuperView:(UIView *)superView;
@end
