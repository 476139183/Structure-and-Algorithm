//
//  VideosCenterCollectionPullViewController.m
//  视频播放的网格显示界面
//
//  Created by yixingman on 2014年03月20日.
//
#import "VideosCenterCollectionPullViewController.h"

#import "Config.h"
#import "DataColumns.h"
#import "DataColumnsList.h"
#import "DataItemsList.h"
#import "DataItems.h"
#import "DataCategories.h"
#import "DataCategoriesList.h"

#import "VideoViewController.h"
#import "UIImageView+WebCache.h"
#import "MGScrollView.h"
#import "MGTableBoxStyled.h"
#import "MGLine.h"
#import "CollectionCellPhotoBox.h"




//VideosCenterCollectionPullViewController *videoCenterCollectionPullViewCtrl;
UINavigationController *videoNav;

static NSString *MJCollectionViewCellIdentifier = @"myCollectionCell";
@implementation VideosCenterCollectionPullViewController
{
    int cellTag;
}

@synthesize videosList = _videosList;
@synthesize oneDataColumns;
@synthesize gridCollectionView = _gridCollectionView;
//水平滑动按钮
@synthesize secondMenuArray;

-(id)init
{
    [super init];
    self.view.backgroundColor = [UIColor cyanColor];
    //视频的数据源
    _videosList = [[NSMutableArray alloc]init];
    //数据分页的第一页
    _firstPageUrl = [[NSString alloc]init];
    _firstPageUrl = [Config DPLocalizedString:@"adedit_url"];
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"YES" forKey:@"ADD_TrainingView"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UILabel *toptitle = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, topview.frame.size.width - 100, topview.frame.size.height)];
    toptitle.text = [Config DPLocalizedString:@"Button_syproject1"];
    toptitle.font = [UIFont systemFontOfSize:20];
    toptitle.textAlignment = NSTextAlignmentCenter;
    topview.backgroundColor =[UIColor lightGrayColor];
    [topview addSubview:toptitle];
    [self.view addSubview:topview];

    DLog(@"SCREEN_CGSIZE_HEIGHT = %f",self.view.frame.origin.y);
//    if (DEVICE_IS_IPAD) {
//        self.view.frame = CGRectMake(70, 0, SCREEN_CGSIZE_HEIGHT - 70, SCREEN_CGSIZE_WIDTH);
//    }else {
//        self.view.frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, self.view.frame.size.height - 60);
//    }
    DLog(@"self.view.frame.size.height = %f",self.view.frame.size.height);
    
//    为适配云屏市场注释掉了
//    NSString *topnavistr=[[NSString alloc]initWithFormat:@"topnavigata.png"];
//    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:topnavistr]];
//    titleImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
//    
//    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 12, SCREEN_CGSIZE_WIDTH-120, 20)];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    
//    titleLabel.text=self.titleLabelText;
//    //    DLog(@"titleLabel.text=%@",titleLabel.text);
//    titleLabel.textColor = [UIColor whiteColor];
//    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [titleImageView addSubview:titleLabel];
//    [titleLabel release];
//    
//    UIButton *callModalViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [callModalViewButton setFrame:CGRectMake(7.0f, 7.0f, 47.0f, 30.0f)];
//    [callModalViewButton addTarget:self action:@selector(backToSuperView) forControlEvents:UIControlEventTouchUpInside];
//    callModalViewButton.backgroundColor = [UIColor clearColor];
//    [callModalViewButton setImage:[UIImage imageNamed:@"backitem.png"] forState:UIControlStateNormal];
//    
//    [self.view addSubview:titleImageView];
//    [titleImageView release];
//    [self.view addSubview:callModalViewButton];
    
//水平滑动按钮
    NSInteger admoduleHeight=0;
    if ([secondMenuArray count]>0) {
        
        DLog(@"secondMenuArray=%@",secondMenuArray);
        admoduleHeight=44;
        YGPtitleArray = [[NSMutableArray alloc]initWithCapacity:1];
        [YGPtitleArray removeAllObjects];
        for (int i=0; i<[secondMenuArray count]; i++) {
            DataColumns *oneDataColumnsM = (DataColumns*)[secondMenuArray objectAtIndex:i];
            [YGPtitleArray addObject:oneDataColumnsM.column_name];
        }
        if (!_ygp) {
//            为适配云屏市场做出修改2014年08月18日14:49:47
//            _ygp = [[YGPSegmentedController alloc] initContentTitleContaintFrame:YGPtitleArray CGRect:CGRectMake(0,0, SCREEN_CGSIZE_WIDTH/* *2 */,admoduleHeight) ContaintFrame:CGRectMake(0,[Config currentNavigateHeight], SCREEN_CGSIZE_WIDTH,admoduleHeight)];
            
            if (DEVICE_IS_IPAD) {
                _ygp = [[YGPSegmentedController alloc] initContentTitleContaintFrame:YGPtitleArray CGRect:CGRectMake(0, 0, SCREEN_CGSIZE_HEIGHT - 70/* *2 */,admoduleHeight) ContaintFrame:CGRectMake(1, 1, SCREEN_CGSIZE_HEIGHT - 72,admoduleHeight)];
            }else {
                _ygp = [[YGPSegmentedController alloc] initContentTitleContaintFrame:YGPtitleArray CGRect:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH/* *2 */,admoduleHeight) ContaintFrame:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH,admoduleHeight)];
            }

            //
            [_ygp setDelegate:self];
            [_ygp setUserInteractionEnabled:YES];
            [self.view setUserInteractionEnabled:YES];
            [self.view addSubview:_ygp];
        }

        [_ygp setHidden:NO];
    }else{
        admoduleHeight=0;
        [_ygp setHidden:YES];
    }

