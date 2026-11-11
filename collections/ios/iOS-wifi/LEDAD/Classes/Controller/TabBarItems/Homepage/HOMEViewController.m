//
//  ViewController.m
//  VideoTest
//
//  Created by 安静。 on 15/4/3.
//  Copyright (c) 2015年 安静。. All rights reserved.
//

#import "HOMEViewController.h"
#import "PlayView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "ZipArchive.h"
#import "SDPieLoopProgressView.h"
@interface HOMEViewController (){
    
    UIPageControl * pageControl;
    
    NSArray *fileNameArray;
    UIButton *buttonUpData;
    UIButton *buttonDown;
    UIButton *buttonCeShiXiaZai;
    UIButton *buttonDelete;
    UIButton *buttonInitial;
    SDPieLoopProgressView *loopProgressView;

}

@property (strong,nonatomic)   PlayView * thePlayer;
@property (strong,nonatomic)  AVPlayer *avPlayer;
@end

@implementation HOMEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];




    self.view.backgroundColor = [UIColor blueColor];

    [self initButton];

    [self haveOrNohave];

    [self initView];


    //    AVAudioPlayer
}//viewDidLoad   加载view时执行方法


-(void)initButton
{

    //刷新按钮
    buttonUpData = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 100, 50)];
    [buttonUpData setTitle:@"刷新" forState:0];
    buttonUpData.backgroundColor = [UIColor grayColor];
    [buttonUpData addTarget:self action:@selector(updataButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    buttonUpData.hidden = YES;
    [self.view addSubview:buttonUpData];



    //下载按钮
    buttonDown = [[UIButton alloc]initWithFrame:CGRectMake(800, 50, 100, 50)];
    [buttonDown setTitle:@"配置播放路径" forState:0];
    buttonDown.backgroundColor = [UIColor grayColor];
    [buttonDown addTarget:self action:@selector(downButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    buttonDown.hidden = YES;
    [self.view addSubview:buttonDown];


    /////////////////////////////////////////////测试代码//////////////////////////////////////////////////////////

    buttonCeShiXiaZai = [[UIButton alloc]initWithFrame:CGRectMake(50, 600, 100, 50)];
    [buttonCeShiXiaZai setTitle:@"测试下载" forState:0];
    buttonCeShiXiaZai.backgroundColor = [UIColor grayColor];
    [buttonCeShiXiaZai addTarget:self action:@selector(ceshiButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonCeShiXiaZai];


    buttonDelete = [[UIButton alloc]initWithFrame:CGRectMake(800, 600, 100, 50)];
    [buttonDelete setTitle:@"清除缓存" forState:0];
    buttonDelete.backgroundColor = [UIColor grayColor];
    [buttonDelete addTarget:self action:@selector(buttonDeleteOnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    buttonDelete.hidden = YES;
    [self.view addSubview:buttonDelete];

    buttonInitial = [[UIButton alloc]initWithFrame:CGRectMake(425, 600, 100, 50)];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
