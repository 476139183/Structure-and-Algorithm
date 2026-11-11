//
//  webViewController.m
//  poptoolbar
//
//  Created by zzvcom on 12-8-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ContainterWebViewController.h"
#import "Config.h"
#import "MyTool.h"
//#import "AGApiViewControllers.h"
//#import "PushViewController.h"
#import "AppDelegate.h"
#import "Reachability.h"
//#import "SGInfoAlert.h"
//#import "shareItemDBOperation.h"
#import "DataColumns.h"
//#import "AHAlertView.h"
//#import "LoginViewController.h"
//#import "Toast+UIView.h"
//#import "Json2Analysis.h"
#import "ASIHTTPRequest.h"
#import "NSString+MD5.h"
#import "NewsWebCycleViewController.h"

@implementation ContainterWebViewController
@synthesize newsWebView = _newsWebView;

-(id)init{
    self = [super init];
    return self;
}

/**
 *@brief 根据输入的URL创建WebView
 */
-(void)readWebViewOfUrl:(DataItems *)item
{
    if (!_newsWebView) {
        [self webViewInit];
        DLog(@"webView 初始化");
    }
    
    webViewUrl = item.item_url;
    DLog(@"item.item_url = %@",item.item_url);
    DLog(@"item.item_column_structure = %@",item.item_column_structure);
    //加载本地HTML文件
    DLog(@"item.item_id = %@",item.item_id);
    if ([item.item_id isEqualToString:@"51130"]) {
        NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"itemid51130" ofType:@"html"];
        [_newsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
        return;
    }
    @try {
        //判断网络的状态
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
        
        /**
         *判断网络的状态，如果没有网络则从缓存中读取数据,如果没有缓存则返回
         */
        if ([netState isEqualToString:NET_STATUS_OFF])
        {
            if ([MyTool isExistsCacheFile:webViewUrl]) {
                //
                NSString *webContentString =[[NSString alloc]initWithData:[MyTool readCacheData:webViewUrl] encoding:NSUTF8StringEncoding ];
                NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches"];
                DLog(@"*documentsDirectory=%@",documentsDirectory);
                //                webContentString = [webContentString stringByReplacingOccurrencesOfString:URL_ZDEC_DOWNLOAD_REPLACE withString:[NSString stringWithFormat:@"src=\"%@",documentsDirectory]];
                //                webContentString = [webContentString stringByReplacingOccurrencesOfString:@"url('http://www.ledmediasz.com')" withString:[NSString stringWithFormat:@"url('%@')",@"20140417145741104.jpg"]];
                
                //2014年05月27日16:18:57产品图片可在我的下载中正常显示
                //                webContentString = [webContentString stringByReplacingOccurrencesOfString:@"http://www.ledmediasz.com" withString:documentsDirectory];
                
                webContentString = [MyTool filterResponseString:webContentString];
                
                NSString *saveFilePath = [[NSString alloc]initWithFormat:@"%@/%@",documentsDirectory,@"index222.html"];
                DLog(@"缓存网页保存的路径 = %@",saveFilePath);
                [webContentString writeToFile:saveFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                
                NSString *htmlstring=[[NSString alloc] initWithContentsOfFile:saveFilePath  encoding:NSUTF8StringEncoding error:nil];
                if ([webContentString length]>0) {
                    //                    [_newsWebView loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
                    
                    //2014年05月15日16:51:55
                    NSURL *baseURL = [NSURL fileURLWithPath:saveFilePath];
                    DLog(@"baseURL=%@",baseURL);
                    [_newsWebView loadHTMLString:htmlstring baseURL:baseURL];
                }
                DLog(@"缓存网页的内容 = %@",webContentString);
                DLog(@"有缓存");
            }else{
                DLog(@"无缓存");
                NSString *htmlstring = @"<html></html>";
                [_newsWebView loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
            }
            DLog(@"读取网页内容的URL = %@",item.item_url);
        }
        /*
         判断网络的状态，如果网络为3G/2G且缓存存在，则从缓存中读取数据,如果没有缓存则从网络拉取数据，并且更新缓存
         */
        if ([netState isEqualToString:NET_STATUS_WLAN])
        {
            [self getWebView:webViewUrl];
            DLog(@"读取网页内容的URL = %@",webViewUrl);
        }
        /*
         判断网络的状态，如果网络为WiFi直接从网络拉去数据，并且更新缓存
         */
        if ([netState isEqualToString:NET_STATUS_WIFI])
        {
            [_newsWebView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString :webViewUrl]]];
            //写入缓存到磁盘中
            [MyTool writeCacheRequestUrl:webViewUrl];
            DLog(@"读取网页内容的URL = %@",item.item_url);
        }
        /*end*/
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    @finally {
        
    }
    //    [self startProgress];
}

-(void)getWebView:(NSString *)item_url{
    //如果缓存存在则从缓存中读取数据,否则发送获取数据的请求
    if ([MyTool isExistsCacheFile:item_url]) {
        [_newsWebView loadHTMLString:[[NSString alloc]initWithData:[MyTool readCacheData:item_url] encoding:NSUTF8StringEncoding ] baseURL:[NSURL URLWithString:item_url]];
    }else
    {
        [_newsWebView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString :item_url]]];
    }
}

