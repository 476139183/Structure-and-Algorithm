//
//  DYT_Hardwaredetectionview.h
//  LEDAD
//   硬件检测
//  Created by laidiya on 15/7/20.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXM_FTPManager.h"
#import "Common.h"
#import "Config.h"
#import "ASIHTTPRequest.h"

#import "GRRequestsManager.h"

@interface DYT_Hardwaredetectionview : UIView<GRRequestsManagerDelegate,ASIHTTPRequestDelegate>
{
    //ftp管理对象
    YXM_FTPManager *_ftpMgr;
    
    GRRequestsManager *requestsManager1;


}
-(id)initWithFrame:(CGRect)frame andname:(NSString *)name;


//云屏名称
@property(nonatomic,strong)NSString *yunpingname;
//亮度
@property(nonatomic,strong)NSMutableArray *Brightnessarray;

@property(nonatomic,assign)BOOL showbutton;


@end
