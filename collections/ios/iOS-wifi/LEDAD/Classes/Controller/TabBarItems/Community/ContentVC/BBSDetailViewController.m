//
//  BBSDetailViewController.m
//  LED2Buy
//
//  Created by LDY on 14-7-17.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "BBSDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "Config.h"
#import "BBSFollowerTableViewCell.h"
#import "MyTool.h"
#import "NSString+SBJSON.h"
#import "BBSContentEntity.h"
#import "ASIFormDataRequest.h"
#import "SGInfoAlert.h"
#import "KLCPopup.h"
#import "UIRefreshControl+UITableView.h"
#import "MJRefresh.h"

@interface BBSDetailViewController (){
    UITextView *contentTV;
    UIRefreshControl *myRefresh;
    //第一页列表数据
    NSString *_firstPageUrl;
    //下一页的URL
    NSMutableString *_nextPageUrl;
    //下拉刷新
    MJRefreshHeaderView *header;
    //上拉加载
    MJRefreshFooterView *_footer;
    //下拉刷新
    MJRefreshBaseView *mjRefreshBaseView;
    NSMutableArray *tablelist;//下拉刷新数据保留防止为空
}

@end

@implementation BBSDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        tablelist = [[NSMutableArray alloc] init];
        followArray  = [[NSMutableArray alloc] init];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = self.BBSTitle;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.895 alpha:1.000];
    bbsDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 500, SCREEN_CGSIZE_WIDTH) style:UITableViewStylePlain];
    bbsDetailTableView.backgroundColor = [UIColor colorWithWhite:0.895 alpha:1.000];
    bbsDetailTableView.tableHeaderView.backgroundColor = [UIColor colorWithWhite:0.913 alpha:1.000]; 
    bbsDetailTableView.delegate = self;
    bbsDetailTableView.dataSource = self;
    [self.view addSubview:bbsDetailTableView];

//    //加入系统刷新控件 （只能下拉刷新）
//    myRefresh = [[UIRefreshControl alloc] init];
//    [myRefresh addToMyTableView:bbsDetailTableView];
//    myRefresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
//    [myRefresh addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    
//    [self loadMainBBS];//云屏不需要主贴
//    [self requesetCommentData];
    
//    //提交评论
//    [self comment];
//    //接听键盘通知
    [self registerForKeyboardNotifications];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(500 - 100, SCREEN_CGSIZE_WIDTH - 100, 60, 60);
    editButton.backgroundColor = [UIColor colorWithWhite:0.643 alpha:1.000];
    editButton.alpha = 0.7;
    editButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    editButton.layer.cornerRadius = 30;
    [editButton setImage:[UIImage imageNamed:@"action_create_34x34"] forState:UIControlStateNormal];
    [editButton setImage:[UIImage imageNamed:@"action_create_press_34x34"] forState:UIControlStateHighlighted];
    [editButton addTarget:self action:@selector(showEditView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editButton];
    
    if (!DEVICE_IS_IPAD) {
        bbsDetailTableView.frame = self.view.frame;
        editButton.frame = CGRectMake(SCREEN_CGSIZE_WIDTH - 60, SCREEN_CGSIZE_HEIGHT - 60, 50, 50);
        editButton.layer.cornerRadius = 25;
    }
    
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
}

