//
//  NewsWebCycleViewController.h
//  SZLEDIA
//
//  Created by yixingman on 1/16/14.
//  Copyright (c) 2014 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataItems.h"
#import "XLCycleScrollView.h"
#import "KKProgressTimer.h"

@class MyToolBar;
@class DataColumns;
@class DataColumns;
@class NewsWebCycleViewController;
@class ContainterWebViewController;

//处理点击事件
extern NewsWebCycleViewController *newsWebCycleViewController;

@interface NewsWebCycleViewController : UIViewController<UIGestureRecognizerDelegate,XLCycleScrollViewDatasource,XLCycleScrollViewDelegate,KKProgressTimerDelegate>
{
    //总页面
    NSInteger countValue;
    //当前页面
    NSUInteger currentPageValue;
    
    //存放左右滑动视图所有视图的数据集
    NSMutableArray *myDataItemArray;
    //包含列表结构的数据集
    DataColumns *oneDataColumn;
    
    //左右滑动视图的控件
    XLCycleScrollView *csView;
    //左右滑动视图中,当前显示视图的数据
    DataItems *dataItem;
    
    //存放已经加载的webView
    NSMutableDictionary *webViewDataSourseDictionary;
    
    //自定义顶部导航栏
    MyToolBar *topNavToolBar;
    //自定义底部工具栏
    MyToolBar *bottomToolbar;
    //标示从哪个页面进入
    NSString *isFromWhere;
    //左右翻页的索引
    NSInteger pageIndex;
    
    //网页中字体放大的倍数
    int fontSize;
    //倍数;
    int haploid;
    
    
    ContainterWebViewController *oneWebCtrl;
    
    DataItems *oneDateItem;
}
@property (nonatomic,retain) DataColumns *oneDataColumn;
@property (nonatomic,retain) DataItems *dataItem;
@property (nonatomic,assign) NSUInteger currentPageValue;
@property (nonatomic,assign) NSMutableArray *myDataItemArray;
@property (nonatomic,retain) XLCycleScrollView *csView;
@property (nonatomic,retain) NSString *tittleStr;
@property (nonatomic,retain) NSString *isFromWhere;

/**
 *@brief 改变网页的字体放大倍数
 */
-(void)changeFontSize:(id)sender;

//返回上一主页
-(void)backToSuperView;

/**
 *@brief 停止进度条
 */
-(void)stopProgress:(UIView *)containtView;

//发送邮件
-(void)sendMailto:(NSString *)mailUrl;
@end
