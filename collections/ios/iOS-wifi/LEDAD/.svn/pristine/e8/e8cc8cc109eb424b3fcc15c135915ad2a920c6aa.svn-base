///
//  NewsWebCycleViewController.m
//  SZLEDIA
//
//  Created by yixingman on 1/16/14.
//  Copyright (c) 2014 JianYe. All rights reserved.
//

#import "NewsWebCycleViewController.h"
#import "Config.h"
#import "NewsWebViewController.h"
#import "MyTool.h"
//#import "AGApiViewControllers.h"
//#import "PushViewController.h"
#import "AppDelegate.h"
#import "Reachability.h"
//#import "SGInfoAlert.h"
//#import "shareItemDBOperation.h"
#import "DataColumns.h"
//#import "Toast+UIView.h"
//#import "AHAlertView.h"
//#import "LoginViewController.h"
#import "ContainterWebViewController.h"

NewsWebCycleViewController *newsWebCycleViewController;

@interface NewsWebCycleViewController ()

@end

@implementation NewsWebCycleViewController
@synthesize oneDataColumn;
@synthesize currentPageValue;
@synthesize myDataItemArray;
@synthesize csView;
@synthesize tittleStr;
@synthesize dataItem;
@synthesize isFromWhere;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置底部工具栏
//    [MyTool insertBottomToolBar:self];
    
    DLog(@"oneDataColumn.column_structure = %@",oneDataColumn.column_structure);
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void) addXLCycleScrollView
{
    csView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, [Config currentNavigateHeight], SCREEN_CGSIZE_WIDTH,SCREEN_CGSIZE_HEIGHT - [Config currentNavigateHeight])];
    csView.delegate = self;
    csView.datasource = self;
    [self.view addSubview:csView];
}

#pragma mark - XLCycleScrollViewDatasource
- (NSInteger)numberOfPages
{
    return countValue;
}
- (UIView *)pageAtIndex:(NSInteger)index
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:@"iscycle"];
    
    if (index >= 0&&index<(countValue-currentPageValue)) {
        self.dataItem = [myDataItemArray objectAtIndex:index+currentPageValue];
        pageIndex = (index+currentPageValue);
    }
    if (index>=(countValue-currentPageValue)&&index<countValue){
        self.dataItem = [myDataItemArray objectAtIndex:index-(countValue-currentPageValue)];
        pageIndex = (index-(countValue-currentPageValue));
    }
    
    DLog(@"countValue = %d , currentPageValue = %d,pageIndex = %d,index = %d",countValue,currentPageValue,pageIndex,index);
    
    oneWebCtrl=[[ContainterWebViewController alloc]init];
    [oneWebCtrl readWebViewOfUrl:self.dataItem];
    [[oneWebCtrl newsWebView] setTag:pageIndex];
    return [oneWebCtrl newsWebView];
}


//当前页面
#pragma mark - XLCycleScrollViewDelegate
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    DLog(@"点击了%d页1",index);
    
    if (index >= 0&&index<(countValue-currentPageValue))
    {
        oneDateItem = [myDataItemArray objectAtIndex:index+currentPageValue];
        DLog(@"点击了%d页2",(index+currentPageValue));
    }
    if (index>=(countValue-currentPageValue)&&index<countValue)
    {
        oneDateItem = [myDataItemArray objectAtIndex:index-(countValue-currentPageValue)];
        DLog(@"点击了%d页3",(index-(countValue-currentPageValue)));
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //启动进度
    [self startProgress];
    
    //根据数据集的条数得出左右滑动的页数
    countValue = [myDataItemArray count];
    //左右滑动页面控件的创建
    //时间间隔
    NSTimeInterval timeInterval =1;
    //定时器
    [NSTimer scheduledTimerWithTimeInterval:timeInterval  target:self selector:@selector(addXLCycleScrollView) userInfo:nil repeats:NO];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:@"iscycle"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:NO forKey:@"iscycle"];
}

/**
 *@brief 改变网页的字体放大倍数
 */
-(void)changeFontSize:(id)sender
{
    //通知webView的视图页面更改字体放大比例
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGE_FONT_SIZE object:nil];
}

/**
 *@brief 底部工具栏上按钮的点击事件
 */
