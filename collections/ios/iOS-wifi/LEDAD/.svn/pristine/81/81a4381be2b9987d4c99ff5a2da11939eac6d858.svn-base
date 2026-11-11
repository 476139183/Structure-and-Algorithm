//
//  PushDetailViewController.m
//  ZDEC
//
//  Created by LDY on 13-9-9.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "PushDetailViewController.h"
#import "BaseButton.h"
#import "BaseUILabel.h"
#import "MyToolBar.h"
#import "Config.h"
#import "MyTool.h"
#import "DataItems.h"
#import "UserInfoEntity.h"
#import "ASIFormDataRequest.h"
#import "NSString+SBJSON.h"
#import "SGInfoAlert.h"
#import "NewsWebViewController.h"

static int fontsize=300;
static int changefond=100;
@interface PushDetailViewController ()

@end

@implementation PushDetailViewController
@synthesize customerTableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithItem:(DataItems*)item andContactItem:(NSArray *)customer
{
    shareItem = item;
    self.titleList = customer;
    if (self) {
        self.title = NSLocalizedString(@"NSStringPushPage",@"推送页面");//Push page
        backgroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Config.currentNavigateHeight,SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT)];
        [self.view addSubview:backgroundScrollView];
        toolbar=[[MyToolBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, Config.currentNavigateHeight)];
        UIBarButtonItem *leftbarbtn=[[UIBarButtonItem alloc]
                                     initWithImage:[UIImage imageNamed:@"backitem.png"]
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(SystembackMainSettingView)];
        
        
        NSMutableArray *myToolBarItems = [[NSMutableArray alloc]initWithObjects:leftbarbtn,nil ];
        [toolbar setItems:myToolBarItems animated:YES];
        [self.view addSubview:toolbar];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        
        titleLabel = [[BaseUILabel alloc] initWithFrame:CGRectMake(10, 44, 100, 30) andTitle:NSLocalizedString(@"NSStringisSclectCustomer",@"已选客户")];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [backgroundScrollView addSubview:titleLabel];
        [titleLabel release];
        
        customerScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, [customer count]*40)];
        customerScrollView.contentSize = CGSizeMake(self.view.frame.size.width, [customer count]*40);
        
        
        customerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [customer count]*40) style:UITableViewStyleGrouped];
        customerTableView.backgroundColor = [UIColor clearColor];
        customerTableView.dataSource  = self;
        customerTableView.delegate    = self;
        customerTableView.showsHorizontalScrollIndicator  =NO;
        customerTableView.showsVerticalScrollIndicator    =NO;
        
        [customerScrollView addSubview:customerTableView];
        //    customerTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackGround.png"]];
        customerTableView.backgroundColor = [UIColor whiteColor];
        [customerTableView release];
        
        
        [backgroundScrollView addSubview:customerScrollView];
        [customerScrollView release];
        
        
        contentLabel = [[BaseUILabel alloc] initWithFrame:CGRectMake(10, [customer count]*40+100, self.view.frame.size.width, 30) andTitle:NSLocalizedString(@"NSStringSelectedContent", @"已选内容")];
        [backgroundScrollView addSubview:contentLabel];
        [contentLabel release];
        
        contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [customer count]*40+140, self.view.frame.size.width, 200)];
        contentScrollView.contentSize = CGSizeMake(self.view.frame.size.width,450);
        
        
        webview  = [[UIWebView   alloc]  initWithFrame:CGRectMake( 0,  0 ,  contentScrollView.frame.size.width , contentScrollView.frame.size.height )];
        
        webview.scalesPageToFit = TRUE;
        [ webview   setUserInteractionEnabled: YES ];	 //是否支持交互
        
        [ webview   setDelegate: self ];				 //委托
        webview.scrollView.delegate=self;
        
        [ webview   setOpaque: YES ];					 //透明
        
        [ contentScrollView  addSubview:webview];			 //加载到自己的view
        
        [backgroundScrollView addSubview:contentScrollView];
        [contentScrollView release];
        [webview release];
        
        
        
        [webview loadHTMLString:[[NSString alloc]initWithData:[MyTool readCacheData:shareItem.item_url] encoding:NSUTF8StringEncoding ] baseURL:[NSURL URLWithString:shareItem.item_url]];
        
        confirmPushButton = [[BaseButton alloc] initWithFrame:CGRectMake(10,[customer count]*40+140+40+250, self.view.frame.size.width-20, 40)];
        [confirmPushButton addTarget:self action:@selector(confirmPushButton:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundScrollView addSubview:confirmPushButton];
        [backgroundScrollView setContentSize:CGSizeMake(SCREEN_CGSIZE_WIDTH, [customer count]*40+140+40+450+100)];
        [confirmPushButton release];
        
        
    }
    return self;
}

