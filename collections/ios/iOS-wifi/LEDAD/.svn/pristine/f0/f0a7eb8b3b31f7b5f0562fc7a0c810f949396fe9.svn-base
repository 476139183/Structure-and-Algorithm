//
//  DownLoadSelectViewController.h
//  ZDEC
//  选择你需要下载的视频列表页面
//  Created by LDY on 13-8-29.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
#import "DataItems.h"

@class LEDVideoItem;
@class MyToolBar;

@interface DownLoadSelectViewController : UIViewController<QCheckBoxDelegate>
{
    MyToolBar *downToolBar;
    NSMutableArray *VideoItemlist;
    
    //视频下载的列表
    UIScrollView *videoListScrollView;
    
    DataItems *shareItem;
    //列表的数量
    NSInteger listIndexNum;
}
@property (nonatomic,retain) NSMutableArray *videosArray;
@property (nonatomic,retain) DataItems *shareItem;
@property (nonatomic,assign) NSInteger listIndexNum;
@end
