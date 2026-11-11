//
//  ScreenOptionsViewController.h
//  屏体选项的类文件
//
//  Created by LDY on 13-11-26.
//
//

#import <UIKit/UIKit.h>
#import "RootVC.h"
#import "AsyncUdpSocketReceivePlayerBroadcastIp.h"
#import "BFPaperButton.h"
#import "UIColor+BFPaperColors.h"
#import "AsyncSocket.h"
#import "YXM_FTPManager.h"
#import "dyt_OnefastViewController.h"

@class BaseButton;

@interface ScreenOptionsViewController : UIViewController <SubstitutableDetailViewController,UITableViewDataSource,UITableViewDelegate,SelectPhotoDelegate>
{
    UIImageView *backgroundView;
    //终端名称
    UILabel *terminalNameLabel;
    //地址
    UILabel *addressLabel;
    //屏体的表格
    UITableView *_myTableView;
    //刷新按钮
    BFPaperButton *confirmButton;
    //LED屏Wifi密码管理
    BFPaperButton *wifiPasswordMangerButton;
    //修改终端名称
    BFPaperButton *updateNameButton;
    //保存按钮
    BFPaperButton *saveNameButton;

    //容器视图
    UIView *containerView;
    YXM_FTPManager *_ftpMgr;

    //表格的行数
    NSInteger _tableOfRow;

    //监听广播
    AsyncUdpSocketReceiveUpgradeTranscationBroadcastIp *_playerBroadcast;

    //自动刷新IP的定时器
    NSTimer *_myRefreshIPTimer;

    //按钮是否能点击
    BOOL buttonIsClicked;
    
    //--------------------------数据
    NSMutableArray *NameArray;
    NSMutableArray *IPArray;
    //
    BOOL isConnect;
    //soket连接
    AsyncSocket *_sendPlayerSocket;
    
    
}
@property (nonatomic,assign) BOOL istrue;
- (void)refreshIPButton:(BaseButton *)sender;
@end