-(void)changeFontsize:(id)sender
{
    if (changefond%4==0) {
        fontsize=350;
    }else if(changefond%4==1)
    {
        fontsize=400;
    }else if(changefond%4==2)
    {
        fontsize=450;
    }else if(changefond%4==3)
    {
        fontsize=300;
    }
    changefond++;
    DLog(@"修改字体大小");
    NSString *fondsizestr = [[NSString alloc]initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%@'",fontsize,@"%"];
    [webview stringByEvaluatingJavaScriptFromString:fondsizestr];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *fondsizestr = [[NSString alloc]initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%@'",fontsize,@"%"];
    [webview stringByEvaluatingJavaScriptFromString:fondsizestr];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)confirmPushButton:(id)sender
{
    if ([self postResource:shareItem.item_title push_url:shareItem.item_url]) {
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[NewsWebViewController class]]) {
                NSDictionary *messageDict = [[NSDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"NSStringPushSuccess",@"推送成功"),@"msg",nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_SHOW_TOASTVIEW_PUSH_R object:nil userInfo:messageDict];
                [self.navigationController popToViewController:controller animated:NO];
            }
        }
        
    }
    
    
    
}

- (void) SystembackMainSettingView
{
    [[self.navigationController popViewControllerAnimated:YES]retain];
}

#pragma marks - UITableView Delegate && DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier]autorelease];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //        cell.showsReorderControl = YES;
    }
    
    NSUInteger row = [indexPath row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UserInfoEntity *oneUser = [self.titleList objectAtIndex:row];
    cell.textLabel.text = oneUser.user_name;
    //    cell.imageView.image = [UIImage imageNamed:@"glow.png"];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleList count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *推送资源
 */
-(BOOL)postResource:(NSString*)push_content push_url:(NSString*)push_url{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *keyString = [ud objectForKey:@"key"];
    if ([keyString length]<8) {
        keyString = @"";
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",URL_FOR_IP_OR_DOMAIN,URL_ZDEC_PUSH_RES,keyString]];
    ASIFormDataRequest *loginRequest = [ASIFormDataRequest requestWithURL:url];
    //对方的alias
    NSMutableString *useraliasStr = [[NSMutableString alloc]initWithCapacity:0];
    for (UserInfoEntity *oneUserinfo in self.titleList) {
        if ([useraliasStr length]==0) {
            [useraliasStr appendString:oneUserinfo.user_alias];
        }else{
            [useraliasStr appendString:@","];
            [useraliasStr appendString:oneUserinfo.user_alias];
        }
        
    }
    [loginRequest setPostValue:useraliasStr forKey:@"alias"];
    //推送显示的内容
    [loginRequest setPostValue:push_content forKey:@"push_content"];
    [loginRequest setPostValue:push_url forKey:@"push_url"];
    [loginRequest setPostValue:@"news" forKey:@"push_type"];
    [loginRequest startSynchronous];
    NSError *error = [loginRequest error];
    if (!error) {
        NSString *messageResponseStr = [loginRequest responseString];
        DLog(@"发送聊天信息后返回 = %@",messageResponseStr);
        NSDictionary *messageDict = [[messageResponseStr JSONValue] objectForKey:@"message"];
        if ([[messageDict objectForKey:@"error"] isEqualToString:@"0"]) {
            //返回的error为0代表发送成功,返回成功
            return YES;
        }else if ([[messageDict objectForKey:@"error"] isEqualToString:@"1"]) {
            //返回的error为1代表 当前没有查到聊天的对象
            [SGInfoAlert showInfo:[messageDict objectForKey:@"msg"]
                          bgColor:[[UIColor darkGrayColor] CGColor]
                           inView:self.view
                         vertical:0.7];
            return YES;
        }else{
            //在返回的错误非0和1的时候，返回错误
            [SGInfoAlert showInfo:[messageDict objectForKey:@"msg"]
                          bgColor:[[UIColor darkGrayColor] CGColor]
                           inView:self.view
                         vertical:0.7];
            return NO;
        }
        
    }else{
        [SGInfoAlert showInfo:@"网络出错"
                      bgColor:[[UIColor darkGrayColor] CGColor]
                       inView:self.view
                     vertical:0.7];
        return NO;
    }
}

@end