//    为适配云屏市场做出修改2014年08月18日14:49:47
//    CGRect gridCollectionViewFrame = CGRectMake( 0, 0, self.view.frame.size.width, SCREEN_CGSIZE_HEIGHT - [Config currentNavigateHeight]-admoduleHeight);
//    floorScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [Config currentNavigateHeight] + admoduleHeight, self.view.frame.size.width, SCREEN_CGSIZE_HEIGHT - [Config currentNavigateHeight]-admoduleHeight)];
    CGRect gridCollectionViewFrame = CGRectMake( 0, 0, SCREEN_CGSIZE_HEIGHT - 70, SCREEN_CGSIZE_WIDTH - 45);
    
    floorScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_CGSIZE_HEIGHT - 70, SCREEN_CGSIZE_WIDTH )];
    [floorScrollView setBackgroundColor:[UIColor whiteColor]];
    [floorScrollView setContentSize:CGSizeMake(SCREEN_CGSIZE_HEIGHT - 70, SCREEN_CGSIZE_WIDTH - 45 + 1)];
    
    if (!DEVICE_IS_IPAD) {
        gridCollectionViewFrame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - 60);
        floorScrollView.frame = CGRectMake(0, 44, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - 60-44);
        floorScrollView.contentSize = CGSizeMake(SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - 60);
    }
    
    //网格视图的容器
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //每个格子的大小
    layout.itemSize = CGSizeMake(SCREEN_CGSIZE_WIDTH/4, SCREEN_CGSIZE_WIDTH/4);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 20;
    _gridCollectionView = [[UICollectionView alloc]initWithFrame:gridCollectionViewFrame collectionViewLayout:layout];
    
    [_gridCollectionView setBackgroundColor:[UIColor whiteColor]];
    [_gridCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
    _gridCollectionView.delegate = self;
    _gridCollectionView.dataSource = self;
    [floorScrollView addSubview:_gridCollectionView];
    [floorScrollView setUserInteractionEnabled:YES];
    [self.view addSubview:floorScrollView];
    //下拉刷新
    [self addHeader];
    //上拉加载
    [self addFooter];
    
}


#pragma mark - collectionView数据源代理
//在一个section中item数量,也就是数据源的条数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_videosList count];
}

//返回每个item的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cellTag = indexPath.row;
    DataItems *oneDataItem = [_videosList objectAtIndex:cellTag];
    
    DLog(@"oneDataItem.item_img = %@",oneDataItem.item_img);
    
//cell 上view重叠
//    [cell addSubview:[CollectionCellPhotoBox photoBoxFor:cellTag boxData:oneDataItem size:CGSizeMake(SCREEN_CGSIZE_WIDTH/4,SCREEN_CGSIZE_WIDTH/4)]];
    cell.backgroundView =[CollectionCellPhotoBox photoBoxFor:cellTag boxData:oneDataItem size:CGSizeMake(SCREEN_CGSIZE_WIDTH/4,SCREEN_CGSIZE_WIDTH/4)];
    return cell;
}

#pragma mark - UICollectionViewDelegate   点击了某一个视频

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    DataItems *oneDataItem = [_videosList objectAtIndex:indexPath.row];
    DLog(@"点击某个视图%ld,%ld, url = %@",(long)indexPath.section,(long)indexPath.row,oneDataItem.item_url);
    
    
    
    
    DataItems *dataItem=[_videosList objectAtIndex:indexPath.row];
    
    //跳转界面==
    if (videoViewController==nil) {
        videoViewController=[[VideoViewController alloc]init];
    }
    
    
    [videoViewController loadVideoView:dataItem];
    DLog(@"oneDataColumns.column_structure=%@",oneDataColumns.column_structure);
    if (oneDataColumns.column_structure == nil) {
        oneDataColumns.column_structure = @"product";
    }
    
    DLog(@"dataitem.item_share_url=%@",dataItem.item_share_url);
    DLog(@"dataitem.item_url=%@",dataItem.item_url);
