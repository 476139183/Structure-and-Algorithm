//
//  NewsWebViewController.h
//  新闻的内容页面
//
//  Created by yxm on 2014年03月17日11:10:52.
//  Copyright (c) 2014年 ldy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataItems.h"
#import "KKProgressTimer.h"

@class MyToolBar;
@class DataColumns;

@interface NewsWebViewController : UIViewController<UIWebViewDelegate,KKProgressTimerDelegate>
{
    UIWebView *_newsWebview;
    DataItems *shareItem;
    //存储加载的时间
    NSInteger loadTime;
    //记录加载的时间的定时器
    NSTimer *webViewLoadTimer;
    //网页中字体放大的倍数
    int fontSize;
    //倍数;
    int haploid;
}
@property (nonatomic,retain) UIWebView *newsWebView;
-(void)reloadWebviewurl:(DataItems*)item;
-(void)insertWebView:(UIView *)contatinView;
@end
