//
//  VideoViewController.h
//  从视频列表点击进入的界面
//  Created by yxm on 2014年03月24日10:54:45.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DataColumns.h"
#import "ASIHTTPRequest.h"
#import "VideoDirectoryTableViewController.h"
#import "VideoDataFilter.h"

@class LEDVideoItem;
@class MyToolBar;
@class DataItems;

@interface VideoViewController : UIViewController<ASIHTTPRequestDelegate,PlayOfOneVideoInListDelegate>{
    /**
     *@brief 页面基本数据
     */
    DataItems *_shareItem;
    /**
     *@brief 视频详细页的视频集
     */
    NSMutableArray *_videosArray;
    
    /**
     *@brief 视频播放的路径
     */
    NSMutableString *_mediaPlayPathString;
    /**
     *@brief 是否是从收藏中出来的
     */
    NSString *isFromFavorites;
    
    /**
     *@brief 视频播放控制器
     */
    MPMoviePlayerViewController *_myMPCtrl;
    /**
     *@brief 记录竖屏时的Frame
     */
    CGRect _portraitViewFrame;
    
    /**
     *@brief 一集视频的ID
     */
    NSString *_myVideoID;
    /**
     *@brief 视屏的总集数
     */
    NSInteger _videosCount;
    /**
     *@brief 正在播放的索引
     */
    NSInteger _videoIndex;
    /**
     *@brief 视频播放列表视图控制器
     */
    VideoDirectoryTableViewController *_videoListCtrl;
    //判断网络状态
    NSString *netState;
    
    NSString *videoType;
    MPMoviePlayerViewController *myMoviePlayerCtrl;
    NSInteger zoom;
    
    //分享视频
    NSString *shareVideoUrl;
    NSString *shareVideoTitle;
    
    NSInteger playListNextSection;
    
    NSInteger playListNextSectionOfRow;
    UIButton *zoomInButton;
    UIButton *zoomOutButton;
    
    UIButton *backToMainButton;//返回按钮
    MPVolumeView *volumeControl;//音量控制控件
    
    CGRect keyWindowFrame;
    
    BOOL online;//是否联网
    
}
@property (nonatomic,retain) NSString *isFromFavorites;
@property (nonatomic,retain) DataItems *shareItem;
@property (nonatomic,retain) NSMutableArray *videosArray;
- (void)loadVideoView:(DataItems*)item;
/**
 *@brief 返回上一主页
 */
-(void)backToSuperView;
@end