//显示评论编辑页面
- (void)showEditView
{
    //iPad键盘高度352
    // Generate content view to present
    UIView* contentView = [[UIView alloc] init];
    //    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    contentView.backgroundColor = [UIColor colorWithRed:0.814 green:0.737 blue:0.449 alpha:1.000];
//    contentView.layer.cornerRadius = 5.0;
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"share_send"] forState:UIControlStateNormal];
    [sendButton setBackgroundImage:[UIImage imageNamed:@"share_send_highlighted"] forState:UIControlStateHighlighted];
    [sendButton addTarget:self action:@selector(commentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* dismissLabel = [[UILabel alloc] init];
    //    dismissLabel.translatesAutoresizingMaskIntoConstraints = NO;
    dismissLabel.backgroundColor = [UIColor colorWithWhite:0.731 alpha:1.000];
    dismissLabel.textColor = [UIColor blackColor];
    dismissLabel.font = [UIFont boldSystemFontOfSize:20.0];
    dismissLabel.textAlignment = NSTextAlignmentCenter;
    dismissLabel.text = NSLocalizedString(@"Yunping_saySomething", @"说点儿什么");
    
    contentTV = [[UITextView alloc] init];
    contentTV.font = [UIFont systemFontOfSize:16];
    contentTV.backgroundColor = [UIColor colorWithRed:0.814 green:0.737 blue:0.449 alpha:1.000];
    
    UIButton* dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
//    dismissButton.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    [dismissButton setBackgroundImage:[UIImage imageNamed:@"close_icon_normal"] forState:UIControlStateNormal];
    [dismissButton setBackgroundImage:[UIImage imageNamed:@"close_icon_highlight"] forState:UIControlStateHighlighted];
    [dismissButton addTarget:self action:@selector(dismissButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //    2014年09月05日11:30:13
    contentView.frame = CGRectMake(0, 0, 400, 450);
    sendButton.frame = CGRectMake(350, -5, 50, 50);
    dismissLabel.frame = CGRectMake(0, 0, 400, 40);
    contentTV.frame = CGRectMake(0, 40, 400, 160);
    dismissButton.frame = CGRectMake(0, -5, 50, 50);
    if (!DEVICE_IS_IPAD) {
        contentView.frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_WIDTH);
        sendButton.frame = CGRectMake(SCREEN_CGSIZE_WIDTH - 50, -5, 50, 50);
        dismissLabel.frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, 40);
        contentTV.frame = CGRectMake(0, 40, SCREEN_CGSIZE_WIDTH, 160);
        dismissButton.frame = CGRectMake(0, -5, 50, 50);
    }
    
    [dismissLabel setUserInteractionEnabled:YES];
    [contentView addSubview:contentTV];
    [contentView addSubview:dismissLabel];
    [contentView addSubview:sendButton];
    [contentView addSubview:dismissButton];
    
    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,
                                               (KLCPopupVerticalLayout)KLCPopupVerticalLayoutCenter);
    
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView
                                            showType:(KLCPopupShowType)KLCPopupShowTypeBounceInFromTop
                                         dismissType:(KLCPopupDismissType)KLCPopupDismissTypeBounceOutToBottom
                                            maskType:(KLCPopupMaskType)KLCPopupMaskTypeClear
                            dismissOnBackgroundTouch:NO
                               dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
}
- (void)dismissButtonPressed:(id)sender {
    if ([sender isKindOfClass:[UIView class]]) {
        [(UIView*)sender dismissPresentingPopup];
    }
}

//评论
- (void)comment
{
    commentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_CGSIZE_WIDTH - 50, 450, 50)];
    commentView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:0.600];
    commentTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 450 - 65, 40)];
    commentTextField.borderStyle = UITextBorderStyleRoundedRect;
    commentTextField.layer.borderWidth = 2.0f;
    commentTextField.layer.borderColor = [[UIColor colorWithRed:0.600 green:0.800 blue:1.000 alpha:1.000] CGColor];
    commentTextField.layer.cornerRadius = 5.0f;
    [commentView addSubview:commentTextField];
    
    commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(450 - 55, 5, 50, 40);
    commentButton.layer.cornerRadius = 5.0f;
    [commentButton setTitle:@"提交" forState:UIControlStateNormal];
    commentButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [commentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [commentButton setBackgroundColor:[UIColor whiteColor]];
    [commentButton setBackgroundImage:[UIImage imageNamed:@"button_pressed"] forState:UIControlStateHighlighted];
//    [commentButton addTarget:self action:@selector(commentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [commentView addSubview:commentButton];
    
    
    [self.view addSubview:commentView];
}

