//
//  ProductionsViewController.m
//  云屏
//
//  Created by LDY on 7/22/14.
//  Copyright (c) 2014 LDY. All rights reserved.
//

#import "ProductionsViewController.h"
#import "AboutViewController.h"
#import "Config.h"
#import "MyTool.h"
#import "DataCategories.h"
#import "DataCategoriesList.h"
#import "DataColumns.h"
#import "DataColumnsList.h"
#import "NSString+SBJSON.h"
#import "UIImageView+WebCache.h"
#import "ASIFormDataRequest.h"
#import "EditViewController.h"


@interface ProductionsViewController ()
{
    UIButton *exitButton;
    UIButton *editButton;
}

@end

@implementation ProductionsViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"fromWhere"] isEqualToString:@"fromHomepage"]) {
        if (DEVICE_IS_IPAD) {
            self.view.frame = CGRectMake(70, 0, SCREEN_CGSIZE_HEIGHT - 70, SCREEN_CGSIZE_WIDTH);
        }
        else {
            self.view.frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - 50);
        }
    }else {
        //返回按钮 从首页过来不显示返回按钮
        backToMainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backToMainButton.frame = CGRectMake(2, 2, 40, 40);
        [backToMainButton setBackgroundImage:[UIImage imageNamed:@"backToMainButton"] forState:UIControlStateNormal];
        [backToMainButton setBackgroundColor:[UIColor blackColor]];
        [backToMainButton addTarget:self action:@selector(backToMainImageView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backToMainButton];
    }
    
    //刷新按钮
    refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.frame = CGRectMake(0, 0, 60, 60);
    if (DEVICE_IS_IPAD) {
        refreshButton.center = CGPointMake(SCREEN_CGSIZE_HEIGHT/2, SCREEN_CGSIZE_WIDTH/2);
    }else {
        refreshButton.center = CGPointMake(SCREEN_CGSIZE_WIDTH/2, SCREEN_CGSIZE_HEIGHT/2);
        
        //查看设计师资料按钮
        UIButton *showDesignerViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        showDesignerViewButton.frame = CGRectMake(SCREEN_CGSIZE_WIDTH/2 - 30, 5, 60, 60);
        showDesignerViewButton.backgroundColor = [UIColor colorWithWhite:0.643 alpha:1.000];
        showDesignerViewButton.alpha = 0.7;
        showDesignerViewButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        showDesignerViewButton.layer.cornerRadius = 30;
        [showDesignerViewButton setImage:[UIImage imageNamed:@"tab_me_24x24@2x.png"] forState:UIControlStateNormal];
        [showDesignerViewButton setImage:[UIImage imageNamed:@"tab_me_select_24x24@2x.png"] forState:UIControlStateHighlighted];
        [showDesignerViewButton addTarget:self action:@selector(showDesignerView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:showDesignerViewButton];
    }
    [refreshButton setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    refreshButton.tag = TAG_REFRESH_BUTTON;
    [self.view addSubview:refreshButton];
    //加载数据
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInformation) name:NOTI_UPDATE_USER_INFORMATION object:nil];
}
//更新用户资料
- (void)updateUserInformation
{
    [aboutDesignerView.headImageView setImage:[UIImage imageWithContentsOfFile:[ud objectForKey:KEY_USER_HEADIMG]]];
    aboutDesignerView.nameLabel.text = [ud objectForKey:KEY_USER_NAME];
    aboutDesignerView.telLabel.text = [NSString stringWithFormat:@"Tel:%@",[ud objectForKey:KEY_USER_PHONE]];
    aboutDesignerView.qqLabel.text = [NSString stringWithFormat:@"QQ:%@",[ud objectForKey:KEY_USER_QQ]];
    aboutDesignerView.descriptionTextView.text = [ud objectForKey:KEY_USER_DESCRIPTION];
}

