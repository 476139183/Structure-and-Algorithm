//
//  DYT_FTPmodel.h
//  LEDAD
//
//  Created by laidiya on 15/7/14.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
#import "YXM_FTPManager.h"
#import "DYT_AsyModel.h"
#import "Project.h"
@protocol ftpprogressdelegate <NSObject>
//反馈 进度条消失
-(void)returemytag:(NSInteger )tag;

-(void)returegress:(float)flo andtag:(NSInteger)tag andstr:(NSString *)str;
-(void)showAlertView:(NSString *)title andtag:(NSInteger)tag;
@end

@interface DYT_FTPmodel : NSObject<UploadResultDelegate,myasydelete>
{
    
    
     NSString *stringip;
    NSMutableArray *xmldataarray;
    
//    区分 硬件升级和 连续播放
    BOOL unknow;
    
    
     YXM_FTPManager *_ftpMgr;
    
    //当前项目所需要发送到服务端的文件列表
    NSMutableArray *_waitForUploadFilesArray;
    //当前数据区域的索引
    NSInteger _currentDataAreaIndex;
    //当前项目所在路径
    NSString *_currentProjectPathRoot;
    
    //是否是连续播放
    BOOL isContinusPlay;

    DYT_AsyModel *myasy;
//    xiazai de
    
    
   
    
    //文件的大小

    NSInteger fileSize;
    //发送给服务端的xml配置文件
    NSString *xmlfilePath;

    //存储用户选择的项目对象
    NSMutableArray *mySelectedProjectArray;
    
    
    //上传的文件的总长度
    long long _uploadFileTotalSize;

    //上传的文件的长度
    long long _sendFileCountSize;


    BOOL canle;
    
//    区别云片 升级 和 发送项目
    NSInteger tago;
    //文件列表
    NSMutableArray *_myFileListArray;
    NSString *version;
    BOOL unftp;
    BOOL show;
    
    NSMutableDictionary *parm;
    BOOL yunduan;


}

@property(nonatomic,strong)id<ftpprogressdelegate>mydelegate;

@property(nonatomic,assign)NSInteger mytag;
-(void)ftp:(NSString *)ipstr and:(NSMutableArray *)xmlarray;

//取消ftp
-(void)cancle;
-(void)yunftp:(NSString *)ipisarrat;
-(void)yunftpshangchuang:(NSMutableArray *)Project;

-(void)uploadRequstMovPath:(NSString *)movPath movName:(NSString *)movName xmlPath:(NSString *)xmlPath xmlName:(NSString *)xmlName Material:(NSString *)materialName andgourpid:(NSString *)mygroupid;

@end
