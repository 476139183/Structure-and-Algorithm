//
//  ContentViewController.m
//  LED2Buy
//
//  Created by LDY on 14-7-16.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentTableViewCell.h"
#import "MyTool.h"
#import "NSString+SBJSON.h"
#import "BBSContentEntity.h"
#import "UIImageView+WebCache.h"
#import "BBSDetailViewController.h"
#import "SendBBSViewController.h"


@interface ContentViewController ()

@end

@implementation ContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        tmpContentArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(test)];
}
- (void)test
{
    DLog(@"发布贴子");
    SendBBSViewController *sendBBSVC = [[SendBBSViewController alloc] init];
    UINavigationController *sendBBSNav = [[UINavigationController alloc] initWithRootViewController:sendBBSVC];
    [self.navigationController presentViewController:sendBBSNav animated:YES completion:nil];
}

//请求主贴列表数据
- (void)requestData:(NSString *)m_id
{
//    NSURL *requestUrl = [NSURL URLWithString:@"http://www.ledmediasz.com/api_bbs/Article_list.aspx?companyid=2287&lang=cn&typeid=2&pageindex=2"];
    requestUrl = [NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",URL_BBS_CONTENTLIST, m_id] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"requestUrl = %@",requestUrl);
//    [self sendAsynchronous:requestUrl];
    //下拉刷新
    
    contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [Config currentNavigateHeight], SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - [Config currentNavigateHeight]) style:UITableViewStylePlain];
    contentTableView.delegate = self;
    contentTableView.dataSource = self;
    [self.view addSubview:contentTableView];
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
    
}

//异步请求网络数据
-(void)sendAsynchronous:(NSURL*)urlStr
{
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:urlStr];
    request.delegate = self;
    [request startAsynchronous];
}
#pragma mark - ASIHTTPRequestDelegate
-(void)requestFinished:(ASIHTTPRequest *)request
{
    DLog(@"请求论坛数据成功");
    [self parseBBSJsonString:request];
    [self stopProgress:self.view];
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    DLog(@"请求论坛数据失败");
    [self parseBBSJsonString:request];
    [self stopProgress:self.view];
}

