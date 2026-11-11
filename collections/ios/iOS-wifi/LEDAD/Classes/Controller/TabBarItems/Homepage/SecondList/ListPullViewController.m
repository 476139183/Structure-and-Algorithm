//
//  NewSCenterPullViewControllerGraidCell.m
//  PullingTableDemo
//
//  Created by ledmedia on 13-8-18.
//
#import "ListPullViewController.h"

#import "Config.h"
#import "DataColumns.h"
#import "DataItems.h"
#import "DataCategories.h"
#import "NewsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "MainDataJTOA.h"
#import "MainDataEntity.h"
#import "NewsWebCycleViewController.h"
#import "SecondMenuDataFilter.h"
#import "ASINetworkQueue.h"
#import "ProductsWebCycleViewController.h"
//#import "ProductList.h"

@implementation ListPullViewController
{
    NSInteger admoduleHeight;
}

@synthesize oneDataColumns;
@synthesize secondMenuArray;



-(id)init
{
    [super init];
    _newsList = [[NSMutableArray alloc]init];
    _firstPageUrl = [[NSString alloc]init];
    _nextPageUrl = [[NSMutableString alloc]initWithCapacity:1];
    tablelist= [[NSMutableArray alloc]init];
    secondMenuArray = [[NSMutableArray alloc]initWithCapacity:1];
    YGPtitleArray = [[NSMutableArray alloc]initWithCapacity:1];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadCustomView];
}

-(bool)checkDevice:(NSString*)name
{
    NSString* deviceType = [UIDevice currentDevice].model;
    //DLog(@"deviceType = %@", deviceType);
    
    NSRange range = [deviceType rangeOfString:name];
    return range.location != NSNotFound;
}