//加入设计师介绍视图
- (void)insertAboutDesignerView
{
    ud = [NSUserDefaults standardUserDefaults];
    if (![[ud objectForKey:@"fromWhere"] isEqualToString:@"fromPingtiDetailImageVC"]) {
        showDesignerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        showDesignerButton.frame = CGRectMake(0, SCREEN_CGSIZE_WIDTH/2 - 25, 35, 50);
        [showDesignerButton setImage:[UIImage imageNamed:@"chevron_black"] forState:UIControlStateNormal];
        [showDesignerButton addTarget:self action:@selector(showDesignerView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:showDesignerButton];
        
        containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 400, SCREEN_CGSIZE_WIDTH)];
        containerView.backgroundColor = [UIColor clearColor];
        
        aboutDesignerView = [[AboutDesignerView alloc] initWithFrame:CGRectMake(0, 0, 390, SCREEN_CGSIZE_WIDTH)];
        aboutDesignerView.backgroundColor = [UIColor whiteColor];
        [aboutDesignerView.headImageView setImageWithURL:[NSURL URLWithString:self.photoUrl] placeholderImage:[UIImage imageWithContentsOfFile:[ud objectForKey:KEY_USER_HEADIMG]]];
        DLog(@"self.photoUrl = %@\n[ud objectForKey:KEY_USER_HEADIMG] = %@",self.photoUrl, [ud objectForKey:KEY_USER_HEADIMG]);
        if (!aboutDesignerView.headImageView.image) {
            aboutDesignerView.headImageView.image = [UIImage imageNamed:@"placeholder"];
        }
        aboutDesignerView.nameLabel.text = self.nameString;
        aboutDesignerView.telLabel.text = [NSString stringWithFormat:@"Tel:%@",self.telString];
        aboutDesignerView.qqLabel.text = [NSString stringWithFormat:@"QQ:%@",self.qqString];
        aboutDesignerView.descriptionTextView.text = self.descriptionString;
        aboutDesignerView.descriptionTextView.editable = NO;
        
        if ([[ud objectForKey:@"fromWhere"] isEqualToString:@"fromHomepage"]) {
            //退出登录按钮
            exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [exitButton setFrame:CGRectMake(30, SCREEN_CGSIZE_WIDTH - 100, 330, 40)];
            [exitButton setTitle:NSLocalizedString(@"Yunping_logout", @"退出登录") forState:UIControlStateNormal];
            [exitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [exitButton setBackgroundColor:[UIColor colorWithWhite:0.762 alpha:1.000]];
            [exitButton setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
            exitButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [exitButton addTarget:self action:@selector(exitLoginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [aboutDesignerView addSubview:exitButton];
            
            editButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [editButton setFrame:CGRectMake(30, SCREEN_CGSIZE_WIDTH - 150, 330, 40)];
            [editButton setTitle:NSLocalizedString(@"Yunping_edit", @"编辑资料") forState:UIControlStateNormal];
            [editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [editButton setBackgroundColor:[UIColor colorWithWhite:0.762 alpha:1.000]];
            [editButton setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
            editButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [editButton addTarget:self action:@selector(editButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            [aboutDesignerView addSubview:editButton];
            
        }
        [containerView addSubview:aboutDesignerView];
        [self.view addSubview:containerView];
        
        //判断是否显示返回按钮
        if (backToMainButton) {
            [backToMainButton.superview bringSubviewToFront:backToMainButton];//把返回按钮置于最上层
        }
        designerViewHidden = NO;
    }else {
        designerViewHidden = YES;
    }
    if (!DEVICE_IS_IPAD) {
        showDesignerButton.hidden = YES;
        containerView.frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - 50);
        aboutDesignerView.frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - 50);
        editButton.frame = CGRectMake(30, SCREEN_CGSIZE_HEIGHT - 120 - 50, SCREEN_CGSIZE_WIDTH - 60, 30);
        exitButton.frame = CGRectMake(30, editButton.frame.origin.y + 40, SCREEN_CGSIZE_WIDTH - 60, 30);
        
        UIButton *hideDesignerViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [hideDesignerViewButton setFrame:CGRectMake(30, SCREEN_CGSIZE_HEIGHT - 90, SCREEN_CGSIZE_WIDTH - 60, 30)];
        [hideDesignerViewButton setTitle:NSLocalizedString(@"Yunping_showDesigns", @"查看设计作品") forState:UIControlStateNormal];
        [hideDesignerViewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [hideDesignerViewButton setBackgroundColor:[UIColor colorWithWhite:0.762 alpha:1.000]];
        [hideDesignerViewButton setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
        hideDesignerViewButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [hideDesignerViewButton addTarget:self action:@selector(hideDesignerView) forControlEvents:UIControlEventTouchUpInside];
        [aboutDesignerView addSubview:hideDesignerViewButton];
    }
}

//退出登陆
-(void)exitLoginButtonClicked:(UIButton*)sneder{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGE_BUTTONCOLOR object:nil userInfo:nil];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    //网址拼接分为域名和访问路径两部分,域名前后不带斜线,路径的前后也不带斜线,统一在拼接的时候加入斜线
    NSString *keyString = [ud objectForKey:@"key"];
    if ([keyString length]<8) {
        keyString = @"";
    }
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",URL_FOR_IP_OR_DOMAIN,URL_ZDEC_LOGOUT,keyString]];
    //
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?key=%@",URL_FOR_IP_OR_DOMAIN,URL_ZDEC_LOGOUT,keyString]];
    DLog(@"退出登录 = %@",url);
    ASIFormDataRequest *loginRequest = [ASIFormDataRequest requestWithURL:url];
    [loginRequest startSynchronous];
    NSError *error = [loginRequest error];
    if (!error) {
        NSString *response = [loginRequest responseString];
        DLog(@"退出登录 response is %@",response);
        NSDictionary *responDict = [[response JSONValue] objectForKey:@"message"];
        DLog(@"responDict is %@",responDict);
        DLog(@"%@",[responDict objectForKey:@"msg"]);
//        if ([[responDict objectForKey:@"error"] isEqualToString:@"0"]) {
            DLog(@"退出成功");
            [ud removeObjectForKey:KEY_USER_QQ];
            [ud removeObjectForKey:KEY_USER_MAIL];
            [ud removeObjectForKey:KEY_USER_PHONE];
            [ud removeObjectForKey:KEY_USER_DESCRIPTION];
            [ud setObject:nil forKey:@"user_alias"];
            [ud removeObjectForKey:@"user_alias"];
            [ud removeObjectForKey:@"user_name"];
            [ud removeObjectForKey:KEY_USER_HEADIMG];
            [ud removeObjectForKey:@"user_status"];
            [ud removeObjectForKey:@"role_id"];
            [ud removeObjectForKey:@"user_company"];
            [ud setObject:@"" forKey:@"key"];
            [ud synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGE_HEADVIEW object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGE_MENU object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGE_SALEBUTTON object:nil userInfo:nil];
            [ud setObject:@"YES" forKey:@"ADD"];
            [self.view removeFromSuperview];
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:NSLocalizedString(@"NSStringNetExecption",@"网络异常，请稍后再试！") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @""), nil];
//            [alert show];
//            [alert release];
//        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"NSString24", @"提示") message:NSLocalizedString(@"NSStringNetExecption",@"网络异常，请稍后再试！") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"NSStringOKButtonTitle", @""), nil];
        [alert show];
        [alert release];
    }
}
//编辑账号资料
- (void)editButtonClicked
{
    EditViewController *editVC = [[EditViewController alloc] init];
    editVC.nameString = self.nameString;
    editVC.telString = self.telString;
    editVC.qqString = self.qqString;
    editVC.descriptionString = self.descriptionString;
    editVC.headImage = aboutDesignerView.headImageView.image;
    UINavigationController *editNav = [[UINavigationController alloc] initWithRootViewController:editVC];
    if (DEVICE_IS_IPAD) {
        editNav.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:editNav animated:YES completion:nil];
    }else {
//        editNav.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self.view addSubview:editNav.view];
    }
}

//隐藏设计师资料页面
- (void)hideDesignerView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         containerView.frame = CGRectMake(SCREEN_CGSIZE_WIDTH/2, 35, 0, 0);
                         //                             aboutDesignerView.hidden = YES;
                     }
                     completion:^(BOOL finished) {
                     }];
}


