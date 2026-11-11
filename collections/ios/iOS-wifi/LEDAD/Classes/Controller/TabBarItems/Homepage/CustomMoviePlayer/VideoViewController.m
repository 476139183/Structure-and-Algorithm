//
//  RootViewController.m
//  AVFoundation
//  从视频列表点击进入的界面,包含视频播放界面和视频播放列表
//  Created by LDY on 13-7-25.
//  Copyright (c) 2013年 LDY. All rights reserved.
//
#import "VideoViewController.h"
#import "LEDVideoItem.h"
#import "MyToolBar.h"
#import "Config.h"
#import "LEDVideoItemsList.h"
#import "UIButton+WebCache.h"
#import "DownloadVideoViewController.h"
#import "MyTool.h"
#import "DownLoadSelectViewController.h"
#import "SGInfoAlert.h"
//#import "shareItemDBOperation.h"
//#import "PushViewController.h"
//#import "AGApiViewControllers.h"
#import "DataItems.h"
#import "DataColumns.h"
#import <math.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "GeneralDatabaseOperation.h"
#import "Toast+UIView.h"
#import "AHAlertView.h"
//#import "LoginViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"




@implementation VideoViewController
@synthesize isFromFavorites;
@synthesize shareItem = _shareItem;
@synthesize videosArray = _videosArray;

- (id)init
{
    self = [super init];
    if (self) {
        //分享视频的URL
        if (!shareVideoUrl) {
            shareVideoUrl = [[NSString alloc] init];
            shareVideoTitle = [[NSString alloc] init];
        }
        //本页面的基础数据
        if (!_shareItem) {
            _shareItem = [[DataItems alloc]init];
        }
        //视频集合
        if (!_videosArray) {
            _videosArray=[[NSMutableArray alloc]initWithCapacity:0];
        }
//        //顶部导航栏
//        [MyTool insertTopNavgationView:self titleString:NSLocalizedString(@"NSString35",@"口袋中庆") topOffSet:0];
//        
//        //设置底部工具栏
//        [MyTool insertBottomToolBar:self];
//        
//        //增加分享的引用
//        [MyTool insertShareSDKButton:self];
    }
    return self;
}

/**
 *@brief 插入播放控件到指定视图内
 *       在所添加的ViewController里添加zoomInMovieButtonClick事件
 */