//    为适应云屏市场修改2014年08月18日15:20:02
//    [self.navigationController pushViewController:videoViewController animated:YES];
    
    if (OS_VERSION_FLOAT >= 8.0) {
//        [[[UIApplication sharedApplication] keyWindow] addSubview:videoViewController.view];
        [self.view addSubview:videoViewController.view];
    }else {
        
        [self presentViewController:videoViewController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    DLog(@"内存报警");
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载视频列表数据
/**
 *@brief 初次加载视频列表或者重新加载视频列表的第一页
 *输入参数为:::上一级菜单被点击的数据行的数据DataColumns
 */
-(void)reloadData:(DataColumns *)columns
{
//    DLog(@"视频播放列表第一页的url=%@",columns.column_url);
//    _firstPageUrl = columns.column_url;
    _firstPageUrl = [Config DPLocalizedString:@"adedit_url"];
//    _firstPageUrl = @"http://www.ledmediasz.com/api_LED/LEDThirdStepAPI.aspx?columnsid=9595&module=16";//测试2014年08月18日15:15:06
//修改为异步网络请求数据
//    _videosList = [DataItemsList getDataItemsList:columns.column_url];
//    DLog(@"视频数据集的列数:_videosList.count = %d",[_videosList count]);
//
//    //刷新网格
    [self addHeader];
}



/**
 *@brief 上拉加载数据
 */
- (void)loadDataReload{
    
    if ([[DataItemsList getNextPageURL] isEqualToString:@"end"]) {
        DLog(@"数据加载到最后一页了");
    } else {
        DLog(@"上拉加载数据,下一页数据加载成功");
        NSMutableArray *nextPageVideosList=[DataItemsList getDataItemsList:[DataItemsList getNextPageURL]];
        DLog(@"nextPageVideosList.count =%lu",(unsigned long)[nextPageVideosList count]);
        [_videosList addObjectsFromArray:nextPageVideosList];
        DLog(@"视频数据集的列数:_videosList.count = %lu",(unsigned long)[_videosList count]);
    }
}


/**
 *@brief 加载视频列表第一页的数据,也就是下拉刷新
 */
-(void)loadDataRefresh
{
    DLog(@"加载视频列表第一页的数据,也就是下拉刷新");
    [_videosList removeAllObjects];
//修改为异步加载
//    _videosList = [DataItemsList getDataItemsList:_firstPageUrl];
    [self sendAsynchronous:_firstPageUrl reqeusttagi:TAG_ONE_PAGE_DATA];
    DLog(@"_videosList.count = %lu , _firstPageUrl = %@",(unsigned long)[_videosList count],_firstPageUrl);
}

/**
 *@brief 上拉加载控件
 */
- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = floorScrollView;
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
            }
        }
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];

    };
    _footer = footer;
}

/**
 *@brief 下拉刷新的方法
 */
- (void)addHeader
{
    if (!header) {
        header = [MJRefreshHeaderView header];
    }
    header.scrollView = floorScrollView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        mjRefreshBaseView = refreshView;
        [_videosList removeAllObjects];
        [self loadDataRefresh];
//        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        DLog(@"%@----刷新完毕", refreshView.class);
        
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState mjrstate) {
        // 控件的刷新状态切换了就会调用这个block
        switch (mjrstate) {
            case MJRefreshStateNormal:
                DLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                DLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                DLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
    [header beginRefreshing];
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    //刷新网格
    [_gridCollectionView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
    DLog(@"endRefreshing--结束刷新");
}


/**
 *@brief 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    NSLog(@"MJTableViewController--dealloc---");
    RELEASE_SAFELY(_videosList);
    RELEASE_SAFELY(videoViewController);
    RELEASE_SAFELY(_firstPageUrl);
    [_header free];
    [_footer free];
    [super dealloc];
}

//返回按钮
-(void)backToSuperView
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark HorizMenu Data Source
//水平选择菜单
-(void)segmentedViewController:(YGPSegmentedController *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    
    
    if (segmentedControl == _ygp) {
        DLog(@"segmentedControl.index :%ld",index);
        DataColumns *oneDataColumnsM = (DataColumns*)[secondMenuArray objectAtIndex:index];
        [self reloadData:oneDataColumnsM];
    }
}
#pragma mark - ASIHTTPRequest
//异步请求网络数据
-(void)sendAsynchronous:(NSString*)urlStr reqeusttagi:(NSInteger)reqeusttagi{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlStr]];
    ASIHTTPRequest *asiHttp = [[ASIHTTPRequest alloc]initWithURL:url];
    asiHttp.delegate = self;
    asiHttp.tag = reqeusttagi;
    [asiHttp startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.tag == TAG_ONE_PAGE_DATA) {
        [self parseDataItemsJsonString:request];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    DLog(@"加载数据失败，检查网络");
    if (request.tag == TAG_ONE_PAGE_DATA) {
        [self parseDataItemsJsonString:request];
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

//    NSArray *itemsDataArray = [itemsDataDictionary objectForKey:@"view"];
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
        [_videosList addObject:dataItems];
        [dataItems release];
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



////需要统计的页面
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    /**
//     *@brief 友盟统计  传入的参数为页面标题
//     */
//    [MobClick beginLogPageView:self.titleLabelText];
//}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    /**
//     *@brief 友盟统计 传入的参数为页面标题
//     */
//    [MobClick endLogPageView:self.titleLabelText];
//}

@end