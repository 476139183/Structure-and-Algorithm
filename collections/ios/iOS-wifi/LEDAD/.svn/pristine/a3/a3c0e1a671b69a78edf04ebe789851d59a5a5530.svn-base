//
//  ProductsWebCycleViewController.m
//  Chipshow
//
//  Created by LDY on 14-6-18.
//  Copyright (c) 2014年 JianYe. All rights reserved.
//

#import "ProductsWebCycleViewController.h"
#import "Config.h"
#import "MyTool.h"
//#import "AGApiViewControllers.h"
#import "AppDelegate.h"
#import "Reachability.h"
//#import "SGInfoAlert.h"
//#import "shareItemDBOperation.h"
#import "DataColumns.h"
//#import "AHAlertView.h"
//#import "LoginViewController.h"
//#import "Toast+UIView.h"
#import "ProductContainerViewController.h"
#import "Json2Analysis.h"
#import "KxMenu.h"
#import "ShowCalculatorViewController.h"
//#import "YXMSendMailViewController.h"

ProductsWebCycleViewController *productsWebCycleViewController;
@interface ProductsWebCycleViewController ()

@end

@implementation ProductsWebCycleViewController
@synthesize oneDataColumn;
@synthesize currentPageValue;
@synthesize myDataItemArray;
@synthesize csView;
@synthesize tittleStr;
@synthesize dataItem;
@synthesize isFromWhere;

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
    //启动进度
    [self startProgress];
    //视图的集合,用于左右滚动
    webViewDataSourseDictionary = [[NSMutableDictionary alloc]init];
    //设置顶部导航工具栏
//    [MyTool insertTopNavToolBarNoFont:self];
    
    // 产品和参数按钮
    buttonProduct=[UIButton buttonWithType:(UIButtonTypeCustom)];
    buttonProduct.frame=CGRectMake(0, self.view.frame.size.height - 44,SCREEN_CGSIZE_WIDTH/2-0.5, 44);
    [buttonProduct setBackgroundColor:[UIColor lightGrayColor]];
    [buttonProduct setTitle:NSLocalizedString(@"NSStringProductFeatures", @"产品特点") forState:(UIControlStateNormal)];
    [buttonProduct addTarget:self action:@selector(productOrParameter:) forControlEvents:(UIControlEventTouchUpInside)];
    buttonProduct.tag = 1;
    
    buttonParameter=[UIButton buttonWithType:(UIButtonTypeCustom)];
    buttonParameter.frame=CGRectMake(SCREEN_CGSIZE_WIDTH/2+1,self.view.frame.size.height - 44,SCREEN_CGSIZE_WIDTH/2-0.5, 44);
    [buttonParameter setBackgroundColor:[UIColor lightGrayColor]];
    [buttonParameter setTitle:NSLocalizedString(@"NSStringTechnicalParameters", @"技术参数") forState:(UIControlStateNormal)];
    [buttonParameter addTarget:self action:@selector(productOrParameter:) forControlEvents:(UIControlEventTouchUpInside)];
    buttonParameter.tag = 2;
    
    if (![[[UIDevice currentDevice] model] isEqualToString:@"iPad"]) {
        buttonParameter.titleLabel.font = [UIFont systemFontOfSize:14];
        buttonProduct.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    [self.view addSubview:buttonProduct];
    [self.view addSubview:buttonParameter];
    
    //选项和分享按钮
    UIButton *shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shareButton.frame = CGRectMake(SCREEN_CGSIZE_WIDTH-50,2,45,40);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:(UIControlStateNormal)];
    //        [shareButton setTitle:NSLocalizedString(@"NSStringShareButton", @"分享") forState:(UIControlStateNormal)];
    [shareButton addTarget:self action:@selector(share:) forControlEvents:(UIControlEventTouchUpInside)];
//    sharesdkButton = [[UIButton alloc] initWithFrame:CGRectMake(0,39,shareButton.width,1)];
//    [shareButton addSubview:sharesdkButton];
    [self.view addSubview:shareButton];
    
    UIButton *selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    selectButton.frame = CGRectMake(SCREEN_CGSIZE_WIDTH-110,2,45,40);
    [selectButton setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:(UIControlStateNormal)];
    //        [selectButton setTitle:NSLocalizedString(@"NSStringSelectButton", @"选项") forState:(UIControlStateNormal)];
    [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:selectButton];
    
    //根据数据集的条数得出左右滑动的页数
    countValue = [myDataItemArray count];
    //左右滑动页面控件的创建
    //时间间隔
    NSTimeInterval timeInterval =1;
    //定时器
    [NSTimer scheduledTimerWithTimeInterval:timeInterval  target:self selector:@selector(addXLCycleScrollView) userInfo:nil repeats:NO];
    
    DLog(@"self.view.frame.size.height=%f",self.view.frame.size.height);
    DLog(@"SCREEN_CGSIZE_HEIGHT = %f",SCREEN_CGSIZE_HEIGHT);
}