-(MPMoviePlayerViewController *)insertMoviePlayerView:(UIViewController *)containtViewCtrl containtView:(UIView *)containtView{
    
    //初始化视频播放器
    myMoviePlayerCtrl = [[MPMoviePlayerViewController alloc]init];
    [myMoviePlayerCtrl.view setFrame:CGRectMake(0, 0, containtView.frame.size.width, containtView.frame.size.height)];
    
    myMoviePlayerCtrl.moviePlayer.movieSourceType=MPMovieSourceTypeFile;
    [myMoviePlayerCtrl.moviePlayer setScalingMode:MPMovieScalingModeAspectFit];
    [myMoviePlayerCtrl.moviePlayer setRepeatMode:MPMovieRepeatModeNone];
    [myMoviePlayerCtrl.moviePlayer setControlStyle:MPMovieControlStyleEmbedded];
    [myMoviePlayerCtrl.moviePlayer setFullscreen:NO animated:YES];
    [[myMoviePlayerCtrl.moviePlayer view] setTag:TAG_MOVIE_PLAY_VIEW];
    [containtView addSubview:[myMoviePlayerCtrl.moviePlayer view]];
    
    //视频放大控制按钮
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"]) {
        zoom = 63;
    }else {
        zoom = 43;
    }
    UIButton *oldButton = (UIButton *)[self.view viewWithTag:TAG_ZOOM_IN_BUTTON];
    if (!oldButton) {
        UIButton *zoomInMoviePlayerButton = [[UIButton alloc]initWithFrame:CGRectMake(containtView.frame.size.width-zoom,containtView.frame.size.height-43,43,43)];
        [zoomInMoviePlayerButton setImage:[UIImage imageNamed:@"movie_play_zoom_in.png"] forState:UIControlStateNormal];
        [zoomInMoviePlayerButton addTarget:containtViewCtrl action:@selector(zoomInMovieButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [zoomInMoviePlayerButton setTag:TAG_ZOOM_IN_BUTTON];
//        [containtView addSubview:zoomInMoviePlayerButton];2014年08月18日15:43:45
    }else{
        [oldButton setHidden:NO];
    }
    
    
    // 视频播放完或者在presentMoviePlayerViewControllerAnimated下的Done按钮被点击响应的通知。
    [[NSNotificationCenter defaultCenter] addObserver:containtViewCtrl
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:myMoviePlayerCtrl.moviePlayer];
    
    [containtViewCtrl.view addSubview:containtView];
    
    return myMoviePlayerCtrl;
}

/**
 *@改变视屏播放视图的大小
 */
-(void)changeMoviePlayerViewFrame:(BOOL)isLandscape{
    NSInteger offSet=0;
    if (OS_VERSION_FLOAT < 7.0f) {
        offSet = 20;
    }else{
        offSet = 0;
    }
    UIView *moviePlayerContaintView = [self.view viewWithTag:TAG_MOVIE_PLAY_CONTAINT_VIEW];
    CGRect fullScreenRect = CGRectMake(0, 0, _portraitViewFrame.size.height+offSet, _portraitViewFrame.size.width-20);
    CGRect littleWindowRect = CGRectMake( 0, 0, _portraitViewFrame.size.width, _portraitViewFrame.size.height/3);
    
    UIView *topNavView = [self.view viewWithTag:TAG_TOP_NAVGATION_VIEW];
    UIView *bottomToolBarView = [self.view viewWithTag:TAG_BOTTOM_TOOL_BAR];
    [topNavView setHidden:isLandscape];
    [bottomToolBarView setHidden:isLandscape];
    [_videoListCtrl.tableView setHidden:isLandscape];
    
    if (isLandscape) {
        [self.navigationController.view setFrame:fullScreenRect];
        [self.view setFrame:fullScreenRect];
        [moviePlayerContaintView setFrame:fullScreenRect];
        [_myMPCtrl.view setFrame:fullScreenRect];
        [[_myMPCtrl.moviePlayer view] setFrame:fullScreenRect];
        
        //缩小按钮
        zoomOutButton = (UIButton *)[self.view viewWithTag:TAG_ZOOM_OUT_BUTTON];
        [zoomOutButton setHidden:NO];
        [zoomOutButton setFrame:CGRectMake(0,0,43,43)];
        //放大按钮
        zoomInButton = (UIButton *)[self.view viewWithTag:TAG_ZOOM_IN_BUTTON];
        [zoomInButton setHidden:YES];
        [_videoListCtrl.tableView setAlpha:0];
    }else{
        DLog(@"竖屏模式");
        [self.navigationController.view setFrame:CGRectMake(0, 0, _portraitViewFrame.size.width, _portraitViewFrame.size.height-20)];
        [self.view setFrame:_portraitViewFrame];
        [moviePlayerContaintView setFrame:CGRectMake(0, 44, littleWindowRect.size.width, littleWindowRect.size.height)];
        [_myMPCtrl.view setFrame:littleWindowRect];
        [[_myMPCtrl.moviePlayer view] setFrame:littleWindowRect];
        
        //缩小按钮
        zoomOutButton = (UIButton *)[self.view viewWithTag:TAG_ZOOM_OUT_BUTTON];
        [zoomOutButton setHidden:YES];
        //放大按钮
        zoomInButton = (UIButton *)[self.view viewWithTag:TAG_ZOOM_IN_BUTTON];
        [zoomInButton setHidden:NO];
        [zoomInButton setFrame:CGRectMake(moviePlayerContaintView.frame.size.width-43,moviePlayerContaintView.frame.size.height-43,43,43)];
        [_videoListCtrl.tableView setAlpha:1];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    if (DEVICE_IS_IPAD) {
//        self.view.frame = CGRectMake(0, 0, SCREEN_CGSIZE_HEIGHT, SCREEN_CGSIZE_WIDTH);
//    }else {
        self.view.frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - 60);
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    backToMainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backToMainButton.frame = CGRectMake(2, 2, 40, 40);
    [backToMainButton setBackgroundImage:[UIImage imageNamed:@"backToMainButton"] forState:UIControlStateNormal];
    [backToMainButton setBackgroundColor:[UIColor blackColor]];
    [backToMainButton addTarget:self action:@selector(backToSuperView) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backToMainButton];

    //竖屏时的Frame
    _portraitViewFrame = self.view.frame;
    //设置屏幕常亮
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //视频播放器的容器
    UIView *moviePlayView = [[UIView alloc]initWithFrame:CGRectMake( 0, 0, SCREEN_CGSIZE_HEIGHT * 2/3, SCREEN_CGSIZE_WIDTH)];
    [moviePlayView setTag:TAG_MOVIE_PLAY_CONTAINT_VIEW];
    [moviePlayView setUserInteractionEnabled:YES];
    //增加视频播放器
    _myMPCtrl = [self insertMoviePlayerView:self containtView:moviePlayView];
    [self.view addSubview:moviePlayView];
    [self.view addSubview:backToMainButton];
    
    //视频播放列表的容器
//    UIView *movieListView = [[UIView alloc]initWithFrame:CGRectMake(0, moviePlayView.frame.origin.y + moviePlayView.frame.size.height, SCREEN_CGSIZE_HEIGHT, SCREEN_CGSIZE_WIDTH - SCREEN_CGSIZE_WIDTH/3 - [Config currentNavigateHeight])];
    UIView *movieListView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_CGSIZE_HEIGHT * 2/3, 0, SCREEN_CGSIZE_HEIGHT * 1/3 - 70, SCREEN_CGSIZE_WIDTH)];
    [movieListView setTag:TAG_MOVIE_LIST_CONTAINT_VIEW];
    [self.view addSubview:movieListView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieEventFullscreenHandler:)
                                                 name:MPMoviePlayerWillEnterFullscreenNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieEventExitFullscreenHandler:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:nil];
    
    _myMPCtrl.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