/** 显示设计师页面 */
- (void)showDesignerView
{
    CGRect frame = CGRectMake(0, 0, 400, SCREEN_CGSIZE_WIDTH);
    if (!DEVICE_IS_IPAD) {
        frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - 50);
    }
    [UIView animateWithDuration:0.5
                     animations:^{
                         containerView.frame = frame;
                         //                             aboutDesignerView.hidden = YES;
                     }
                     completion:^(BOOL finished) {
                         designerViewHidden = NO;
                     }];
}

//返回图片列表页面
- (void)backToMainImageView
{
    ud = [NSUserDefaults standardUserDefaults];
    if (!aboutDesignerView) {
        if ([[ud objectForKey:@"jump"] isEqualToString:@"1"]) {
            [ud setObject:@"0" forKey:@"jump"];
            [ud setObject:@"pingti" forKey:@"PingtiOrImage"];
        }
    }
    DLog(@"fromWhere = %@",[ud objectForKey:@"fromWhere"])
    if ([[ud objectForKey:@"fromWhere"] isEqualToString:@"fromHomepage"]) {
        [ud setObject:@"YES" forKey:@"ADD"];
        [self.view removeFromSuperview];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
//    [self dismissViewControllerAnimated:YES completion:nil];
}

//加载数据
- (void)loadData
{
    //开启进度
    [self startProgress];
    //请求数据
    [self backLoadMenuData];
}
/**
 *@brief 加载数据
 */
-(void)backLoadMenuData
{
    [self sendAsynchronous:self.requestUrl reqeusttagi:TAG_ONE_PAGE_DATA];
    DLog(@"url=====%@",self.requestUrl);
}

/**
 *@brief 开始进度条
 */
-(void)startProgress{
    KKProgressTimer *myProgress = [[KKProgressTimer alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (DEVICE_IS_IPAD) {
        [myProgress setCenter:CGPointMake(SCREEN_CGSIZE_HEIGHT/2, SCREEN_CGSIZE_WIDTH/2)];
    }else {
        [myProgress setCenter:CGPointMake(SCREEN_CGSIZE_WIDTH/2, SCREEN_CGSIZE_HEIGHT/2)];
    }

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
 滚动广告模块儿
 */
- (UIView *)insertADCellView
{
    DLog(@"adIntroduceArray = %@",adIntroduceArray);
    
    if (adDataArray.count == 0) {
        [refreshButton setHidden:NO];
    }
    if (DEVICE_IS_IPAD) {
        adEScrollerView=[[EScrollerView alloc] initWithFrameRect:CGRectMake(40, 70, SCREEN_CGSIZE_HEIGHT - 70 - 40, SCREEN_CGSIZE_WIDTH - 70) dataArray:adDataArray introduceArray:adIntroduceArray];
    }else {
        adEScrollerView=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 70, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - 70 - 50) dataArray:adDataArray introduceArray:adIntroduceArray];
    }
    adEScrollerView.delegate = self;
    adEScrollerView.tag = TAG_AD;
    return adEScrollerView;
    if (!designerViewHidden) {
        
    }
}
#pragma mark - EScrollerViewDelegate
-(void)EScrollerViewDidClicked:(NSUInteger)index
{
    DLog(@"测试一下index = %d",index);
    if (!designerViewHidden) {
        DLog(@"点击了图片");
        [UIView animateWithDuration:0.5
                         animations:^{
                             containerView.frame = CGRectMake(0, 0, 0, SCREEN_CGSIZE_WIDTH);
//                             aboutDesignerView.hidden = YES;
                         }
                         completion:^(BOOL finished) {
                             designerViewHidden = YES;
                         }];
    }else{
        imageListVC = [[ImageListViewController alloc] init];
        imageListVC.mainImageName = [adDataArray objectAtIndex:index - 1];
        [imageListVC requestImageData:[_newsList objectAtIndex:index - 1]];
//        [self presentViewController:imageListVC animated:YES completion:nil];
        UINavigationController *testNav = [[UINavigationController alloc] initWithRootViewController:imageListVC];
        
        if (OS_VERSION_FLOAT >= 8.0) {
            [[[UIApplication sharedApplication] keyWindow] addSubview:testNav.view];
        }else {
            [self presentViewController:testNav animated:YES completion:nil];
        }
    }
}



//2014年07月19日17:43:33 云屏项目———————————————————————————————————————————————————————————————————
//异步请求网络数据
-(void)sendAsynchronous:(NSString*)urlStr reqeusttagi:(NSInteger)reqeusttagi{
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",urlStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIHTTPRequest *asiHttp = [[ASIHTTPRequest alloc]initWithURL:url];
    asiHttp.delegate = self;
    asiHttp.tag = reqeusttagi;
    [asiHttp startAsynchronous];
    
    [[self.view viewWithTag:TAG_AD] removeFromSuperview];
    RELEASE_SAFELY(adEScrollerView);
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    DLog(@"数据加载完成");
    [self stopProgress:self.view];
    if (request.tag == TAG_ONE_PAGE_DATA) {
        [self parseDataItemsJsonString:request];
    }
    [self.view addSubview:[self insertADCellView]];
    //设计师介绍视图
#warning 暂时隐藏
    [self insertAboutDesignerView];
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    DLog(@"加载数据失败，检查网络");
    [self stopProgress:self.view];
    if (request.tag == TAG_ONE_PAGE_DATA) {
        [self parseDataItemsJsonString:request];
    }
    [self.view addSubview:[self insertADCellView]];
    //设计师介绍视图
    [self insertAboutDesignerView];
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
    if (!adDataArray) {
        adDataArray = [[NSMutableArray alloc]init];
        adIntroduceArray = [[NSMutableArray alloc] init];
    }
    [adDataArray removeAllObjects];
    [adIntroduceArray removeAllObjects];
    [_newsList removeAllObjects];
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
        [adDataArray addObject:dataItems.item_img];
        [adIntroduceArray addObject:dataItems.item_title];
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
}


- (void)dealloc
{
    DLog(@"%@进行了释放！！！",self.class);
    DLog(@"[aboutDesignerView retainCount] = %d",[aboutDesignerView retainCount]);
    [aboutDesignerView release];
    RELEASE_SAFELY(aboutDesignerView)
    RELEASE_SAFELY(adEScrollerView)
    [super dealloc];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    ud = [NSUserDefaults standardUserDefaults];
    NSString *keyString = [ud objectForKey:@"key"];
    DLog(@"keyString = %@",keyString);
    DLog(@"self.photoUrl = %@",self.photoUrl);
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
