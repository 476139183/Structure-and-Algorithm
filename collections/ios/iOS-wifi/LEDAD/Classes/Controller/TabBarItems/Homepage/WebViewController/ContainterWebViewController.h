//
//  webViewController.h
//  poptoolbar
//
//  Created by zzvcom on 12-8-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataItems.h"
#import "KKProgressTimer.h"

@class MyToolBar;
@class DataColumns;

@interface ContainterWebViewController : UIViewController<UIWebViewDelegate,KKProgressTimerDelegate,UIGestureRecognizerDelegate>
{
    UIActivityIndicatorView * activityIndicator;
    
    NSString *netState;
    
    //存储加载的时间
    NSInteger loadTime;
    //记录加载的时间的定时器
    NSTimer *webViewLoadTimer;
    //网页中字体放大的倍数
    int fontSize;
    //倍数;
    int haploid;
    
    //webView网址
    NSString *webViewUrl;
    UIWebView *_newsWebView;
}
@property (nonatomic,retain) UIWebView *newsWebView;


/**
 *@brief 根据输入的URL创建WebView
 */
-(void)readWebViewOfUrl:(DataItems*)item;
/**
 *@brief 改变网页的字体放大倍数
 */
-(void)changeFontSize:(id)sender;
@end