//    _myMPCtrl.moviePlayer.controlStyle = MPMovieControlStyleNone; //隐藏视频控制
    
//    2014年09月04日19:11:48音量控件
    volumeControl = [[MPVolumeView alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_HEIGHT *2/3 - 130, 300, 200, 20)];
    volumeControl.transform = CGAffineTransformMakeRotation(-M_PI/2);
    [self.view addSubview:volumeControl];
    
//    if (!DEVICE_IS_IPAD) {
        moviePlayView.frame = CGRectMake(0, 40, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT * 1/2 - 40);
        movieListView.frame = CGRectMake(0, SCREEN_CGSIZE_HEIGHT * 1/2, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT * 1/2 - 60);
        volumeControl.frame = CGRectMake(SCREEN_CGSIZE_WIDTH - 30, 80, 20, 150);
//    }
}

#pragma mark - UIResponder
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    DLog(@"touchesEnded");
//    [backToMainButton setHidden:(!backToMainButton.hidden)];
//    [volumeControl setHidden:(!volumeControl.hidden)];
}


- (void)movieEventFullscreenHandler:(NSNotification*)notification {
//    [_myMPCtrl.moviePlayer setFullscreen:NO animated:YES];
//    [_myMPCtrl.moviePlayer setControlStyle:MPMovieControlStyleEmbedded];
    keyWindowFrame = [[UIApplication sharedApplication] keyWindow].frame;
    DLog(@"%f\n%f\n%f\n%f",keyWindowFrame.origin.x, keyWindowFrame.origin.y, keyWindowFrame.size.width, keyWindowFrame.size.height);
//    if (!DEVICE_IS_IPAD) {
        [[UIApplication sharedApplication] keyWindow].transform = CGAffineTransformMakeRotation(M_PI/2);
        [[UIApplication sharedApplication] keyWindow].frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT);
//    }
}
- (void)movieEventExitFullscreenHandler:(NSNotification*)notification {
    [[UIApplication sharedApplication] keyWindow].transform = CGAffineTransformMakeRotation(0);
    [[UIApplication sharedApplication] keyWindow].frame = keyWindowFrame;
}



/**
 *@brief 底部工具栏调用的方法
 */



/**
 *@brief 添加视频播放列表
 */
-(VideoDirectoryTableViewController *)insertMovieListView:(UIViewController *)contaitViewCtrl containtView:(UIView*)containtView{
    VideoDirectoryTableViewController *oneCapterCtrl = [[VideoDirectoryTableViewController alloc]initWithStyle:UITableViewStylePlain];
    [oneCapterCtrl setDataSourceArray:_videosArray];
    [oneCapterCtrl setSectionHeadHeight:40];
    [oneCapterCtrl setRowHeadHeight:50];
    [oneCapterCtrl setTableFrame:CGRectMake(0,0,containtView.frame.size.width,containtView.frame.size.height)];
    [oneCapterCtrl setDelegate:self];
    [containtView addSubview:oneCapterCtrl.view];
    return oneCapterCtrl;
}

