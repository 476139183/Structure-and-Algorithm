//
//  XLCycleScrollView.h
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import <UIKit/UIKit.h>
//代理方法
@protocol XLCycleScrollViewDelegate;
//数据源
@protocol XLCycleScrollViewDatasource;

@interface XLCycleScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    //代理方法
    id<XLCycleScrollViewDelegate> _delegate;
    //数据源
    id<XLCycleScrollViewDatasource> _datasource;
    
    //总页数
    NSInteger _totalPages;
    //当前页面
    NSInteger _curPage;
    
    //预加载的三个视图的集合
    NSMutableArray *_curViews;
    //已经加载过的页面
    NSMutableDictionary *_readyLoadViews;
    
    UITouch *myTouch;
    UIEvent *myEvent;
}

//滚动视图的容器
@property (nonatomic,readonly) UIScrollView *scrollView;
//当前页面的索引
@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,assign,setter = setDataource:) id<XLCycleScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<XLCycleScrollViewDelegate> delegate;

//当前预加载的三个页面的数据
- (void)reloadData;


- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;
//释放内存
-(void)free;
@end

@protocol XLCycleScrollViewDelegate <NSObject>

@optional
//点击了滚动视图中某一页触发的事件
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index;

@end

@protocol XLCycleScrollViewDatasource <NSObject>

@required
//返回左右滑动页的总数
- (NSInteger)numberOfPages;
//根据传入的页面索引返回滑动页面的某一页
- (UIView *)pageAtIndex:(NSInteger)index;

@end