- (void)inserSegmentView
{
    admoduleHeight = 0;
    if ([secondMenuArray count]>0) {
        admoduleHeight=44;
        [YGPtitleArray removeAllObjects];
        for (int i=0; i<[secondMenuArray count]; i++) {
            [YGPtitleArray addObject:[(DataColumns*)[secondMenuArray objectAtIndex:i] column_name]];
        }
        _ygp = [[YGPSegmentedController alloc] initContentTitleContaintFrame:YGPtitleArray CGRect:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH/* *2 */,admoduleHeight) ContaintFrame:CGRectMake(0,[Config currentNavigateHeight], SCREEN_CGSIZE_WIDTH,admoduleHeight)];
        [_ygp setDelegate:self];
        [_ygp setUserInteractionEnabled:YES];
        [self.view setUserInteractionEnabled:YES];
        [self.view addSubview:_ygp];
    }
    DLog(@"admoduleHeight = %d",admoduleHeight);
}
-(void)loadCustomView{
    
    state=1;
    //二级目录
    [self inserSegmentView];
    
    CGRect bounds = CGRectMake(0, [Config currentNavigateHeight]+admoduleHeight, self.view.frame.size.width, SCREEN_CGSIZE_HEIGHT - [Config currentNavigateHeight] - admoduleHeight);
    dataTableView = [[UITableView alloc] initWithFrame:bounds];
    dataTableView.delegate = self;
    dataTableView.dataSource = self;
    [self.view addSubview:dataTableView];
    //下拉刷新
    SEL selAddHeader = @selector(addHeader);
    if ([self respondsToSelector:selAddHeader]) {
        DLog(@"respondsToSelector:selAddHeader");
        [self performSelector:selAddHeader];
    }
    //上拉加载更多
    SEL selAddFooter = @selector(addFooter);
    if ([self respondsToSelector:selAddFooter]) {
        [self performSelector:selAddFooter];
    }
    //修改后
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    DLog(@"[_newsList count]=%d",[_newsList count]);
    tablelist=[_newsList copy];
    return [tablelist count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataItems *dataitem=[tablelist objectAtIndex:[indexPath row]];
    NSString *CellIdentifier =[[NSString alloc]initWithFormat:@"%@-%@-%ld",dataitem.item_column_id,dataitem.item_id,(long)[indexPath row]];
    NewsTableViewCell *newstbcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (newstbcell == nil){
        newstbcell = [[[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier withdataNewsLeditem:dataitem] autorelease];
    }
    // Configure the cell...
    return newstbcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataItems *dataitem=[tablelist objectAtIndex:[indexPath row]];
    DLog(@"dataitem.item_url = %@",dataitem.item_url);
    DLog(@"dataitem.item_column_structure = %@",dataitem.item_column_structure);
    
    if ([dataitem.item_column_structure isEqualToString:@"product_new"])
    {
        productsWebCycleViewController = [[ProductsWebCycleViewController alloc] init];
        //列表的数据集,主要是获取数据结构标示
        [productsWebCycleViewController setOneDataColumn:oneDataColumns];
        //导航条上的标题
        [productsWebCycleViewController setTittleStr:oneDataColumns.column_name];
        //当前页的索引
        [productsWebCycleViewController setCurrentPageValue:indexPath.row];
        //列表中页面的数据集
        [productsWebCycleViewController setMyDataItemArray:_newsList];
        [self.navigationController pushViewController:productsWebCycleViewController animated:NO];
    }else
    {
        newsWebCycleViewController=[[NewsWebCycleViewController alloc]init];
        //列表的数据集,主要是获取数据结构标示
        [newsWebCycleViewController setOneDataColumn:oneDataColumns];
        //导航条上的标题
        //    [newsWebCycleViewController setTittleStr:oneDataColumns.column_name];
        //当前页的索引
        [newsWebCycleViewController setCurrentPageValue:indexPath.row];
        //列表中页面的数据集
        [newsWebCycleViewController setMyDataItemArray:_newsList];
        [self.navigationController pushViewController:newsWebCycleViewController animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - reloadData
//-(void)reloadCategoryData:(DataCategories *)oneDataCategory
//{
//    [MyTool getSecondMenuData:self oneDataCategory:oneDataCategory];
//}
//#pragma mark -
//-(void)queueFetchFailed:(ASIHTTPRequest *)request{
//    DLog(@"队列执行失败");
//    //关闭进度条
//    //    [MyTool stopProgress:self];
//}
//-(void)queueFetchFinished:(ASIHTTPRequest *)request{
//    DLog(@"队列执行完成,停止进度条,加载主页视图");
//    //    [MyTool stopProgress:self];
//    secondMenuArray = _ColumnsDataArray;
//    [self reloadData:[secondMenuArray objectAtIndex:0]];
//}
- (void)reloadData:(DataColumns *)columns
{
    oneDataColumns=columns;
    columnName = columns.column_name;
    DLog(@"columns.column_name=%@",columns.column_name);
    [_newsList removeAllObjects];
    _firstPageUrl = columns.column_url;
//    [self loadCustomView];
}
- (void)reloadSearchData:(NSString *)searchUrl
{
    [_newsList removeAllObjects];
    _firstPageUrl = [searchUrl retain];
    DLog(@"_firstPageUrl = %@",_firstPageUrl);
}


#pragma mark YGPSegmentedControllerDelegate
//水平选择菜单
-(void)segmentedViewController:(YGPSegmentedController *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    if (segmentedControl == _ygp) {
        DLog(@"segmentedControl.index :%d",index);
        oneDataColumns = (DataColumns*)[secondMenuArray objectAtIndex:index];
        _firstPageUrl = oneDataColumns.column_url;
        [_newsList removeAllObjects];
        [self addHeader];
    }
}

/**
 *@brief 下拉刷新的方法
 */
- (void)addHeader
{
    if (!header) {
        header = [MJRefreshHeaderView header];
    }
    header.scrollView = dataTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        DLog(@"MJRefreshBaseView下拉刷新了");
        mjRefreshBaseView = refreshView;
        [_newsList removeAllObjects];
        DLog(@"_firstPageUrl = %@",_firstPageUrl);
        [self sendAsynchronous:_firstPageUrl reqeusttagi:TAG_ONE_PAGE_DATA];
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        DLog(@"%@----刷新完毕", refreshView.class);
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState mjrstate) {
        // 控件的刷新状态切换了就会调用这个block
        switch (mjrstate) {
            case MJRefreshStateNormal:
                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
    [header beginRefreshing];
}

/**
 *@brief 上拉加载控件
 */
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = dataTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        DLog(@"下一页的地址 getNextPageURL = %@",_nextPageUrl);
        if (_nextPageUrl) {
            if ([_nextPageUrl isEqualToString:@"end"]) {
                DLog(@"CustomerViewController拉到底了");
            } else {
                DLog(@"CustomerViewController拉到加载");
                DLog(@"[DataItemsList getNextPageURL]=%@",_nextPageUrl);
                
                mjRefreshBaseView = refreshView;
                [self sendAsynchronous:_nextPageUrl reqeusttagi:TAG_ONE_PAGE_DATA];
                
                DLog(@"_newsList.count = %d",[_newsList count]);
            }
        }
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
    };
    _footer = footer;
}


- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [dataTableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
    DLog(@"endRefreshing--结束刷新");
}

//异步请求网络数据
-(void)sendAsynchronous:(NSString*)urlStr reqeusttagi:(NSInteger)reqeusttagi{
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",urlStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    asiHttp = [[ASIHTTPRequest alloc]initWithURL:url];
    asiHttp.delegate = self;
    asiHttp.tag = reqeusttagi;
    [asiHttp startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    DLog(@"数据加载完成");
    if (request.tag == TAG_ONE_PAGE_DATA) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"segmentYesOrNo"] isEqualToString:@"fromSearchVC"]) {
            [self parseDataProductListJsonString:request];
        }else {
            [self parseDataItemsJsonString:request];
        }
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    DLog(@"加载数据失败，检查网络");
    if (request.tag == TAG_ONE_PAGE_DATA) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([[ud objectForKey:@"segmentYesOrNo"] isEqualToString:@"fromSearchVC"]) {
            [self parseDataProductListJsonString:request];
        }else {
            [self parseDataItemsJsonString:request];
        }
    }
}


/**
 *@brief 解析返回的JSON数据的到列表对象的集合和下一页的URL
 */
-(void)parseDataItemsJsonString:(ASIHTTPRequest *)request{
    
    NSString *jsonString = [request responseString];
    //网络未读取到数据的时候，判断缓存是否存在，存在则读取缓存，有网络则写缓存
    NSString *urlStr = [[NSString alloc]initWithFormat:@"%@",[request url]];
    //缓存数据
    if ([jsonString length]==0) {
        if ([MyTool isExistsCacheFile:urlStr]) {
            jsonString = [MyTool readCacheString:urlStr];
        }
    }else{
        [MyTool writeCache:jsonString requestUrl:urlStr];
    }
    jsonString = [MyTool filterResponseString:jsonString];
    
    NSDictionary *itemsDataDictionary = [jsonString JSONValue];
    if ((itemsDataDictionary == nil) || (![itemsDataDictionary isKindOfClass:[NSDictionary class]])) {
        DLog(@"返回的数据非法，不是一个字典");
        return;
    }
    
    NSArray *itemsDataArray = [itemsDataDictionary objectForKey:[DataItems forkey]];
    if ((itemsDataArray == nil) || (![itemsDataArray isKindOfClass:[NSArray class]])) {
        DLog(@"返回的数据非法，字典内部不是包含的数组");
        return;
    }
    
    if (!_newsList) {
        _newsList = [[NSMutableArray alloc]init];
    }
    for (NSDictionary *oneDataItemDict in itemsDataArray) {
        DataItems *dataItems = [[DataItems alloc]init];
        dataItems.item_id = [oneDataItemDict objectForKey:@"item_id"];
        dataItems.item_title = [oneDataItemDict objectForKey:@"item_title"];
        dataItems.item_img = [oneDataItemDict objectForKey:@"item_img"];
        dataItems.item_url = [oneDataItemDict objectForKey:@"item_url"];
        dataItems.item_time = [oneDataItemDict objectForKey:@"item_time"];
        dataItems.item_column_id = [oneDataItemDict objectForKey:@"item_column_id"];
        dataItems.item_share_url = [oneDataItemDict objectForKey:@"item_share"];
        dataItems.item_introduce = [oneDataItemDict objectForKey:@"item_introduce"];
        dataItems.item_column_structure = [oneDataItemDict objectForKey:@"item_column_structure"];
        [_newsList addObject:dataItems];
    }
    
    
    //获得下一页数据
    NSArray *nextPageUrlArray = [itemsDataDictionary objectForKey:@"page"];
    if (!_nextPageUrl) {
        _nextPageUrl = [[NSMutableString alloc]init];
    }
    for (NSDictionary *nextPageUrlDictionary in nextPageUrlArray) {
        [_nextPageUrl setString:[nextPageUrlDictionary objectForKey:@"page_url"]];
    }
    if ([_nextPageUrl length] == 0) {
        [_nextPageUrl setString:@"end"];
    }
    
    [self performSelector:@selector(doneWithView:) withObject:mjRefreshBaseView];
}
//当从搜索产品页面跳转过来解析产品列表
-(void)parseDataProductListJsonString:(ASIHTTPRequest *)request
{
    NSString *jsonString = [request responseString];
    //网络未读取到数据的时候，判断缓存是否存在，存在则读取缓存，有网络则写缓存
    NSString *urlStr = [[NSString alloc]initWithFormat:@"%@",[request url]];
    //缓存数据
    if ([jsonString length]==0) {
        if ([MyTool isExistsCacheFile:urlStr]) {
            jsonString = [MyTool readCacheString:urlStr];
        }
    }else{
        [MyTool writeCache:jsonString requestUrl:urlStr];
    }
    jsonString = [MyTool filterResponseString:jsonString];
    
    NSDictionary *itemsDataDictionary = [jsonString JSONValue];
    DLog(@"itemsDataDictionary = %@",itemsDataDictionary);
    if ((itemsDataDictionary == nil) || (![itemsDataDictionary isKindOfClass:[NSDictionary class]])) {
        DLog(@"返回的数据非法，不是一个字典");
        return;
    }
    
    NSArray *itemsDataArray = [itemsDataDictionary objectForKey:@"list"];
    if ((itemsDataArray == nil) || (![itemsDataArray isKindOfClass:[NSArray class]])) {
        DLog(@"返回的数据非法，字典内部不是包含的数组");
        return;
    }
    
    if (!_newsList) {
        _newsList = [[NSMutableArray alloc]init];
    }
    for (NSDictionary *oneDataItemDict in itemsDataArray) {
        DataItems *dataItems = [[DataItems alloc]init];
        dataItems.item_id = [oneDataItemDict objectForKey:@"id"];
        dataItems.item_title = [oneDataItemDict objectForKey:@"title"];
        dataItems.item_img = [oneDataItemDict objectForKey:@"image"];
        dataItems.item_url = [oneDataItemDict objectForKey:@"url"];
        dataItems.item_time = nil;
        dataItems.item_column_id = nil;
        dataItems.item_share_url = nil;
        dataItems.item_introduce = nil;
        dataItems.item_column_structure = @"product_new";
        [_newsList addObject:dataItems];
    }
    
    
    //获得下一页数据
    NSArray *nextPageUrlArray = [itemsDataDictionary objectForKey:@"page"];
    if (!_nextPageUrl) {
        _nextPageUrl = [[NSMutableString alloc]init];
    }
    for (NSDictionary *nextPageUrlDictionary in nextPageUrlArray) {
        [_nextPageUrl setString:[nextPageUrlDictionary objectForKey:@"page_url"]];
    }
    if ([_nextPageUrl length] == 0) {
        [_nextPageUrl setString:@"end"];
    }
    
    [self performSelector:@selector(doneWithView:) withObject:mjRefreshBaseView];
}

////解决push出详细页面的时候残留显示tableview的问题
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [dataTableView setHidden:NO];
    [self inserSegmentView];
}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [dataTableView setHidden:YES];
//    [_ygp setHidden:YES];
//}


-(void)dealloc{
    [header free];
    [_footer free];
    [super dealloc];
}


@end