//返回上一主页
-(void)backToSuperView
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
//    if (self.navigationController.navigationBar.hidden) {
//        [self.navigationController.navigationBar setHidden:YES];
//    }
//    if ([isFromFavorites isEqualToString:@"isFromFavorites"]) {
//        [self.navigationController.navigationBar setHidden:NO];
//        [self.view removeFromSuperview];
//    }else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }

    if (OS_VERSION_FLOAT >= 8.0) {
        [self.view removeFromSuperview];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//-( void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    DLog(@"横竖屏切换触发事件");
////    [self changeMoviePlayerViewFrame:UIInterfaceOrientationIsLandscape(toInterfaceOrientation)];
//}


-(void)sendRquest:(NSString *)URLString{
    NSURL *url = [NSURL URLWithString:URLString];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    online = YES;
    UIView *oldView = [self.view viewWithTag:TAG_REFRESH_VIEW];
    [oldView removeFromSuperview];
    
    [_videosArray setArray:[VideoDataFilter refreshVideoData:request]];
    //完成数据请求，并且成功解析数据的情况下刷新视屏列表和视屏播放
    DLog(@"_videosArray = %@",_videosArray);
    
    LEDVideoItem *oneVideoItem = ((LEDVideoItem*)[_videosArray firstObject]);
    DLog(@"我要的视频输出======%@",oneVideoItem.video_video);
    
    //如果东西为空
    if (oneVideoItem.video_video==NULL) {
        UIAlertView *aleview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"NSStringDataError"] delegate:self cancelButtonTitle:[Config  DPLocalizedString:@"NSStringYes"] otherButtonTitles: nil];
        [aleview show];
        return;
    }
//2014年05月23日10:15:22
    if (oneVideoItem.video_h) {
        videoType = [[NSString alloc] initWithString:oneVideoItem.video_h];
    }else {
        videoType = [[NSString alloc] initWithString:@"0"];
    }
//    if ([videoType isEqualToString:@"1"]) {
//        [myMoviePlayerCtrl.moviePlayer setScalingMode:MPMovieScalingModeAspectFill];
//    }else {
//        [myMoviePlayerCtrl.moviePlayer setScalingMode:MPMovieScalingModeAspectFit];
//    }
    if (oneVideoItem) {
        NSDictionary *oneVideoDictionary = [oneVideoItem.video_video firstObject];
        _myVideoID = oneVideoItem.video_id;
        if ((oneVideoDictionary) && ([oneVideoDictionary isKindOfClass:[NSDictionary class]])) {
            //开始播放视频列表的第一个视频
            
            [self mediaPlayWithURL:[oneVideoDictionary objectForKey:KEY_VIDEO_VIDEO_URL]];
            
        }
    }
    
    UIView *movieListContaintView = [self.view viewWithTag:TAG_MOVIE_LIST_CONTAINT_VIEW];
    _videoListCtrl = [self insertMovieListView:self containtView:movieListContaintView];
    
    
    for (LEDVideoItem *oneData in _videosArray) {
        _videosCount += [oneData.video_video count];
    }
    
    if ([_videosArray count]>0) {
        //如果可以的话
        NSLog(@"可以的数据 加到view里面去 ");
        [_videoListCtrl.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    
    online = NO;
    
//进入我的视频下载页面自动播放已下载的视频
//    [MyTool insertRefreshDataButton:self.view containtCtrl:self];
    UIView *oldView = [self.view viewWithTag:TAG_REFRESH_VIEW];
    [oldView removeFromSuperview];
    
    [_videosArray setArray:[VideoDataFilter refreshVideoData:request]];
    //完成数据请求，并且成功解析数据的情况下刷新视屏列表和视屏播放
    if (_videosArray ==nil) {
        [MyTool insertRefreshDataButton:self.view containtCtrl:self];
        return;
    }
    LEDVideoItem *oneVideoItem = ((LEDVideoItem*)[_videosArray firstObject]);
    
    //如果东西为空
    if (oneVideoItem.video_video==NULL) {
        UIAlertView *aleview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"NSStringDataError"] delegate:self cancelButtonTitle:[Config  DPLocalizedString:@"NSStringYes"] otherButtonTitles: nil];
        [aleview show];
        return;
    }

    
//2014年05月23日10:15:22
    if (oneVideoItem.video_h) {
        videoType = [[NSString alloc] initWithString:oneVideoItem.video_h];
    }else {
        videoType = [[NSString alloc] initWithString:@"0"];
    }
