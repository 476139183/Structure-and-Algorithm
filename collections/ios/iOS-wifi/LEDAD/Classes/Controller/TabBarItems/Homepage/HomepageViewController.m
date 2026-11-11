//
//  HomepageViewController.m
//  LED2Buy
//   手机版LEDAD
//  Created by LDY on 14-7-3.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "HomepageViewController.h"
#import "HomepageTableViewCell.h"
#import "MyTool.h"
#import "MainDataJTOA.h"
#import "MainDataEntity.h"
#import "ADdetailViewController.h"
#import "FirstMenuDataFilter.h"
#import "Config.h"
#import "SecondMenuDataFilter.h"
#import "VideosCenterCollectionPullViewController.h"
#import "DataColumns.h"
#import "DataCategoriesList.h"
#import "DataColumnsList.h"
#import "SearchViewController.h"
#import "DataItems.h"
#import "ImageListViewController.h"
#import "MyButton.h"
#import "LoginViewController.h"
#import "ProductionsViewController.h"
#import "AppDelegate.h"
#import "VideosCenterCollectionPullViewController.h"
#import "NLViewController.h"
#import "LEDAD_TAG.h"
#import "MyProjectListViewController.h"
#import "GDataXMLNode.h"
#import "XMLDictionary.h"
#import "YXM_WiFiManagerViewController.h"
#import "ChenXuNeedDemos.h"
#import "CX_SelectIPViewController.h"
#import "HOMEViewController.h"
#import "SDPieLoopProgressView.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "ZipArchive.h"
#import "CX_SaveViewController.h"


@interface HomepageViewController ()<UITableViewDataSource,UITableViewDelegate,CTAssetsPickerControllerDelegate>
{
    ProductionsViewController *myProductionsVC;


    UIPageControl * pageControl;

    NSArray *fileNameArray;

    UIButton *buttonUpData;
    UIButton *buttonDown;
    UIButton *buttonCeShiXiaZai;
    UIButton *buttonDelete;
    UIButton *buttonInitial;
    SDPieLoopProgressView *loopProgressView;
    NSInteger num;
    
//    选路由的界面
    UIView *addview;
    
    
    CX_SelectIPViewController * _cx;

}


@property (strong,nonatomic)   PlayView * thePlayer;
@property (strong,nonatomic)  AVPlayer *avPlayer;



@end

@implementation HomepageViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        DLog(@"初始化代码");
        if (!adDataArray) {
            adDataArray = [[NSMutableArray alloc]init];
            adIntroduceArray = [[NSMutableArray alloc] init];
        }
        //广告焦点图的高度
        _adModelScrollHeight = ((DEVICE_IS_IPAD) ? MAIN_AD_MODEL_HEIGHT : MAIN_AD_MODEL_HEIGHT_IPHONE);

        //待发送的文件列表
        _waitForUploadFilesArray = [[NSMutableArray alloc]init];

        //数据是否已经全部发送完毕
        isAllSend = NO;

        //是否发送完成
        isComplete = NO;

        isPlay = NO;

        //项目素材字典,按照区域编号去索引区域内的素材列表
        _projectMaterialDictionary = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(void)initdata{
    ipAddressArr = [[NSMutableArray alloc]init];
    ipNameArr = [[NSMutableArray alloc]init];
    selectIpArr = [[NSMutableArray alloc]init];
    selectNameArr  = [[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"即将出现");
    if (addview.frame.origin.x==0&&!DEVICE_IS_IPAD) {
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in self.view.subviews) {
                [view setFrame:CGRectMake(view.frame.origin.x-50, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
            }
        }];

    }
   
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initdata];
    secondMenuArray = [[NSMutableArray alloc]init];
    DLog(@"\n%d\n%f\n%f",DEVICE_IS_IPAD, SCREEN_CGSIZE_HEIGHT, SCREEN_CGSIZE_WIDTH);
    // Do any additional setup after loading the view.
    currentColumId = [[NSString alloc] init];//记录点击量的栏目id
    //刷新按钮
    refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.frame = CGRectMake(0, 0, 60, 60);
    [refreshButton setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    refreshButton.tag = TAG_REFRESH_BUTTON;
    [self.view addSubview:refreshButton];


    if (DEVICE_IS_IPAD) {
//        平板 版
        refreshButton.center = CGPointMake(SCREEN_CGSIZE_HEIGHT/2, SCREEN_CGSIZE_WIDTH/2);
        [self loadLeftButtonView];

            [self loadData];


    }else {
        //手机版
        refreshButton.center = CGPointMake(SCREEN_CGSIZE_WIDTH/2, SCREEN_CGSIZE_HEIGHT/2);
        [self addhuadong];
        [self addbutton];
        refreshButton.hidden = YES;
        [self loadLeftButtonView];

        [self showProjectpage:marketButton];
    }
       //    refreshButton.hidden = YES;

    //加载数据
//    [self loadData];

    //    [self initView];

    //显示加载图片中...
    //    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_HEIGHT/2 - 150, SCREEN_CGSIZE_WIDTH/2 - 20, 300, 50)];
    //    loadingLabel.font = [UIFont systemFontOfSize:18];
    //    loadingLabel.backgroundColor = [UIColor clearColor];
    //    loadingLabel.text = @"图片加载中...";
    //    loadingLabel.textAlignment = NSTextAlignmentCenter;
    //    [self.view addSubview:loadingLabel];

    //左侧按钮
//    [self loadLeftButtonView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertProductionsVC) name:NOTI_ADD_PRODUCTION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initButtonColor) name:NOTI_CHANGE_BUTTONCOLOR object:nil];//切换按钮颜色


    //    [self initView];
//    self.view.backgroundColor = [UIColor darkGrayColor];
//
//    [self initButton];
//
//    [self haveOrNohave];
//
//    [self initView];

    num = 0;
    

}

//************************************/////////////////////////////////////////////


-(void)initButton
{

    //刷新按钮
    buttonUpData = [[UIButton alloc]initWithFrame:CGRectMake(100, 100 ,100, 50)];
    [buttonUpData setTitle:@"刷新" forState:0];
    buttonUpData.backgroundColor = [UIColor grayColor];
    [buttonUpData addTarget:self action:@selector(updataButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    buttonUpData.hidden = YES;
    [self.view addSubview:buttonUpData];



    //下载按钮
    buttonDown = [[UIButton alloc]initWithFrame:CGRectMake(900, 100, 100, 50)];
    [buttonDown setTitle:@"配置路径" forState:0];
    buttonDown.backgroundColor = [UIColor grayColor];
    [buttonDown addTarget:self action:@selector(downButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    buttonDown.hidden = YES;
    [self.view addSubview:buttonDown];


    /////////////////////////////////////////////测试代码//////////////////////////////////////////////////////////

    buttonCeShiXiaZai = [[UIButton alloc]initWithFrame:CGRectMake(100, 700, 100, 50)];
    [buttonCeShiXiaZai setTitle:@"测试下载" forState:0];
    buttonCeShiXiaZai.backgroundColor = [UIColor grayColor];
    [buttonCeShiXiaZai addTarget:self action:@selector(ceshiButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonCeShiXiaZai];


    buttonDelete = [[UIButton alloc]initWithFrame:CGRectMake(900, 700, 100, 50)];
    [buttonDelete setTitle:@"清除缓存" forState:0];
    buttonDelete.backgroundColor = [UIColor grayColor];
    [buttonDelete addTarget:self action:@selector(buttonDeleteOnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    buttonDelete.hidden = YES;
    [self.view addSubview:buttonDelete];

    buttonInitial = [[UIButton alloc]initWithFrame:CGRectMake(500, 700, 100, 50)];
    [buttonInitial setTitle:@"初始化" forState:0];
    buttonInitial.backgroundColor = [UIColor grayColor];
    [buttonInitial addTarget:self action:@selector(deleteZIPFile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonInitial];


}//加载button


-(void)haveOrNohave{
    //    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);

    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"video"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {

        NSFileManager* fileManager=[NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);

        //文件夹路径
        NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"video/eightVideo"];

        NSArray *files = [fileManager subpathsAtPath: uniquePath ];

        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:files];

        [array removeObjectAtIndex:0];


        //    fileManager
        //    fileNameArray = [[NSArray alloc]initWithContentsOfFile:uniquePath];
        NSMutableArray *fileMubtabelArray = [[NSMutableArray alloc]init];

        for (int i=0; i<array.count; i++) {
            NSString *string = [array objectAtIndex:i];
            NSString *fileStr = [NSString stringWithFormat:@"%@/%@",uniquePath,string];

            [fileMubtabelArray addObject:fileStr];
        }


        fileNameArray  = (NSArray *)fileMubtabelArray;

        //        bu
        buttonCeShiXiaZai.hidden = YES;

        buttonInitial.hidden = YES;

    }
}


//////////////////////////////////////////////////测试下载///////////////////////////////////////////////


-(void)buttonDeleteOnClick:(id)sender
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);

    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"video"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {

            [_thePlayer.player pause];
            [_thePlayer removeFromSuperview];
            [pageControl removeFromSuperview];

            fileNameArray = nil;

            [self initButton];


            NSLog(@"dele success");
        }else {
            NSLog(@"dele fail");
        }

    }



}//清除缓存按钮执行方法


-(void)ceshiButtonOnClick:(id)sender
{

    loopProgressView.hidden = NO;

    //    NSString  *fileURL = @"http://223.4.14.124/upload/video/of.zip";
    NSString *fileURL = @"http://www.ledmediasz.com/UploadFiles/2733/upload/eightVideo2.zip";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];

    [self downloadFileURL:fileURL savePath:documentsDirectory fileName:@"video.zip" tag:1];





}//测试下载点击事件

//////////////////////////////////////////////////测试下载结束///////////////////////////////////////////
- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag
{
    NSFileManager *fileManager = [NSFileManager defaultManager];

    //检查本地文件是否已存在
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", aSavePath, aFileName];

    //检查附件是否存在
    if ([fileManager fileExistsAtPath:fileName]) {
        //        NSData *audioData = [NSData dataWithContentsOfFile:fileName];
        //        [self requestFinished:[NSDictionary dictionaryWithObject:audioData forKey:@"res"] tag:aTag];
        NSLog(@"该文件存在");

        [self showAlertView:@"该文件存在"];

    }else{
        //创建附件存储目录
        if (![fileManager fileExistsAtPath:aSavePath]) {
            [fileManager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
        }

        //下载附件
        NSURL *url = [[NSURL alloc] initWithString:aUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];

        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.inputStream   = [NSInputStream inputStreamWithURL:url];
        operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];

        //下载进度控制

        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {

            loopProgressView.progress =(float)totalBytesRead/totalBytesExpectedToRead;
            NSLog(@"is download：%f", (float)totalBytesRead/totalBytesExpectedToRead);
        }];


        //已完成下载
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

            loopProgressView.hidden = YES;
            //            [self showAlertView:@"下载完成"];

            [self showAlertView:@"正在解压"];
            [self unpackZIP];

            [self showAlertView:@"解压已完成"];

            [self deleteZIPFile];//解压完成后删除下载下来的zip文件夹

            buttonCeShiXiaZai.hidden = YES;
            buttonInitial.hidden = YES;

            buttonDown.hidden = NO;
            //            buttonUpData.hidden = NO;
            buttonDelete.hidden = NO;

            NSLog(@"下载完成");
            //            NSData *audioData = [NSData dataWithContentsOfFile:fileName];
            //            //设置下载数据到res字典对象中并用代理返回下载数据NSData
            //            [self requestFinished:[NSDictionary dictionaryWithObject:audioData forKey:@"res"] tag:aTag];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            loopProgressView.hidden = YES;
            [self showAlertView:@"下载失败"];

            //下载失败
            NSLog(@"下载失败");
            [self deleteZIPFile];//解压完成后删除下载下来的zip文件夹

            //            [self requestFailed:aTag];
        }];

        [operation start];

    }
}// 下载文件


-(void)unpackZIP
{

    //            当下载完成zip后   解压zip
    ZipArchive* zip = [[ZipArchive alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;

    NSString* l_zipfile = [documentpath stringByAppendingString:@"/video.zip"] ;
    NSString* unzipto = [documentpath stringByAppendingString:@"/video"] ;
    if( [zip UnzipOpenFile:l_zipfile] )
    {
        BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
        if( NO==ret )
        {
        }
        [zip UnzipCloseFile];
    }

}//解压zip文件



-(void)deleteZIPFile
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"video.zip"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {
        [self showAlertView:@"ok！"];
        loopProgressView.progress = 0 ;
        loopProgressView.hidden = YES;
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"dele success");
        }else {
            NSLog(@"dele fail");
        }

    }
}//文件解压好后删除掉zip文件


-(void)updataButtonOnClick:(id)sender
{

    if (fileNameArray.count == 0 ) {
        [self showAlertView:@"刷新失败，请重新下载"];
        buttonDown.hidden = NO;
    }else{

        [_thePlayer removeFromSuperview];
        [buttonDown removeFromSuperview];
        [buttonUpData removeFromSuperview];
        [pageControl removeFromSuperview];
        [buttonCeShiXiaZai removeFromSuperview];
        [self initView];

    }

}//点击刷新按钮实现方法

-(void)downButtonOnClick:(id)sender
{

    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);

    //文件夹路径
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"video/eightVideo"];

    NSArray *files = [fileManager subpathsAtPath: uniquePath ];

    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:files];

    [array removeObjectAtIndex:0];


    //    fileManager
    //    fileNameArray = [[NSArray alloc]initWithContentsOfFile:uniquePath];
    NSMutableArray *fileMubtabelArray = [[NSMutableArray alloc]init];

    for (int i=0; i<array.count; i++) {
        NSString *string = [array objectAtIndex:i];
        NSString *fileStr = [NSString stringWithFormat:@"%@/%@",uniquePath,string];

        [fileMubtabelArray addObject:fileStr];
    }


    fileNameArray  = (NSArray *)fileMubtabelArray;


    NSLog(@"%@",uniquePath);

    buttonDown.hidden = YES;

    buttonUpData.hidden = NO;

    [self showAlertView:@"配置播放路径成功成功！"];
}//点击配置路径按钮实现方法


