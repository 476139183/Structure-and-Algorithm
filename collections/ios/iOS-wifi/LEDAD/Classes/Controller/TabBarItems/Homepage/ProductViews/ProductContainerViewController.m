//
//  ProductContainerViewController.m
//  Chipshow
//
//  Created by LDY on 14-6-18.
//  Copyright (c) 2014年 JianYe. All rights reserved.
//

#import "ProductContainerViewController.h"
#import "Config.h"
#import "MyTool.h"
#import "AppDelegate.h"
#import "Reachability.h"
//#import "SGInfoAlert.h"
//#import "shareItemDBOperation.h"
#import "DataColumns.h"
//#import "Toast+UIView.h"
//#import "AHAlertView.h"
//#import "LoginViewController.h"
#import "Json2Analysis.h"
#import "ASIHTTPRequest.h"
#import "NSString+MD5.h"
#import "ProductGif.h"
#import "ProductsWebCycleViewController.h"

@interface ProductContainerViewController ()

@end

@implementation ProductContainerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_newsWebView) {
        [self webViewInit];
        DLog(@"webView 初始化");
    }
}

/**
 *@brief 初始化一个WebView并且添加到视图中
 */
-(void)webViewInit{
//    [self.view removeAllSubviews];
    _newsWebView  = [[UIWebView alloc]initWithFrame:CGRectMake( 0, 0,  self.view.frame.size.width , SCREEN_CGSIZE_HEIGHT - [Config currentNavigateHeight] - 44)];
    _newsWebView.scalesPageToFit = YES;
    [_newsWebView setUserInteractionEnabled: YES ];	 //是否支持交互
    [_newsWebView setDelegate: self ];				 //委托
    [_newsWebView setOpaque: YES ];					 //透明
    [self.view  addSubview:_newsWebView];
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
    if ([item.item_column_structure isEqualToString:@"product_new"]) {
        NSDictionary *dictionary=[Json2Analysis getNSDictionaryFromZDECUrl:item.item_url];
        NSDictionary *prOrPaDictionary=[dictionary objectForKey:@"item"];
        webViewUrl = [prOrPaDictionary objectForKey:@"page1_url"];
        [self addTapOnWebView];
    }
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
            }
            else{
                DLog(@"无缓存");
                NSString *htmlstring = @"<html></html>";
                [_newsWebView loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
            }
            DLog(@"读取网页内容的URL = %@",item.item_url);
            [[[[UIApplication sharedApplication] keyWindow] viewWithTag:TAG_PROGRESS] removeFromSuperview];
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

#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    DLog(@"webView开始加载,启动loading动画");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    DLog(@"webView加载成功,停止loading动画");
    
    [_newsWebView stringByEvaluatingJavaScriptFromString:@"document.getElementById('openapp').style.display='none'"];
    
    [[[[UIApplication sharedApplication] keyWindow] viewWithTag:TAG_PROGRESS] removeFromSuperview];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    DLog(@"webView加载失败");
    [[[[UIApplication sharedApplication] keyWindow] viewWithTag:TAG_PROGRESS] removeFromSuperview];
}

/**
 * @brief 点击产品后控制-暂停、放大缩小
 */
-(void)addTapOnWebView
{
    _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [_newsWebView addGestureRecognizer:_singleTap];
    _singleTap.delegate = self;
    _singleTap.cancelsTouchesInView = NO;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    
    CGPoint pt = [sender locationInView:_newsWebView];
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
    NSString *urlToSave = [_newsWebView stringByEvaluatingJavaScriptFromString:imgURL];
    DLog(@"%@",urlToSave);
    if ([urlToSave length] != 0) {
        [self newProductGifView:urlToSave];
    }
}
-(void)closeButtonClick{
    [_singleTap setEnabled:YES];
    //    [[_newsWebView viewWithTag:100101] removeFromSuperview];
    [closeButton removeFromSuperview];
    [productGif.view removeFromSuperview];
    DLog(@"[productGif retainCount] = %d",[productGif retainCount]);
    RELEASE_SAFELY(productGif);
}

// 产品gif展示
- (void)newProductGifView:(NSString *)gifPath{
    productGif = [[ProductGif alloc] init];
    productGif.filePath = gifPath;
    [productGif startLoadGif:gifPath];
    [productGif.view setTag:100101];
    
    [_singleTap setEnabled:NO];
    closeButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH-85, 25, 80, 30)];
    [closeButton setTag:100102];
    //    [closeButton setBackgroundImage:[UIImage imageNamed:@"closeGif.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:NSLocalizedString(@"NSStringClose", @"关闭") forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
    closeButton.titleLabel.textColor = [UIColor blackColor];
    //    [_newsWebView addSubview:productGif.view];
    [[[UIApplication sharedApplication] keyWindow] addSubview:productGif.view];
    [[[UIApplication sharedApplication] keyWindow] addSubview:closeButton];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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

@end