//    if ([videoType isEqualToString:@"1"]) {
//        [myMoviePlayerCtrl.moviePlayer setScalingMode:MPMovieScalingModeAspectFill];
//    }else {
//        [myMoviePlayerCtrl.moviePlayer setScalingMode:MPMovieScalingModeAspectFit];
//    }
    if (oneVideoItem) {
        NSDictionary *oneVideoDictionary = [oneVideoItem.video_video firstObject];
        _myVideoID = oneVideoItem.video_id;
        if ((oneVideoDictionary) && ([oneVideoDictionary isKindOfClass:[NSDictionary class]])) {
            //开始播放视频列表的第一个视频
            [self mediaPlayWithURL:[oneVideoDictionary objectForKey:KEY_VIDEO_VIDEO_URL]];
        }
        
    }
    
    
    UIView *movieListContaintView = [self.view viewWithTag:TAG_MOVIE_LIST_CONTAINT_VIEW];
    _videoListCtrl = [self insertMovieListView:self containtView:movieListContaintView];
    
    
    for (LEDVideoItem *oneData in _videosArray) {
        _videosCount += [oneData.video_video count];
    }
    if ([_videosArray count]>0) {
        [_videoListCtrl.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }

}

/**
 *@brief 数据加载失败时刷新数据按钮调用的方法
 */
-(void)refreshDataButtonClick{
    //重新发送请求
    [self sendRquest:[MyTool stringCovertToUTF8:_shareItem.item_url]];
}

- (void)loadVideoView:(DataItems*)item
{
    
    
    
//    //2014年05月23日10:15:22
//    videoType = [[NSString alloc] initWithString:item.item_title];
//    DLog(@"videoType = %@",videoType);
//    if ([videoType isEqualToString:@"培训教程"]) {
//        [myMoviePlayerCtrl.moviePlayer setScalingMode:MPMovieScalingModeAspectFill];
//    }else {
//        [myMoviePlayerCtrl.moviePlayer setScalingMode:MPMovieScalingModeAspectFit];
//    }
    
//    self.view.frame = CGRectMake(0, [Config topOffsetHeight], SCREEN_CGSIZE_WIDTH, [Config currentOniPhoneHeight]);
    DLog(@"self.view.frame.origin.y = %f, SCREEN_CGSIZE_HEIGHT = %f",self.view.frame.origin.y, SCREEN_CGSIZE_HEIGHT);
    DLog(@"item = %@",[item description]);
     /****************段雨田****/
    
    if (!_shareItem) {
        _shareItem = [[DataItems alloc]init];
    }
    
    [self setShareItem:item];
    
    //分享视频title
    shareVideoTitle = item.item_title;
    
    //加载视频播放列表
    [self sendRquest:[MyTool stringCovertToUTF8:item.item_url]];
    
    _videoIndex = 0;//重置_videoIndex
}

/**
 *@brief 执行视频播放动作
 */
-(void)mediaPlayWithURL:(NSString *)URLString
{
    DLog(@"当前播放视频的URLString = %@",URLString);
    shareVideoUrl = URLString;
    _mediaPlayPathString = [[NSMutableString alloc]initWithCapacity:0];
    if ([MyTool isExistsVideoFile:URLString]) {
        [_mediaPlayPathString setString:[MyTool getVideoFilePath:URLString]];
    }else
    {
        [_mediaPlayPathString setString:URLString];
    }
    
    
    NSURL *playURL;
    if ([_mediaPlayPathString hasPrefix:@"http://"]) {
        playURL = [NSURL URLWithString:_mediaPlayPathString];
        [MyTool writeVideoCacheRequestUrl:_mediaPlayPathString];
    }else{
        playURL = [NSURL fileURLWithPath:_mediaPlayPathString];
    }
    
    [_myMPCtrl.moviePlayer setContentURL:playURL];
    [_myMPCtrl.moviePlayer play];

//    测试AVPlayer
//    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:URLString] options:nil];
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
//    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//    playerLayer.frame = CGRectMake(0, 0, 300, 300);
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    
//    [self.view.layer addSublayer:playerLayer];
//    [player play];
}


/**
 *@brief 视频横屏按钮被点击后的处理
 */