-(void)initView
{


    int width = self.view.frame.size.width;


    int pageControlHeight = 20;

    //    //初始化 数组
    //    fileNameArray = [[NSArray alloc]initWithObjects:@"a",@"b",@"c",@"d",@"e",@"f", nil];



    //设置pageControl  frame   默认显示页   点击执行方法  背景色
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 700, width, pageControlHeight)];


    pageControl.numberOfPages = [fileNameArray count];

    pageControl.currentPage = 0;


    pageControl.hidesForSinglePage = YES;

    pageControl.backgroundColor = [UIColor clearColor];


    [pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventTouchUpInside];

    CGRect frame = CGRectMake(90, 100, 850, 540);
    _thePlayer = [[PlayView alloc]initWithFrame:frame];

    [self.view addSubview:_thePlayer];


    if (fileNameArray.count == 0) {

        [self showAlertView:@"无项目，请点击下载项目。"];
    }else{


        [self playMovie:[fileNameArray objectAtIndex:pageControl.currentPage]];


    }


    loopProgressView = [[SDPieLoopProgressView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    loopProgressView.hidden = YES;
    [self.view addSubview:loopProgressView];


    [self GestureRecognizer];//加载手势  单击


    [self.view addSubview:pageControl];
    [self.view addSubview:_thePlayer];


}//初始化

-(void)GestureRecognizer
{

    //添加向左滑手势
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(handleSwipeLeft)];
    //设置向左滑动手势
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;

    //加载手势
    [_thePlayer addGestureRecognizer:swipeLeft];





    //添加向右滑手势
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(handleSwipeRight)];
    //设置向右滑动手势
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;

    //加载手势
    [_thePlayer addGestureRecognizer:swipeRight];







    //添加单击手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(tapGestureRecognizerNumberOf_one)];

    //设置手势点击次数 1
    [tapGestureRecognizer setNumberOfTapsRequired:1];

    //加载单击手势
    [_thePlayer addGestureRecognizer:tapGestureRecognizer];



}//手势 和点击加载



-(void)tapGestureRecognizerNumberOf_one
{


    NSLog(@"单击手势 识别成功！");


}//单击手势点击时执行该方法



- (void)handleSwipeLeft
{


    NSLog(@"向左手势滑动识别成功！！");

    if (fileNameArray.count == 0) {

    }else{


        //如果滑动到最后一项，那就不让它滑动  不传URL播放视频  播放最后一个视频
        if (pageControl.currentPage == fileNameArray.count-1) {

            pageControl.currentPage = fileNameArray.count-1;


        }else{

            [_thePlayer.player pause];


            pageControl.currentPage = pageControl.currentPage + 1;

            //        NSLog(@"向左滑动角标值%d")
            [self playMovie:[fileNameArray objectAtIndex:pageControl.currentPage]];

        }
    }
}//向左滑动执行方法



-(void)handleSwipeRight
{


    NSLog(@"向右手势滑动识别成功！！");

    if (fileNameArray.count == 0) {
    }else{


        //如果滑动到第一项  不传URL播放视频   ｀播放第一个视频
        if (pageControl.currentPage == 0) {

            pageControl.currentPage = 0;


        }else{


            [_thePlayer.player pause];

            pageControl.currentPage = pageControl.currentPage - 1 ;


            [self playMovie:[fileNameArray objectAtIndex:pageControl.currentPage]];

        }

    }
}//向右滑动执行方法




- (void)pageControlChanged:(id)sender
{


    NSLog(@"打印角标值：%ld",(long)pageControl.currentPage);


    [self playMovie:[fileNameArray objectAtIndex:pageControl.currentPage]];


}//点击pageControl执行方法

- (void)playMovie:(NSString *)fileName
{

    //    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:fileName];
    AVPlayerItem *_itemone = [[AVPlayerItem alloc]initWithURL:url];
    //
    _avPlayer = [[AVPlayer alloc]initWithPlayerItem:_itemone];


    //    CGRect frame = CGRectMake(50, 100, 850, 540);
    //    _thePlayer = [[PlayView alloc]initWithFrame:frame];
    
    _thePlayer.player = _avPlayer;
    
    [ _avPlayer play];
    
    //注册通知   当播放结束后执行  runLoopTheMovie方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}//播放视频调用该方法



- (void)runLoopTheMovie:(NSNotification *)notification
{
    //注册的通知  可以自动把 AVPlayerItem 对象传过来，只要接收一下就OK
    
    AVPlayerItem * p = [notification object];
    //关键代码
    [p seekToTime:kCMTimeZero];
    
    [_thePlayer.player play];
    
    
}//注册通知执行的方法


#pragma mark - showAlertView
-(void)showAlertView:(NSString*)showString
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:showString delegate:nil  cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:2.0];
    
    
    
}//温馨提示



- (void)dimissAlert:(UIAlertView *)alert
{
    if(alert)
    {
        
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
        
    }
}//温馨提示




//************************************///////////////////////////////////


//左侧按钮视图  平板版

