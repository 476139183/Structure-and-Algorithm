//
//  ProductOrCaseViewController.m
//  001ZDEC
//
//  Created by LDY on 13-12-16.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "ProductOrCaseViewController.h"
#import "Config.h"
#import "Reachability.h"
#import "MyTool.h"

@interface ProductOrCaseViewController ()

@end

@implementation ProductOrCaseViewController
@synthesize productOrParameterURL;

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
    DLog(@"%@",self);
	// Do any additional setup after loading the view
    webView=[[UIWebView alloc] initWithFrame:self.view.frame];
    webView.scalesPageToFit = YES;
    webView.opaque = YES;
    [self.view addSubview:webView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = self.titleText;
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app.absen.cn/api/page/id/1"]]];
    
    [self reloadWebviewurl:productOrParameterURL];
}

-(void)reloadWebviewurl:(NSString *)webUrl
{
    
    @try {
        //        AppDelegate *appDele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
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
        
        DLog(@"appDelegate.netStatusStr %@",netState);
        
        /*
         判断网络的状态，如果没有网络则从缓存中读取数据,如果没有缓存则返回
         */
        if ([netState isEqualToString:NET_STATUS_OFF])
        {
            if ([MyTool isExistsCacheFile:webUrl]) {
                //
                NSString *webContentString =[[NSString alloc]initWithData:[MyTool readCacheData:webUrl] encoding:NSUTF8StringEncoding ];
                NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches/"];
                
//                webContentString =[webContentString stringByReplacingOccurrencesOfString:URL_ZDEC_DOWNLOAD_REPLACE withString:[[NSString alloc] initWithFormat:@"src=\"%@",documentsDirectory]];
                NSString *saveFilePath = [[NSString alloc]initWithFormat:@"%@/%@",documentsDirectory,@"indexSYJ.html"];
                DLog(@"%@",saveFilePath);
                [webContentString writeToFile:saveFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                
                DLog(@"filePath=%@",saveFilePath);
                
                NSString *htmlstring=[[NSString alloc] initWithContentsOfFile:saveFilePath  encoding:NSUTF8StringEncoding error:nil];
                if ([webContentString length]>0) {
                    [webView loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:saveFilePath]];
                }
                
                
                DLog(@"写入的html = %@",webContentString);
                DLog(@"有缓存");
            }else{
                DLog(@"无缓存");
                NSString *htmlstring = @"<html></html>";
                [webView loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
            }
        }
        /*
         判断网络的状态，如果网络为3G/2G且缓存存在，则从缓存中读取数据,如果没有缓存则从网络拉取数据，并且更新缓存
         */
        if ([netState isEqualToString:NET_STATUS_WLAN])
        {
            [self getWebView:webUrl];
//            DLog(@"%@",item.item_url);
        }
        /*
         判断网络的状态，如果网络为WiFi直接从网络拉去数据，并且更新缓存
         */
        if ([netState isEqualToString:NET_STATUS_WIFI])
        {
            
            
            [webView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString :webUrl]]];
            
            [MyTool writeCacheRequestUrl:webUrl];

        }
        /*end*/
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}

-(void)getWebView:(NSString *)webUrl{
    if ([MyTool isExistsCacheFile:webUrl]) {
        [webView loadHTMLString:[[NSString alloc]initWithData:[MyTool readCacheData:webUrl] encoding:NSUTF8StringEncoding ] baseURL:[NSURL URLWithString:webUrl]];
    }else
    {
        [webView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString :webUrl]]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