/**
 *@brief 改变网页的字体放大倍数
 */
-(void)changeFontSize:(id)sender
{
    fontSize = ((DEVICE_IS_IPAD) ? FONT_SIZE_HAPLOID_WEB_VIEW_IPAD : FONT_SIZE_HAPLOID_WEB_VIEW) + ((haploid++)*100);
    //如果放大的倍数大于最高值则回到0倍
    if (haploid>FONT_SIZE_HAPLOID_LEVEL) {
        haploid=0;
    }
    DLog(@"修改网页中字体大小,放大倍数 = %d%@",fontSize,@"%");
    [MyTool changeWebView:_newsWebView HtmlContentTextSizeAdjust:fontSize];
}

#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    DLog(@"webView开始加载,启动loading动画");
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    DLog(@"webView加载成功,停止loading动画");
    [_newsWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('openapp').style.display='none'"];
    haploid = 0;
    [self changeFontSize:nil];
    
    [[[[UIApplication sharedApplication] keyWindow] viewWithTag:TAG_PROGRESS] removeFromSuperview];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    DLog(@"webView加载失败");
    [[[[UIApplication sharedApplication] keyWindow] viewWithTag:TAG_PROGRESS] removeFromSuperview];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    DLog(@"%@",[request URL]);
    DLog(@"[[request URL] scheme] = %@",[[request URL] scheme]);
    NSString *mailUrl = [[NSString alloc] initWithFormat:@"%@",[request URL]];
    if ([mailUrl hasPrefix:@"mailto:"]) {
        DLog(@"发送邮件");
        mailUrl = [mailUrl stringByReplacingOccurrencesOfString:@"mailto:" withString:@""];
        DLog(@"mailUrl = %@",mailUrl);
        //        YXMSendMailViewController *sendMail = [[YXMSendMailViewController alloc] init];
        //        [sendMail displayMailPickerWithSubject:nil toRecipient:mailUrl emailBody:nil fromViewController:self];
        [newsWebCycleViewController sendMailto:mailUrl];
        return NO;
    }
    return YES;
}

/**
 *@brief 初始化一个WebView并且添加到视图中
 */
-(void)webViewInit{
//    NSInteger webviewFrameHeightOffset=44;
    _newsWebView  = [[UIWebView alloc]initWithFrame:CGRectMake( 0, 0,  self.view.frame.size.width , SCREEN_CGSIZE_HEIGHT - [Config currentNavigateHeight])];
    _newsWebView.scalesPageToFit = YES;
    [_newsWebView setUserInteractionEnabled: YES ];	 //是否支持交互
    [_newsWebView setDelegate: self ];				 //委托
    [_newsWebView setOpaque: YES ];					 //透明
    [self.view  addSubview:_newsWebView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_newsWebView) {
        [self webViewInit];
        DLog(@"webView 初始化");
    }
    //改变字体的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeFontSize:) name:NOTI_CHANGE_FONT_SIZE object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


/**
 *@brief 开始进度条
 */
-(void)startProgress{
    KKProgressTimer *myProgress = [[KKProgressTimer alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [myProgress setCenter:_newsWebView.center];
    myProgress.delegate = self;
    [myProgress setTag:1000];
    [_newsWebView addSubview:myProgress];
    
    __block CGFloat i3 = 0;
    [myProgress startWithBlock:^CGFloat {
        return ((i3++ >= 50) ? (i3 = 0) : i3) / 50;
    }];
}

/**
 *@brief 停止进度条
 */
-(void)stopProgress:(UIView *)containtView{
    KKProgressTimer *oldProgress = (KKProgressTimer *)[containtView viewWithTag:1000];
    [oldProgress stop];
    [oldProgress removeFromSuperview];
}


-(void)dealloc
{
    DLog(@"ContainterWebViewController.h进行了释放");
    _newsWebView.delegate = nil;
    while ([_newsWebView retainCount] >1) {
        [_newsWebView release];
        DLog(@"ContainterWebViewController.h进行了释放");
    }
    RELEASE_SAFELY(_newsWebView);
    DLog(@"ContainterWebViewController.h进行了释放");
    [super dealloc];
}

@end