- (void)loadLeftButtonView
{
    leftBttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, SCREEN_CGSIZE_WIDTH)];
    leftBttonView.backgroundColor = [UIColor grayColor];
    NSInteger padding = 70;

    //最新设计按钮
    newestButton  = [MyButton buttonWithType:UIButtonTypeCustom];
    newestButton.frame = CGRectMake(5, 20, 60, 60);
    [newestButton setImage:[UIImage imageNamed:@"tab_newest_select"] forState:UIControlStateNormal];
    [newestButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [newestButton setTitle:NSLocalizedString(@"Button_Newest", @"最新设计") forState:UIControlStateNormal];
    //    [leftBttonView addSubview:newestButton];
    //    [newestButton addTarget:self action:@selector(showHomepage:) forControlEvents:UIControlEventTouchUpInside];
    //    newestButton.tag = 4;
    //显示首页按钮  广告市场
    homePageButton = [MyButton buttonWithType:UIButtonTypeCustom];
    homePageButton.frame = CGRectMake(5, 20 , 60, 60);
    [homePageButton setImage:[UIImage imageNamed:@"tab_feed_24x24"] forState:UIControlStateNormal];
    [homePageButton setImage:[UIImage imageNamed:@"tab_feed_select_24x24"] forState:UIControlStateHighlighted];
    [homePageButton setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [homePageButton setTitle:NSLocalizedString(@"Button_Industry", @"广告市场") forState:UIControlStateNormal];
    //    [leftBttonView addSubview:homePageButton];
    [homePageButton addTarget:self action:@selector(showHomepage:) forControlEvents:UIControlEventTouchUpInside];
    homePageButton.tag = 0;

    //登录按钮
    loginButton = [MyButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(5, homePageButton.frame.origin.y + padding, 60, 60);
    [loginButton setImage:[UIImage imageNamed:@"tab_me_24x24"] forState:UIControlStateNormal];
    [loginButton setImage:[UIImage imageNamed:@"tab_me_select_24x24"] forState:UIControlStateHighlighted];
    [loginButton setTitle:NSLocalizedString(@"Button_Account", @"登录账号") forState:UIControlStateNormal];
    //    [leftBttonView addSubview:loginButton];
    [loginButton addTarget:self action:@selector(goToLogin) forControlEvents:UIControlEventTouchUpInside];

    //显示屏体市场页面
    marketButton = [MyButton buttonWithType:UIButtonTypeCustom];
    marketButton.frame = CGRectMake(5, homePageButton.frame.origin.y + padding * 2, 60, 60);
    [marketButton setImage:[UIImage imageNamed:@"tab_market_24x24"] forState:UIControlStateNormal];
    [marketButton setImage:[UIImage imageNamed:@"tab_market_select_24x24"] forState:UIControlStateHighlighted];


    [marketButton setTitle:NSLocalizedString(@"Button_project", @"本地项目") forState:UIControlStateNormal];

    //    [leftBttonView addSubview:marketButton];
    [marketButton addTarget:self action:@selector(showProjectpage:) forControlEvents:UIControlEventTouchUpInside];
    marketButton.tag = 1;

    //显示选取照片页面
    selectPhotoButton = [MyButton buttonWithType:UIButtonTypeCustom];
    selectPhotoButton.frame = CGRectMake(5, loginButton.frame.origin.y + loginButton.frame.size.height, 60, 60);
    [selectPhotoButton setImage:[UIImage imageNamed:@"tab_photo_24x24"] forState:UIControlStateNormal];
    [selectPhotoButton setImage:[UIImage imageNamed:@"tab_photo_select_24x24"] forState:UIControlStateHighlighted];
    [selectPhotoButton setTitle:NSLocalizedString(@"Button_reAD", @"选取照片") forState:UIControlStateNormal];
    [selectPhotoButton addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    selectPhotoButton.tag = 2;

    //培训
    trainingButton = [MyButton buttonWithType:UIButtonTypeCustom];
    trainingButton.frame = CGRectMake(5, selectPhotoButton.frame.origin.y + selectPhotoButton.frame.size.height, 60, 60);
    [trainingButton setImage:[UIImage imageNamed:@"tab_training"] forState:UIControlStateNormal];
    [trainingButton setImage:[UIImage imageNamed:@"tab_training_select"] forState:UIControlStateHighlighted];
    [trainingButton setTitle:NSLocalizedString(@"Button_Training", @"培训") forState:UIControlStateNormal];
    [trainingButton addTarget:self action:@selector(training:) forControlEvents:UIControlEventTouchUpInside];
    trainingButton.tag = 3;
    //论坛
    //    ForumButton = [MyButton buttonWithType:UIButtonTypeCustom];
    //    ForumButton.frame = CGRectMake(5, trainingButton.frame.origin.y + trainingButton.frame.size.height, 60, 60);
    //    [ForumButton setImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
    //    [ForumButton setImage:[UIImage imageNamed:@"22"] forState:UIControlStateHighlighted];
    //    [ForumButton setTitle:NSLocalizedString(@"Button_Forum", @"论坛中心") forState:UIControlStateNormal];
    //    //    [leftBttonView addSubview:trainingButton];
    //    [ForumButton addTarget:self action:@selector(Forum:) forControlEvents:UIControlEventTouchUpInside];
    //    ForumButton.tag = 4;


    //返回按钮
    CGFloat fButtonHeight = 44;
    CGRect rectCloseButton = CGRectMake(5, SCREEN_CGSIZE_WIDTH - fButtonHeight - 5, 60, fButtonHeight);
    UIButton *closeButton = [[UIButton alloc]initWithFrame:rectCloseButton];
    [closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setBackgroundColor:[UIColor whiteColor]];
    [closeButton setTitle:[Config DPLocalizedString:@"adedit_back"] forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBttonView addSubview:closeButton];



    settingButton = [MyButton buttonWithType:UIButtonTypeCustom];
    settingButton.frame = CGRectMake(5, 20 , 60, 60);
    [settingButton setImage:[UIImage imageNamed:@"tab_setting_24x24"] forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"tab_setting_select_24x24"] forState:UIControlStateHighlighted];
    [settingButton setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [settingButton setTitle:NSLocalizedString(@"button_title_settings", @"设置") forState:UIControlStateNormal];
    //    [leftBttonView addSubview:homePageButton];
    [settingButton addTarget:self action:@selector(settingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    settingButton.tag = 5;


    if (DEVICE_IS_IPAD) {
        [leftBttonView addSubview:homePageButton];
        [leftBttonView addSubview:loginButton];
        [leftBttonView addSubview:selectPhotoButton];
        [leftBttonView addSubview:trainingButton];
        [leftBttonView addSubview:ForumButton];

    }else{
        [leftBttonView addSubview:marketButton];
        [leftBttonView addSubview:loginButton];
        [leftBttonView addSubview:homePageButton];
        [leftBttonView addSubview:trainingButton];
        [leftBttonView addSubview:settingButton];
        leftBttonView.frame = CGRectMake(0, SCREEN_CGSIZE_HEIGHT - 50, SCREEN_CGSIZE_WIDTH, 50);
        CGFloat buttonWidth = (SCREEN_CGSIZE_WIDTH/4.0f);
        marketButton.frame = CGRectMake(0, 0, buttonWidth, 50);
        loginButton.frame = CGRectMake( buttonWidth* 1, 0, buttonWidth, leftBttonView.frame.size.height);
      homePageButton.frame= CGRectMake(buttonWidth * 2, 0, buttonWidth, leftBttonView.frame.size.height);
        trainingButton.frame = CGRectMake(buttonWidth * 3, 0, buttonWidth, leftBttonView.frame.size.height);
        settingButton.frame = CGRectMake(buttonWidth * 4, 0, buttonWidth, leftBttonView.frame.size.height);
    }

    [self.view addSubview:leftBttonView];




}
#pragma mark - 左侧按钮
- (void)initButtonColor
{
    //    [newestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [newestButton setImage:[UIImage imageNamed:@"tab_newest"] forState:UIControlStateNormal];
    [homePageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [homePageButton setImage:[UIImage imageNamed:@"tab_feed_24x24"] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setImage:[UIImage imageNamed:@"tab_me_24x24"] forState:UIControlStateNormal];
    if (!DEVICE_IS_IPAD) {
        [marketButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [marketButton setImage:[UIImage imageNamed:@"tab_market_24x24"] forState:UIControlStateNormal];
    }

    if (DEVICE_IS_IPAD) {
        [selectPhotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [selectPhotoButton setImage:[UIImage imageNamed:@"tab_photo_24x24"] forState:UIControlStateNormal];
    }else{
        [settingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [settingButton setImage:[UIImage imageNamed:@"tab_setting_24x24"] forState:UIControlStateNormal];
    }
    [trainingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [trainingButton setImage:[UIImage imageNamed:@"tab_training"] forState:UIControlStateNormal];
}

//登录
- (void)goToLogin
{
    
    [self closeview];
    [self changeButtonColor:1000];
    [videoCenterCollectionPullViewCtrl.view removeFromSuperview];//移除培训页面
    RELEASE_SAFELY(videoCenterCollectionPullViewCtrl);
    ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"YES" forKey:@"ADD_TrainingView"];
    [ud setObject:@"image" forKey:@"PingtiOrImage"];

    if ([MyTool CheckIsLogin]) {
        //隐藏选取照片的页面
        if (selectPhotoVC) {
            selectPhotoVC.view.hidden = YES;
        }
        ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:@"fromHomepage" forKey:@"fromWhere"];
        if (!myProductionsVC) {
            myProductionsVC = [[ProductionsViewController alloc] init];
        }
        myProductionsVC.requestUrl = [NSString stringWithFormat:@"%@%@",URL_DESIGNER_PRODUCTS, [ud objectForKey:KEY_USER_ID]];
        myProductionsVC.nameString = [ud objectForKey:KEY_USER_NAME];
        myProductionsVC.qqString = [ud objectForKey:KEY_USER_QQ];
        myProductionsVC.telString = [ud objectForKey:KEY_USER_PHONE];
        myProductionsVC.photoUrl = [ud objectForKey:KEY_USER_HEADIMG];
        myProductionsVC.descriptionString = [ud objectForKey:KEY_USER_DESCRIPTION];
        if (![[ud objectForKey:@"ADD"] isEqualToString:@"NO"]) {
            [self.view addSubview:myProductionsVC.view];
        }
        [ud setObject:@"NO" forKey:@"ADD"];
    }
    else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        loginNav.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:loginNav animated:YES completion:nil];
    }
}
- (void)insertProductionsVC
{
    ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"fromHomepage" forKey:@"fromWhere"];
    //    if (!myProductionsVC) {
    myProductionsVC = [[ProductionsViewController alloc] init];
    //    }
    myProductionsVC.requestUrl = [NSString stringWithFormat:@"%@%@",URL_DESIGNER_PRODUCTS, [ud objectForKey:KEY_USER_ID]];
    myProductionsVC.nameString = [ud objectForKey:KEY_USER_NAME];
    myProductionsVC.qqString = [ud objectForKey:KEY_USER_QQ];
    myProductionsVC.telString = [ud objectForKey:KEY_USER_PHONE];
    myProductionsVC.photoUrl = [ud objectForKey:KEY_USER_HEADIMG];
    myProductionsVC.descriptionString = [ud objectForKey:KEY_USER_DESCRIPTION];
    if (![[ud objectForKey:@"ADD"] isEqualToString:@"NO"]) {
        [self.view addSubview:myProductionsVC.view];
    }
    [ud setObject:@"NO" forKey:@"ADD"];
}


//显示培训页面
- (void)training:(UIButton *)sender
{
    NSLog(@"培训视频");
    
    [adEScrollerView removeFromSuperview];
    
    [self closeview];
    
    if (selectPhotoVC) {
        selectPhotoVC.view.hidden = YES;
    }
    [self changeButtonColor:sender.tag];
    ud = [NSUserDefaults standardUserDefaults];
    [myProductionsVC.view removeFromSuperview];//移除登录界面
    [ud setObject:@"YES" forKey:@"ADD"];
    //    RELEASE_SAFELY(myProductionsVC);
    
   //二级数据要为0
    NSLog(@"培训视频请求数组====%lu",(unsigned long)_ColumnsDataArray.count);
    DataColumns *duan = secondMenuArray[0];
    
    NSLog(@"我要的url====%@",duan.column_url);
    
//    必须点击广告市场  因为数据在广告市场里面
    if (_ColumnsDataArray.count != 0)
    {
        [secondMenuArray removeAllObjects];
        
        [secondMenuArray setArray:[_ColumnsDataArray objectAtIndex:sender.tag]];
        
        if ([[(DataColumns *)[secondMenuArray firstObject] column_structure]isEqualToString:@"video_new"])
        {
            if (!videoCenterCollectionPullViewCtrl) {
                videoCenterCollectionPullViewCtrl= [[VideosCenterCollectionPullViewController alloc] init];
            }
            //加载水平按钮
            [videoCenterCollectionPullViewCtrl setSecondMenuArray:secondMenuArray];
            
            //网络请求
            [videoCenterCollectionPullViewCtrl reloadData:[secondMenuArray objectAtIndex:0]];
            duan = [secondMenuArray objectAtIndex:0];
            
        //  http://www.ledmediasz.com/api_LED/LEDThirdStepAPI.aspx?columnsid=9595&module=16
            
            NSLog(@"第二次想要的url===%@",duan.column_url);
            [videoCenterCollectionPullViewCtrl setHidesBottomBarWhenPushed:YES];
            if (![[ud objectForKey:@"ADD_TrainingView"] isEqualToString:@"NO"]) {
                [self.view addSubview:videoCenterCollectionPullViewCtrl.view];
            }
            [ud setObject:@"NO" forKey:@"ADD_TrainingView"];
        }

    }
    else
    {
        
        
//     、、   [self loadData];

        //    [self backLoadMenuData];//刷新行业排序

    
    }
    
}

//选取照片2014年09月23日11:26:12
- (void)selectPhoto:(UIButton *)sender
{

    [self changeButtonColor:sender.tag];
    //移除视频播放页面
    [videoCenterCollectionPullViewCtrl.view removeFromSuperview];
    RELEASE_SAFELY(videoCenterCollectionPullViewCtrl);
    ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"YES" forKey:@"ADD_TrainingView"];

    if (!selectPhotoVC) {
        selectPhotoVC = [[NLViewController alloc] init];
        selectPhotoVC.view.frame = CGRectMake(70, 0, SCREEN_CGSIZE_HEIGHT - 70, SCREEN_CGSIZE_WIDTH);
        [self.view addSubview:selectPhotoVC.view];
    }else{
        selectPhotoVC.view.hidden = NO;
        [selectPhotoVC.view.superview bringSubviewToFront:selectPhotoVC.view];
    }
}

//切换按钮颜色
- (void)changeButtonColor:(NSInteger)tag
{
    DLog(@"tag = %ld",(long)tag);

    [self initButtonColor];
    if (tag == 0)
    {
        [homePageButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [homePageButton setImage:[UIImage imageNamed:@"tab_feed_select_24x24"] forState:UIControlStateNormal];
    }
    else if (tag == 1)
    {
        [marketButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [marketButton setImage:[UIImage imageNamed:@"tab_market_select_24x24"] forState:UIControlStateNormal];
    }
    else if (tag == 2)
    {
        if (DEVICE_IS_IPAD) {
            [selectPhotoButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
            [selectPhotoButton setImage:[UIImage imageNamed:@"tab_photo_select_24x24"] forState:UIControlStateNormal];
        }
    }
    else if (tag == 3)
    {
        [trainingButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [trainingButton setImage:[UIImage imageNamed:@"tab_training_select"] forState:UIControlStateNormal];
    }
    else if (tag == 4)
    {
        [ForumButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [ForumButton setImage:[UIImage imageNamed:@"22"] forState:UIControlStateNormal];
    }
    else if (tag == 5)
    {
        [settingButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [settingButton setImage:[UIImage imageNamed:@"tab_setting_select_24x24"] forState:UIControlStateNormal];
    }
    else
    {
        [loginButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [loginButton setImage:[UIImage imageNamed:@"tab_me_select_24x24"] forState:UIControlStateNormal];
    }

}


//加载数据
- (void)loadData
{
    //开启进度
    [self startProgress];
    //请求数据
    [self backLoadMenuData];
    [self initialData];//初始请求的数据
    //    [self sendRequest];
}

/**
 *@brief 开始进度条
 */
-(void)startProgress{
    KKProgressTimer *myProgress = [[KKProgressTimer alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (DEVICE_IS_IPAD) {
        [myProgress setCenter:CGPointMake(SCREEN_CGSIZE_HEIGHT/2, SCREEN_CGSIZE_WIDTH/2)];
    }else {
        [myProgress setCenter:CGPointMake(SCREEN_CGSIZE_WIDTH/2, SCREEN_CGSIZE_HEIGHT/2)];
    }
    myProgress.delegate = self;
    [myProgress setTag:TAG_PROGRESS + 1];

    [self.view addSubview:myProgress];
    __block CGFloat i3 = 0;
    [myProgress startWithBlock:^CGFloat {
        return ((i3++ >= 50) ? (i3 = 0) : i3) / 50;
    }];
}

/**
 *@brief 停止进度条
 */
-(void)stopProgress:(UIView *)containtView{
    KKProgressTimer *oldProgress = (KKProgressTimer *)[containtView viewWithTag:TAG_PROGRESS + 1];
    [oldProgress stop];
    if (oldProgress) {
        [oldProgress removeFromSuperview];
    }
}

//搜索
- (void)clickSearchButton
{
    DLog(@"开始搜索");
    if (!searchVC) {
        searchVC = [[SearchViewController alloc] init];
    }
    UINavigationController *searchNav = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self.navigationController presentViewController:searchNav animated:YES completion:nil];
}


/**
 请求数据
 */
- (void)sendRequest
{
    NSString *langUrl = [MyTool getURLLangSuffix];
    NSMutableArray *requestUrlArray = [[NSMutableArray alloc]init];
    //请求广告模块数据
    if (((!adDataArray) || ([adDataArray count]<1))) {
        NSDictionary *adRequestRulDict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@/%@%@",URL_FOR_IP_OR_DOMAIN,URL_ZDEC_GET_ADMODLE_LIST,langUrl],@"requestUrl",[NSString stringWithFormat:@"%d",TAG_URL_ZDEC_GET_ADMODLE_LIST],@"tag",nil];
        [requestUrlArray addObject:adRequestRulDict];
        RELEASE_SAFELY(adRequestRulDict);
    }
    //请求一级栏目数据
    if (((!firstMenuArray) || ([firstMenuArray count]<1))) {
        NSDictionary *firstMenuRequestRulDict = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@/%@%@",URL_FOR_IP_OR_DOMAIN,URL_INTERFACE_IMPORT,langUrl],@"requestUrl",[NSString stringWithFormat:@"%d",TAG_FIRST_MENU_DATA_REQUEST],@"tag",nil];
        [requestUrlArray addObject:firstMenuRequestRulDict];
        RELEASE_SAFELY(firstMenuRequestRulDict);
    }


    if (!networkQueue) {
        networkQueue = [[ASINetworkQueue alloc] init];
    }

    [networkQueue reset];
    [networkQueue setRequestDidFailSelector:@selector(queueRequestFetchFailed:)];
    [networkQueue setQueueDidFinishSelector:@selector(queueRequestFetchFinished:)];
    [networkQueue setDelegate:self];

    for (int i=0; i<[requestUrlArray count]; i++) {
        NSString *requestUrlString = [[requestUrlArray objectAtIndex:i] objectForKey:@"requestUrl"];
        DLog(@"requestUrl=%@",requestUrlString);
        NSURL *requestUrl = [NSURL URLWithString:requestUrlString];
        __block ASIHTTPRequest *firstPageRequest = [[ASIHTTPRequest alloc]initWithURL:requestUrl];
        [firstPageRequest setTag:[[[requestUrlArray objectAtIndex:i] objectForKey:@"tag"] integerValue]];

        [firstPageRequest setCompletionBlock:^{
            if (firstPageRequest.tag == TAG_URL_ZDEC_GET_ADMODLE_LIST) {
                [self refreshAdmodule:firstPageRequest];
            }
            if (firstPageRequest.tag == TAG_FIRST_MENU_DATA_REQUEST) {
                [FirstMenuDataFilter refreshFirstMenuData:firstPageRequest];
            }
        }];
        [firstPageRequest setFailedBlock:^{
            DLog(@"请求主页数据失败");
        }];
        [networkQueue addOperation:firstPageRequest];
    }
    RELEASE_SAFELY(requestUrlArray);
    [networkQueue go];
}

-(void)queueRequestFetchFailed:(ASIHTTPRequest *)request{
    DLog(@"队列执行失败");
    refreshButton.hidden = NO;
    //关闭进度条
    [self stopProgress:self.view];
}
-(void)queueRequestFetchFinished:(ASIHTTPRequest *)request{
    //    [homepageTableView reloadData];
    DLog(@"队列执行完成,停止进度条,加载主页视图");
    [self stopProgress:self.view];
        [self.view addSubview:[self insertADCellView]];
}


/**
 刷新广告
 */
- (void)refreshAdmodule:(ASIHTTPRequest*)request{
    NSString *responseString = [request responseString];

    responseString = [MyTool filterResponseString:responseString];

    //网络未读取到数据的时候，判断缓存是否存在，存在则读取缓存，有网络则写缓存
    NSString *urlStr = [[NSString alloc]initWithFormat:@"%@",[request url]];

    if ([responseString length]==0) {
        if ([MyTool isExistsCacheFile:urlStr]) {
            responseString=[MyTool readCacheString:urlStr];
            DLog(@"本地广告数据urlStr=%@,本地广告数据responseString=%@",urlStr,responseString);
        }
    }else{
        [MyTool writeCache:responseString requestUrl:urlStr];
    }

    DLog(@"广告数据请求完毕 = %@",responseString);
    [adDataArray removeAllObjects];
    [adDataArray setArray:[MainDataJTOA adlistJsonToObject:responseString]];
    DLog(@"广告数据解析完毕 = %@",adDataArray);
}
/**
 滚动广告模块儿
 */

//滚动的广告市场
- (UIView *)insertADCellView
{
//    HOMEViewController *HOME = [[HOMEViewController alloc]init];
//    [HOME.view setFrame:CGRectMake(70, 45, SCREEN_CGSIZE_HEIGHT - 70, SCREEN_CGSIZE_WIDTH - 45)];
//    return HOME.view;
    DLog(@"adIntroduceArray = %@",adIntroduceArray);
    if (DEVICE_IS_IPAD) {
        adEScrollerView=[[EScrollerView alloc] initWithFrameRect:CGRectMake(75, 70, SCREEN_CGSIZE_HEIGHT - 80, SCREEN_CGSIZE_WIDTH - 70) dataArray:adDataArray introduceArray:adIntroduceArray];
    }else {
        adEScrollerView=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 70, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - 70 - 50) dataArray:adDataArray introduceArray:adIntroduceArray];
    }

    adEScrollerView.delegate = self;
    adEScrollerView.tag = TAG_AD;
    return adEScrollerView;
}

#pragma mark - EScrollerViewDelegate
-(void)EScrollerViewDidClicked:(NSUInteger)index
{
    //#warning请求点击纪录
    [self requestClickRecords];
    //    ADdetailViewController *ADdetailVC = [[ADdetailViewController alloc] init];
    //    ADdetailVC.ad_link = ((MainDataEntity *)[adDataArray objectAtIndex:(index - 1)]).item_link;
    //    ADdetailVC.ad_title = ((MainDataEntity *)[adDataArray objectAtIndex:(index - 1)]).item_title;
    //    [ADdetailVC setHidesBottomBarWhenPushed:YES];
    //    [self.navigationController pushViewController:ADdetailVC animated:YES];
    DLog(@"测试一下index = %lu \n[adDataArray count] = %d",index, [adDataArray count]);
    //修复滚动到首尾时点击出现bug
    if (index > [adDataArray count]) {
        index = 1;
    }
    if (index == 0) {
        index = [adDataArray count];
    }
    imageListVC = [[ImageListViewController alloc] init];
    imageListVC.mainImageName = [adDataArray objectAtIndex:index - 1];
    [imageListVC requestImageData:[_newsList objectAtIndex:index - 1]];
    //    imageListVC.modalPresentationStyle = UIModalPresentationFormSheet;
    UINavigationController *testNav = [[UINavigationController alloc] initWithRootViewController:imageListVC];

    //    修改时间2014年09月22日17:26:30-因iOS8做出调整
    if (OS_VERSION_FLOAT >= 8.0) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:testNav.view];
    }else {
        [self presentViewController:testNav animated:YES completion:nil];
    }
}

/**
 *  请求一次行业的点击量（hits）加一
 */
- (void)requestClickRecords
{
    currentClickUrl = [NSString stringWithFormat:@"%@%@", URL_ITEM_CLICK, currentColumId];
    [self sendAsynchronous:currentClickUrl reqeusttagi:0];
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [firstMenuArray count] + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *MyIdentifier = [[NSString alloc] initWithFormat:@"%d",indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];

    if (cell == nil)
    {
        if (indexPath.row == 0) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:MyIdentifier] autorelease];
        }
        else
        {
            cell = [[HomepageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier withdataNewsLeditem:[firstMenuArray objectAtIndex:(indexPath.row - 1)]];
            UIView *backgrdView = [[UIView alloc] initWithFrame:cell.frame];
            backgrdView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_bg_qq"]];
            cell.backgroundView = backgrdView;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return _adModelScrollHeight;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITextField *searchTextField = (UITextField *)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
    [searchTextField resignFirstResponder];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger currentIndex = indexPath.row - 1;
    DLog(@"一级栏目=%@",[firstMenuArray objectAtIndex:currentIndex]);
    secondMenuArray = [_ColumnsDataArray objectAtIndex:currentIndex];
    //    修改时间2014年07月07日18:15:23
    //    DataCategories *oneDataCategories = [firstMenuArray objectAtIndex:(indexPath.row - 1)];
    //    if (!_detailsController) {
    //        _detailsController = [[ListPullViewController alloc]init];
    //    }
    //    [_detailsController reloadCategoryData:oneDataCategories];
    if ([[(DataColumns *)[secondMenuArray firstObject] column_structure]isEqualToString:@"video_new"]) {
        videoCenterCollectionPullViewCtrl= [[VideosCenterCollectionPullViewController alloc] init];
        [videoCenterCollectionPullViewCtrl setSecondMenuArray:secondMenuArray];
        [videoCenterCollectionPullViewCtrl reloadData:[secondMenuArray objectAtIndex:0]];
        [videoCenterCollectionPullViewCtrl setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:videoCenterCollectionPullViewCtrl animated:YES];
    }
    else
    {
        ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:@"fromHomepageVC" forKey:@"segmentYesOrNo"];
        _detailsController = [[ListPullViewController alloc]init];
        [_detailsController setSecondMenuArray:secondMenuArray];
        [_detailsController reloadData:[secondMenuArray objectAtIndex:0]];
        [_detailsController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:_detailsController animated:YES];
    }
}


/**
 *@brief 加载数据
 */
-(void)backLoadMenuData{
    DLog(@"后台任务开始加载数据,打印时间=%@",[MyTool getCurrentDateString]);
    //后台任务开始加载主界面
    NSString *stringUrlInterfaceImport=nil;
    strLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    DLog(@"AppleLanguages = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]);
    if ([strLanguage isEqualToString:@"zh-Hans"]) {
        //中文
        stringUrlInterfaceImport = [[NSString alloc]initWithFormat:@"%@",URL_INTERFACE_IMPORT];
    }else{
        stringUrlInterfaceImport = [[NSString alloc]initWithFormat:@"%@",URL_ENGLISH_MARK];
    }
    if (firstMenuArray==nil) {
        firstMenuArray = [[NSMutableArray alloc]init];
    }
    //一级数据
    firstMenuArray = [DataCategoriesList getDataCategoriesListList:stringUrlInterfaceImport];
    DLog(@"firstMenuArray的行数 = %ld",(unsigned long)[firstMenuArray count]);


    RELEASE_SAFELY(_ColumnsDictionary);
    RELEASE_SAFELY(_ColumnsDataArray);
    _ColumnsDictionary = [[NSMutableDictionary alloc] init];
    _ColumnsDataArray = [[NSMutableArray alloc] init];

    for (DataCategories *categoriesitems in firstMenuArray) {
        NSString *category_idswp=categoriesitems.category_id;
        //        if ([_ColumnsDictionary objectForKey:category_idswp]==nil) {
        NSMutableArray *dataColumnsarraylist= [DataColumnsList getDataColumnsList:categoriesitems.category_url];
        [_ColumnsDictionary setObject:dataColumnsarraylist forKey:category_idswp];
        [_ColumnsDataArray addObject:dataColumnsarraylist];
        //        }
    }
    DLog(@"firstMenuArray=%@",firstMenuArray);
    DLog(@"_ColumnsDArray的行数 = %lu",(unsigned long)[_ColumnsDataArray count]);
    DLog(@"后台任务结束加载数据,打印时间=%@",[MyTool getCurrentDateString]);
}

- (void)initialData
{
    if (firstMenuArray.count != 0) {
        DLog(@"隐藏刷新按钮");
        //        refreshButton =  (UIButton *)[self.view viewWithTag:TAG_REFRESH_BUTTON];//隐藏刷新按钮
        [refreshButton setHidden:YES];

        [secondMenuArray setArray:[_ColumnsDataArray objectAtIndex:0]];

        [self inserSegmentView];//
        [self sendAsynchronous:[(DataColumns *)[secondMenuArray objectAtIndex:0] column_url] reqeusttagi:TAG_ONE_PAGE_DATA];
    }
    else
    {
        [self stopProgress:self.view];
    }
}



//2014年07月19日17:43:33 云屏项目———————————————————————————————————————————————————————————————————
//栏目标题segmentControl
- (void)inserSegmentView
{

    admoduleHeight = 0;
    if ([secondMenuArray count]>0) {
        admoduleHeight=50;
        YGPtitleArray = [[NSMutableArray alloc] init];
        for (int i=0; i<[secondMenuArray count]; i++) {
            [YGPtitleArray addObject:[(DataColumns*)[secondMenuArray objectAtIndex:i] column_name]];
        }
        if (_ygp) {
            [_ygp removeFromSuperview];
        }
        if (DEVICE_IS_IPAD) {
            
            _ygp = [[YGPSegmentedController alloc] initContentTitleContaintFrame:YGPtitleArray CGRect:CGRectMake(70, 0, SCREEN_CGSIZE_HEIGHT - 70/* *2 */,admoduleHeight) ContaintFrame:CGRectMake(71, 1, SCREEN_CGSIZE_HEIGHT - 72,admoduleHeight)];
        }else {
            //那就是手机了 导航
            _ygp = [[YGPSegmentedController alloc] initContentTitleContaintFrame:YGPtitleArray CGRect:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH,admoduleHeight) ContaintFrame:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH,admoduleHeight)];
        }
        [_ygp setDelegate:self];
        [_ygp setUserInteractionEnabled:YES];
        [self.view setUserInteractionEnabled:YES];
        [self.view addSubview:_ygp];
    }
    DLog(@"admoduleHeight = %ld\nYGPtitleArray = %@",(long)admoduleHeight, YGPtitleArray);
}


//异步请求网络数据
-(void)sendAsynchronous:(NSString*)urlStr reqeusttagi:(NSInteger)reqeusttagi{
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",urlStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIHTTPRequest *asiHttp = [[ASIHTTPRequest alloc] initWithURL:url];
    asiHttp.delegate = self;
    asiHttp.tag = reqeusttagi;
    [asiHttp startAsynchronous];
    
    //在请求点击量记录是不移除
    if (reqeusttagi == TAG_ONE_PAGE_DATA) {
        [[self.view viewWithTag:TAG_AD] removeFromSuperview];
        RELEASE_SAFELY(adEScrollerView);
    }
}
//请求成功
-(void)requestFinished:(ASIHTTPRequest *)request{
    DLog(@"数据加载完成");
    if (request.tag == TAG_ONE_PAGE_DATA) {
        [self parseDataItemsJsonString:request];
        [self.view addSubview:[self insertADCellView]];
    }
    [self stopProgress:self.view];
}

//请求失败
-(void)requestFailed:(ASIHTTPRequest *)request{
    DLog(@"加载数据失败，检查网络");
    
    if (request.tag == TAG_ONE_PAGE_DATA) {
        [self parseDataItemsJsonString:request];
        [self.view addSubview:[self insertADCellView]];
    }
    [self stopProgress:self.view];
}


/**
 *@brief 解析返回的JSON数据的到列表对象的集合和下一页的URL
 */
-(void)parseDataItemsJsonString:(ASIHTTPRequest *)request{

    NSString *jsonString = [request responseString];
    //网络未读取到数据的时候，判断缓存是否存在，存在则读取缓存，有网络则写缓存
    NSString *urlStr = [[NSString alloc]initWithFormat:@"%@",[request url]];
    //缓存数据
    if ([jsonString length]==0) {
        if ([MyTool isExistsCacheFile:urlStr]) {
            jsonString = [MyTool readCacheString:urlStr];
        }
    }else{
        [MyTool writeCache:jsonString requestUrl:urlStr];
    }
    jsonString = [MyTool filterResponseString:jsonString];

    NSDictionary *itemsDataDictionary = [jsonString JSONValue];
    DLog(@"itemsDataDictionary = %@",itemsDataDictionary);
    if ((itemsDataDictionary == nil) || (![itemsDataDictionary isKindOfClass:[NSDictionary class]])) {
        DLog(@"返回的数据非法，不是一个字典");
        return;
    }

    NSArray *itemsDataArray = [itemsDataDictionary objectForKey:[DataItems forkey]];
    if ((itemsDataArray == nil) || (![itemsDataArray isKindOfClass:[NSArray class]])) {
        DLog(@"返回的数据非法，字典内部不是包含的数组");
        return;
    }

    if (!_newsList) {
        _newsList = [[NSMutableArray alloc]init];
    }
    [adDataArray removeAllObjects];
    [adIntroduceArray removeAllObjects];
    [_newsList removeAllObjects];
    for (NSDictionary *oneDataItemDict in itemsDataArray) {
        DataItems *dataItems = [[DataItems alloc]init];
        dataItems.item_id = [oneDataItemDict objectForKey:@"item_id"];
        dataItems.item_title = [oneDataItemDict objectForKey:@"item_title"];
        dataItems.item_img = [oneDataItemDict objectForKey:@"item_img"];
        dataItems.item_url = [oneDataItemDict objectForKey:@"item_url"];
        dataItems.item_time = [oneDataItemDict objectForKey:@"item_time"];
        dataItems.item_column_id = [oneDataItemDict objectForKey:@"item_column_id"];
        dataItems.item_share_url = [oneDataItemDict objectForKey:@"item_share"];
        dataItems.item_introduce = [oneDataItemDict objectForKey:@"item_introduce"];
        dataItems.item_column_structure = [oneDataItemDict objectForKey:@"item_column_structure"];
        [_newsList addObject:dataItems];
        [adDataArray addObject:dataItems.item_img];
        [adIntroduceArray addObject:dataItems.item_title];
    }


    //获得下一页数据
    NSArray *nextPageUrlArray = [itemsDataDictionary objectForKey:@"page"];
    if (!_nextPageUrl) {
        _nextPageUrl = [[NSMutableString alloc]init];
    }
    for (NSDictionary *nextPageUrlDictionary in nextPageUrlArray) {
        [_nextPageUrl setString:[nextPageUrlDictionary objectForKey:@"page_url"]];
    }
    if ([_nextPageUrl length] == 0) {
        [_nextPageUrl setString:@"end"];
    }
}

//水平选择菜单

-(void)segmentedViewController:(YGPSegmentedController *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    
    
    UITextField *searchTextField = (UITextField*)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
    [searchTextField resignFirstResponder];

    
    DLog(@"segmentedControl.index :%lu/ncolumn_id = %@",(unsigned long)index , [(DataColumns *)[secondMenuArray objectAtIndex:index] column_id]);
    if (currentColumId == nil) {
        currentColumId = [[NSString alloc] init];
    }
    currentColumId = [(DataColumns *)[secondMenuArray objectAtIndex:index] column_id];
    if ([currentColumId isEqualToString:TAG_PROJECTS_ID]) {
        return;
    }
    //    loadingLabel.text = @"图片加载中...";
    [self startProgress];
    [self sendAsynchronous:[(DataColumns *)[secondMenuArray objectAtIndex:index] column_url] reqeusttagi:TAG_ONE_PAGE_DATA];
}









- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



/**
 *  用户选择项目列表中的某个项目上的选择框时的回调
 *
 *  @param mySelectedProjectList 用户已经选择的项目列表
 */
-(void)selectedProjectWithObject:(NSMutableArray *)mySelectedProjectList{
    @try {
        if (mySelectedProjectArray==nil) {
            mySelectedProjectArray = [[NSMutableArray alloc]initWithArray:mySelectedProjectList];
        }else{
            [mySelectedProjectArray removeAllObjects];
            [mySelectedProjectArray setArray:mySelectedProjectList];
        }

        DLog(@"mySelectedProjectList.count = %d",[mySelectedProjectList count]);
        UIButton *myButton = (UIButton*)[self.view viewWithTag:TAG_PUBLISH_PROJ_BUTTON];
        if (myButton==nil) {
            myButton = (UIButton*)[self.view viewWithTag:TAG_CREATE_GROUP_BUTTON];
        }
        if ([mySelectedProjectList count] > 0) {
            DLog(@"连续播放");
            myButton.titleLabel.text = [Config DPLocalizedString:@"adedit_continuous_play"];
            [myButton setTag:TAG_CREATE_GROUP_BUTTON];
            isContinusPlay = YES;
        }else{
            DLog(@"发布项目");
            myButton.titleLabel.text = [Config DPLocalizedString:@"adedit_PublishProj"];
            [myButton setTag:TAG_PUBLISH_PROJ_BUTTON];
            isContinusPlay = NO;
        }

    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    @finally {

    }
}


/**
 *  项目列表点击的回调，开始模拟播放已经编辑好的项目
 *
 *  @param asset 输入播放对象
 *  @param cellIndexPath 以及项目的索引
 */
-(void)playOneWithProjectObj:(ProjectListObject *)asset cellIndexPath:(NSIndexPath *)cellIndexPath{

    if (isPlay) {

        [_waitForUploadFilesArray removeAllObjects];


    }


    currentPlayProObject = asset;

    DLog(@"播放的项目名称 = %@",asset.project_name);
    _currentPlayProjectFilename = asset.project_filename;
    DLog(@"播放的项目配置文件路径 = %@",asset.project_filename);
    [_waitForUploadFilesArray addObject:asset.project_filename];
    _currentPlayProjectName = asset.project_name;
    /**
     *  当前播放的项目索引
     */
    _currentPlayProjIndex = cellIndexPath;
    @try {


        //获得项目的根目录
        NSString *projectFileLastString =  [_currentPlayProjectFilename lastPathComponent];
        _currentProjectPathRoot = [[NSString alloc]initWithFormat:@"%@",[_currentPlayProjectFilename stringByReplacingOccurrencesOfString:projectFileLastString withString:@""]];

        //缓存文件夹的路径
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithXMLFile:asset.project_filename]];

        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithDictionary:dataDictionary];
        [tempDictionary removeObjectForKey:@"projectName"];

        //设置屏端宽高
        //        NSDictionary *masterScreenDict = [tempDictionary objectForKey:@"masterScreenFrame"];
        //        [self applyMasterScreenDictionaryWithDict:masterScreenDict];
        //删除屏端宽高
        [tempDictionary removeObjectForKey:@"masterScreenFrame"];

        //播放音频
        NSDictionary *musicDict = [tempDictionary objectForKey:@"projectMusicElement"];
        if (musicDict) {
            if ([musicDict isKindOfClass:[NSDictionary class]]) {
                NSString *musicNameString = [musicDict objectForKey:@"musicName"];
                _musicFilePath = [[NSString alloc]initWithFormat:@"%@%@",_currentProjectPathRoot,musicNameString];
                [_waitForUploadFilesArray addObject:_musicFilePath];
                //                [myMusicPicker playMusicWithPath:_musicFilePath];
                _musicVolume = [musicDict objectForKey:@"musicVolume"];
                DLog(@"vString floatValue = %lf",[_musicVolume floatValue]);
                //                [myMusicPicker.myMusicPlayer setVolume:([_musicVolume floatValue]/100)];
                [tempDictionary removeObjectForKey:@"projectMusicElement"];
            }
        }

        //文本
        //        NSDictionary *textItemDict = [[NSDictionary alloc]initWithDictionary:[tempDictionary objectForKey:@"text"]];
        [tempDictionary removeObjectForKey:@"text"];

        DLog(@"materialListElementempDictionary = %@",tempDictionary);
        NSArray *materiallistArray = [tempDictionary objectForKey:@"materialListElement"];
        if (materiallistArray) {
            if ([materiallistArray isKindOfClass:[NSArray class]]) {
                for (NSDictionary *oneMaterialListElement in materiallistArray) {
                    NSString *oneMaterialListElementOfKey = [oneMaterialListElement objectForKey:@"key"];
                    NSMutableArray *tempObjectArray =  [[NSMutableArray alloc]init];
                    NSArray *listItemArray = [oneMaterialListElement objectForKey:@"listItemElement"];
                    if (listItemArray) {
                        if ([listItemArray isKindOfClass:[NSArray class]]) {
                            for (NSDictionary *oneListItemDict in listItemArray) {
                                [tempObjectArray addObject:[self analysisDataToMaterialObjectWith:oneListItemDict]];
                            }
                            [_projectMaterialDictionary setObject:tempObjectArray forKey:oneMaterialListElementOfKey];
                        }else{
                            [tempObjectArray removeAllObjects];
                            [tempObjectArray addObject:[self analysisDataToMaterialObjectWith:[oneMaterialListElement objectForKey:@"listItemElement"]]];
                            [_projectMaterialDictionary setObject:tempObjectArray forKey:oneMaterialListElementOfKey];
                        }
                    }
                }
            }else{


                
                NSDictionary *oneMaterialListElement = [tempDictionary objectForKey:@"materialListElement"];
                NSString *oneMaterialListElementOfKey = [oneMaterialListElement objectForKey:@"key"];
                NSMutableArray *tempObjectArray =  [[NSMutableArray alloc]init];
                NSArray *listItemArray = [oneMaterialListElement objectForKey:@"listItemElement"];
                if (listItemArray) {
                    if ([listItemArray isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *oneListItemDict in listItemArray) {
                            [tempObjectArray addObject:[self analysisDataToMaterialObjectWith:oneListItemDict]];
                        }
                        [_projectMaterialDictionary setObject:tempObjectArray forKey:oneMaterialListElementOfKey];
                    }else{
                        [tempObjectArray removeAllObjects];
                        [tempObjectArray addObject:[self analysisDataToMaterialObjectWith:[oneMaterialListElement objectForKey:@"listItemElement"]]];
                        [_projectMaterialDictionary setObject:tempObjectArray forKey:oneMaterialListElementOfKey];
                    }
                }
            }
        }

        DLog(@"_waitForUploadFilesArray = %@",_waitForUploadFilesArray);
        ChenXuNeedDemos *cx = [[ChenXuNeedDemos alloc]init];
        cx.filePath = [_waitForUploadFilesArray lastObject];
        [self presentViewController:cx animated:YES completion:nil];
        isPlay = YES;
        
    }
    @catch (NSException *exception) {
        DLog(@"exception = %@",exception);
    }
    @finally {

    }

}

/**
 *@brief 解析素材数据字典为素材对象字典
 */
-(NSDictionary*)analysisDataToMaterialObjectWith:(NSDictionary *)oneListItemDict{

    NSString *materialFilePath = [[NSString alloc]initWithFormat:@"%@/%@",[_currentProjectPathRoot lastPathComponent],[oneListItemDict objectForKey:@"filename"]];
    NSString *playFilePath = [[NSString alloc]initWithFormat:@"%@/%@",[LayoutYXMViewController defaultProjectRootPath],materialFilePath];
    DLog(@"_waitForUploadFilesArray add %@",playFilePath);
    [_waitForUploadFilesArray addObject:playFilePath];
    MaterialObject *myMaterial = [[MaterialObject alloc]init];
    [myMaterial setMaterial_path:materialFilePath];
    [myMaterial setMaterial_type:[oneListItemDict objectForKey:@"filetype"]];
    [myMaterial setMaterial_duration:[[oneListItemDict objectForKey:@"duration"] integerValue]];
    [myMaterial setMaterial_direction:[oneListItemDict objectForKey:@"direction"]];
    //是否透明
    NSString *sAlpha = [oneListItemDict objectForKey:@"alpha"];
    if (!sAlpha) {
        sAlpha = @"0";
    }
    if (![sAlpha isKindOfClass:[NSString class]]) {
        sAlpha = @"0";
    }
    [myMaterial setMaterial_alpha:sAlpha];
    int mfangle = [[oneListItemDict objectForKey:@"fangle"] intValue];
    [myMaterial setMaterial_angle:mfangle];
    [myMaterial setMaterial_of_projectfolder:[_currentProjectPathRoot lastPathComponent]];
    [myMaterial setMaterial_x:[[oneListItemDict objectForKey:@"x"] integerValue]];
    [myMaterial setMaterial_y:[[oneListItemDict objectForKey:@"y"] integerValue]];
    [myMaterial setMaterial_w:[[oneListItemDict objectForKey:@"w"] integerValue]];
    [myMaterial setMaterial_h:[[oneListItemDict objectForKey:@"h"] integerValue]];

    NSDictionary *assetDict = [[[NSDictionary alloc]initWithObjectsAndKeys:[oneListItemDict objectForKey:@"duration"],@"duration",myMaterial,@"asset",nil] autorelease];
    [materialFilePath release];
    return assetDict;
}
-(void)closeview
{


//        NSLog(@"swipe right");
//        if (addview.frame.origin.x < 0) {
//            [UIView animateWithDuration:0.5 animations:^{
//                for (UIView *view in self.view.subviews) {
//                    [view setFrame:CGRectMake(view.frame.origin.x+50, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
//                }
//            }];
//        }
//        
    //}
    
        DLog(@"swipe left111");
    UITextField *searchTextField = (UITextField*)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
    [searchTextField resignFirstResponder];
    
        if (addview.frame.origin.x == 0&& !DEVICE_IS_IPAD)
        {
        
            
            [UIView animateWithDuration:0.5 animations:^{
                for (UIView *view in self.view.subviews) {
                    [view setFrame:CGRectMake(view.frame.origin.x-50, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
                }
            }];
        }
    

    


}
//手机版  平板 版
-(void)showProjectpage:(UIButton *)sender{
    
    [adEScrollerView removeFromSuperview];
    //清除手势
    DLog(@"点击了本地项目");
    [self closeview];
    [[self.view viewWithTag:TAG_AD] removeFromSuperview];
    if (selectPhotoVC) {
        selectPhotoVC.view.hidden = YES;
    }
    ud = [NSUserDefaults standardUserDefaults];
    //    [ud setObject:[NSString stringWithFormat:@"%d",sender.tag] forKey:@"Category_Id"];
    if (sender.tag == 1) {
        [ud setObject:@"pingti" forKey:@"PingtiOrImage"];
    }
    else
    {
        [ud setObject:@"image" forKey:@"PingtiOrImage"];
    }

    [self changeButtonColor:sender.tag];

    ud = [NSUserDefaults standardUserDefaults];
    [myProductionsVC.view removeFromSuperview];
    [ud setObject:@"YES" forKey:@"ADD"];
    
    [videoCenterCollectionPullViewCtrl.view removeFromSuperview];
    [ud setObject:@"YES" forKey:@"ADD_TrainingView"];
    RELEASE_SAFELY(videoCenterCollectionPullViewCtrl);


    [self startProgress];
    [secondMenuArray removeAllObjects];
    
    DataColumns *tData = [[DataColumns alloc]init];
    [tData setColumn_id:TAG_PROJECTS_ID];
    
    [tData setColumn_name:[Config DPLocalizedString:@"adedit_localProjects"]];
    [secondMenuArray addObject:tData];
    //首次点击栏目的id

    currentColumId = [(DataColumns *)[secondMenuArray objectAtIndex:0] column_id];

    [self inserSegmentView];




    //项目列表
    UIView *projectItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT- 60 -50)];
    [projectItemView setTag:TAG_AD];
        [self.view addSubview:projectItemView];

//    [self.view addSubview:projectItemView];
    [projectItemView release];
    
    //搜索框
    CGRect mySearchTextFieldRect = CGRectMake(10, 10, projectItemView.frame.size.width - 80, 44);
    UITextField *searchTextField = [[UITextField alloc]initWithFrame:mySearchTextFieldRect];
    searchTextField.layer.borderWidth = 1;
    searchTextField.layer.borderColor = [UIColor grayColor].CGColor;
    [searchTextField setTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
    searchTextField.delegate = self;
    [projectItemView addSubview:searchTextField];
    [searchTextField release];
    
    
    
    //搜索按钮
    CGRect searchButtonRect = CGRectMake(mySearchTextFieldRect.origin.x + mySearchTextFieldRect.size.width , mySearchTextFieldRect.origin.y, 60, mySearchTextFieldRect.size.height);
    [self creteeButtonWithFrame:searchButtonRect andTag:TAG_SEARCH_PUBLISH_PROJ_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_SearchPublishProj"] superViewTag:TAG_AD];
    //项目列表
    _myProjectCtrl = [[MyProjectListViewController alloc]init];
    [_myProjectCtrl.view setFrame:CGRectMake(10, mySearchTextFieldRect.origin.y + mySearchTextFieldRect.size.height+10, projectItemView.frame.size.width-20, (projectItemView.frame.size.height - mySearchTextFieldRect.size.height*2-20))];
    _myProjectCtrl.delegate = self;
    
    
    [projectItemView addSubview:_myProjectCtrl.view];

    //发布到显示屏
    CGRect rect9 = CGRectMake(10 , _myProjectCtrl.view.frame.origin.y + _myProjectCtrl.view.frame.size.height+5, _myProjectCtrl.view.frame.size.width, 44);
    [self creteeButtonWithFrame:rect9 andTag:TAG_PUBLISH_PROJ_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_PublishProj"] superViewTag:TAG_AD];

    UIButton *myTempButton = (UIButton*)[self.view viewWithTag:TAG_PUBLISH_PROJ_BUTTON];
    [myTempButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];

    
    //返回的按钮
    CGRect rectStateButton = CGRectMake(SCREEN_CGSIZE_2WIDTH-50, 3, 44, 44);
    _netStateButton = [[BaseButton alloc]initWithFrame:rectStateButton];
    [_netStateButton setImage:[UIImage imageNamed:@"you"] forState:0];
    //    [_netStateButton setTitle:@"未连接LED屏" forState:UIControlStateNormal];
    //    [_netStateButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    //    [_netStateButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [_netStateButton setTag:TAG_REST_SCREEN_AS_BUTTON];
    [_netStateButton addTarget:self action:@selector(functionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [_netStateButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_netStateButton];

    [self initBrodcast];
    
    
    //左侧的按钮
    
    CGRect rectleft = CGRectMake(5, 5, 30, 30) ;
    _leftviewButton = [[BaseButton alloc]initWithFrame:rectleft];
    [_leftviewButton setImage:[UIImage imageNamed:@"mynextviewleft"] forState:UIControlStateNormal];
    _leftviewButton.tag = TAG_Left_View;
    [_leftviewButton addTarget:self action:@selector(leftview) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftviewButton];
    
}
#pragma mark-
//添加滑动显示btn   左滑

-(void)leftview
{
    
    if (DEVICE_IS_IPAD) {
        return;
    }
    
    DLog(@"swipe left");
    
    UITextField *searchTextField = (UITextField*)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
    [searchTextField resignFirstResponder];

    
    
    if (addview.frame.origin.x == 0)
    {
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in self.view.subviews) {
                [view setFrame:CGRectMake(view.frame.origin.x-50, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
            }
        }];
    }else if(addview.frame.origin.x < 0) {
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in self.view.subviews) {
                [view setFrame:CGRectMake(view.frame.origin.x+50, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
            }
        }];
    }
    
    
 



}

//添加
-(void)addbutton{

    addview= [[UIView alloc]initWithFrame:CGRectMake(-50, self.view.frame.origin.y, 50, self.view.frame.size.height)];
    addview.backgroundColor = [UIColor lightGrayColor];
//    addview.backgroundColor = [UIColor blackColor]; Button_Newest
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 44)];
    [btn setTitle:[Config DPLocalizedString:@"Add_Proj"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
//    [btn setTintColor:[UIColor redColor]];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [btn addTarget:self action:@selector(addbtn) forControlEvents:UIControlEventTouchUpInside];
    [addview addSubview:btn];
    [self.view addSubview:addview];
}

-(void)addbtn{

    myMasterCtrl = [[CTMasterViewController alloc]init];
    myMasterCtrl.view.backgroundColor = [UIColor cyanColor];
    myMasterCtrl.delegate = self;
    myMasterCtrl.tableView.hidden = YES;
    [self.view addSubview:myMasterCtrl.view];
    [myMasterCtrl setSAssetType:ASSET_TYPE_VIDEO];
//    [myMasterCtrl setSAssetType:ASSET_TYPE_PHOTO];
    [myMasterCtrl setIAssetMaxSelect:1];
    [myMasterCtrl pickAssets:nil];
    [myMasterCtrl setIslist:NO];
}




//选择了 素材后 跳 界面
-(void)selectPhotoToLayerWithALAsset:(ALAsset *)asset cellIndexPath:(NSIndexPath *)cellIndexPath{


    CX_SaveViewController *cx_save = [[CX_SaveViewController alloc]init];
    cx_save.asset = asset;
    [self.view addSubview:cx_save.view];
}

-(void)selfreloadview
{
    NSLog(@"ff");
    [_waitForUploadFilesArray removeAllObjects];
    [_myProjectCtrl reloadMyPlaylist];

}
//添加右滑事件
-(void)addhuadong{

    UISwipeGestureRecognizer *recognizer;
    
    //向右滑动
    recognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer  setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:recognizer];
    [recognizer release];
    
    
//    recognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer  setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [self.view addGestureRecognizer:recognizer];
//    [recognizer release];

}

//滑动手势响应事件
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if (DEVICE_IS_IPAD) {
        return;
    }
//
//    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
//        NSLog(@"swipe right");
//        if (addview.frame.origin.x < 0) {
//        [UIView animateWithDuration:0.5 animations:^{
//            for (UIView *view in self.view.subviews) {
//                [view setFrame:CGRectMake(view.frame.origin.x+50, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
//            }
//        }];
//        }
//
//    }
    
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        DLog(@"swipe left");
        if (addview.frame.origin.x == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in self.view.subviews) {
                [view setFrame:CGRectMake(view.frame.origin.x-50, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
            }
        }];
        }
    }
}



//显示homepage
- (void)showHomepage:(UIButton *)sender
{
    
    DLog(@"点击了广告市场");
    [self closeview];
    
    if (selectPhotoVC) {
        selectPhotoVC.view.hidden = YES;
    }
    ud = [NSUserDefaults standardUserDefaults];
    if (sender.tag == 1) {
        [ud setObject:@"pingti" forKey:@"PingtiOrImage"];
    }
    else
    {
        [ud setObject:@"image" forKey:@"PingtiOrImage"];
    }

    [self changeButtonColor:sender.tag];

    ud = [NSUserDefaults standardUserDefaults];
    [myProductionsVC.view removeFromSuperview];
    [ud setObject:@"YES" forKey:@"ADD"];
    [videoCenterCollectionPullViewCtrl.view removeFromSuperview];
    [ud setObject:@"YES" forKey:@"ADD_TrainingView"];
    RELEASE_SAFELY(videoCenterCollectionPullViewCtrl);

    [[self.view viewWithTag:TAG_AD] removeFromSuperview];
    //    [self backLoadMenuData];//刷新行业排序
    NSLog(@"点击了广告市场===%lu",(unsigned long)_ColumnsDataArray.count);
    
    if (_ColumnsDataArray.count != 0) {
        [secondMenuArray removeAllObjects];
        [self startProgress];
        [secondMenuArray setArray:[_ColumnsDataArray objectAtIndex:sender.tag]];
        //首次点击栏目的id

        currentColumId = [(DataColumns *)[secondMenuArray objectAtIndex:0] column_id];

        [self inserSegmentView];//导航
        //请求数据
        [self sendAsynchronous:[(DataColumns *)[secondMenuArray objectAtIndex:0] column_url] reqeusttagi:TAG_ONE_PAGE_DATA];
    }else{
        [self loadData];
    }
}

/**
 *  创建按钮
 *
 *  @param frame        按钮的区域
 *  @param tag          按钮的标签
 *  @param selector     按钮点击的响应事件
 *  @param title        按钮上的文字
 *  @param superViewTag 按钮的父视图
 */
-(void)creteeButtonWithFrame:(CGRect)frame andTag:(NSInteger)tag andAction:(SEL)selector andTitle:(NSString *)title superViewTag:(NSInteger)superViewTag{

    UIView *superView = [self.view viewWithTag:superViewTag];

    UIButton *myControlButton = [[UIButton alloc]initWithFrame:frame];
    [myControlButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myControlButton setTag:tag];
    [myControlButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [myControlButton setTitle:title forState:UIControlStateNormal];
    if (tag == TAG_DEFAULT_REGION_BUTTON) {
        [myControlButton addTarget:self action:@selector(saveDefaultApplyTitle:) forControlEvents:UIControlEventTouchDragExit];
    }

    [myControlButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];


    [myControlButton setBackgroundColor:[UIColor grayColor]];
    myControlButton.layer.borderColor = [UIColor greenColor].CGColor;
    myControlButton.layer.borderWidth = 0.5;
    [myControlButton.titleLabel setFont:[UIFont systemFontOfSize:BUTTON_TITILE_FONT]];
    [superView addSubview:myControlButton];
    [myControlButton release];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


/**
 *  点击功能按钮触发的事件
 *
 *  @param sender 发送者
 */
-(void)functionButtonClick:(UIButton *)sender{

    //发布项目
    if (sender.tag == TAG_PUBLISH_PROJ_BUTTON) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_Publishoperation"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptno"] otherButtonTitles:[Config DPLocalizedString:@"adedit_PublishProj"], nil];
        [myAlertView setTag:10021];
        myAlertView.delegate = self;
        [myAlertView show];
        [myAlertView release];
    }


    if (sender.tag == TAG_SEARCH_PUBLISH_PROJ_BUTTON) {
        //[self addbtn];
        DLog(@"搜索已经编辑好的项目");
        [self clearSelectBox];

        UITextField *searchTextField = (UITextField*)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
        DLog(@"搜索的内容====%@",searchTextField.text);
        [searchTextField resignFirstResponder];
        NSString *mySearchTextString = searchTextField.text;
        if ((mySearchTextString)&&([mySearchTextString length]>0))
        
        {
            [self performSelectorInBackground:@selector(startSearchActi1) withObject:nil];
            
            [_myProjectCtrl searchProjectListWithProjectName:mySearchTextString];
            
            [self stopSearchActi1];
        }else{
            [_myProjectCtrl reloadMyPlaylist];
        }


    }

    //创建项目分组
    if (sender.tag == TAG_CREATE_GROUP_BUTTON) {
        NSString *groupNameString = @"连续播放";
        //开始创建分组文件
        NSDictionary *myGroupDict = [[NSDictionary alloc]initWithObjectsAndKeys:groupNameString,@"playlistname",mySelectedProjectArray,@"playlist" ,nil];
        [self createGroupXMLFileWithDictionary:myGroupDict andSavePath:nil andEdit:NO];
        [_waitForUploadFilesArray removeAllObjects];
        [_waitForUploadFilesArray addObject:xmlfilePath];
        isContinusPlay = YES;
        [self startupPublish];
    }

  
    if (TAG_REST_SCREEN_AS_BUTTON == sender.tag) {
        //        [self initdata];
        NSLog(@"多屏同步");
        
        [self selectip];
    }

}

//屏体选项
-(void)selectip{
    
//    多屏同步
    
    UITextField *searchTextField = (UITextField*)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
    [searchTextField resignFirstResponder];
    
    if (!_cx) {
        _cx = [[CX_SelectIPViewController alloc]init];
        _cx.ipName = ipNameArr;
        _cx.ipadress = ipAddressArr;
    }
    [self presentViewController:_cx animated:NO completion:^{
        
    }];
    
//    
//    UIView *ipview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
//    ipview.tag = 1994;
//    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ipview.frame.size.width, 50)];
//    myview.backgroundColor = [UIColor darkGrayColor];
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(3, 3, 44, 44)];
//
//    [btn setImage:[UIImage imageNamed:@"zuo"] forState:0];
//    [btn addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
//    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(ipview.frame.size.width-53, 0 , 50, 50)];
//    btn1.backgroundColor = [UIColor redColor];
//    [btn1 addTarget:self action:@selector(viewrelest:) forControlEvents:UIControlEventTouchUpInside];
//    
////    重置
//    [btn1 setTitle:[Config DPLocalizedString:@"adedit_RestDataProject"] forState:0];
//    
//    CX_SelectIPViewController * cx = [[CX_SelectIPViewController alloc]init];
//    cx.ipName = ipNameArr;
//    cx.ipadress = ipAddressArr;
//    [cx.view setFrame:CGRectMake(0, 50, ipview.frame.size.width, ipview.frame.size.height)];
//    [myview addSubview:btn];
//    [ipview addSubview:cx.view];
//    [myview addSubview:btn1];
//    [ipview addSubview:myview];
//    [self.view addSubview:ipview];
}

-(void)onclick:(UIButton *)sender{
    
    UIView *myview = (UIView *)[self.view viewWithTag:1994];
    [myview removeFromSuperview];
    //    __block HomepageViewController *weakSelf = self;
    if(!playerNameString.length==0){
        //    [weakSelf->_netStateButton setTitle:[[NSString alloc] initWithFormat:@"%@",playerNameString] forState:UIControlStateNormal];
        //    [weakSelf->_netStateButton setBackgroundColor:[UIColor greenColor]];
        //        if(isConnect){
        ////            [self.connectTimer invalidate];
        //            [_sendPlayerSocket disconnect];
        //            isConnect = NO;
        //        }
        ////    [self.connectTimer invalidate];
        //
        //
        //
        isConnect = NO;
        [self startSocket];
    }
}

-(void)viewrelest:(UIButton *)sender{
    DLog(@"重置   ");
    if (ipAddressString == nil) {
        
    //如没有联网
    UIAlertView *mynextalertview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_NoipError"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles: nil];
    [mynextalertview show];
        return;
    }
    
    //重置
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_resetscreenbutton"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptno"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptyes"], nil];
    [myAlertView setTag:TAG_ALTERVIEW_TAG_REST_SCREEN_AS_BUTTON];
    myAlertView.delegate = self;
    [myAlertView show];
    [myAlertView release];
}

/**
 *  清除所有的复选框
 */
-(void)clearSelectBox{
    [_myProjectCtrl useGroupInfoReloadProjectList];
    [self selectedProjectWithObject:nil];
}

/**
 *  创建需要传送给服务端的分组文件
 */
-(void)createGroupXMLFileWithDictionary:(NSDictionary*)myDict andSavePath:(NSString *)savePath andEdit:(BOOL)isEditXML{

    @try {
        if ((!myDict)||(![myDict isKindOfClass:[NSDictionary class]])) {
            return;
        }
        //创建根节点
        GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"playlist"];

        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithDictionary:myDict];

        //创建分组名称节点
        NSString *proejctName = [tempDictionary objectForKey:@"playlistname"];
        GDataXMLElement *projectNameElement = [GDataXMLNode elementWithName:@"playlistname" stringValue:proejctName];
        //添加子节点到根节点上
        [rootElement addChild:projectNameElement];

        //项目列表
        NSArray *playListArray = [tempDictionary objectForKey:@"playlist"];
        if (playListArray) {
            if ([playListArray isKindOfClass:[NSArray class]]) {
                for (int i=0; i<[playListArray count]; i++) {
                    ProjectListObject *oneProjectListObject = [playListArray objectAtIndex:i];
                    //创建项目节点
                    GDataXMLElement *materialListElement = [GDataXMLNode elementWithName:@"playlistElement"];

                    GDataXMLElement *selectAreaIndexElement = [GDataXMLElement elementWithName:@"playlistindex" stringValue:[NSString stringWithFormat:@"%d",i]];
                    [materialListElement addChild:selectAreaIndexElement];

                    GDataXMLElement *filepathElement = [GDataXMLElement elementWithName:@"filepath" stringValue:[NSString stringWithFormat:@"%@",[oneProjectListObject.project_filename lastPathComponent]]];
                    [materialListElement addChild:filepathElement];

                    [rootElement addChild:materialListElement];
                }
            }
        }

        //使用根节点创建xml文档
        GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
        //设置使用的xml版本号
        [rootDoc setVersion:@"1.0"];
        //设置xml文档的字符编码
        [rootDoc setCharacterEncoding:@"utf-8"];
        //获取并打印xml字符串
        NSString *XMLDocumentString = [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
        //文件字节大小
        fileSize = [rootDoc.XMLData length];
        if (isEditXML) {
            xmlfilePath = [[NSString alloc]initWithFormat:@"%@",savePath];;
        }else{
            xmlfilePath = [[NSString alloc]initWithFormat:@"%@",[[self documentGroupXMLDir]
                                                                 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",@"playlist"]]];
        }
        DLog(@"保存分组文件XML路径 = %@",xmlfilePath);
        [[NSFileManager defaultManager] removeItemAtPath:xmlfilePath error:nil];
        NSError *error = nil;
        BOOL writeFileBool = [XMLDocumentString writeToFile:xmlfilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (writeFileBool) {
            DLog(@"保存分组文件为xml成功");
        }else{
            DLog(@"保存分组文件为xml失败；error = %@", error);
        }
        [_myProjectCtrl useGroupInfoReloadProjectList];
        [mySelectedProjectArray removeAllObjects];
        [rootDoc release];
    }
    @catch (NSException *exception) {
        DLog(@"保存分组文件为xml出错；exception = %@", exception);
    }
    @finally {

    }
}

/**
 *  获取或者创建分组xml文件所在的路径
 *
 *  @return 分组xml文件所在的路径
 */
-(NSString*)documentGroupXMLDir{
    NSFileManager *myFileManager = [NSFileManager defaultManager];
    NSString *documentsGroupXMLDir = [[[NSString alloc]initWithFormat:@"%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/GroupXMLDir"]] autorelease];
    BOOL isDir;
    if (![myFileManager fileExistsAtPath:documentsGroupXMLDir isDirectory:&isDir]) {
        [myFileManager createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/GroupXMLDir"] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentsGroupXMLDir;
}

/**
 *  启动项目搜索进度指示
 */
-(void)startSearchActi1{
    UITextField *searchTextField = (UITextField*)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
    UIActivityIndicatorView *myIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, searchTextField.frame.size.width, searchTextField.frame.size.height)];

    [myIndicatorView setBackgroundColor:[UIColor brownColor]];
    [myIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [myIndicatorView setTag:TAG_SEARCH_INDICATOR_VIEW];
    [searchTextField addSubview:myIndicatorView];
    [myIndicatorView startAnimating];
    [myIndicatorView release];
}
/**
 *  停止项目搜索进度指示
 */
-(void)stopSearchActi1{
    [NSThread sleepForTimeInterval:0.3];
    UIActivityIndicatorView *myActiView = (UIActivityIndicatorView *)[self.view viewWithTag:TAG_SEARCH_INDICATOR_VIEW];
    [myActiView stopAnimating];
    [myActiView removeFromSuperview];
}

/**
 *  //在确认连接成功之后开始发布
 */
-(void)startupPublish{
    if (!isConnect) {
        [self startSocket];
    }
    
    if (ipAddressString==NULL) {
        UIAlertView *alerviewnext = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_NoipError"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles: nil];
        [alerviewnext show];
        return;

    }

    
    
    _currentDataAreaIndex = 0;
    //启动发布的进度条
    [self startPuslisProgress];
    //计算文件总大小
    for (NSString *sFielPath in _waitForUploadFilesArray) {
        _uploadFileTotalSize += [LayoutYXMViewController fileSizeAtPath:sFielPath];
    }
    //开始发送文件，使用ftp的方式
    [self useFTPSendProject];
}

/**
 *  重置播放列表
 */
-(void)resetScreenPlayList{
//    if (!isConnect) {
    isConnect = NO;
    ipAddressString = selectIpArr[num];
    DLog(@"222%@  %@",selectIpArr,selectNameArr[num]);
        [self startSocket];
//    }
    //0x1C
    [self commandResetServerWithType:0x1C andContent:nil andContentLength:0];
}



/**
 *  重置连续播放列表
 */
-(void)resetContinuesPlayList{
    //0x2D
    [self commandResetServerWithType:0x2D andContent:nil andContentLength:0];
}


/**
 *  启动发布进度条
 */
-(void)startPuslisProgress{
    //发送状态设置为发送中
    isSendState = YES;
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT,self.view.frame.size.height, self.view.frame.size.width)];
    //    if (OS_VERSION_FLOAT>7.9) {
    [myView setFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    //    }
    [myView setBackgroundColor:[UIColor whiteColor]];
    [myView setAlpha:0.9];
    [myView setTag:8000088];
    [myView setUserInteractionEnabled:YES];
    [self.view addSubview:myView];


    myMRProgressView = [MRProgressOverlayView showOverlayAddedTo:myView title:[Config DPLocalizedString:@"adedit_publishprojecting"] mode:MRProgressOverlayViewModeDeterminateHorizontalBar animated:YES stopBlock:^(MRProgressOverlayView *progressOverlayView) {
        progressOverlayView.mode = MRProgressOverlayViewModeCheckmark;
        progressOverlayView.titleLabelText = @"Succeed";
        [progressOverlayView dismiss:YES];
    }];

    [myMRProgressView setFrame:CGRectMake(myMRProgressView.frame.origin.x-40, myMRProgressView.frame.origin.y - 40, myMRProgressView.frame.size.width + 80, myMRProgressView.frame.size.height + 80)];

    //取消发布按钮
    UIButton *cancelPublishButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_CGSIZE_HEIGHT - 320, SCREEN_CGSIZE_WIDTH - 90, 320, 55)];
    if (OS_VERSION_FLOAT>7.9) {
        [cancelPublishButton setFrame:CGRectMake(SCREEN_CGSIZE_WIDTH - 320, SCREEN_CGSIZE_HEIGHT - 90, 320, 55)];
    }
    [cancelPublishButton setBackgroundColor:[UIColor grayColor]];
    [cancelPublishButton setTitle:[Config DPLocalizedString:@"adedit_CancelPublish"] forState:UIControlStateNormal];
    [cancelPublishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelPublishButton.layer.borderWidth = 1;
    cancelPublishButton.layer.borderColor = [UIColor blackColor].CGColor;
    [cancelPublishButton addTarget:self action:@selector(cancelPublishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelPublishButton setAlpha:1];
    [myView addSubview:cancelPublishButton];


}

/**
 *  取消发布按钮的处理方法
 *
 *  @param sender 发送者
 */
-(void)cancelPublishButtonClick:(UIButton *)sender{
    [self stopPublishProgress];
}

/**
 *  停止发布进度条需要处理的事件
 */
-(void)stopPublishProgress{
    @try {
        isSendState = NO;
        UIView *myView = [self.view viewWithTag:8000088];
        UIActivityIndicatorView *myIndicatorView = (UIActivityIndicatorView*)[self.view viewWithTag:8000089];
        UILabel *myLabel = (UILabel*)[self.view viewWithTag:8000090];
        if (myIndicatorView) {
            //停止指示器
            [myIndicatorView stopAnimating];
            [myIndicatorView removeFromSuperview];
        }

        if (myView) {
            //删除遮罩视图
            [myView removeFromSuperview];
        }

        if (myLabel) {
            //删除提示标签
            [myLabel removeFromSuperview];
        }
        if (myProgressView) {
            //删除进度条
            [myProgressView removeFromSuperview];
            [myProgressView release],myProgressView = nil;
        }
        //将发送索引置于不可达处
        _currentDataAreaIndex = TAG_MAX_NUMBER;
        if (_currentDataArray) {
            //清理发送数据池
            [_currentDataArray removeAllObjects];
        }

        if (myPublishCompleteTimer) {
            if ([myPublishCompleteTimer isValid]) {
                [myPublishCompleteTimer invalidate];
                myPublishCompleteTimer = nil;
            }
        }
        //初始化继续播放变量
        isContinusPlay = NO;
        //重置分组信息
        [_myProjectCtrl useGroupInfoReloadProjectList];
        //重新加载播放列表
        [_myProjectCtrl reloadMyPlaylist];
    }
    @catch (NSException *exception) {
        DLog(@"exception = %@",exception);
    }
    @finally {
    }
}

/**
 *  发送文件信息
 *
 *  @param commandType   命令类型
 *  @param contentBytes  数据内容
 *  @param contentLength 数据长度
 */
-(void)commandFileInfoWithType:(Byte)commandType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength
{
    int byteLength = contentLength+7;
    Byte outdate[byteLength];
    memset(outdate, 0x00, byteLength);
    outdate[0]=0x7D;
    outdate[1]=commandType;//命令类型
    outdate[2]=0x03; /*命令执行与状态检查2：获取服务器端的数据*/
    outdate[3]=0x00;
    for (int i=0; i<contentLength; i++) {
        outdate[i+4]=contentBytes[i];
    }
    outdate[byteLength-3]=(Byte)byteLength;
    outdate[byteLength-2]=(Byte)(byteLength>>8);
    int sumByte = 0;
    for (int j=0; j<(byteLength-1); j++) {
        sumByte += outdate[j];
    }
    //校验码计算（包头到校验码前所有字段求和取反+1）
    outdate[(byteLength-1)]=~(sumByte)+1;
    long tag = outdate[1];
    DLog(@"命令类型 commandType = %d",(int)commandType);
    NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:byteLength];
    [_sendPlayerSocket writeData:udpPacketData withTimeout:-1 tag:tag];
}

/**
 *  传输文件内容
 *
 *  @param commandType   命令类型
 *  @param sendType      发送类型
 *  @param contentBytes  内容byte数组
 *  @param contentLength 内容长度
 *  @param pageNumber    页码
 */
-(void)commandContentWithType:(Byte)commandType andSendType:(Byte)sendType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength andPageNumber:(NSInteger)pageNumber
{
    int byteLength = 7;
    if (sendType == 0x01 ) {
        byteLength = 11 + contentLength;
    }
    DLog(@"byteLength = %d",byteLength);
    Byte outdate[byteLength];
    memset(outdate, 0x00, byteLength);
    outdate[0]=0x7D;
    outdate[1]=commandType;//命令类型
    outdate[2]=0x03; //传输数据到客户端
    outdate[3]=sendType;
    if (sendType == 0x01) {
        DLog(@"pageNumber = %d",pageNumber);
        pageNumber = pageNumber + 1;
        outdate[4]=(Byte)pageNumber;
        outdate[5]=(Byte)(pageNumber>>8);
        outdate[6]=(Byte)(pageNumber>>16);
        outdate[7]=(Byte)(pageNumber>>24);
        for (int i=0; i<contentLength; i++) {
            outdate[i+8]=contentBytes[i];
            //DLog(@"%x",contentBytes[i]);
        }
    }
    outdate[byteLength-3]=(Byte)byteLength;
    outdate[byteLength-2]=(Byte)(byteLength>>8);
    int sumByte = 0;
    for (int j=0; j<(byteLength-1); j++) {
        sumByte += outdate[j];
    }
    //校验码计算（包头到校验码前所有字段求和取反+1）
    outdate[(byteLength-1)]=~(sumByte)+1;
    long tag = outdate[1];
    DLog(@"tag = %ld",tag);
    NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:byteLength];
    DLog(@"pageNumber = %d",pageNumber);
    if (pageNumber==TAG_MAX_NUMBER) {
        DLog(@"发送文件数据传输完成命令");
    }
    [_sendPlayerSocket writeData:udpPacketData withTimeout:-1 tag:tag];
}