//-(void)ItembuttonClick:(id)sender
//{
//    switch (([sender tag]-TAG_MYTOOLBAR))
//    {
//        case 0:
//        {
//            DLog(@"收藏");
//            
//            if ([isFromWhere isEqualToString:@"AppDelegate"])
//            {
//                return;
//            }
//            if (![MyTool CheckIsLogin])
//            {
//                //判断是否登录了
//                [self alertViewLogin];
//                return;
//            }
//            shareItemDBOperation *collect = [[shareItemDBOperation alloc]init];
//            NSString *structureStr = oneDataColumn.column_structure;
//            if (structureStr==nil)
//            {
//                structureStr = @"product";
//            }
//            //2014年05月08日17:40:51
//            [oneDateItem setItem_iscollect:@"1"];
//            [oneDateItem setItem_column_structure:structureStr];
//            DLog(@"收藏页面的URL = %@",oneDateItem.item_url);
//            if ([collect saveDataItems:oneDateItem])
//            {
//                [SGInfoAlert showInfo:NSLocalizedString(@"NSStringCollectSuccess",@"收藏成功！")
//                              bgColor:[[UIColor darkGrayColor] CGColor]
//                               inView:self.view
//                             vertical:0.7];
//            }else{
//                [SGInfoAlert showInfo:NSLocalizedString(@"NSStringSuccessfullycanceled",@"取消收藏成功！")
//                              bgColor:[[UIColor darkGrayColor] CGColor]
//                               inView:self.view
//                             vertical:0.7];
//            }
//        }
//            break;
//        case 1:
//        {
//            DLog(@"下载");
//            if (![MyTool CheckIsLogin])
//            {
//                //判断是否登录了
//                [self alertViewLogin];
//                return;
//            }
//            [MyTool writeCacherequestUrl:oneDateItem.item_url];
//            if ([MyTool isExistsCacheFile:oneDateItem.item_url])
//            {
//            }else{
//                [SGInfoAlert showInfo:NSLocalizedString(@"NSStringDownloading",@"下载数据中！")
//                              bgColor:[[UIColor darkGrayColor] CGColor]
//                               inView:self.view
//                             vertical:0.7];
//            }
//            shareItemDBOperation *collect = [[shareItemDBOperation alloc]init];
//            NSString *structureStr = oneDataColumn.column_structure;
//            if (structureStr==nil)
//            {
//                structureStr = @"product";
//            }
//            [oneDateItem setItem_isdownload:@"1"];
//            [oneDateItem setItem_column_structure:structureStr];
//            
//            if ([collect saveDownloadDataItems:oneDateItem])
//            {
//                [SGInfoAlert showInfo:NSLocalizedString(@"NSStringDownloadDataSuccess",@"下载数据成功") bgColor:[[UIColor darkGrayColor] CGColor]
//                               inView:self.view
//                             vertical:0.7];
//                
//            }else{
//                [SGInfoAlert showInfo:NSLocalizedString(@"NSStringDownloaded",@"已下载数据到本地")
//                              bgColor:[[UIColor darkGrayColor] CGColor]
//                               inView:self.view
//                             vertical:0.7];
//            }
//            
//            
//        }
//            break;
//        case 2:
//            DLog(@"分享");
//            NSLog(@"shareItem=%@",[oneDateItem description]);
//            [AGApiViewControllers shareApi:oneDateItem];
//            break;
//        case 3:
//            DLog(@"推送");
//            if ([isFromWhere isEqualToString:@"AppDelegate"])
//            {
//                return;
//            }
//            if (![MyTool CheckIsLogin]) {
//                //判断是否登录了
//                [self alertViewLogin];
//                return;
//            }
//            PushViewController *puchViewController = [[PushViewController alloc] initWithItem:oneDateItem];
//            [self.navigationController pushViewController:puchViewController animated:YES];
//            [puchViewController release];
//            break;
//        default:
//            break;
//    }
//}

/**
 *@brief 显示提示登录的警告窗
 */
//-(void)alertViewLogin{
//    NSString *title = @"";
//	NSString *message = [[NSString alloc]initWithFormat:@"\n\n\n%@",NSLocalizedString(@"NSStringYouNotlogin", @"您尚未登陆，请登陆！")];
//    //自定义的提示框
//	AHAlertView *alert = [[AHAlertView alloc] initWithTitle:title message:message];
//	[alert setCancelButtonTitle:NSLocalizedString(@"NSStringNO",@"取消") block:^{
//        alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
//        NSLog(@"点击了取消");
//	}];
//    
//    UIImageView *viewe = [[UIImageView alloc]initWithFrame:CGRectMake((alert.frame.size.width/2)-45/2,15.0,45.0,45.0)];
//    viewe.image = [UIImage imageNamed:@"crytoastimage.png"];
//    
//    [alert addSubview:viewe];
//	[alert addButtonWithTitle:NSLocalizedString(@"NSStringYes",@"确定") block:^{
//        [self jumpToLoginViewController];
//    }];
//	[alert show];
//}
//
///**
// *@brief 跳转到登陆页面
// */
//-(void)jumpToLoginViewController{
//    LoginViewController *loginViewController= [[LoginViewController alloc]init];
//    isHereToLogin = @"FromServerRepairCenter";
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setObject:@"ispresentViewController" forKey:@"ispresentViewController"];
//    [ud setObject:@"NO" forKey:@"fromServersCenter"];
//    [self presentViewController:loginViewController animated:YES completion:nil];
//}


/**
 *@brief 开始进度条
 */
-(void)startProgress{
    KKProgressTimer *myProgress = [[KKProgressTimer alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [myProgress setCenter:self.view.center];
    myProgress.delegate = self;
    [myProgress setTag:TAG_PROGRESS];
    
    [[UIApplication sharedApplication].keyWindow addSubview:myProgress];
    __block CGFloat i3 = 0;
    [myProgress startWithBlock:^CGFloat {
        return ((i3++ >= 50) ? (i3 = 0) : i3) / 50;
    }];
}

/**
 *@brief 停止进度条
 */
-(void)stopProgress:(UIView *)containtView{
    KKProgressTimer *oldProgress = (KKProgressTimer *)[containtView viewWithTag:TAG_PROGRESS];
    [oldProgress stop];
    [oldProgress removeFromSuperview];
}


//- (void)share:(id)sender
//{
//    [AGApiViewControllers shareApi:oneDateItem];
//}

/**
 * @brief 发邮件
 */
//-(void)sendMailto:(NSString *)mailUrl
//{
//    YXMSendMailViewController *sendMail = [[YXMSendMailViewController alloc] init];
//    [sendMail displayMailPickerWithSubject:nil toRecipient:mailUrl emailBody:nil fromViewController:newsWebCycleViewController];
//}

- (void)dealloc
{
    DLog(@"NewsWebCycleViewController进行了释放");
    //    RELEASE_SAFELY(csView);
    //    csView.delegate = nil;
    //    RELEASE_SAFELY(oneWebCtrl);
    [super dealloc];
}

@end
