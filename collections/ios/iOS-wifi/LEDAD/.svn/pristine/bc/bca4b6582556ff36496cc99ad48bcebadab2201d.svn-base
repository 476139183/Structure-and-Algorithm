//
//  XLCycleScrollView.m
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import "XLCycleScrollView.h"

@implementation XLCycleScrollView

@synthesize scrollView = _scrollView;
@synthesize currentPage = _curPage;
@synthesize datasource = _datasource;
@synthesize delegate = _delegate;

- (void)dealloc
{
    DLog(@"XLCycleScrollView.h进行了释放");
    _datasource = nil;
    _delegate = nil;
    RELEASE_SAFELY(_scrollView);
    _scrollView.delegate = nil;
    RELEASE_SAFELY(_curViews);
    RELEASE_SAFELY(_readyLoadViews);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化已经加载过的视图
        _readyLoadViews = [[NSMutableDictionary alloc] init];
        // 初始化滚动容器
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        // 设置预加载的三个页面的大小
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        //水平滚动条设置为禁用
        _scrollView.showsHorizontalScrollIndicator = NO;
        //把预加载的三个页面滚动到中间
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        //每次滚动一整个页面
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        //当前页面设置为0
        _curPage = 0;
    }
    return self;
}

- (void)setDataource:(id<XLCycleScrollViewDatasource>)datasource
{
    _datasource = datasource;
    [self reloadData];
}

- (void)reloadData
{
    _totalPages = [_datasource numberOfPages];
    if (_totalPages == 0) {
        return;
    }
    
    [self loadData];
}

/**
 *@brief 加载数据
 */
- (void)loadData
{
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        //隐式循环,让数组中的每个元素 都调用 removeFromSuperview
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    //获得预加载三页的页面视图集合
    [self getDisplayImagesWithCurpage:_curPage];
    
    //把预加载三页的页面插入到滚动容器里面
    for (int i = 0; i < 3; i++) {
        UIView *v = [_curViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        //        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
        //                                                                                    action:@selector(handleTap:)];
        //        [v addGestureRecognizer:singleTap];
        //        [singleTap release];
        
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        if (v.frame.origin.x>SCREEN_CGSIZE_WIDTH)
        {
            float vOriX = SCREEN_CGSIZE_WIDTH;
            if (i==2)
            {
                vOriX = 0;
            }
            v.frame = CGRectMake(vOriX, v.frame.origin.y, v.frame.size.width,v.frame.size.height);
        }
        if ([[_curViews objectAtIndex:2] isEqual:[_curViews objectAtIndex:1]])
        {
            v.frame = CGRectMake(0, v.frame.origin.y, v.frame.size.width,v.frame.size.height);
        }
        DLog(@"__scrollView.subview = %@",v);
        [_scrollView addSubview:v];
    }
    //把滚动容器设置到中间一页显示
    float scrollViewOffset = _scrollView.frame.size.width;
    if ([[_curViews objectAtIndex:2] isEqual:[_curViews objectAtIndex:1]]) {
        scrollViewOffset = 0;
    }
    [_scrollView setContentOffset:CGPointMake(scrollViewOffset, 0)];
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
}

/**
 *@brief 获得预加载三页的页面视图集合
 */
- (void)getDisplayImagesWithCurpage:(int)page {
    DLog(@"page index = %d",page);
    //获得前一页的索引
    int pre = [self validPageValue:_curPage + 1];
    //获得后一页的索引
    int last = [self validPageValue:_curPage - 1];
    
    //如果保存预加载三页的集合未初始化,则初始化
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
    }
    
    [_curViews removeAllObjects];
    
    //保存当前页面
    NSNumber *proNum = [[NSNumber alloc]initWithInt:pre];
    NSNumber *pageNum = [[NSNumber alloc]initWithInt:page];
    NSNumber *lastNum = [[NSNumber alloc]initWithInt:last];
    
    if (![_readyLoadViews objectForKey:proNum]) {
        [_readyLoadViews setObject:[_datasource pageAtIndex:pre] forKey:proNum];
        [_curViews addObject:[_datasource pageAtIndex:pre]];
    }else{
        [_curViews addObject:[_readyLoadViews objectForKey:proNum]];
    }
    
    if (![_readyLoadViews objectForKey:pageNum]) {
        [_readyLoadViews setObject:[_datasource pageAtIndex:page] forKey:pageNum];
        [_curViews addObject:[_datasource pageAtIndex:page]];
    }else{
        [_curViews addObject:[_readyLoadViews objectForKey:pageNum]];
    }
    
    if (![_readyLoadViews objectForKey:lastNum]) {
        [_readyLoadViews setObject:[_datasource pageAtIndex:last] forKey:lastNum];
        [_curViews addObject:[_datasource pageAtIndex:last]];
    }else{
        [_curViews addObject:[_readyLoadViews objectForKey:lastNum]];
    }
    
    DLog(@" _curViews = %@",_curViews);
    //    [_curViews addObject:[_datasource pageAtIndex:pre]];
    //    [_curViews addObject:[_datasource pageAtIndex:page]];
    //    [_curViews addObject:[_datasource pageAtIndex:last]];
}

/**
 *@brief 验证页面索引的值的;
 *       如果当前页减去1为负数,则设置页面索引为最大页
 *       如果当前页面加1大于等于总页面数,则设置页面索引为最小页
 */
- (int)validPageValue:(NSInteger)value {
    
    if(value <= -1) {
        value = _totalPages - 1;
    }
    if(value >= _totalPages) {
        value = 0;
    }
    
    return value;
    
}

//- (void)handleTap:(UITapGestureRecognizer *)tap {
//
//    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
//        [_delegate didClickPage:self atIndex:_curPage];
//    }
//
//}

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
{
    if (index == _curPage) {
        [_curViews replaceObjectAtIndex:1 withObject:view];
        for (int i = 0; i < 3; i++) {
            UIView *v = [_curViews objectAtIndex:i];
            v.userInteractionEnabled = YES;
            //            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
            //                                                                                        action:@selector(handleTap:)];
            //            [v addGestureRecognizer:singleTap];
            //            [singleTap release];
            v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
            [_scrollView addSubview:v];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    int x = aScrollView.contentOffset.x;
    DLog(@"aScrollView.contentOffset.x = %d",x);
    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
        _curPage = [self validPageValue:_curPage + 1];
        DLog(@"_curPage = %d",_curPage);
        [self loadData];
    }
    
    //往上翻
    if(x <= 0) {
        _curPage = [self validPageValue:_curPage - 1];
        DLog(@"_curPage = %d",_curPage);
        [self loadData];
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
}

-(void)free{
    RELEASE_SAFELY(_readyLoadViews);
    RELEASE_SAFELY(_curViews);
}

@end
