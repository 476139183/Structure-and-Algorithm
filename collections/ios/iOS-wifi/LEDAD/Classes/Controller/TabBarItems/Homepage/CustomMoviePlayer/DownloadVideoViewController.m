//
//  视频的下载界面
//  Created by ledmedia on 13-8-16.
//  Copyright (c) 2013年 JianYe. All rights reserved.
#import "DownloadVideoViewController.h"
#import "MyTool.h"
#import "MyToolBar.h"
#import "Config.h"
#import "ASINetworkQueue.h"

#import "SGInfoAlert.h"
//#import "shareItemDBOperation.h"


@interface DownloadVideoViewController ()
@end

@interface DownloadVideoViewController ()
@end

@implementation DownloadVideoViewController
@synthesize VideoItemlistSelected;
@synthesize shareItem;

-(id)initWithVideoItemlist:(NSMutableArray *)VideoItemlist
{
    [super init];
    VideoItemlistSelected= [[NSMutableArray  alloc ]initWithArray:VideoItemlist];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    MyToolBar *toolbar=[[MyToolBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIBarButtonItem *leftbarbtn=[[UIBarButtonItem alloc]
                                 initWithImage:[UIImage imageNamed:@"backitem.png"]
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(backvideoDownloadtosuperview)];
    [leftbarbtn setTintColor:[UIColor whiteColor]];
    NSMutableArray *myToolBarItems = [[NSMutableArray alloc]initWithObjects:leftbarbtn,nil ];
    [toolbar setItems:myToolBarItems animated:YES];
    [self.view addSubview:toolbar];
    
    //下载进度条时不用delegate代理
    if (!networkQueue) {
		networkQueue = [[ASINetworkQueue alloc] init];
	}
	failed = NO;
	[networkQueue reset];
    UIProgressView *progressIndicator = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    [progressIndicator setFrame:CGRectMake(0, 44, self.view.frame.size.width, 20)];
    
	[networkQueue setDownloadProgressDelegate:progressIndicator];
	[networkQueue setRequestDidFailSelector:@selector(VideoFetchFailed:)];
	[networkQueue setShowAccurateProgress:YES];
	[networkQueue setDelegate:self];
    [self.view addSubview:progressIndicator];
    
    ASIHTTPRequest *request;
    
    downloadListScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44,SCREEN_CGSIZE_WIDTH,SCREEN_CGSIZE_HEIGHT-44-44-20)];
    [downloadListScrollView setContentSize:CGSizeMake(SCREEN_CGSIZE_WIDTH, [VideoItemlistSelected count]*50+50)];
    for (int i=0; i<[VideoItemlistSelected count]; i++) {
        NSString *videourl=[[VideoItemlistSelected objectAtIndex:i] objectForKey:@"video_url"];
        DLog(@"videourl=%@",videourl);
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,(i+1)*50, SCREEN_CGSIZE_WIDTH, 30)];
        [titleLabel setText:[[VideoItemlistSelected objectAtIndex:i] objectForKey:@"title"]];
        [downloadListScrollView addSubview:titleLabel];
        
        UIProgressView *videodownprogressview = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        [videodownprogressview setFrame:CGRectMake(0,44+(i+1)*50, SCREEN_CGSIZE_WIDTH, 50)];
        request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:videourl]];
        
        [request setDownloadDestinationPath:[MyTool getVideoFilePath:videourl]];
        
        
        [request setDownloadProgressDelegate:videodownprogressview];
        //区分标示身份的
        [request setUserInfo:[NSDictionary dictionaryWithObject:videourl forKey:@"name"]];
        [networkQueue addOperation:request];
        [networkQueue setQueueDidFinishSelector:@selector(VideoFetchComplete:)];
        [downloadListScrollView addSubview:videodownprogressview];
    }
    [self.view addSubview:downloadListScrollView];
	[networkQueue go];
}

-(void)backvideoDownloadtosuperview
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)VideoFetchComplete:(ASIHTTPRequest *)request
{
    DLog(@"视频下载完成,视频列表的编号shareItem.item_id= %@",shareItem.item_id);
//    shareItemDBOperation *collect = [[shareItemDBOperation alloc]init];
//    if ([collect saveDownloadDataItems:shareItem]) {
//        [SGInfoAlert showInfo:NSLocalizedString(@"NSStringDownloadSuccess",@"下载成功！")
//                      bgColor:[[UIColor darkGrayColor] CGColor]
//                       inView:self.view
//                     vertical:0.7];
//        
//    }
//    
//    [VideoItemlistSelected removeAllObjects];
    
    [self backvideoDownloadtosuperview];
}

- (void)VideoFetchFailed:(ASIHTTPRequest *)request
{
    DLog(@"视频下载出错");
	if (!failed) {
		if ([[request error] domain] != NetworkRequestErrorDomain || [[request error] code] != ASIRequestCancelledErrorType) {
			UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NSStringDownloadFailed", @"下载失败") message:NSLocalizedString(@"NSStringDownloadFailedMessage", "请检查网络，重新下载") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
			[alertView show];
		}
		failed = YES;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
