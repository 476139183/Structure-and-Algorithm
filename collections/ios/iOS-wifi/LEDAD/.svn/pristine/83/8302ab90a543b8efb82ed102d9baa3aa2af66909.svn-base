//
//  ProductGif.m
//  Chipshow
//
//  Created by LDY on 14-4-14.
//  Copyright (c) 2014年 JianYe. All rights reserved.
//

#import "ProductGif.h"
#import "GEGifView.h"
#import "NSString+MD5.h"
#import "Config.h"
#import "KKProgressTimer.h"
#import "ASIHTTPRequest.h"

@interface ProductGif (){
    GEGifView* gifView3;
}

@end

@implementation ProductGif
//@synthesize filePath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self startProgress];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - Config.currentNavigatehight*2 - [Config topOffsetHight]);
    self.view.frame = CGRectMake(0, 20, self.view.frame.size.width, SCREEN_CGSIZE_HEIGHT - 20);
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)insertGEGifView{
    NSFileManager *file = [NSFileManager defaultManager];
    NSData *fileContentData = [file contentsAtPath:self.filePath];

    //gif图片
    gifView3 = [[GEGifView alloc] initWithData:fileContentData]; // gif which has many frames
    gifView3.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_CGSIZE_HEIGHT - 20);
    gifView3.backgroundColor = [UIColor grayColor];
    [gifView3 start];
    //增加点击手势控制gif状态、史勇杰2014年04月10日17:21:51
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stopAnimate)];
    _tap.numberOfTapsRequired = 1;
    gifView3.userInteractionEnabled = YES;
    [gifView3 addGestureRecognizer:_tap];
    
    //可放大缩小的scrollview
//    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, [Config topOffsetHight]-20, self.view.frame.size.width, self.view.frame.size.height-Config.currentNavigatehight*2 - [Config topOffsetHight])];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_CGSIZE_HEIGHT - 20)];
    [scrollView setBackgroundColor:[UIColor blackColor]];
    [scrollView setDelegate:self];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setMaximumZoomScale:5.0];
    [scrollView setContentSize:[gifView3 frame].size];
    [scrollView setMinimumZoomScale:[scrollView frame].size.width / [gifView3 frame].size.width];
    [scrollView setZoomScale:[scrollView minimumZoomScale]];
    [scrollView addSubview:gifView3];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [scrollView addGestureRecognizer:doubleTap];
    
    [[self view] addSubview:scrollView];
}

- (void)stopAnimate{
    if (gifView3.isAnimating) {
        [gifView3 pause];
    }else
    {
        [gifView3 start];
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return gifView3;
}

// 双击放大效果
- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    //    _doubleTap = YES;
    
    CGPoint touchPoint = [tap locationInView:scrollView];
	if (scrollView.zoomScale == scrollView.maximumZoomScale) {
		[scrollView setZoomScale:scrollView.minimumZoomScale animated:YES];
	} else {
		[scrollView zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
	}
}


/**
 *@brief 开始进度条
 */
-(void)startProgress{
    KKProgressTimer *myProgress = [[KKProgressTimer alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [myProgress setCenter:self.view.center];
    myProgress.delegate = self;
    [myProgress setTag:TAG_PROGRESS];
    
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
    KKProgressTimer *oldProgress = (KKProgressTimer *)[containtView viewWithTag:TAG_PROGRESS];
    [oldProgress stop];
    [oldProgress removeFromSuperview];
}

- (void)startLoadGif:(NSString *)urlToSave{
    
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/GIFImageCache"];
    NSString *filePath= [documentsDirectory
                         stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.gif",[urlToSave md5Encrypt]]];
    
//离线状态需修改路径
    NSString *imagePath = [urlToSave stringByReplacingOccurrencesOfString:@"file://" withString:@""];

    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        DLog(@"缓存*filePath= %@",urlToSave);
        self.filePath = imagePath;
        [self insertGEGifView];
        [self stopProgress:self.view];
    }
//判断是否存在缓存图片
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        DLog(@"缓存*filePath= %@",filePath);
        self.filePath = filePath;
        [self insertGEGifView];
        [self stopProgress:self.view];
    }
    else{
        ASIHTTPRequest *asiReguest = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlToSave]];
        [asiReguest setCompletionBlock:^{
            NSData *imageData = [asiReguest responseData];
            
            NSFileManager *file = [NSFileManager defaultManager];
            
            [file createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
            DLog(@"*filePath= %@",filePath);
            [imageData writeToFile:filePath atomically:YES];
            
            // 产品gif展示
            self.filePath = filePath;
            [self insertGEGifView];
            DLog(@"文件名urlToSave = %@",urlToSave);
            [self stopProgress:self.view];
        }];
        [asiReguest setFailedBlock:^{
            DLog(@"下载图片失败！！");
            [self stopProgress:self.view];
        }];
        [asiReguest startAsynchronous];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    /**
//     *@brief 友盟统计  传入的参数为页面标题
//     */
//    [MobClick beginLogPageView:@"虚拟产品"];
//}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    /**
//     *@brief 友盟统计 传入的参数为页面标题
//     */
//    [MobClick endLogPageView:@"虚拟产品"];
//}

- (void)dealloc{
    DLog(@"gifView3.retainCount = %d,\nscrollView.retainCount = %d",gifView3.retainCount, scrollView.retainCount);
    RELEASE_SAFELY(gifView3);
    RELEASE_SAFELY(scrollView);
    [super dealloc];
}

@end

