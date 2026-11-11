//
//  ASITestControllerViewController.h
//  LEDTraing
//
//  Created by ledmedia on 13-8-16.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "DataItems.h"
@class ASINetworkQueue;
@interface DownloadVideoViewController : UIViewController<ASIProgressDelegate>
{
    //下载的队列
    ASINetworkQueue *networkQueue;
    //被选择的视频列表
    NSMutableArray *VideoItemlistSelected;
    //下载队列的容器
    UIScrollView *downloadListScrollView;
    
    BOOL failed;
    
    DataItems *shareItem;
}
@property(nonatomic,strong) NSMutableArray *VideoItemlistSelected;
@property (nonatomic,retain) DataItems *shareItem;
-(id)initWithVideoItemlist:(NSMutableArray *)VideoItemlist;
@end