//提交按钮
//- (void)commentButtonPressed
//{
//    if ([MyTool CheckIsLogin]) {
//        
//        if (commentTextField.text.length == 0) {
//            DLog(@"评论内容不能为空！！！");
//            [SGInfoAlert showInfo:NSLocalizedString(@"评论内容不能为空！！！",@"评论内容不能为空！！！")
//                          bgColor:[[UIColor darkGrayColor] CGColor]
//                           inView:self.view
//                         vertical:0.4];
//            return;
//        }
//        
//        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//        NSURL *commentURL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@&contenttype=2",URL_BBS_SENDBBS] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        ASIFormDataRequest *commentRequest = [ASIFormDataRequest requestWithURL:commentURL];
//        [commentRequest addPostValue:self.contentid forKey:@"parent_id"];
//        [commentRequest addPostValue:[ud objectForKey:KEY_USER_ID] forKey:@"userid"];
//        [commentRequest addPostValue:@"jiegou_aid" forKey:@"article_id"];
//        [commentRequest addPostValue:commentTextField.text forKey:@"textcontent"];
//        [commentRequest setCompletionBlock:^{
//            DLog(@"发布成功");
//            [SGInfoAlert showInfo:NSLocalizedString(@"发布成功",@"发布成功")
//                          bgColor:[[UIColor darkGrayColor] CGColor]
//                           inView:self.view
//                         vertical:0.4];
//            //clear评论
//            commentTextField.text = nil;
//            [self requesetCommentData];
//        }];
//        [commentRequest setFailedBlock:^{
//            DLog(@"发布失败");
//            [SGInfoAlert showInfo:NSLocalizedString(@"发布失败",@"发布失败")
//                          bgColor:[[UIColor darkGrayColor] CGColor]
//                           inView:self.view
//                         vertical:0.4];
//        }];
//        [commentRequest startAsynchronous];
//        
//    }
//    [commentTextField resignFirstResponder];
//}
//提交按钮
- (void)commentButtonPressed:(id)sender
{
    [self dismissButtonPressed:sender];
    if ([MyTool CheckIsLogin]) {

        if (contentTV.text.length == 0) {
            DLog(@"评论内容不能为空！！！");
            [SGInfoAlert showInfo:NSLocalizedString(@"Yunping_contentNil！",@"评论内容不能为空！")
                          bgColor:[[UIColor darkGrayColor] CGColor]
                           inView:self.view
                         vertical:0.4];
            return;
        }

        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSURL *commentURL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",URL_BBS_SENDBBS,self.item_id] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        ASIFormDataRequest *commentRequest = [ASIFormDataRequest requestWithURL:commentURL];
        [commentRequest addPostValue:self.contentid forKey:@"parent_id"];
        [commentRequest addPostValue:[ud objectForKey:KEY_USER_ID] forKey:@"userid"];
        [commentRequest addPostValue:@"jiegou_aid" forKey:@"article_id"];
        [commentRequest addPostValue:contentTV.text forKey:@"textcontent"];
        [commentRequest setCompletionBlock:^{
            DLog(@"发布成功");
            [SGInfoAlert showInfo:NSLocalizedString(@"Yunping_succeed",@"发布成功")
                          bgColor:[[UIColor darkGrayColor] CGColor]
                           inView:self.view
                         vertical:0.4];
            //clear评论
            contentTV.text = nil;
            [self requesetCommentData];
        }];
        [commentRequest setFailedBlock:^{
            DLog(@"发布失败");
            [SGInfoAlert showInfo:NSLocalizedString(@"Yunping_failure",@"发布失败")
                          bgColor:[[UIColor darkGrayColor] CGColor]
                           inView:self.view
                         vertical:0.4];
        }];
        [commentRequest startAsynchronous];

    }else {
        [SGInfoAlert showInfo:NSLocalizedString(@"Yunping_pleaseLoginFirst",@"请登陆后再评论")
                      bgColor:[[UIColor darkGrayColor] CGColor]
                       inView:self.view
                     vertical:0.4];
    }
    [contentTV resignFirstResponder];
}