/** 解析论坛 */
- (void)parseBBSJsonString:(ASIHTTPRequest *)request
{
    NSString *jsonString = [request responseString];
    //网络未读取到数据的时候，判断缓存是否存在，存在则读取缓存，有网络则写缓存
    NSString *urlStr = [[NSString alloc] initWithFormat:@"%@",[request url]];
    //缓存数据
    if ([jsonString length]==0) {
        if ([MyTool isExistsCacheFile:urlStr]) {
            jsonString = [MyTool readCacheString:urlStr];
        }
    }else{
        [MyTool writeCache:jsonString requestUrl:urlStr];
    }
    jsonString = [MyTool filterResponseString:jsonString];
    
    NSDictionary *contentsJson = [jsonString JSONValue];
    if ((contentsJson == nil) || (![contentsJson isKindOfClass:[NSDictionary class]])) {
        DLog(@"返回的数据非法，不是一个字典");
        return;
    }
    NSArray *itemsDataArray = [contentsJson objectForKey:@"items"];
    if ((itemsDataArray == nil) || (![itemsDataArray isKindOfClass:[NSArray class]])) {
        DLog(@"返回的数据非法，字典内部不是包含的数组");
        return;
    }
    
    if (!contentArray) {
        contentArray = [[NSMutableArray alloc]init];
    }
    for (NSDictionary *oneContentDict in itemsDataArray) {
        BBSContentEntity *oneContent = [[BBSContentEntity alloc]init];
        oneContent.article_id = [oneContentDict objectForKey:@"article_id"];
        oneContent.parent_id = [oneContentDict objectForKey:@"parent_id"];
        oneContent.title = [oneContentDict objectForKey:@"title"];
        oneContent.text = [oneContentDict objectForKey:@"text"];
        oneContent.contentid = [oneContentDict objectForKey:@"contentid"];
        oneContent.origpic = [oneContentDict objectForKey:@"origpic"];
        oneContent.thumbnail = [oneContentDict objectForKey:@"thumbnail"];
        oneContent.publishtime = [oneContentDict objectForKey:@"publishtime"];
        oneContent.source = [oneContentDict objectForKey:@"source"];
        oneContent.detailurl = [oneContentDict objectForKey:@"detailurl"];
        oneContent.contenttype = [oneContentDict objectForKey:@"contenttype"];
        oneContent.user = [oneContentDict objectForKey:@"user"];
        [contentArray addObject:oneContent];
    }
    
    //获得下一页数据
    NSArray *nextPageUrlArray = [contentsJson objectForKey:@"page"];
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

/**
 *@brief 开始进度条
 */
-(void)startProgress{
    KKProgressTimer *myProgress = [[KKProgressTimer alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [myProgress setCenter:self.view.center];
    myProgress.delegate = self;
    [myProgress setTag:TAG_PROGRESS + 1];
    
    [self.view addSubview:myProgress];
    __block CGFloat i3 = 0;
    [myProgress startWithBlock:^CGFloat {
        return ((i3++ >= 50) ? (i3 = 0) : i3) / 50;
    }];
}

/**
 *@brief 停止进度条
 */
-(void)stopProgress:(UIView *)containtView{
    KKProgressTimer *oldProgress = (KKProgressTimer *)[containtView viewWithTag:TAG_PROGRESS + 1];
    [oldProgress stop];
    if (oldProgress) {
        [oldProgress removeFromSuperview];
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
    header.scrollView = contentTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        DLog(@"MJRefreshBaseView下拉刷新了");
        mjRefreshBaseView = refreshView;
        [contentArray removeAllObjects];
        DLog(@"_firstPageUrl = %@",requestUrl);
        [self sendAsynchronous:requestUrl];
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
    footer.scrollView = contentTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        DLog(@"下一页的地址 getNextPageURL = %@",_nextPageUrl);
        if (_nextPageUrl) {
            if ([_nextPageUrl isEqualToString:@"end"]) {
                DLog(@"CustomerViewController拉到底了");
            } else {
                DLog(@"CustomerViewController拉到加载");
                DLog(@"[DataItemsList getNextPageURL]=%@",_nextPageUrl);
                
                mjRefreshBaseView = refreshView;
                [self sendAsynchronous:[NSURL URLWithString:_nextPageUrl]];
                
                DLog(@"_newsList.count = %d",[contentArray count]);
            }
        }
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
    };
    _footer = footer;
}
- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [contentTableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
    DLog(@"endRefreshing--结束刷新");
}



#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tmpContentArray = [contentArray copy];
    return [tmpContentArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier%d",indexPath.row];
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[ContentTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier] autorelease];
    }

    BBSContentEntity *oneContent = [tmpContentArray objectAtIndex:indexPath.row];
    [cell.leftImageView setImageWithURL:[NSURL URLWithString:[oneContent.user objectForKey:@"headimg"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text = [oneContent.user objectForKey:@"username"];
    cell.detailTextLabel.text = oneContent.title;
    cell.dateLabel.text = [MyTool TimestampToDate:oneContent.publishtime];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithRed:70.0/256 green:130.0/256 blue:180.0/256 alpha:1.0];
    cell.dateLabel.font = [UIFont systemFontOfSize:10];
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BBSContentEntity *oneContent = [tmpContentArray objectAtIndex:indexPath.row];
    DLog(@"\n帖子标题：%@\n发帖人：%@\n发帖时间：%@\n帖子内容：%@\n发帖人头像：%@\ncontentid = %@",oneContent.title, [oneContent.user objectForKey:@"username"], [MyTool TimestampToDate:oneContent.publishtime], oneContent.text, [oneContent.user objectForKey:@"headimg"], oneContent.contentid);
    BBSDetailViewController *bbsDetaiVC = [[BBSDetailViewController alloc] init];
    bbsDetaiVC.BBSTitle = oneContent.title;
    bbsDetaiVC.username = [oneContent.user objectForKey:@"username"];
    bbsDetaiVC.publishtime = [MyTool TimestampToDate:oneContent.publishtime];
    bbsDetaiVC.text = oneContent.text;
    bbsDetaiVC.headimg = [oneContent.user objectForKey:@"headimg"];
    bbsDetaiVC.contentid = oneContent.contentid;
    [self.navigationController pushViewController:bbsDetaiVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [header free];
    [_footer free];
    [super dealloc];
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