-(void)zoomInMovieButtonClick:(UIButton*)sender{
    //隐藏放大按钮
    self.navigationController.navigationBar.hidden = YES;
    zoomInButton = (UIButton*)[self.view viewWithTag:TAG_ZOOM_IN_BUTTON];
    [zoomInButton setHidden:(!zoomInButton.hidden)];
    
    //强制旋转视频播放视图
    UIView *moviePlayerContaintView = [self.view viewWithTag:TAG_MOVIE_PLAY_CONTAINT_VIEW];
    
//2014年05月23日09:57:37
    DLog(@"videoType = %@",videoType);
    if ([videoType isEqualToString:@"1"]) {
        [moviePlayerContaintView setTransform:CGAffineTransformMakeRotation(0)];
    }else {
        [moviePlayerContaintView setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    }
//    [moviePlayerContaintView setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    [moviePlayerContaintView setFrame:CGRectMake(0,[Config topOffsetHeight],SCREEN_CGSIZE_WIDTH,[Config currentOniPhoneHeight])];
    
    //隐藏顶部导航栏
    UIView *topNavView = [self.view viewWithTag:TAG_TOP_NAVGATION_VIEW];
    [topNavView setHidden:YES];
    
    //隐藏底部工具栏
    UIView *bottomToolBarView = [self.view viewWithTag:TAG_BOTTOM_TOOL_BAR];
    [bottomToolBarView setHidden:YES];
    
    //隐藏视频列表视图
    UIView *playListView = [self.view viewWithTag:TAG_MOVIE_LIST_CONTAINT_VIEW];
    [playListView setHidden:YES];
    [_videoListCtrl.view setHidden:YES];
    [playListView setAlpha:0];
    [_videoListCtrl.tableView setHidden:YES];
    
    //添加缩小按钮
    [self insertZoomOutButton:[_myMPCtrl.moviePlayer view]];
    
}



///**
// *@brief 隐藏状态栏
// */
//-(void)hiddenStatusBar{
//    //设置状态栏是否隐藏的标示符
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setBool:YES forKey:STATUS_BAR_STAT];
//    //通知根视图中的方法隐藏状态栏
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGE_STATUSBAR_STATE object:nil];
//}
//
///**
// *@brief 显示状态栏
// */
//-(void)showStatusBar{
//    //设置状态栏是否隐藏的标示符
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setBool:NO forKey:STATUS_BAR_STAT];
//    //通知根视图中的方法隐藏状态栏
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGE_STATUSBAR_STATE object:nil];
//}

/**
 *@brief 视频缩小按钮,手动从横屏状态切换为竖屏状态
 */
-(void)insertZoomOutButton:(UIView *)containtView{
    UIButton *oldButton = (UIButton *)[self.view viewWithTag:TAG_ZOOM_OUT_BUTTON];
    if (!oldButton) {
// 2014年05月23日10:49:43
        zoomOutButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH-zoom, SCREEN_CGSIZE_HEIGHT-43, 43, 43)];
        [zoomOutButton setTag:TAG_ZOOM_OUT_BUTTON];
        [zoomOutButton setImage:[UIImage imageNamed:@"movie_play_zoom_out.png"] forState:UIControlStateNormal];
        [zoomOutButton addTarget:self action:@selector(zoomOutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:zoomOutButton];
    }else{
        [oldButton setHidden:NO];
    }
}



/**
 *@brief 点击视频缩小按钮后,执行从横屏到竖屏的动作
 */
-(void)zoomOutButtonClick:(UIButton*)sender{
    self.navigationController.navigationBar.hidden = NO;
    //隐藏缩小按钮
    zoomOutButton = (UIButton *)[self.view viewWithTag:TAG_ZOOM_OUT_BUTTON];
    [zoomOutButton setHidden:(!zoomOutButton.hidden)];
    
    //显示放大按钮
    zoomInButton = (UIButton *)[self.view viewWithTag:TAG_ZOOM_IN_BUTTON];
    [zoomInButton setHidden:(!zoomInButton.hidden)];
    
    
    //强制旋转视频播放视图
    UIView *moviePlayerContaintView = [self.view viewWithTag:TAG_MOVIE_PLAY_CONTAINT_VIEW];
    [moviePlayerContaintView setTransform:CGAffineTransformMakeRotation(M_PI*2)];
    [moviePlayerContaintView setFrame:CGRectMake(0, [Config currentNavigateHeight], SCREEN_CGSIZE_WIDTH,SCREEN_CGSIZE_HEIGHT/3)];
    
    //显示顶部导航栏
    UIView *topNavView = [self.view viewWithTag:TAG_TOP_NAVGATION_VIEW];
    [topNavView setHidden:NO];
    
    //显示底部工具栏
    UIView *bottomToolBarView = [self.view viewWithTag:TAG_BOTTOM_TOOL_BAR];
    [bottomToolBarView setHidden:NO];
    
    //显示视频列表视图
    UIView *playListView = [self.view viewWithTag:TAG_MOVIE_LIST_CONTAINT_VIEW];
    [playListView setHidden:NO];
    [_videoListCtrl.view setHidden:NO];
    [playListView setAlpha:1];
    [_videoListCtrl.tableView setHidden:NO];
    
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    DLog(@"视图消失后,取消屏幕常亮");
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}


