//
//  AppDelegate.h
//  LEDAD
//
//  yixingman on 11-10-22.
//  ledmedia All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXM_FTPManager.h"
#import "DYT_HomepageViewController.h"
@class SplitVCDemoViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate,UIAlertViewDelegate,UploadResultDelegate> {
    UIWindow *window;
    SplitVCDemoViewController *viewController;

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
}

@property (nonatomic,retain) SplitVCDemoViewController *rootCtrl;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SplitVCDemoViewController *viewController;

@end
