//
//  ADdetailViewController.m
//  LED2Buy
//
//  Created by LDY on 14-7-4.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "ADdetailViewController.h"
#import "MyTool.h"


@interface ADdetailViewController ()

@end

@implementation ADdetailViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    AdDetaiWebview = [[UIWebView alloc] initWithFrame:self.view.frame];
    AdDetaiWebview.delegate = self;
    AdDetaiWebview.scalesPageToFit = YES;
    [self.view addSubview:AdDetaiWebview];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadWebView];
    self.title = self.ad_title;
}

- (void)loadWebView
{
    DLog(@"self.ad_link = %@",self.ad_link);
    [AdDetaiWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.ad_link]]];
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
    [MyTool changeWebView:AdDetaiWebview HtmlContentTextSizeAdjust:fontSize];
}


#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self startProgress];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self stopProgress];
    [self changeFontSize:nil];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self stopProgress];
}

#pragma mark - KKProgressTimer
/**
 *@brief 开始进度条
 */
-(void)startProgress{
    KKProgressTimer *myProgress = [[KKProgressTimer alloc]initWithFrame:CGRectMake((SCREEN_CGSIZE_WIDTH/2)-50, (SCREEN_CGSIZE_HEIGHT/2)-50, 100, 100)];
    myProgress.delegate = self;
    [myProgress setTag:TAG_FIRST_PAGE_MY_PROGRESS];
    [self.view addSubview:myProgress];
    
    __block CGFloat i3 = 0;
    [myProgress startWithBlock:^CGFloat {
        return ((i3++ >= 50) ? (i3 = 0) : i3) / 50;
    }];
}

/**
 *@brief 停止进度条
 */
-(void)stopProgress{
    KKProgressTimer *oldProgress = (KKProgressTimer *)[self.view viewWithTag:TAG_FIRST_PAGE_MY_PROGRESS];
    [oldProgress stop];
    [oldProgress removeFromSuperview];
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
