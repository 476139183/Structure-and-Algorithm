//
//  ProductContainerViewController.h
//  Chipshow
//
//  Created by LDY on 14-6-18.
//  Copyright (c) 2014年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataItems.h"
#import "KKProgressTimer.h"

@class MyToolBar;
@class DataColumns;
@class ProductGif;

@interface ProductContainerViewController : UIViewController<UIWebViewDelegate,KKProgressTimerDelegate,UIGestureRecognizerDelegate>
{
    UIActivityIndicatorView * activityIndicator;
    
    NSString *netState;
    
    //webView网址
    NSString *webViewUrl;
    UIWebView *_newsWebView;
    UITapGestureRecognizer *_singleTap;
    ProductGif *productGif;
    UIButton *closeButton;
}

@property (nonatomic,retain) UIWebView *newsWebView;

/**
 *@brief 根据输入的URL创建WebView
 */
-(void)readWebViewOfUrl:(DataItems*)item;

@end