//根据键盘从新布局
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardShow:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize= [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    DLog(@"kbSize.height = %f\nkbSize.width = %f",kbSize.height, kbSize.width);

    if (DEVICE_IS_IPAD) {
        contentTV.frame = CGRectMake(0, 40, 400, 160);
    }
}
- (void)keyboardHide:(NSNotification *)aNotificatio
{
    if (DEVICE_IS_IPAD) {
        contentTV.frame = CGRectMake(0, 40, 400, 410);
    }
}

//加载主贴页面
- (void)loadMainBBS
{
    textLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, SCREEN_CGSIZE_WIDTH - 155, 30)];
    leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH - 90, 10, 85, 20)];
    textView = [[UITextView alloc] initWithFrame:CGRectMake(60, 40, SCREEN_CGSIZE_WIDTH - 70, 30)];
    
    [leftImageView setImageWithURL:[NSURL URLWithString:self.headimg] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    textLabel.text = self.username;
    dateLabel.text = self.publishtime;
    
    textView.text = self.text;
    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont systemFontOfSize:14];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    CGRect frame = textView.frame;
    CGSize size = [textView.text sizeWithFont:textView.font constrainedToSize:CGSizeMake(280, 1000) lineBreakMode:NSLineBreakByTruncatingTail];
    frame.size.height = size.height > 1 ? size.height + 50 : 60;
    textView.frame = frame;
    DLog(@"textView.frame.size.height= %f",textView.frame.size.height);
    
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.textColor = [UIColor colorWithRed:70.0/256 green:130.0/256 blue:180.0/256 alpha:1.0];
    dateLabel.font = [UIFont systemFontOfSize:10];
    
    bbsDetailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, 40 + textView.frame.size.height)];
    bbsDetailScrollView.contentSize = CGSizeMake(SCREEN_CGSIZE_WIDTH, 40 + textView.frame.size.height);
    bbsDetailScrollView.scrollEnabled = YES;
    //    bbsDetailScrollView.backgroundColor = [UIColor lightGrayColor];
    [bbsDetailScrollView addSubview:leftImageView];
    [bbsDetailScrollView addSubview:textLabel];
    [bbsDetailScrollView addSubview:dateLabel];
    [bbsDetailScrollView addSubview:textView];
}

//请求跟帖数据
- (void)requesetCommentData
{
    [followArray removeAllObjects];//评论成功后请求数据之前先把数据清空
    _firstPageUrl = [NSString stringWithFormat:@"%@%@",URL_BBS_CONTENT_FOLLOW,self.item_id];
    NSURL *requestUrl = [NSURL URLWithString:[_firstPageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"requestUrl = %@",requestUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:requestUrl];
    request.delegate = self;
    [request startAsynchronous];
}
- (void)requesetCommentDataOfNextPage:(NSString *)nextPageUrl
{
    NSURL *requestUrl = [NSURL URLWithString:[nextPageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"requestUrl = %@",requestUrl);
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:requestUrl];
    request.delegate = self;
    [request startAsynchronous];
}
#pragma mark - ASIHTTPRequestDelegate
-(void)requestFinished:(ASIHTTPRequest *)request
{
    DLog(@"请求论坛数据成功");
    [self parseBBSJsonString:request];
    //    [self stopProgress:self.view];
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    DLog(@"请求论坛数据失败");
    [self parseBBSJsonString:request];
    //    [self stopProgress:self.view];
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
//    NSArray *ContentDataArray = [contentsJson objectForKey:@"Content"];
//    if ((ContentDataArray == nil) || (![ContentDataArray isKindOfClass:[NSArray class]])) {
//        DLog(@"返回的数据非法，字典内部不是包含的数组");
//        return;
//    }
//    NSDictionary *ContentDataDictionary = [ContentDataArray firstObject];
//    if (ContentDataDictionary == nil || ![ContentDataDictionary isKindOfClass:[NSDictionary class]]) {
//        DLog(@"返回的数据非法，不是一个字典");
//        return;
//    }
    NSArray *itemsDataArray = [contentsJson objectForKey:@"items"];
    if (itemsDataArray == nil || ![itemsDataArray isKindOfClass:[NSArray class]]) {
        DLog(@"返回的数据非法，字典内部不是包含的数组");
        return;
    }
    if (!followArray) {
        followArray = [[NSMutableArray alloc]init];
    }
//    [followArray removeAllObjects];
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
        [followArray addObject:oneContent];
    }
    [bbsDetailTableView reloadData];
    
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
    [self performSelector:@selector(doneWithView:) withObject:mjRefreshBaseView];//停止刷新
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"相关评论";
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tablelist = [followArray copy];
    return tablelist.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *MyIdentifier = [NSString stringWithFormat:@"MyIdentifier%d",indexPath.row];
    BBSFollowerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[[BBSFollowerTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier] autorelease];
    }
    
    BBSContentEntity *oneFollow = [tablelist objectAtIndex:indexPath.row];
    [cell initData:oneFollow];
    cell.backgroundColor = [UIColor colorWithWhite:0.895 alpha:1.000];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    DLog(@"bbsDetailScrollView.frame.size.height = %f",bbsDetailScrollView.frame.size.height);