- (void) addXLCycleScrollView
{
    csView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, [Config currentNavigateHeight],SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - [Config currentNavigateHeight] - 44)];
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
    
    oneWebCtrl=[[ProductContainerViewController alloc]init];
    [oneWebCtrl readWebViewOfUrl:self.dataItem];
    [[oneWebCtrl newsWebView] setTag:pageIndex];
    return [oneWebCtrl newsWebView];
}

#pragma mark - XLCycleScrollViewDelegate
//当前页面
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
    // 产品页面
    if ([oneDateItem.item_column_structure isEqualToString:@"product_new"])
    {
        // 2014年06月13日13:51:12
        NSDictionary *dictionary=[Json2Analysis getNSDictionaryFromZDECUrl:oneDateItem.item_url];
        if (dictionary) {
            if ([dictionary isKindOfClass:[NSDictionary class]]) {
                DLog(@"dictionary = %@",dictionary);
                prOrPaDictionary= [[NSDictionary alloc] initWithDictionary:[dictionary objectForKey:@"item"]];
                DLog(@"prOrPaDictionary = %@",prOrPaDictionary);
                page1_url = [[NSString alloc] initWithString:[prOrPaDictionary objectForKey:@"page1_url"]];
                page2_url = [[NSString alloc] initWithString:[prOrPaDictionary objectForKey:@"page2_url"]];
                page3_url = [[NSString alloc] initWithString:[prOrPaDictionary objectForKey:@"page3_url"]];
                DLog(@"page2_url = %@\npage3_url = %@",page2_url,page3_url);
            }
        }else{
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NSStringDataError", @"数据请求异常") message:NSLocalizedString(@"NSStringSlide", @"向左向右滑动试试看") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            myAlertView.tag = 300001;
            [myAlertView show];
            return;
        }
    }
}

/**
 *@brief 开始进度条
 */
-(void)startProgress{
    myProgress = [[KKProgressTimer alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
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
 *  @brief 产品和参数页面
 */
-(void)productOrParameter:(id)sender{
    if (productOrCaseCtrl==nil) {
        productOrCaseCtrl=[[ProductOrCaseViewController alloc] init];
    }
    if ([sender tag]==1) {
        productOrCaseCtrl.titleText=NSLocalizedString(@"NSStringProductFeatures", @"产品特点");
        productOrCaseCtrl.productOrParameterURL = page3_url;
    }else if([sender tag]==2){
        productOrCaseCtrl.titleText=NSLocalizedString(@"NSStringTechnicalParameters", @"技术参数");
        productOrCaseCtrl.productOrParameterURL = page2_url;
    }
    [self.navigationController pushViewController:productOrCaseCtrl animated:YES];
}

/**
 *  @brief 分享
 */
- (void)share:(id)sender
{
    DLog(@"分享功能尚未加入");
//    [AGApiViewControllers shareApi:oneDateItem];
}

/**
 *@brief 下拉选项按钮点击事件
 */
#pragma mark **下拉选项按钮点击事件**
- (void)selectButtonClick:(UIButton *)sender{
    DLog(@"selectButtonClick");
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:NSLocalizedString(@"NSStringCollect", @"收藏") image:nil senderTag:0 parameter:nil target:self action:@selector(KxMenuItemClick:)],
      
      [KxMenuItem menuItem:NSLocalizedString(@"NSStringDownload", @"下载") image:nil senderTag:1 parameter:nil target:self action:@selector(KxMenuItemClick:)],
      
      [KxMenuItem menuItem:NSLocalizedString(@"NSStringCalculatorLabel", @"计算器") image:nil senderTag:2 parameter:nil target:self action:@selector(calculatorButtonClicked:)],
      ];
    
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
}

- (void)KxMenuItemClick:(KxMenuItem *)sender{
//    switch (([sender senderTag]))
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
//            [oneDateItem setItem_iscollect:@"1"];
//            [oneDateItem setItem_column_structure:structureStr];
//            
//            DLog(@"收藏页面的URL = %@",oneDateItem.item_url);
//            
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
//            DLog(@"下载page1_url = %@",page1_url);
//            if (![MyTool CheckIsLogin])
//            {
//                //判断是否登录了
//                [self alertViewLogin];
//                return;
//            }
//            //            [MyTool writeProductCacherequestUrl:page1_url];
//            [MyTool writeCacherequestUrl:page1_url];
//            if ([MyTool isExistsCacheFile:page1_url])
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
//    }
}

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

/**
 *@brief 跳转到登陆页面
 */
//-(void)jumpToLoginViewController{
//    LoginViewController *loginViewController= [[LoginViewController alloc]init];
//    isHereToLogin = @"FromServerRepairCenter";
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setObject:@"ispresentViewController" forKey:@"ispresentViewController"];
//    [ud setObject:@"NO" forKey:@"fromServersCenter"];
//    [self presentViewController:loginViewController animated:YES completion:nil];
//}