//显示提示登录的警告窗
//-(void)alertViewLogin{
//    NSString *title = @"";
//	NSString *message = [[NSString alloc]initWithFormat:@"\n\n\n%@",NSLocalizedString(@"NSStringYouNotlogin", @"您尚未登陆，请登陆！")];
//    //自定义的提示框
//	AHAlertView *alert = [[AHAlertView alloc] initWithTitle:title message:message];
//	[alert setCancelButtonTitle:NSLocalizedString(@"NSStringNO",@"取消") block:^{
//        alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
//        NSLog(@"点击了取消");
//	}];
//    
//    UIImageView *viewe = [[UIImageView alloc]initWithFrame:CGRectMake((alert.frame.size.width/2)-(45/2),15.0,45.0,45.0)];
//    viewe.image = [UIImage imageNamed:@"crytoastimage.png"];
//    
//    [alert addSubview:viewe];
//	[alert addButtonWithTitle:NSLocalizedString(@"NSStringYes",@"确定") block:^{
//        [self jumpToLoginViewController];
//    }];
//	[alert show];
//}

//跳转到登陆页面
//-(void)jumpToLoginViewController{
//    LoginViewController *loginViewController= [[LoginViewController alloc]init];
//    isHereToLogin = @"FromServerRepairCenter";
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setObject:@"ispresentViewController" forKey:@"ispresentViewController"];
//    [ud setObject:@"NO" forKey:@"fromServersCenter"];
//    [self presentViewController:loginViewController animated:YES completion:nil];
//}



-(void)movieStateChangeCallback:(NSNotification*)notify  {
    DLog(@"点击播放器中的播放/ 暂停按钮响应的通知");
}

/**
 *@brief 自动播放下一个视频,并且记录播放状态
 */
-(void)playNextVideo{
    DLog(@"记录播放状态");
    //获得正在播放的章序号
    NSInteger playListCurrentSection=0;
    for (int i=0;i<[_videosArray count];i++) {
        LEDVideoItem *oneDataItem = [_videosArray objectAtIndex:i];
        if ([oneDataItem.video_id isEqualToString:_myVideoID]) {
            playListCurrentSection = i;
            //当前的总行数
            NSInteger currentRowCount = [oneDataItem.video_video count];
            //当前行向前偏移1
            _videoIndex = _videoIndex +1;
            //计算下一集的章序号
            if ((playListCurrentSection+1)>[_videosArray count]) {
                //如果当前章节向前偏移1之后大于总章节数，回到第一章
                playListNextSection = 0;
            }else{
                if (_videoIndex>=currentRowCount) {
                    //如果当前行向前偏移1之后大于当前总行数，则进入下一个章
                    playListNextSection = playListCurrentSection + 1;
                    if (playListNextSection>=[_videosArray count]) {
                        //如果当前章节向前偏移1之后大于总章节数，回到第一章
                        playListNextSection = 0;
                        NetworkStatus netStatus = [Reachability GobalcurrentReachabilityStatus];
                        if (netStatus == NotReachable) {
                            DLog(@"无网络时直接返回");
                            return;
                        }
                    }
                }else{
                    //否则在当前章继续播放
                    playListNextSection = playListCurrentSection;
                }
            }
            //如果当前行向前偏移1之后大于当前总行数，则进入下一个章的第0行
            if (_videoIndex>=currentRowCount) {
                _videoIndex = 0;
            }
            playListNextSectionOfRow = _videoIndex;
        }
    }
    if (([_videosArray count]>0)&&(playListNextSection<[_videosArray count])) {
        
        LEDVideoItem *tempDataItem = [_videosArray objectAtIndex:playListNextSection];
        if (tempDataItem) {
            NSDictionary *oneVideoDict = [tempDataItem.video_video objectAtIndex:playListNextSectionOfRow];
            if ([oneVideoDict isKindOfClass:[NSDictionary class]]) {
                [self playWithOneVideoOfDictionary:oneVideoDict videoID:tempDataItem.video_id videoIndex:playListNextSectionOfRow];
                
                //播放状态
                GeneralDatabaseOperation *dbOperation = [[GeneralDatabaseOperation alloc]init];
                NSInteger video_done_index = playListNextSectionOfRow;
                if (playListNextSectionOfRow == 0) {
                    video_done_index = tempDataItem.video_video.count;
                }
                [dbOperation saveVideoPlayState:_myVideoID videoIndex:[[NSString alloc] initWithFormat:@"%d",video_done_index - 1] videoState:@"video_done"];
                [_videoListCtrl.tableView reloadData];
                
                DLog(@"playListNextSectionOfRow = %d",playListNextSectionOfRow);
                [_videoListCtrl.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:playListNextSectionOfRow inSection:playListNextSection] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            }
        }
    }
}