//    return bbsDetailScrollView.frame.size.height;
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    return bbsDetailScrollView;
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.tableHeaderView.frame.size.height, tableView.tableHeaderView.frame.size.width - 30)];
    titleLable.backgroundColor = [UIColor colorWithWhite:0.895 alpha:1.000];
    titleLable.font = [UIFont boldSystemFontOfSize:23.0f];
    titleLable.textAlignment = NSTextAlignmentCenter;
    
    if (tablelist.count == 0) {
        titleLable.text = NSLocalizedString(@"Yunping_NOcomments", @"暂无评论");
    }else {
        titleLable.text = NSLocalizedString(@"Yunping_comments", @"相关评论");
    }
    
    return titleLable;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBSContentEntity *oneFollow = [tablelist objectAtIndex:indexPath.row];
//    CGSize size = [oneFollow.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(400, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attrivutesDic = @{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                    NSParagraphStyleAttributeName : paragraph};
    CGSize size = [oneFollow.text boundingRectWithSize:CGSizeMake(400, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrivutesDic context:nil].size;
    if (!DEVICE_IS_IPAD) {
        size = [oneFollow.text boundingRectWithSize:CGSizeMake(SCREEN_CGSIZE_WIDTH - 65, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrivutesDic context:nil].size;
    }
    DLog(@"size.height = %f",size.height);
    return 50 + size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [commentTextField resignFirstResponder];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

/**
 *@brief 下拉刷新的方法
 */
- (void)addHeader
{
    if (!header) {
        header = [MJRefreshHeaderView header];
    }
    header.scrollView = bbsDetailTableView;
    
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        DLog(@"MJRefreshBaseView下拉刷新了");
        mjRefreshBaseView = refreshView;
        [followArray removeAllObjects];
        DLog(@"_firstPageUrl = %@",_firstPageUrl);
        [self requesetCommentData];
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
    footer.scrollView = bbsDetailTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        DLog(@"下一页的地址 getNextPageURL = %@",_nextPageUrl);
        if (_nextPageUrl) {
            if ([_nextPageUrl isEqualToString:@"end"]) {
                DLog(@"CustomerViewController拉到底了");
            } else {
                DLog(@"CustomerViewController拉到加载");
                DLog(@"_nextPageUrl=%@",_nextPageUrl);
                
                mjRefreshBaseView = refreshView;
                [self requesetCommentDataOfNextPage:_nextPageUrl];
                
                DLog(@"_newsList.count = %d",[followArray count]);
            }
        }
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
    };
    _footer = footer;
}


- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [bbsDetailTableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
    DLog(@"endRefreshing--结束刷新");
}

- (void)RefreshViewControlEventValueChanged
{
    [myRefresh endRefreshing];
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