#pragma mark **选屏计算器**
-(void)calculatorButtonClicked:(UIButton*)sender{
    DLog(@"显示计算器");
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"danwei_xuanze",@"单位选择") message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"gongzhi_danwei", @"公制") otherButtonTitles:NSLocalizedString(@"yingzhi_danwei", @"英制"), nil];
    al.tag = TAG_CALCULATOR;
    [al show];
    [al release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == TAG_CALCULATOR) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if (buttonIndex==0) {
            //公制单位
            [ud setObject:@"metric" forKey:UNIT_STRING];
        }
        if (buttonIndex==1) {
            //英制单位
            [ud setObject:@"imperial" forKey:UNIT_STRING];
        }
        
        ShowCalculatorViewController *showCalculCtrl = [[ShowCalculatorViewController alloc]init];
        //计算器数据
        //产品名称
        showCalculCtrl.calculator_product_name = [prOrPaDictionary objectForKey:@"parm2"];
        //箱体参数
        showCalculCtrl.Cabinet_Width = [[prOrPaDictionary objectForKey:@"parm3"] intValue];
        showCalculCtrl.Cabinet_Height = [[prOrPaDictionary objectForKey:@"parm4"] intValue];
        showCalculCtrl.Cabinet_Resolution = [prOrPaDictionary objectForKey:@"parm5"];
        showCalculCtrl.Cabinet_Weight = [[prOrPaDictionary objectForKey:@"parm6"] intValue];
        showCalculCtrl.Average_Power_Area = [[prOrPaDictionary objectForKey:@"parm7"] intValue];
        showCalculCtrl.Total_Power_Area = [[prOrPaDictionary objectForKey:@"parm8"] intValue];
        //屏体性能参数
        showCalculCtrl.Pixel_Pitch = [[prOrPaDictionary objectForKey:@"parm9"] floatValue];
        showCalculCtrl.Brightness = [[prOrPaDictionary objectForKey:@"parm10"] intValue];
        showCalculCtrl.Viewing_Angle = [prOrPaDictionary objectForKey:@"parm11"];
        showCalculCtrl.LED_Type = [prOrPaDictionary objectForKey:@"parm12"];
        //其他参数
        showCalculCtrl.Pixel_Configuration = [prOrPaDictionary objectForKey:@"parm13"];
        showCalculCtrl.Gray_Scale = [prOrPaDictionary objectForKey:@"parm14"];
        showCalculCtrl.Refresh_Frequency = [prOrPaDictionary objectForKey:@"parm15"];
        showCalculCtrl.Input_Power_Frequency = [prOrPaDictionary objectForKey:@"parm16"];
        showCalculCtrl.Input_Voltage = [prOrPaDictionary objectForKey:@"parm17"];
        showCalculCtrl.Ingress_Protection = [prOrPaDictionary objectForKey:@"parm18"];
        showCalculCtrl.Weather_Rating = [prOrPaDictionary objectForKey:@"parm19"];
        showCalculCtrl.Operating_Temperature = [prOrPaDictionary objectForKey:@"parm20"];
        showCalculCtrl.Operating_Humidity = [prOrPaDictionary objectForKey:@"parm21"];
        
        
        showCalculCtrl.productImageUrl = oneDateItem.item_img;
        DLog(@"showCalculCtrl.productImageUrl = %@",oneDateItem.item_img);
        [self.navigationController pushViewController:showCalculCtrl animated:YES];
        [showCalculCtrl release];
    }else if (alertView.tag == 300001){
//        [[[[UIApplication sharedApplication] keyWindow] viewWithTag:TAG_PROGRESS] removeFromSuperview];
        [myProgress removeFromSuperview];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:@"iscycle"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:NO forKey:@"iscycle"];
}

//返回上一主页
-(void)backToSuperView
{
    [csView free];
    if ([isFromWhere isEqualToString:@"AppDelegate"]) {
        AppDelegate *appD = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appD intoMain];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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