/**
 *  传输项目完成
 *
 *  @param commandType   命令类型
 *  @param sendType      发送类型
 *  @param contentBytes  内容byte数组
 *  @param contentLength 内容长度
 *  @param pageNumber    页码
 */
-(void)commandCompleteWithType:(Byte)commandType andSendType:(Byte)sendType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength andPageNumber:(NSInteger)pageNumber
{
    int byteLength = 7;
    if (sendType == 0x01 ) {
        byteLength = 11 + contentLength;
    }
    DLog(@"byteLength = %d",byteLength);
    Byte outdate[byteLength];
    memset(outdate, 0x00, byteLength);
    outdate[0]=0x7D;
    outdate[1]=commandType;//命令类型
    outdate[2]=0x03; //传输数据到客户端
    outdate[3]=sendType;

    if (sendType == 0x01) {
        DLog(@"pageNumber = %d",pageNumber);
        pageNumber = pageNumber + 1;
        outdate[4]=(Byte)pageNumber;
        outdate[5]=(Byte)(pageNumber>>8);
        outdate[6]=(Byte)(pageNumber>>16);
        outdate[7]=(Byte)(pageNumber>>24);
        for (int i=0; i<contentLength; i++) {
            outdate[i+8]=contentBytes[i];
        }
    }
    outdate[byteLength-3]=(Byte)byteLength;
    outdate[byteLength-2]=(Byte)(byteLength>>8);
    int sumByte = 0;
    for (int j=0; j<(byteLength-1); j++) {
        sumByte += outdate[j];
    }
    //校验码计算（包头到校验码前所有字段求和取反+1）
    outdate[(byteLength-1)]=~(sumByte)+1;
    long tag = outdate[1];
    NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:byteLength];
    if (pageNumber==TAG_MAX_NUMBER) {
        DLog(@"发送文件数据传输完成命令");
    }
    DLog(@"udpPacketData = %@",udpPacketData);
    [_sendPlayerSocket writeData:udpPacketData withTimeout:-1 tag:tag];
}