-(void)movieFinishedCallback:(NSNotification*)notify{
    DLog(@"视频播放完或者在presentMoviePlayerViewControllerAnimated下的Done按钮被点击响应的通知");
//判断网络状态，若有网则连续播放
    switch ([Reachability GobalcurrentReachabilityStatus]) {
        case 2:
            netState = NET_STATUS_WLAN;
            break;
        case 1:
            netState = NET_STATUS_WIFI;
            break;
        default:
            netState = NET_STATUS_OFF;
            break;
    }
    
    DLog(@"网络状态netStatusStr= %@",netState);
    if (![netState isEqualToString:NET_STATUS_OFF]) {
        [self playNextVideo];
    }
}

/**
 *@brief 视频播放列表的回调方法
 */
-(void)playWithOneVideoOfDictionary:(NSDictionary *)oneVideoDict videoID:(NSString *)videoID videoIndex:(NSInteger)videoIndex{
    NSString *playURLString = [oneVideoDict objectForKey:KEY_VIDEO_VIDEO_URL];
    [self mediaPlayWithURL:playURLString];
    _myVideoID = videoID;
    _videoIndex = videoIndex;
}


//-(void)ItembuttonClick:(id)sender
//{
//    switch (([sender tag]-TAG_MYTOOLBAR)) {
//        case 0:
//        {
//            DLog(@"收藏");
//            if (![MyTool CheckIsLogin]) {
//                //判断是否登录了
//                [self alertViewLogin];
//                return;
//            }
//            shareItemDBOperation *collect = [[shareItemDBOperation alloc]init];
//            [_shareItem setItem_iscollect:@"1"];
//            [_shareItem setItem_column_structure:@"video"];
//            NSString *promptInfoString = @"";
//            if ([collect saveDataItems:_shareItem]) {
//                promptInfoString = NSLocalizedString(@"NSStringCollectSuccess",@"收藏成功！");
//            }else{
//                promptInfoString = NSLocalizedString(@"NSStringSuccessfullycanceled",@"取消收藏成功！");
//            }
//            [SGInfoAlert showInfo:promptInfoString bgColor:[[UIColor darkGrayColor] CGColor] inView:self.view vertical:0.7];
//        }
//            break;
//        case 1:
//        {
//            DLog(@"下载");
//            if (![MyTool CheckIsLogin]) {
//                //判断是否登录了
//                [self alertViewLogin];
//                return;
//            }
//            DownLoadSelectViewController *downlaodSelectViewController = [[DownLoadSelectViewController alloc]init];
//            [self.shareItem setItem_isdownload:@"1"];
//            [self.shareItem setItem_column_structure:@"video"];
//            [downlaodSelectViewController setVideosArray:_videosArray];
//            [downlaodSelectViewController setShareItem:_shareItem];
//            /*传入视频列表的数量*/
//            [downlaodSelectViewController setListIndexNum:_videosCount];
//            [self.navigationController pushViewController:downlaodSelectViewController animated:NO];
//        }
//            break;
//        case 2:
//        {
//            DLog(@"分享");
//            [AGApiViewControllers shareApi:_shareItem];
////            [AGApiViewControllers shareVideoUrl:shareVideoUrl shareVideoTitle:shareVideoTitle];
//        }
//            break;
//        case 3:
//        {
//            DLog(@"推送资源");
//            if (![MyTool CheckIsLogin]) {
//                //判断是否登录了
//                [self alertViewLogin];
//                return;
//            }
//            PushViewController *puchViewController = [[PushViewController alloc] initWithItem:_shareItem];
//            [self.navigationController pushViewController:puchViewController animated:YES];
//            [puchViewController release];
//        }
//            break;
//        default:
//            break;
//    }
//}



-(void)dealloc{
    DLog(@"调用销毁的方法");
    [super dealloc];
}
@end
