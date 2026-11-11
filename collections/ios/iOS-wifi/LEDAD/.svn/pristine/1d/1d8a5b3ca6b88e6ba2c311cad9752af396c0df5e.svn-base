//
//  DownLoadSelectViewController.m
//  ZDEC
//  选择你需要下载的视频列表页面
//  Created by LDY on 13-8-29.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "DownLoadSelectViewController.h"
#import "LEDVideoItem.h"
#import "Config.h"
#import "DownloadVideoViewController.h"
#import "MyTool.h"
#import "MyToolBar.h"
#import "Toast+UIView.h"

@interface DownLoadSelectViewController ()

@end

@implementation DownLoadSelectViewController
@synthesize videosArray;
@synthesize shareItem;
@synthesize listIndexNum;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        VideoItemlist=[[NSMutableArray alloc]init];
        if (self) {
            CGSize viewSize = self.view.frame.size;
            float toolbarHeight = 44;
            CGRect toolbarFrame = CGRectMake(0,viewSize.height-toolbarHeight,viewSize.width,toolbarHeight);
            
            downToolBar = [[MyToolBar alloc] initWithFrame:toolbarFrame];
            
            downToolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth
            |
            UIViewAutoresizingFlexibleLeftMargin
            |
            UIViewAutoresizingFlexibleRightMargin
            |
            UIViewAutoresizingFlexibleTopMargin;
            
            
            //确定下载按钮
            UIButton *myButton0 = [UIButton buttonWithType:UIButtonTypeCustom];
            myButton0.frame = CGRectMake(2.5, 2.5, 40, 40);
            [myButton0 setTitle:NSLocalizedString(@"NSStringYes",@"确定") forState:UIControlStateNormal];
            [myButton0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [myButton0 setTitle:NSLocalizedString(@"NSStringYes",@"确定") forState:UIControlStateHighlighted];
            [myButton0 addTarget:self action:@selector(ItembuttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [myButton0 setTag:0];
            UIBarButtonItem *button0 = [[UIBarButtonItem alloc] initWithCustomView:myButton0];
            [button0 setWidth:SCREEN_CGSIZE_WIDTH/2];
            
            
            UIButton *myButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
            myButton1.frame = CGRectMake(2.5, 2.5, 40, 40);
            [myButton1 setTitle:NSLocalizedString(@"NSStringNO",@"取消") forState:UIControlStateNormal];
            [myButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [myButton1 setTitle:NSLocalizedString(@"NSStringNO",@"取消") forState:UIControlStateHighlighted];
            [myButton1 addTarget:self action:@selector(ItembuttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [myButton1 setTag:1];
            UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithCustomView:myButton1];
            [button1 setWidth:SCREEN_CGSIZE_WIDTH/2];
            
            
            
            NSArray *buttons = [[NSArray alloc] initWithObjects:button0,button1,nil];
            
            [downToolBar setItems:buttons animated:YES];
            [self.view addSubview:downToolBar];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


/**
 *@brief 创建带复选框的视频列表
 */
-(void)loadCheckBox{
    if (videoListScrollView!=nil) {
        [videoListScrollView removeFromSuperview];
        videoListScrollView=nil;
    }
    if (VideoItemlist!=nil) {
        [VideoItemlist removeAllObjects];
    }
    
    videoListScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT-44-44-20)];
    [videoListScrollView setBackgroundColor:[UIColor whiteColor]];
    [videoListScrollView setContentSize:CGSizeMake(SCREEN_CGSIZE_WIDTH,60+(listIndexNum)*50)];
    NSInteger checkBoxIndex=0;
    for (int j=0;j<[videosArray count];j++) {
        LEDVideoItem *oneLedVideoItem = [videosArray objectAtIndex:j];
        for (int i=0; i<oneLedVideoItem.video_video.count; i++) {
            checkBoxIndex+=1;
            QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self];
            _check1.frame = CGRectMake(20, 30+checkBoxIndex*50, SCREEN_CGSIZE_WIDTH-30, 50);
            //判断视频是否已经下载
            NSString *isDownloadVideo=@"";
            DLog(@"video_url = %@",[[oneLedVideoItem.video_video objectAtIndex:i] objectForKey:@"video_url"]);
            if ([MyTool isExistsVideoFile:[[oneLedVideoItem.video_video objectAtIndex:i] objectForKey:@"video_url"]]) {
                isDownloadVideo = @":(已下载)";
            }
            [_check1 setTitle:[[NSString alloc]initWithFormat:@" %@ %@",[NSString stringWithFormat:@"%@",[[oneLedVideoItem.video_video objectAtIndex:i] objectForKey:@"title"]],isDownloadVideo] forState:UIControlStateNormal];
            [_check1 setTag:(checkBoxIndex+TAG_VIEDO_DOWNLOAD_START)];
            [_check1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [_check1.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
            _check1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _check1.titleLabel.numberOfLines = 0;//上面两行设置多行显示
            [videoListScrollView addSubview:_check1];
            [_check1 release];
        }
    }
    [self.view addSubview:videoListScrollView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)viewDidAppear:(BOOL)animated{
    [self loadCheckBox];
}

#pragma mark - QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    DLog(@"\ndid tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
    NSInteger videoIndex = checkbox.tag-TAG_VIEDO_DOWNLOAD_START;
    NSInteger index=0;
    NSDictionary *voo;
    for (int m=0;m<[videosArray count];m++) {
        LEDVideoItem *oneLedVideoItem = [videosArray objectAtIndex:m];
        for (int n=0;n<[oneLedVideoItem.video_video count]; n++) {
            index+=1;
            if (index==videoIndex) {
                voo = [oneLedVideoItem.video_video objectAtIndex:n];
                break;
            }
        }
    }
    if (checked) {
        [VideoItemlist addObject:voo];
    }else{
        [VideoItemlist removeObject:voo];
    }
    
}


-(void)ItembuttonClick:(id)sender
{
    
    switch ([sender tag]) {
        case 0:
        {
            DLog(@"点击确定下载");
            DLog(@"点击确定时需要判断是否有选中项目,VideoItemlist = %@",VideoItemlist);
            if ([VideoItemlist count]>0) {
                DownloadVideoViewController *downloadvideoviewcontroller=[[DownloadVideoViewController alloc]initWithVideoItemlist:VideoItemlist];
                [downloadvideoviewcontroller setShareItem:shareItem];
                [self.navigationController pushViewController:downloadvideoviewcontroller animated:NO];
            }else{
                [self.view makeToast:NSLocalizedString(@"NSStringPleaseSelectList",@"请选择需要下载的视频") duration:3.0 position:@"center"];
            }
            
        }
            break;
        case 1:
        {
            DLog(@"点击取消");
            [self.navigationController popViewControllerAnimated:NO];
        }
            break;
        default:
            break;
    }
}

-(void)backvideoDownloadtosuperview
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