/**
 *  启动网络连接
 */
-(void)startSocket{
    //    if (!_sendPlayerSocket) {
    _sendPlayerSocket = [[AsyncSocket alloc] initWithDelegate:self];
    //    }
    DLog(@"ipAddressString = %@",ipAddressString);
    if (ipAddressString) {
        DLog(@"ipaddress = %@",ipAddressString);
        if (!isConnect) {
            isConnect = [_sendPlayerSocket connectToHost:ipAddressString onPort:PORT_OF_TRANSCATION_PLAY error:nil];
            [_sendPlayerSocket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
            if (!isConnect) {
                DLog(@"连接失败");
            }else{
                DLog(@"连接成功");
            }
        }
    }else{
        isConnect = NO;
        DLog(@"ipaddress is null");
    }


    //初始化数据仓库
    if (!_currentDataArray) {
        _currentDataArray = [[NSMutableArray alloc]init];
    }


    //发送索引
    _currentDataAreaIndex = 0;
}


/**
 *  使用ftp发送项目
 */
-(void)useFTPSendProject{
    if (!_ftpMgr) {
        //连接ftp服务器
        _ftpMgr = [[YXM_FTPManager alloc]init];
        _ftpMgr.delegate = self;
    }
    NSString *sZipPath = nil;

    NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@:21/rec_bmp",ipAddressString];
    //如果是连续播放,则发送文件到分组文件夹内
    if (isContinusPlay) {
        sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@:21/manager_xmls",ipAddressString];
    }
    DLog(@"_waitForUploadFilesArray = %@,_currentDataAreaIndex=%d",_waitForUploadFilesArray,_currentDataAreaIndex);
    if ([_waitForUploadFilesArray count]>_currentDataAreaIndex) {
        sZipPath = [_waitForUploadFilesArray objectAtIndex:_currentDataAreaIndex];
        DLog(@"zipPath = %@,sUploadUrl = %@,_currentDataAreaIndex=%d",sZipPath,sUploadUrl,_currentDataAreaIndex);
        [_ftpMgr startUploadFileWithAccount:@"ftpuser" andPassword:@"ftpuser" andUrl:sUploadUrl andFilePath:sZipPath];
        _currentDataAreaIndex ++;
    }
}


/**
 *  反映上传进度的回调，每次写入流的数据长度
 *
 *  @param writeDataLength 数据长度
 */
-(void)uploadWriteData:(NSInteger)writeDataLength{
    _sendFileCountSize += writeDataLength;
    CGFloat progressValue = _sendFileCountSize*1.00f / _uploadFileTotalSize*1.00f;
    [myMRProgressView setProgress:progressValue animated:YES];

    [myMRProgressView setTitleLabelText:[NSString stringWithFormat:@"%@ %0.0lf％",[Config DPLocalizedString:@"adedit_publishprojecting"],progressValue*100]];
}


/**
 *  ftp上传文件的反馈结果
 *
 *  @param sInfo 反馈结果字符串
 */
-(void)uploadResultInfo:(NSString *)sInfo{
    NSLog(@"云屏sInfo = %@",sInfo);
    if ([sInfo isEqualToString:@"uploadComplete"]) {
        DLog(@"_waitForUploadFilesArray = %@,_currentDataAreaIndex=%d",_waitForUploadFilesArray,_currentDataAreaIndex);
        if ([_waitForUploadFilesArray count]>_currentDataAreaIndex) {
            [self useFTPSendProject];
        }else if(([sInfo isEqualToString:@"error_ReadFileError"])||([sInfo isEqualToString:@"error_StreamOpenError"])){
            [self stopPublishProgress];
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
        }else{
            //如果是连续播放
            if (isContinusPlay) {
                [self commandCompleteWithType:0x2C andSendType:0x04 andContent:nil andContentLength:TAG_MAX_NUMBER andPageNumber:TAG_MAX_NUMBER];
            }else{
                [self commandCompleteWithType:0x1D andSendType:0x04 andContent:nil andContentLength:TAG_MAX_NUMBER andPageNumber:TAG_MAX_NUMBER];
                _currentDataAreaIndex = 0;
            }
            //上传成功
            isContinusPlay = NO;
            _currentDataAreaIndex = 0;
            [mySelectedProjectArray removeAllObjects];


        }
    }else{
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }
}


/**
 *  重置服务端
 *
 *  @param commandType   命令类型
 *  @param contentBytes  发送内容
 *  @param contentLength 内容长度
 */
-(void)commandResetServerWithType:(Byte)commandType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength
{
    int byteLength = 6;
    Byte outdate[byteLength];
    memset(outdate, 0x00, byteLength);
    outdate[0]=0x7D;
    outdate[1]=commandType;//命令类型
    outdate[2]=0x00; /*命令执行与状态检查2：获取服务器端的数据*/
    outdate[byteLength-3]=(Byte)byteLength;
    outdate[byteLength-2]=(Byte)(byteLength>>8);
    //计算校验码
    int sumByte = 0;
    for (int j=0; j<(byteLength-1); j++) {
        sumByte += outdate[j];
    }
    //校验码计算（包头到校验码前所有字段求和取反+1）
    outdate[(byteLength-1)]=~(sumByte)+1;
    long tag = outdate[1];
    DLog(@"恢复默认列表 = %d",(int)commandType);
    NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:byteLength];
    [_sendPlayerSocket writeData:udpPacketData withTimeout:-1 tag:tag];
}


