//
//  ProductsWebCycleViewController.h
//  Chipshow
//
//  Created by LDY on 14-6-18.
//  Copyright (c) 2014年 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataItems.h"
#import "XLCycleScrollView.h"
#import "ProductOrCaseViewController.h"
#import "KKProgressTimer.h"

@class MyToolBar;
@class DataColumns;
@class DataColumns;
@class ProductContainerViewController;


@interface ProductsWebCycleViewController : UIViewController<UIGestureRecognizerDelegate,XLCycleScrollViewDatasource,XLCycleScrollViewDelegate,KKProgressTimerDelegate>
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
    
    ProductContainerViewController *oneWebCtrl;
    
    DataItems *oneDateItem;
    
    // 产品和参数按钮
    UIButton *buttonProduct;
    UIButton *buttonParameter;
    NSString *productOrParameterURL;
    NSString *page1_url;
    NSString *page2_url;
    NSString *page3_url;
    ProductOrCaseViewController *productOrCaseCtrl;
    NSDictionary *prOrPaDictionary;
    // 进度盘
    KKProgressTimer *myProgress;
}

extern ProductsWebCycleViewController *productsWebCycleViewController;

@property (nonatomic,retain) DataColumns *oneDataColumn;
@property (nonatomic,retain) DataItems *dataItem;
@property (nonatomic,assign) NSUInteger currentPageValue;
@property (nonatomic,assign) NSMutableArray *myDataItemArray;
@property (nonatomic,retain) XLCycleScrollView *csView;
@property (nonatomic,retain) NSString *tittleStr;
@property (nonatomic,retain) NSString *isFromWhere;

//返回上一主页
-(void)backToSuperView;

@end
