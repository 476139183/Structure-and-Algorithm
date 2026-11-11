//
//  DYT_rightbaseview.h
//  LEDAD
//   右弹框
//  Created by laidiya on 15/7/20.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXM_FTPManager.h"
//@protocol myrightdelete<NSObject>
//-(void)returerightview:(NSInteger )mytag;
//@end
typedef void(^Rightbuttonblock)(NSInteger buttontag);
@interface DYT_rightbaseview : UIView<UploadResultDelegate>
{

    
     BOOL isgaiming;
    //ftp管理对象
    YXM_FTPManager *_ftpMgr;
    //上传的文件的长度
    long long _sendFileCountSize;



}

@property(nonatomic,copy)Rightbuttonblock rightblock;

//-(void)writeFile:(NSString*)filename Data:(NSString*)data;
//-(void)ftpuser1;
//@property(nonatomic,strong)id<myrightdelete>delegate;

@end
