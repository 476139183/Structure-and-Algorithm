////
////  NewsWebViewController.m
////  新闻的内容页面
////
////  Created by yxm on 2014年03月17日11:10:52.
////  Copyright (c) 2014年 ldy. All rights reserved.
////
//#import "Config.h"
//#import "NewsWebViewController.h"
//#import "MyTool.h"
////#import "AGApiViewControllers.h"
////#import "PushViewController.h"
//#import "AppDelegate.h"
//#import "Reachability.h"
////#import "SGInfoAlert.h"
////#import "shareItemDBOperation.h"
//#import "DataColumns.h"
////#import "Toast+UIView.h"
////#import "AHAlertView.h"
////#import "LoginViewController.h"
//
//
//@implementation NewsWebViewController
//@synthesize newsWebView = _newsWebView;
//- (id)init
//{
//    self = [super init];
//    return self;
//}
//
//
//-(void)insertWebView:(UIView *)contatinView{
//    if (!_newsWebView) {
//        _newsWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT-44)];
//        _newsWebView.scalesPageToFit = YES;
//        [_newsWebView setDelegate:self];
//        [_newsWebView setOpaque:YES];
//        [contatinView addSubview:_newsWebView];
//    }
//}
//
//
///**
// *@brief 根据指定的URL读取webView的内容
// */
//-(void)reloadWebviewurl:(DataItems *)item
//{
//    shareItem = item;
//    [self startProgress];
//    @try {
//        switch ([Reachability GobalcurrentReachabilityStatus]) {
//            case 1:
//            case 2:
//            {
//                /*
//                 判断网络的状态，如果网络为WiFi或者3G直接从网络拉去数据，并且更新缓存
//                 */
//                [self getOnLineWebView:item.item_url];
//            }
//                break;
//            default:
//            {
//                /*
//                 判断网络的状态，如果没有网络则从缓存中读取数据,如果没有缓存则返回
//                 */
//                [self getLocalCacheWebView:item.item_url];
//            }
//                break;
//        }
//    }
//    @catch (NSException *exception) {
//        DLog(@"WebView加载异常 = %@",exception);
//    }
//    @finally {
//        
//    }
//}
//
///**
// *@brief 获得本地离线下载的HTML
// */
//-(void)getLocalCacheWebView:(NSString *)requestURL{
//    if ([MyTool isExistsCacheFile:requestURL]) {
//        //本地有缓存文件
//        NSString *webContentString = [[NSString alloc]initWithData:[MyTool readCacheData:requestURL] encoding:NSUTF8StringEncoding];
//        
//        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches/"];
//        
////        webContentString = [webContentString stringByReplacingOccurrencesOfString:@"<img src=\"http://www.ledmediasz.com/pocket/" withString:[NSString stringWithFormat:@"<img src=\"%@",documentsDirectory]];
////        NSURL *baseURL = [NSURL fileURLWithPath:documentsDirectory];
////        DLog(@"baseURL = %@",baseURL);
//        
//        [_newsWebView loadHTMLString:[webContentString stringByReplacingOccurrencesOfString:@"<img src=\"http://www.ledmediasz.com/pocket/" withString:[NSString stringWithFormat:@"<img src=\"%@",documentsDirectory]] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//        RELEASE_SAFELY(webContentString);
//    }else{
//        //无缓存文件
//        [_newsWebView loadHTMLString:@"<html></html>" baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//    }
//}
//
///**
// *@brief 获得网络的HTML
// */
//-(void)getOnLineWebView:(NSString *)requestURL{
//    if ([MyTool isExistsCacheFile:requestURL]) {
//        [_newsWebView loadHTMLString:[[NSString alloc]initWithData:[MyTool readCacheData:requestURL] encoding:NSUTF8StringEncoding ] baseURL:[NSURL URLWithString:requestURL]];
//    }else{
//        [_newsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]]];
//    }
//    //本地离线文件写入
//    [MyTool writeCacheRequestUrl:requestURL];
//}
//
///**
// *@brief 改变网页的字体放大倍数
// */
//-(void)changeFontSize:(id)sender
//{
//    fontSize = ((DEVICE_IS_IPAD) ? FONT_SIZE_HAPLOID_WEB_VIEW_IPAD : FONT_SIZE_HAPLOID_WEB_VIEW) + ((haploid++)*100);
//    //如果放大的倍数大于最高值则回到0倍
//    if (haploid>FONT_SIZE_HAPLOID_LEVEL) {
//        haploid=0;
//    }
//    DLog(@"修改网页中字体大小,放大倍数 = %d%@",fontSize,@"%");
//    [MyTool changeWebView:_newsWebView HtmlContentTextSizeAdjust:fontSize];
//}
//
//
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    DLog(@"webView加载成功");
//    [self stopProgress];
//    //清理加载超时的计时器
//    if (webViewLoadTimer!=nil) {
//        [webViewLoadTimer invalidate],webViewLoadTimer=nil;
//    }
//    //加载时间清零
//    loadTime=0;
//    
//    [self changeFontSize:nil];
//}
//
//
//-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    DLog(@"webView加载失败");
//    [self stopProgress];
//}
//
////-(void)itemButtonClick:(id)sender
////{
////    DLog(@"itemButtonClick = %@",[shareItem description]);
////    shareItemDBOperation *collect = [[[shareItemDBOperation alloc]init] autorelease];
////    switch (([sender tag]-TAG_MYTOOLBAR)) {
////        case 0:
////        {
////            DLog(@"收藏");
////            if (![MyTool CheckIsLogin]) {
////                //判断是否登录了
////                [self alertViewLogin];
////                return;
////            }
////            [shareItem setItem_iscollect:@"1"];
////            [SGInfoAlert showInfo:[collect saveDataItems:shareItem]
////                          bgColor:[[UIColor darkGrayColor] CGColor]
////                           inView:_newsWebView
////                         vertical:0.7];
////        }
////            break;
////        case 1:
////        {
////            DLog(@"下载");
////            if (![MyTool CheckIsLogin]) {
////                //判断是否登录了
////                [self alertViewLogin];
////                return;
////            }
////            [MyTool writeCacheRequestUrl:shareItem.item_url];
////            [shareItem setItem_isdownload:@"1"];
////            [SGInfoAlert showInfo:[collect saveDownloadDataItems:shareItem]
////                          bgColor:[[UIColor darkGrayColor] CGColor]
////                           inView:_newsWebView
////                         vertical:0.7];
////        }
////            break;
////        case 2:
////        {
////            DLog(@"分享shareItem = %@",[shareItem description]);
////            [AGApiViewControllers shareApi:shareItem];
////        }
////            break;
////        case 3:
////            DLog(@"推送");
////            if (![MyTool CheckIsLogin]) {
////                //判断是否登录了
////                [self alertViewLogin];
////                return;
////            }
////            PushViewController *puchViewController = [[PushViewController alloc] initWithItem:shareItem];
////            [self.navigationController pushViewController:puchViewController animated:YES];
////            [puchViewController release];
////            break;
////        default:
////            break;
////    }
////}
////
////- (void)viewDidLoad
////{
////    [super viewDidLoad];
////    [self.view setBackgroundColor:[UIColor whiteColor]];
////    [self.view setFrame:[Config currentNoTabBarViewPortraitFrame]];
////    //增加WebView
////    [self insertWebView:self.view];
////    //设置底部工具栏
////    [MyTool insertBottomToolBar:self];
////    //增加分享的引用
////    [MyTool insertShareSDKButton:self];
////    //推送资源成功的提示
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPushSuccessMakeToast:) name:NOTI_SHOW_TOASTVIEW_PUSH_R object:nil];
////}
////
//////推送资源成功的提示
////-(void)showPushSuccessMakeToast:(NSNotification*)noti{
////    NSDictionary *messageDict = [noti userInfo];
////    //显示一个笑脸
////    [self.view makeToast:[messageDict objectForKey:MESSAGE_DICT_MSG]
////                duration:3.0
////                position:@"center"
////                   image:[UIImage imageNamed:@"smiletoast.png"]];
////}
//
//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//}
//
//
///**
// *@brief 显示提示登录的警告窗
// */
//-(void)alertViewLogin{
//    NSString *title = @"";
//	NSString *message = [[NSString alloc]initWithFormat:@"\n\n\n%@",NSLocalizedString(@"NSStringYouNotlogin", @"您尚未登陆，请登陆！")];
//    //自定义的提示框
//	AHAlertView *alert = [[AHAlertView alloc] initWithTitle:title message:message];
//    RELEASE_SAFELY(message);
//	[alert setCancelButtonTitle:NSLocalizedString(@"NSStringNO",@"取消") block:^{
//        alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
//        NSLog(@"点击了取消");
//	}];
//    
//    float faceWidth;
//    float faceHeight;
//    faceHeight = faceWidth = 45.0;
//    UIImageView *viewe = [[UIImageView alloc]initWithFrame:CGRectMake((alert.frame.size.width/2)-(faceWidth/2), 15.0, faceWidth, faceWidth)];
//    viewe.image = [UIImage imageNamed:@"crytoastimage.png"];
//    [alert addSubview:viewe];
//    RELEASE_SAFELY(viewe);
//	[alert addButtonWithTitle:NSLocalizedString(@"NSStringYes",@"确定") block:^{
//        [self jumpToLoginViewController];
//    }];
//	[alert show];
//    RELEASE_SAFELY(alert);
//}
//
/////**
//// *@brief 跳转到登陆页面
//// */
////-(void)jumpToLoginViewController{
////    LoginViewController *loginViewController= [[LoginViewController alloc]init];
////    UINavigationController *l = [[UINavigationController alloc]initWithRootViewController:loginViewController];
////    [self.navigationController presentViewController:l animated:YES completion:^{
////        
////    }];
////}
//
///**
// *@brief 开始进度条
// */
//-(void)startProgress{
//    KKProgressTimer *myProgress = [[KKProgressTimer alloc]initWithFrame:CGRectMake((SCREEN_CGSIZE_WIDTH/2)-50, (SCREEN_CGSIZE_HEIGHT/2)-50, 100, 100)];
//    myProgress.delegate = self;
//    [myProgress setTag:TAG_FIRST_PAGE_MY_PROGRESS];
//    [self.view addSubview:myProgress];
//    
//    __block CGFloat i3 = 0;
//    [myProgress startWithBlock:^CGFloat {
//        return ((i3++ >= 50) ? (i3 = 0) : i3) / 50;
//    }];
//}
//
///**
// *@brief 停止进度条
// */
//-(void)stopProgress{
//    KKProgressTimer *oldProgress = (KKProgressTimer *)[self.view viewWithTag:TAG_FIRST_PAGE_MY_PROGRESS];
//    [oldProgress stop];
//    [oldProgress removeFromSuperview];
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//}
//
//-(void)dealloc{
//    [super dealloc];
//}
//@end
//
//