/**
 *  返回按钮，需要在返回的时候清理定时器资源
 *
 *  @param sender
 */
-(void)closeButtonClick:(UIButton*)sender{
    @try {
        [_thePlayer.player pause];
//        [_thePlayer removeFromSuperview];
        AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [myDelegate.window setRootViewController:(UIViewController*)myDelegate.rootCtrl];
    }
    @catch (NSException *exception) {
        DLog(@"点击返回按钮报错=%@",exception);
    }
    @finally {

    }

}


/**
 *  初始化广播接收器
 */
-(void)initBrodcast{
    @try {
        __block HomepageViewController *weakSelf = self;
        
        _playerBroadcast = [[AsyncUdpSocketReceiveUpgradeTranscationBroadcastIp alloc] initReceivePlayerBroadcastIp:^(NSString *ledPlayerName,NSString *ledPlayerIP){
            //            if (ledPlayerName!=nil) {
            //                playerNameString = [[NSString alloc]initWithFormat:@"%@",ledPlayerName];
            //            }
            if (ledPlayerIP!=nil) {
                NSString *ip;
                ip = [[NSString alloc]initWithFormat:@"%@",[ledPlayerIP stringByReplacingOccurrencesOfString:@"::ffff:" withString:@""]];
                if (![ipAddressArr containsObject:ip]) {
//                    ipAddressString = ip;
                    [ipAddressArr addObject:ip];
                    if (ledPlayerName!=nil) {
                     NSString   *_playerNameString = [[NSString alloc]initWithFormat:@"%@",ledPlayerName];
                        //                        [weakSelf->_netStateButton setTitle:[[NSString alloc] initWithFormat:@"%@",playerNameString] forState:UIControlStateNormal];
                        //                        [weakSelf->_netStateButton setBackgroundColor:[UIColor greenColor]];
                        // if (![ipNameArr containsObject:playerNameString]) {
                        [ipNameArr addObject:_playerNameString];
                        //}

                    }
                }
            }
            DNetLog(@"ledPlayerIP=%@,ledPlayerName=%@,50000",ipAddressString,playerNameString);
        }];


    }
    @catch (NSException *exception) {
        DLog(@"升级时广播异常 = %@",exception);
    }
    @finally {

    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10020) {
        if (buttonIndex==1) {
            //删除项目
            //            [self deletePlayProject:nil];
            //            [self cleanEditerResources];
        }
    }
    if (alertView.tag == 10021) {
        //发布按钮点击
        if (buttonIndex == 1) {
            DLog(@"发布项目前先检查网络==%@",_waitForUploadFilesArray);
            
            if (_waitForUploadFilesArray.count<1) {
                UIAlertView *alerviewnext = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_Pleaseselectanitem"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles: nil];
                [alerviewnext show];
                return;
            }
            
            [self startupPublish];
        }

    }
    if (alertView.tag == TAG_RECONNECT_ALERTVIEW) {
        //重新连接网络
        if (buttonIndex==1) {
            isReconnect = YES;
            [self startSocket];
        }

    }


    if (alertView.tag == TAG_ALTERVIEW_GROUPNAME_INPUT) {
        if (buttonIndex==1) {
            DLog(@"输入分组名称");
            //得到输入框
            UITextField *groupNameTextField = [alertView textFieldAtIndex:0];
            DLog(@"%@",groupNameTextField.text);
            NSString *groupNameString = groupNameTextField.text;
            //开始创建分组文件
            NSDictionary *myGroupDict = [[NSDictionary alloc]initWithObjectsAndKeys:groupNameString,@"playlistname",mySelectedProjectArray,@"playlist" ,nil];
            [self createGroupXMLFileWithDictionary:myGroupDict andSavePath:nil andEdit:NO];
        }
    }

    if (alertView.tag == TAG_ALTERVIEW_TAG_REST_SCREEN_AS_BUTTON) {
        if (buttonIndex==1) {
            DLog(@"重置");
            [self resetScreenPlayList];
        }
    }

    if (alertView.tag == TAG_IS_CLEAR_IMAGE_LIST_ALERT) {
        if (buttonIndex==1) {
            DLog(@"确认是否清除列表");
            //            [self clearImageListWithCurrentScene];
        }
    }

    if (alertView.tag == TAG_IS_TRANS_TYPE_ALERT) {
        if (buttonIndex==1) {
            DLog(@"使用旧传输协议传文件");

        }
    }
}


