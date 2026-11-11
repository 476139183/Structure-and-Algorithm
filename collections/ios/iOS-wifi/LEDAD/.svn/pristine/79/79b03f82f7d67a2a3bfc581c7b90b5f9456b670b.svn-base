//
//  CommunityViewController.m
//  LED2Buy
//
//  Created by LDY on 14-7-3.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityTableViewCell.h"
#import "BBSEntity.h"
#import "MyTool.h"
#import "NSString+SBJSON.h"
#import "ContentViewController.h"


@interface CommunityViewController ()

@end

@implementation CommunityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    bbsTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    bbsTableView.dataSource = self;
    bbsTableView.delegate = self;
    [self.view addSubview:bbsTableView];
    
    [self startProgress];
    [self requestData];
}

- (void)requestData
{
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:URL_BBS_MAIN]];
    request.delegate = self;
    [request startAsynchronous];
}
#pragma mark - ASIHTTPRequestDelegate
-(void)requestFinished:(ASIHTTPRequest *)request
{
    DLog(@"请求论坛数据成功");
    [self parseBBSJsonString:request];
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    DLog(@"请求论坛数据失败");
    [self parseBBSJsonString:request];
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
    
    NSArray *BBSArrayJson = [jsonString JSONValue];
    if ((BBSArrayJson == nil) || (![BBSArrayJson isKindOfClass:[NSArray class]])) {
        DLog(@"返回的数据非法，不是一个数组");
        return;
    }
    
    if (!bbsArray) {
        bbsArray = [[NSMutableArray alloc]init];
    }
    for (NSDictionary *oneBBSDict in BBSArrayJson) {
        BBSEntity *oneBBS = [[BBSEntity alloc]init];
        oneBBS.m_id = [oneBBSDict objectForKey:@"m_id"];
        oneBBS.m_name = [oneBBSDict objectForKey:@"m_name"];
        oneBBS.status = [oneBBSDict objectForKey:@"status"];
        oneBBS.other = [oneBBSDict objectForKey:@"other"];
        oneBBS.lang = [oneBBSDict objectForKey:@"lang"];
        oneBBS.companyid = [oneBBSDict objectForKey:@"companyid"];
        [bbsArray addObject:oneBBS];
    }
    [bbsTableView reloadData];
    [self stopProgress:self.view];
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



#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [bbsArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier%d",indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[CommunityTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier] autorelease];
    }
    BBSEntity *oneBBSEntity = [bbsArray objectAtIndex:indexPath.section];
    cell.imageView.image = [UIImage imageNamed:@"BBS"];
    cell.textLabel.text = oneBBSEntity.m_name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = oneBBSEntity.other;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BBSEntity *oneBBSEntity = [bbsArray objectAtIndex:indexPath.section];
    contentVC = [[ContentViewController alloc] init];
    [contentVC requestData:oneBBSEntity.m_id];
    contentVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contentVC animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