#pragma mark - Socket
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    DLog(@"%s %d", __FUNCTION__, __LINE__);
    [_sendPlayerSocket readDataWithTimeout: -1 tag: 0];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    DLog(@"%s %d, tag = %ld", __FUNCTION__, __LINE__, tag);
    DLog(@"写数据完成");
    [_sendPlayerSocket readDataWithTimeout: -1 tag: tag];
}


- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    DLog(@"返回的数据");
    Byte *AckByte = (Byte *)[data bytes];
    DLog(@"ack[0]=%x",AckByte[0]);
    DLog(@"ack[1]=%x",AckByte[1]);
    DLog(@"ack[2]=%x",AckByte[2]);
    DLog(@"ack[3]=%x",AckByte[3]);
    DLog(@"ack[4]=%x",AckByte[4]);
    DLog(@"ack[5]=%x",AckByte[5]);

    if (AckByte[1] == 0x1D) {
        DLog(@"发送图数据成功");
        [self myFinishedPublishEvent];
    }

    if (AckByte[1] == 0x1c) {
        DLog(@"发送重置命令成功");
        if (AckByte[2]==0x00) {
            //重置完成
            num++;
            if (num<selectIpArr.count) {
                [self resetScreenPlayList];
            }
            else{
                num = 0;
                [self showRestScreenSuccess];
            }

        }else{
            [self showRestScreenfailed];
        }
    }

    if (AckByte[1] == 0x2C) {
        DLog(@"发送连续播放数据成功");
        [self myFinishedPublishEvent];
    }

    if (AckByte[1] == 0xD1) {
        DLog(@"发送重置命令成功");

        if (AckByte[3]==0x00) {
            [self showRestScreenSuccess];
        }else{
            [self showRestScreenfailed];
        }
    }

    [_sendPlayerSocket readDataWithTimeout: -1 tag: tag];
}



- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    DLog(@"willDisconnectWithError, err = %@", err);
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    DLog(@"%s %d", __FUNCTION__, __LINE__);
    if (isSendState) {
        [self stopPublishProgress];
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }
}

/**
 *  项目发送完成的处理
 */
-(void)myFinishedPublishEvent{
    if (isSendState) {
        [mySelectedProjectArray removeAllObjects];

        DLog(@"发送项目成功");
        _currentDataAreaIndex = 0;
        if (_currentDataArray) {
            [_currentDataArray removeAllObjects];
            [_currentDataArray release],_currentDataArray = nil;
        }
        isSendConfig = NO;
        isSendContent = NO;
        isAllSend = NO;

        /**
         *  如果是连续播放，则提示命令发送成功
         */
        if (isContinusPlay) {
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_playsendCompleted"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            isContinusPlay = NO;
        }else{
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_sendCompleted"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
        }
        [self stopPublishProgress];
    }
    UIButton *myButton = (UIButton*)[self.view viewWithTag:TAG_PUBLISH_PROJ_BUTTON];
    if (myButton==nil) {
        myButton = (UIButton*)[self.view viewWithTag:TAG_CREATE_GROUP_BUTTON];
    }
    myButton.titleLabel.text = [Config DPLocalizedString:@"adedit_PublishProj"];
    [myButton setTag:TAG_PUBLISH_PROJ_BUTTON];
    isContinusPlay = NO;
}

-(void)showRestScreenSuccess{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_tryRestScreenSuccess"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView setTag:TAG_REST_SCREEN_ALERT];
    [myAlertView show];
    [myAlertView release];
    
}

-(void)showRestScreenfailed{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_tryRestScreenfailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    [myAlertView release];
}

-(void)settingButtonClicked:(UIButton *)sender{
    [self changeButtonColor:sender.tag];
    CGRect frame = [self.view viewWithTag:TAG_AD].frame;
    [[self.view viewWithTag:TAG_AD] removeFromSuperview];
    if (selectPhotoVC) {
        selectPhotoVC.view.hidden = YES;
    }
    ud = [NSUserDefaults standardUserDefaults];
    if (sender.tag == 1) {
        [ud setObject:@"pingti" forKey:@"PingtiOrImage"];
    }
    else
    {
        [ud setObject:@"image" forKey:@"PingtiOrImage"];
    }
    
    
    ud = [NSUserDefaults standardUserDefaults];
    [myProductionsVC.view removeFromSuperview];
    [ud setObject:@"YES" forKey:@"ADD"];
    [videoCenterCollectionPullViewCtrl.view removeFromSuperview];
    [ud setObject:@"YES" forKey:@"ADD_TrainingView"];
    RELEASE_SAFELY(videoCenterCollectionPullViewCtrl);
    
    
    
    [secondMenuArray removeAllObjects];
    
    UIView *t = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [t setTag:TAG_AD];
    YXM_WiFiManagerViewController *wifiCtrl = [[YXM_WiFiManagerViewController alloc]init];
    [wifiCtrl.view setFrame:CGRectMake(0, 0, t.frame.size.width, t.frame.size.height)];
    [t addSubview:wifiCtrl.view];
    [self.view addSubview:t];
    
}
@end
