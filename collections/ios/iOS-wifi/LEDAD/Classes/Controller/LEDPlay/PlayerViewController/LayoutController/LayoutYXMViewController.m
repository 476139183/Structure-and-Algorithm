//
//  LayoutYXMViewController.m
//  PlayerEdit 编辑界面，右侧为编辑显示窗口，左侧为编辑控制窗口
//  1、编辑不同屏幕区域的位置，大小
//  2、为每个可编辑区域添加素材
//  3、在屏幕上显示滚动文本
//  4、管理播放项目
//
//  Created by yixingman on 14-6-4.
//  Copyright (c) 2014年 yixingman. All rights reserved.
//  modify 2014年09月18日14:52:32
//  1、重写多层播放的函数
//  2、将项目文件夹名称与项目名称设置为相同的字符串

#import "LEDAD_TAG.h"
#import <AVFoundation/AVFoundation.h>
#import "LayoutYXMViewController.h"
#import "UIGestureRecognizer+DraggingAdditions.h"
#import <QuartzCore/QuartzCore.h>
#import "CTMasterViewController.h"
#import "AppDelegate.h"
#import "NSString+MD5.h"
#import "ProjectListObject.h"
#import "RGBColorSlider.h"
#import "RGBColorSliderDelegate.h"
#import "KWPopoverView.h"
#import "GDataXMLNode.h"
#import "Config.h"
#import "ASIFormDataRequest.h"
#import "TestBaiImageViewController.h"
#import "XMLDictionary.h"
#import "BaiImage.h"
#import "MyTool.h"
#import "YXM_VideoEditerViewController.h"
#import "YXM_VideoFrameActionObject.h"
#import "AsyncUdpSocketReceivePlayerBroadcastIp.h"
#import "ScreenOptionsViewController.h"
#import "CX_ErrorViewController.h"
#import "CX_MACViewController.h"
#import "CX_AddGroupController.h"
#import "YXM_WiFiManagerViewController.h"
#import "YXM_LoginPage.h"
#import "YXM_RegisteredPage.h"
#import "ForumWXDataServer.h"
#import "YXM_uploadViewController.h"
#import "CX_WIFIViewController.h"
#import "DYT_ClouduploadViewController.h"
#define NSEC_PER_SEC 1000000000ull


@interface LayoutYXMViewController ()<RGBColorSliderDataOutlet,UITextFieldDelegate>{
    
//    登陆界面
    YXM_LoginPage *loginPage;
//    注册界面
    YXM_RegisteredPage *registeredPage;
//    下载界面
    DYT_ClouduploadViewController *uploadView;

}
//显示区域对象数组
@property (strong, nonatomic) NSArray *evaluateViews;
@property (nonatomic, strong) RGBColorSliderDelegate *delegate;

@end

@implementation LayoutYXMViewController
{
    UIView *v;
    KWPopoverView *kw;
    NSTimer *time;
    UITextField *fieldH;
    UITextField *fieldW;
    UITextField *fieldR;
    UITextField *fieldG;
    UITextField *fieldB;
    UITextField *fieldA;
    UITextField *textfid;
    UILabel *fieldR1;
    UILabel *fieldG1;
    UILabel *fieldB1;
    UILabel *fieldA1;
    UILabel *IPShow;
    RGBColorSlider *alphaSlider;
    NSInteger Num; //屏体个数
    BOOL isloops; //是否多屏连续
    CX_ErrorViewController *CXError;
    BOOL isLEDS;
    
    
    NSMutableArray *fenzuarr;

    NSMutableArray *iparr;
}
#pragma mark 代码开始的地方

-(instancetype)init{
    self = [super init];
    if (self) {
        //待发送的文件列表
        _waitForUploadFilesArray = [[NSMutableArray alloc]init];
        //动画运动方向为不动
        iDriection = 0;
        //用户是否点击了旋转
        isRotation = NO;
        //旋转的角度
        viewdown = NO;
        fangle = 0;
        //动画索引
        animationIndex = 101;
        //项目列表
        _projectArray = [[NSMutableArray alloc]init];
        //使用流打开图片出错的列表
        analyzeImageDataErrorPathArray = [[NSMutableArray alloc]init];
        //当前选中的屏区域
        _currentSelectIndex = TAG_NO_SELECT_AREA;
        //数据是否已经全部发送完毕
        isAllSend = NO;
        //项目素材字典,按照区域编号去索引区域内的素材列表
        _projectMaterialDictionary = [[NSMutableDictionary alloc]init];
        //默认加载单屏
        isMultiScreen = NO;
        //图片循环是否是第一次加载
        isFirstRun = YES;
        //需要控制是否显示的视图集合
        myEditerCtrlViewArray = [[NSMutableArray alloc]init];
        //需要高亮的按钮集合
        myCtrlButtonArray = [[NSMutableArray alloc]init];
        //字体的大小的数组
        fontSizeArray = [[NSArray alloc]initWithObjects:@"12",@"14",@"16",@"18",@"20",@"24",@"28",@"36",@"48",@"72", nil];
        //是否发送完成
        isComplete = NO;
        //需要高亮的按钮
        mySceneButtonArray = [[NSMutableArray alloc]init];
        //需要显示的前景后景列表的视图集合
        mySceneViewArray = [[NSMutableArray alloc]init];
        isLEDS = NO;
        fenzuarr = [[NSMutableArray alloc]init];
    }
    return self;
}




/**
 *  返回按钮
 */
-(void)insertBackButton{
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 2, 40, 40)];
    [closeButton addTarget:self action:@selector(closeEditerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"backToMainButton"] forState:UIControlStateNormal];
    UIView *superView = [self.view viewWithTag:TAG_MYSTATEBAR_VIEW];
    [superView addSubview:closeButton];
    [closeButton release];
    [self isNetwork];
    [self insertCtrlViewStateButton];
}
/**
 *  控制区域显示网络连接    当前连接
 */
-(void)isNetwork{
    UIView *superView = [self.view viewWithTag:TAG_MYSTATEBAR_VIEW];
    IPShow=[[UILabel alloc]initWithFrame:CGRectMake(superView.frame.origin.x+50, 2, superView.frame.size.width-100, 40)];

    NSString *ipstr=[Config DPLocalizedString:@"adedit_selflianjie"];
    
    for (int i=0; i<selectIpArr.count; i++) {
        ipstr=[NSString stringWithFormat:@"%@%@  ,",ipstr,selectNameArr[i]];
    }
    IPShow.textAlignment = NSTextAlignmentCenter;
    IPShow.textColor = [UIColor redColor];
    [IPShow setText:ipstr];
//    [superView addSubview:IPShow];
}


/**
 *  控制区域是否显示的按钮
 */
-(void)insertCtrlViewStateButton{
    UIView *superView = [self.view viewWithTag:TAG_MYSTATEBAR_VIEW];
    UIButton *ctrlViewStateButton = [[UIButton alloc]initWithFrame:CGRectMake(superView.frame.size.width - 44, 2, 40, 40)];
    [ctrlViewStateButton addTarget:self action:@selector(ctrlViewStateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [ctrlViewStateButton setTitle:[Config DPLocalizedString:@"adedit_hide"] forState:UIControlStateNormal];
    [ctrlViewStateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [superView addSubview:ctrlViewStateButton];
    [ctrlViewStateButton release];
}

-(void)ctrlViewStateButtonClick:(UIButton *)sender{
    
    
    
    
    [self hiddenOrShowCtrlView:sender];
}

/**
 *  插入主屏幕视图
 */
-(void)insertMasertScreenView{
    NSInteger masterScreenHeight = self.view.frame.size.width - 46;
    CGRect rectMasterView = CGRectMake(5, NAVIGATION_BAR_HEIGHT+1, SCREEN_CGSIZE_2HEIGHT-320 - 10, masterScreenHeight);

    if (OS_VERSION_FLOAT>7.9) {
        masterScreenHeight = self.view.frame.size.height-46;
        rectMasterView = CGRectMake(5, NAVIGATION_BAR_HEIGHT+1, SCREEN_CGSIZE_2WIDTH-320 - 10, masterScreenHeight);
    }
//    UIScrollView *masterScreenView = [[UIScrollView alloc]initWithFrame:rectMasterView];
    UIView *masterScreenView = [[UIView alloc]initWithFrame:rectMasterView];
    [masterScreenView setBackgroundColor:[UIColor clearColor]];
    [masterScreenView setTag:TAG_MASTER_SCREEN_VIEW];
    masterScreenView.layer.borderWidth = 1.0f;
    masterScreenView.layer.borderColor = [UIColor colorWithRed:0.972 green:0.972 blue:0.974 alpha:1.000].CGColor;
//    [masterScreenView setContentSize:CGSizeMake(SCREEN_CGSIZE_2HEIGHT, SCREEN_CGSIZE_2HEIGHT)];
//    if (OS_VERSION_FLOAT>7.9) {
//        [masterScreenView setContentSize:CGSizeMake(SCREEN_CGSIZE_2WIDTH, SCREEN_CGSIZE_2WIDTH)];
//    }
//    [masterScreenView setShowsVerticalScrollIndicator:YES];
//    [masterScreenView setShowsHorizontalScrollIndicator:YES];
    
    UIButton *mybutton = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-320)/2, 0, 30, 30)];

    [mybutton setImage:[UIImage imageNamed:@"mynextvierigth"] forState:UIControlStateNormal];
    [mybutton addTarget:self action:@selector(myviewup:) forControlEvents:UIControlEventTouchUpInside];
    mybutton.tag = 922;
    [self.view addSubview:mybutton];
    
    
    
    
    //屏体选择的界面
    ScreenOptionsViewController *scree = [[ScreenOptionsViewController alloc]init];
    
    
    
    scree.istrue = YES;
    scree.view.tag = 924;
    scree.view.backgroundColor = [UIColor whiteColor];
    [scree.view setFrame:CGRectMake(0,  - masterScreenHeight, self.view.frame.size.width-320-10, masterScreenHeight)];
    UISwipeGestureRecognizer *recognizer;
    //向上滑动
    recognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer  setDirection:UISwipeGestureRecognizerDirectionUp];
    [scree.view addGestureRecognizer:recognizer];
    [recognizer release];
    //向下滑动
    recognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    [masterScreenView addGestureRecognizer:recognizer];
    [recognizer release];

    [masterScreenView addSubview:scree.view];
    [self.view addSubview:masterScreenView];
    [self.view bringSubviewToFront:mybutton];
    [masterScreenView release];
}

/**
 *  插入可编辑区域视图
 */
-(void)insertEditerScreenView{
    CGRect rect4 = CGRectMake(0, 0, 512, 96);
    [self createViewFactory:rect4 viewTag:1004];

    //文字区域根视图
    CGRect rect5 = CGRectMake(0, rect4.origin.y+rect4.size.height+2, rect4.size.width, 46);
    [self createViewFactory:rect5 viewTag:VIEW_TAG_TEXT_AREA_1005];

    //显示区域对象数组
    NSArray *viewsOfInterest = @[[self.view viewWithTag:1004],[self.view viewWithTag:VIEW_TAG_TEXT_AREA_1005]];
    [self setEvaluateViews:viewsOfInterest];

    //文字可编辑区域
    [self createTextArea];
}

/**
 *  增加底部状态栏视图
 */
-(void)insertStateBarView{
    CGRect rectStateBarView = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
    if (OS_VERSION_FLOAT<8.0) {
        rectStateBarView = CGRectMake(0, self.view.frame.size.width - 44, self.view.frame.size.height, 44);
    }
    UIView *myStateBarView = [[UIView alloc]initWithFrame:rectStateBarView];
    [myStateBarView setBackgroundColor:[UIColor colorWithWhite:0.902 alpha:1.000]];
    [myStateBarView setTag:TAG_MYSTATEBAR_VIEW];
    [self.view addSubview:myStateBarView];
    [myStateBarView release];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showOneEditerCtrlViewWithTag:TAG_PROJECT_SETTING_VIEW];
    [self highlightButtonWithTag:TAG_SAVE_PROJECT_BUTTON];
    UITextField *fil=(UITextField *)[self.view viewWithTag:TAG_PROJECT_NAME_TEXTFIELD];
    [fil setText:pname];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self FTPSendProject];
//    [self startSocket];
    Num = 0;
    CXError = [[CX_ErrorViewController alloc]init];
//    isloops = NO;
    [self.view setBackgroundColor:[UIColor blackColor]];
    //隐藏导航栏
    [self.navigationController.navigationBar setHidden:YES];
    //主屏幕视图
    [self insertMasertScreenView];
    //初始化屏幕内的可编辑区域
    [self insertEditerScreenView];
    //控制区域
    [self editCtroller];
    //状态栏区域
    [self insertStateBarView];
    //返回按钮
    [self insertBackButton];

}

/**
 *  重置编辑区域的视图Frame
 */
-(void)resetEditerViewFrame{
    @try {
        CGRect rect4 = CGRectMake(0, 0, 512, 96);
        UIView *view4 = [self.view viewWithTag:1004];
        [view4 setFrame:rect4];
        view4.transform = CGAffineTransformMakeRotation(DEGRESS_TO_RADIANS(0));
        isRotation = NO;
        fangle = 0;
        UIImageView *oldImageView = (UIImageView*)[self.view viewWithTag:TAG_BEFORE_IMAGEVIEW];
        [oldImageView setImage:nil];
        UIImageView *tempImageView = (UIImageView*)[self.view viewWithTag:(TAG_IMAGE_VIEW+1004)];
        [tempImageView setImage:nil];
        CGRect rect5 = CGRectMake(rect4.origin.x, rect4.origin.y+rect4.size.height+1, rect4.size.width, 46);
        UIView *view5 = [self.view viewWithTag:VIEW_TAG_TEXT_AREA_1005];
        [view5 setFrame:rect5];

        CGRect rect6 = CGRectMake(0, 0, 512, 96);
        UIView *view6 = [self.view viewWithTag:1006];
        [view6 setFrame:rect6];
        [self.view bringSubviewToFront:view4];


        CGRect rect1 = CGRectMake(0, 96+0, 360, 300);
        UIView *view1 = [self.view viewWithTag:1001];
        [view1 setFrame:rect1];
        CGRect rect2 = CGRectMake(360+0, 96+0, 152, 150);
        UIView *view2 = [self.view viewWithTag:1002];
        [view2 setFrame:rect2];
        CGRect rect3 = CGRectMake(360+0, 150+96+0, 152, 150);
        UIView *view3 = [self.view viewWithTag:1003];
        [view3 setFrame:rect3];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    @finally {

    }

}


-(void)ftpuser1{
    if (!_ftpMgr) {
        //连接ftp服务器
        _ftpMgr = [[YXM_FTPManager alloc]init];
        _ftpMgr.delegate = self;
    }
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* sZipPath =[NSString stringWithFormat:@"%@/vlc.txt",DocumentsPath];
    NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@:21/config",ipAddressString];
    [_ftpMgr startUploadFileWithAccount:@"ftpuser" andPassword:@"ftpuser" andUrl:sUploadUrl andFilePath:sZipPath];
    NSFileManager * fm = [NSFileManager defaultManager];
    NSDictionary * dict = [fm attributesOfItemAtPath:sZipPath error:nil];
    //方法一:
    NSLog(@"size = %lld",[dict fileSize]);

}

//同步
-(void)ftpuser2:(NSString *)stringip
{
    //    if (!_ftpMgr) {
    //连接ftp服务器
    _ftpMgr = [[YXM_FTPManager alloc]init];
    _ftpMgr.delegate = self;
    //    }
    
    
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* sZipPath =[NSString stringWithFormat:@"%@/ip.xml",DocumentsPath];
    NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@:21/manager_xmls",mianipscrenn];
    
    [_ftpMgr startUploadFileWithAccount:@"ftpuser" andPassword:@"ftpuser" andUrl:sUploadUrl andFilePath:sZipPath];
    NSFileManager * fm = [NSFileManager defaultManager];
    NSDictionary * dict = [fm attributesOfItemAtPath:sZipPath error:nil];
    
    //方法一:
    NSLog(@"size = %lld",[dict fileSize]);
    
}
-(void)qxzp:(NSMutableArray *)arr{
    iparr = [[NSMutableArray alloc]init];
    iparr = arr;
    [self qxzp];
}

//取消主屏
-(void)qxzp{
    isConnect =  NO;
    ipAddressString = iparr[Num];
    [self startSocket];
    [self commandResetServerWithType:0x4c andContent:nil andContentLength:0];
}

/**
 * 发送多屏IP
 */
-(void)ip{
    if (!isConnect) {
        [self startSocket];
    }
    DLog(@"多屏IP");
    //0x18
    [self commandIPServerWithType:0x18 andContent:nil andContentLength:0];
}
-(void)commandIPServerWithType:(Byte)commandType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength
{
    int byteLength = 7+4*(iparr.count-1);
    
    Byte outdate[byteLength];
    memset(outdate, 0x00, byteLength);
    outdate[0]=0x7D;
    outdate[1]=commandType;//命令类型
    outdate[2]=0x00; /*命令执行与状态检查2：获取服务器端的数据*/
    outdate[3]=iparr.count;

//    for (NSString *str in iparr) {
//        if ([str isEqualToString:mianipscrenn]) {
//            [iparr removeObject:str];
//        }
//    }
//    int k = 0;
    [iparr removeObject:mianipscrenn];
    for (int i=0; i<iparr.count; i++) {
        if(![iparr[i] isEqualToString:mianipscrenn]){
            NSArray *b = [iparr[i] componentsSeparatedByString:@"."];
            for (int j=1; j<=b.count; j++) {
                DLog(@"=======%@",b);
                outdate[3+j+4*i]=[b[j-1] intValue];
                DLog(@"===%d  %d",outdate[3+j+4*i],3+j+4*i);
//                k = k+1;
            }
        }
    }
    outdate[byteLength-3]=(Byte)byteLength;
    outdate[byteLength-2]=(Byte)(byteLength>>8);
    //计算校验码
    int sumByte = 0;
    for (int j=0; j<(byteLength-1); j++) {
        sumByte += outdate[j];
    }
    //校验码计算（包头到校验码前所有字段求和取反+1）
    outdate[(byteLength-1)]=~(sumByte)+1;
    long tag = outdate[1];
    DLog(@"恢复默认列表 = %d",(int)commandType);
    NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:byteLength];
    DLog(@"udpPacketData=======%@",udpPacketData);
    [_sendPlayerSocket writeData:udpPacketData withTimeout:-1 tag:tag];
}

/**
 *  销毁定时器
 *
 *  @param myTimer 定时器
 */
-(void)KillTimer:(NSTimer *)myTimer
{
    if(myTimer)
    {
        if([myTimer isValid])
        {
            [myTimer invalidate];
        }

        myTimer=nil;
    }
}

/**
 *  //清理定时器
 */
-(void)clearAllTimer{
    if (timerKillerArray) {
        for (NSTimer *oneTimer in timerKillerArray) {
            [self KillTimer:oneTimer];
        }
    }
}


/**
 *  返回按钮，需要在返回的时候清理定时器资源
 *
 *  @param sender
 */
-(void)closeEditerButtonClick:(UIButton*)sender{
    @try {
        [self quitePlayProjAndResetEditer:YES];

        //停止音乐播放器
        if (myMusicPicker.myMusicPlayer) {
            [myMusicPicker.myMusicPlayer setCurrentTime:1000000];
            [myMusicPicker.myMusicPlayer stop];
        }


        //清理定时器
        [self clearAllTimer];
        isFirstRun = YES;

        [self cleanEditerResources];
        self.view = nil;

        [self myRelease];

        AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [myDelegate.window setRootViewController:(UIViewController*)myDelegate.rootCtrl];
    }
    @catch (NSException *exception) {
        DLog(@"点击返回按钮报错=%@",exception);
    }
    @finally {

    }
}


/**
 *  创建按钮
 *
 *  @param frame        按钮的区域
 *  @param tag          按钮的标签
 *  @param selector     按钮点击的响应事件
 *  @param title        按钮上的文字
 *  @param superViewTag 按钮的父视图
 */
-(void)creteeButtonWithFrame:(CGRect)frame andTag:(NSInteger)tag andAction:(SEL)selector andTitle:(NSString *)title superViewTag:(NSInteger)superViewTag{

    UIView *superView = [self.view viewWithTag:superViewTag];

    UIButton *myControlButton = [[UIButton alloc]initWithFrame:frame];

    [myControlButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myControlButton setTag:tag];
    [myControlButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [myControlButton setTitle:title forState:UIControlStateNormal];
    if (tag == TAG_DEFAULT_REGION_BUTTON) {
        [myControlButton addTarget:self action:@selector(saveDefaultApplyTitle:) forControlEvents:UIControlEventTouchDragExit];
    }

    [myControlButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];


    [myControlButton setBackgroundColor:[UIColor grayColor]];
    myControlButton.layer.borderColor = [UIColor greenColor].CGColor;
    myControlButton.layer.borderWidth = 0.5;
    [myControlButton.titleLabel setFont:[UIFont systemFontOfSize:BUTTON_TITILE_FONT]];
    [superView addSubview:myControlButton];
    [myControlButton release];
}

/**
 *  编辑控制器
 */
-(void)editCtroller{
    UIView *editCtrollerView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_CGSIZE_2HEIGHT-320,NAVIGATION_BAR_HEIGHT, 320, SCREEN_CGSIZE_2WIDTH)];
    if (OS_VERSION_FLOAT>7.9) {
        [editCtrollerView setFrame:CGRectMake(SCREEN_CGSIZE_2WIDTH-320,NAVIGATION_BAR_HEIGHT, 320, SCREEN_CGSIZE_2HEIGHT)];
    }
    [editCtrollerView setBackgroundColor:[UIColor colorWithRed:0.972 green:0.972 blue:0.972 alpha:1.000]];
    [editCtrollerView setTag:TAG_EDIT_CONTROLLER_VIEW];
    [self.view addSubview:editCtrollerView];
    [editCtrollerView release];

    //功能按钮区域
    UIView *settingsButtonView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, editCtrollerView.frame.size.width-10, 44)];
    [settingsButtonView setTag:TAG_CONTROL_BUTTON_VIEW];
    [editCtrollerView addSubview:settingsButtonView];
    [settingsButtonView release];

    //范围设置
    NSInteger buttonWidth = 310/4;
    CGRect rect1 = CGRectMake(0, 0, buttonWidth, 44);
    //列表设置
    CGRect rect2 = CGRectMake(rect1.origin.x + rect1.size.width, 0, buttonWidth, 44);
    //wifi设置
    CGRect rect3 = CGRectMake(rect2.origin.x + rect2.size.width, 0, buttonWidth, 44);
//    登陆
    CGRect rect4 = CGRectMake(rect3.origin.x + rect3.size.width, 0, buttonWidth, 44);
    
    [self creteeButtonWithFrame:rect1 andTag:TAG_ITEM_SETTING_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_Item"] superViewTag:TAG_CONTROL_BUTTON_VIEW];
    [self addCtrlButtonToArrayWithTag:TAG_ITEM_SETTING_BUTTON];

    [self creteeButtonWithFrame:rect2 andTag:TAG_SAVE_PROJECT_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_Project"] superViewTag:TAG_CONTROL_BUTTON_VIEW];
    [self addCtrlButtonToArrayWithTag:TAG_SAVE_PROJECT_BUTTON];
    
    [self creteeButtonWithFrame:rect3 andTag:TAG_WIFI_SET_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_wifi22"] superViewTag:TAG_CONTROL_BUTTON_VIEW];
    [self addCtrlButtonToArrayWithTag:TAG_WIFI_SET_BUTTON];
    
    [self creteeButtonWithFrame:rect4 andTag:TAG_LOGIN_SETBUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"Login_btn"] superViewTag:TAG_CONTROL_BUTTON_VIEW];
    [self addCtrlButtonToArrayWithTag:TAG_LOGIN_SETBUTTON];
    
    
    
/*
    //    [self creteeButtonWithFrame:rect1 andTag:TAG_SETTIONG_REGION_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_Region"] superViewTag:TAG_CONTROL_BUTTON_VIEW];
    //    [self addCtrlButtonToArrayWithTag:TAG_SETTIONG_REGION_BUTTON];
    //    UIButton * btn=(UIButton*)[self.view viewWithTag:TAG_SETTIONG_REGION_BUTTON];
    //    btn.selected=NO;
    
    //    UIButton * btn1=(UIButton*)[self.view viewWithTag:TAG_ITEM_SETTING_BUTTON];
    //    btn1.selected=NO;
    //文本设置
    //    CGRect rect3 = CGRectMake(rect2.origin.x + rect2.size.width, 0, buttonWidth, 44);
    //    [self creteeButtonWithFrame:rect3 andTag:TAG_TEXT_EDIT_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_Text"] superViewTag:TAG_CONTROL_BUTTON_VIEW];
    //    [self addCtrlButtonToArrayWithTag:TAG_TEXT_EDIT_BUTTON];
    //
    //
    //    //音频设置
    //    CGRect rect4 = CGRectMake(rect3.origin.x + rect3.size.width, 0, buttonWidth, 44);
    //    [self creteeButtonWithFrame:rect4 andTag:TAG_MUSIC_EDIT_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_music_ctrl"] superViewTag:TAG_CONTROL_BUTTON_VIEW];
    //    [self addCtrlButtonToArrayWithTag:TAG_MUSIC_EDIT_BUTTON];
    
    //项目设置
    //    CGRect rect5 = CGRectMake(rect2.origin.x + rect2.size.width, 0, buttonWidth, 44);
//    UIButton * btn2=(UIButton*)[self.view viewWithTag:TAG_CONTROL_BUTTON_VIEW];
//    btn2.selected=YES;
 */
    //区域的范围设置
    [self editCtrlRegionSettings];

    //区域内的子项列表
    [self regionSubitemList];

    //文本设置
    [self textRegionSetting];

    //音频设置
    [self musicSettingView];

    //项目设置
    [self projectSetting];

    //右侧控制区域，默认加载Region区域
    [self showOneEditerCtrlViewWithTag:TAG_PROJECT_SETTING_VIEW];

    //右侧控制区域，默认选中Region按钮
    [self highlightButtonWithTag:TAG_SAVE_PROJECT_BUTTON];


}

-(void)addCtrlButtonToArrayWithTag:(NSInteger)buttonTag{
    @try {
        UIButton *myButton = ((UIButton *)[self.view viewWithTag:buttonTag]);
        if ([myCtrlButtonArray indexOfObject:myButton] == NSNotFound) {
            [myCtrlButtonArray addObject:myButton];
        }
    }
    @catch (NSException *exception) {
        DLog(@"addCtrlButtonToArrayWithTag方法中异常 =%@",exception);
    }
    @finally {

    }
}

-(void)highlightButtonWithTag:(NSInteger)buttonTag{
    for (UIButton *myButton in myCtrlButtonArray) {
        if (myButton.tag == buttonTag) {
            [myButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        }else{
            [myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

/**
 *  根据点击的功能按钮来显示功能区域
 *
 *  @param viewTag 要显示的功能区域的标签
 */
-(void)showOneEditerCtrlViewWithTag:(NSInteger)viewTag{
    for (UIView *myView in myEditerCtrlViewArray) {
        if (myView.tag == viewTag) {
            [myView setHidden:NO];
        }else{
            [myView setHidden:YES];
        }
    }
}

-(void)createTextViewWithFrame:(CGRect)rect viewTag:(NSInteger)tag{

    UIView *supserView = [self.view viewWithTag:TAG_TEXT_REGION_SETTING_VIEW];

    UITextView *myTextView = [[UITextView alloc]initWithFrame:rect];
    myTextView.tag = tag;
    myTextView.layer.borderColor = [UIColor blackColor].CGColor;
    myTextView.layer.borderWidth = 2.0f;
    if (TEST_MODE == CURRENT_MODE) {
        [myTextView setText:[Config DPLocalizedString:@"adedit_defaultText"]];
    }


    [supserView addSubview:myTextView];
    [myTextView release];
}

/**
 *  文字设置区域
 */
-(void)textRegionSetting{
    UIView *supserView = [self.view viewWithTag:TAG_EDIT_CONTROLLER_VIEW];
    //功能选择按钮区域视图
    UIView *tempYView = [self.view viewWithTag:TAG_CONTROL_BUTTON_VIEW];


    UIView *textRegionSettingsView = [[UIView alloc]initWithFrame:CGRectMake(5, tempYView.frame.origin.y + tempYView.frame.size.height + 5, supserView.frame.size.width-10, supserView.frame.size.height - tempYView.frame.size.height - 15 - HEIGHT_OF_BUTTOM_BAR)];
    [textRegionSettingsView setTag:TAG_TEXT_REGION_SETTING_VIEW];
    textRegionSettingsView.layer.borderWidth = 2.0f;
    textRegionSettingsView.layer.borderColor = [[UIColor blackColor] CGColor];

    [myEditerCtrlViewArray addObject:textRegionSettingsView];

    [supserView addSubview:textRegionSettingsView];
    [textRegionSettingsView release];


    CGRect xRect = CGRectMake(5, 5, textRegionSettingsView.frame.size.width - 10, 150);
    [self createTextViewWithFrame:xRect viewTag:5001];



    //设置运动速度 文本框
    CGRect rectRollingSpeed = CGRectMake(5, xRect.origin.y + xRect.size.height + 5, 140, 30);

    //设置运动速度 文本框
    CGRect rectTextFontSize = CGRectMake(rectRollingSpeed.origin.x + rectRollingSpeed.size.width + 5, xRect.origin.y + xRect.size.height + 5, 140, 30);


    //设置字体 文本框
    CGRect rectTextFont = CGRectMake(5, rectRollingSpeed.origin.y + rectRollingSpeed.size.height + 5, 300, 30);

    //设置文字的颜色 按钮 点击弹出选择器
    CGRect rectTextColor = CGRectMake(5, rectTextFont.origin.y + rectTextFont.size.height + 5, 300, 44);
    [self creteeButtonWithFrame:rectTextColor andTag:TAG_CHANGE_COLOR_BUTTON andAction:@selector(changeTextColorButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_Presstosettextcolor"] superViewTag:TAG_TEXT_REGION_SETTING_VIEW];

    //设置文字背景的颜色 按钮 点击弹出选择器
    //    CGRect rectTextBackgroundColor = CGRectMake(5, rectTextColor.origin.y + rectTextColor.size.height + 5, 300, 30);
    //    [self creteeButtonWithFrame:rectTextBackgroundColor andTag:TAG_CHANGE_TEXT_BACK_GROUND_COLOR_BUTTON andAction:@selector(changeTextBackgroundColorButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_Presstosettextbackgroundcolor"] superViewTag:TAG_TEXT_REGION_SETTING_VIEW];
    //设置文字的字体 按钮 点击弹出选择器
    //设置文字背景的透明度 滑块Slider




    //保存按钮

    //    CGRect rectSaveTextToScreenButton = CGRectMake(5, rectTextBackgroundColor.origin.y + rectTextBackgroundColor.size.height+5, 300, 30);
    CGRect rectSaveTextToScreenButton = CGRectMake(5, rectTextColor.origin.y + rectTextColor.size.height + 5, 300, 44);
    [self creteeButtonWithFrame:rectSaveTextToScreenButton andTag:TAG_SAVE_TEXT_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_SaveChange"] superViewTag:TAG_TEXT_REGION_SETTING_VIEW];

    //设置文字字体控件
    [self createTextFontTextFieldWithFrame:rectTextFont andTag:TAG_ROLLING_FONT_TEXT superViewTag:TAG_TEXT_REGION_SETTING_VIEW];


    //设置字体大小控件
    [self createSizeTextFieldWithFrame:rectTextFontSize andTag:TAG_FONT_SIZE_TEXT superViewTag:TAG_TEXT_REGION_SETTING_VIEW];

    //设置滚动速度控件
    [self createSpeedTextFieldWithFrame:rectRollingSpeed andTag:TAG_ROLLING_SPEED_TEXT superViewTag:TAG_TEXT_REGION_SETTING_VIEW];


}


/**
 *  改变亮度的事件，显示颜色拾取器的窗口
 *
 *  @param sender 触发按钮
 */
-(void)changeBrightnessColorButtonClick{
    isOK=0;
    UIButton *sender=(UIButton*)[self.view viewWithTag:TAG_BRIGHTNESS_REGION_BUTTON];
    JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
    _currentChangeColorViewTag = ticker.tag + 1;
    UIView *supserView1 = [self.view viewWithTag:TAG_EDIT_CONTROLLER_VIEW];

    UIView *supserView = [self.view viewWithTag:TAG_TEXT_REGION_SETTING_VIEW];
    CGPoint point1 = ((UIButton*)sender).center;
    NSInteger contentViewWidth = supserView.frame.size.width;
    NSInteger contentViewHeight = 370;

    CGRect contentViewRect = CGRectMake(supserView1.frame.origin.x , sender.frame.origin.y + sender.frame.size.height, contentViewWidth, contentViewHeight);
    UIColor *myTColor = [ticker.tickerColor retain];
    UIView *contentView = [self createBrightnessSwithView:contentViewRect viewTag:0 supserViewTag:0 andColor:myTColor];

    [KWPopoverView showPopoverAtPoint:point1 inView:supserView withContentView:contentView];
    time=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(aaa) userInfo:nil repeats:YES];
}
-(void)aaa{
    [self HW];
    if (isOK) {
        [self UploadBrightness];
        [time invalidate];
    }
}
+(void)ISOK{
    isOK=1;
}
-(void)HW{
    _alpha1=[fieldA.text integerValue];
    _red1=[fieldR.text integerValue];
    _green1=[fieldG.text integerValue];
    _blue1=[fieldB.text integerValue];
    _height2=[fieldH.text integerValue];
    _width2=[fieldW.text integerValue];
    if(_alpha1>255){
        _alpha1=255;
        fieldA.text=@"255";
    }else if(_alpha1<0){
        _alpha1=0;
        fieldA.text=@"0";
    }
    if(_red1>255){
        _red1=255;
        fieldR.text=@"255";
    }else if(_red1<0){
        _red1=0;
        fieldR.text=@"0";
    }
    if(_green1>255){
        _green1=255;
        fieldG.text=@"255";
    }else if(_green1<0){
        _green1=0;
        fieldG.text=@"0";
    }
    if(_blue1>255){
        _blue1=255;
        fieldB.text=@"255";
    }else if(_blue1<0){
        _blue1=0;
        fieldB.text=@"0";
    }
    if(_width2>1024 || _width2<0){
        _width2=0;
        fieldW.text=@"0";
    }
    if(_height2>768 || _height2<0){
        _height2=0;
        fieldH.text=@"0";
    }
}
/**
 *  改变文字颜色的事件，显示颜色拾取器的窗口
 *
 *  @param sender 触发按钮
 */
-(void)changeTextColorButtonClick:(UIButton *)sender{
    JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
    _currentChangeColorViewTag = ticker.tag + 1;
    UIView *supserView1 = [self.view viewWithTag:TAG_EDIT_CONTROLLER_VIEW];

    UIView *supserView = [self.view viewWithTag:TAG_TEXT_REGION_SETTING_VIEW];
    CGPoint point1 = ((UIButton*)sender).center;
    NSInteger contentViewWidth = supserView.frame.size.width;
    NSInteger contentViewHeight = 370;

    CGRect contentViewRect = CGRectMake(supserView1.frame.origin.x , sender.frame.origin.y + sender.frame.size.height, contentViewWidth, contentViewHeight);
    UIColor *myTColor = [ticker.tickerColor retain];
    UIView *contentView = [self createColorSwithView:contentViewRect viewTag:0 supserViewTag:0 andColor:myTColor];

    [KWPopoverView showPopoverAtPoint:point1 inView:supserView withContentView:contentView];
}

/**
 *  改变文字背景颜色的处理事件
 *
 *  @param sender 触发按钮
 */
-(void)changeTextBackgroundColorButtonClick:(UIButton *)sender{
    JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];

    _currentChangeColorViewTag = ticker.tag;

    UIView *supserView = [self.view viewWithTag:TAG_TEXT_REGION_SETTING_VIEW];
    UIView *supserView1 = [self.view viewWithTag:TAG_EDIT_CONTROLLER_VIEW];
    CGPoint point1 = ((UIButton*)sender).center;
    NSInteger contentViewWidth = supserView.frame.size.width;
    NSInteger contentViewHeight = 370;
    CGRect contentViewRect = CGRectMake(supserView1.frame.origin.x +5 , supserView.frame.origin.y + supserView.frame.size.height , contentViewWidth, contentViewHeight);

    UIView *contentView = [self createColorSwithView:contentViewRect viewTag:0 supserViewTag:0 andColor:ticker.backgroundColor];
    [KWPopoverView showPopoverAtPoint:point1 inView:supserView withContentView:contentView];
}

/**
 *  项目设置区域
 */
-(void)projectSetting{
    UIView *supserView = [self.view viewWithTag:TAG_EDIT_CONTROLLER_VIEW];

    UIView *tempYView = [self.view viewWithTag:TAG_CONTROL_BUTTON_VIEW];


    UIView *projectView = [[UIView alloc]initWithFrame:CGRectMake(0, tempYView.frame.origin.y + tempYView.frame.size.height + 0, supserView.frame.size.width, supserView.frame.size.height - (tempYView.frame.size.height + 5)  - HEIGHT_OF_BUTTOM_BAR)];
    [projectView setTag:TAG_PROJECT_SETTING_VIEW];
    [myEditerCtrlViewArray addObject:projectView];
    [supserView addSubview:projectView];
    [projectView release];


    UIView *projectSettingView = [[UIView alloc]initWithFrame:CGRectMake(5,  5, supserView.frame.size.width-10, supserView.frame.size.width-10-150)];

    projectSettingView.layer.borderWidth = 2.0f;
    projectSettingView.layer.borderColor = [[UIColor blackColor] CGColor];
    [projectView addSubview:projectSettingView];
    [projectSettingView release];



  
    
    //项目名称输入框
    CGRect rect4 = CGRectMake( 10, 10, projectSettingView.frame.size.width - 10, 44);
    [self createRegionPropertiesViewWithFrame:rect4 viewTag:TAG_PROJECT_NAME_TEXTFIELD leftLabelText:[Config DPLocalizedString:@"adedit_ProName"] superViewTag:TAG_PROJECT_SETTING_VIEW defaultText:@""];

    CGRect rect5 = CGRectMake(20, rect4.origin.y + rect4.size.height + 5, 90, 44);
    [self creteeButtonWithFrame:rect5 andTag:TAG_SAVE_AS_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_SaveProject"] superViewTag:TAG_PROJECT_SETTING_VIEW];
    UIButton * btn1 = (UIButton *)[self.view viewWithTag:TAG_SAVE_AS_BUTTON];
    btn1.hidden=NO;
     
    
    
    //重置屏上的数据的按钮
    CGRect rect51 = CGRectMake(projectView.frame.size.width - 100, rect4.origin.y + rect4.size.height + 5, 90, 44);
    [self creteeButtonWithFrame:rect51 andTag:TAG_REST_SCREEN_AS_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_RestDataProject"] superViewTag:TAG_PROJECT_SETTING_VIEW];




    //云屏项目
    CGRect rect52 = CGRectMake(projectView.frame.size.width - 100, rect51.origin.y + rect51.size.height + 10, 90, 44);
    [self creteeButtonWithFrame:rect52 andTag:TAG_SCREEN_PLAYLIST_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_wifi24"] superViewTag:TAG_PROJECT_SETTING_VIEW];




    //云屏检测
    CGRect rect54 = CGRectMake(rect52.origin.x-rect52.size.width-10 ,rect52.origin.y, 90, 44);
//    [self creteeButtonWithFrame:rect54 andTag:TAG_LED_DETECT_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_screenpDetect"] superViewTag:TAG_PROJECT_SETTING_VIEW];





    //多屏同步
    CGRect rect53 = CGRectMake(20, rect51.origin.y + rect51.size.height + 10, 90, 44);
//    [self creteeButtonWithFrame:rect53 andTag:nil andAction:@selector(cxonclick) andTitle:[Config DPLocalizedString:@"adedit_tongbu"] superViewTag:TAG_PROJECT_SETTING_VIEW];

    //项目列表
    UIView *projectItemView = [[UIView alloc]initWithFrame:CGRectMake(5, projectSettingView.frame.origin.y + projectSettingView.frame.size.height +5, projectSettingView.frame.size.width, supserView.frame.size.height - projectSettingView.frame.size.height - tempYView.frame.size.height - 44 - 20)];
    [projectItemView setTag:TAG_PROJECT_LIST_VIEW];
    projectItemView.layer.borderWidth = 2.0f;
    projectItemView.layer.borderColor = [UIColor blackColor].CGColor;



    //项目列表
    CGRect rect6 = CGRectMake(5 , 5, 90, 44);
    myProjectCtrl = [[MyProjectListViewController alloc]init];
    myProjectCtrl.view.tag=9999;
    [myProjectCtrl.view setFrame:CGRectMake(0, 50+44+10, projectItemView.frame.size.width, (projectItemView.frame.size.height - 60 - rect6.size.height - 44 - 5 - 10))];
    myProjectCtrl.delegate = self;
    [projectItemView addSubview:myProjectCtrl.view];

    [projectView addSubview:projectItemView];
    [projectItemView release];

    //退出播放按钮

    [self creteeButtonWithFrame:rect6 andTag:TAG_QUIT_PLAY_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_QuitPlay"] superViewTag:TAG_PROJECT_LIST_VIEW];

    //删除项目按钮
    CGRect rect7 = CGRectMake(rect6.origin.x + rect6.size.width + 5 , 5, 95, 44);
    [self creteeButtonWithFrame:rect7 andTag:TAG_DELETE_PROJ_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_DeleteProj"] superViewTag:TAG_PROJECT_LIST_VIEW];
    [self setHiddenQuitPlayButton:YES];

    //编辑项目按钮
    CGRect rect8 = CGRectMake(rect7.origin.x + rect7.size.width + 5 , 5, 105, 44);
    [self creteeButtonWithFrame:rect8 andTag:TAG_EDIT_PROJ_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_EditProj"] superViewTag:TAG_PROJECT_LIST_VIEW];
    UIButton * btn3 = (UIButton *)[self.view viewWithTag:TAG_EDIT_PROJ_BUTTON];
    btn3.hidden=YES;
    //搜索框
    CGRect mySearchTextFieldRect = CGRectMake(rect6.origin.x, rect6.origin.y + rect6.size.height + 10, projectItemView.frame.size.width - 70, rect6.size.height);
    UITextField *searchTextField = [[UITextField alloc]initWithFrame:mySearchTextFieldRect];
    searchTextField.layer.borderWidth = 1;
    searchTextField.layer.borderColor = [UIColor grayColor].CGColor;
    [searchTextField setTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
    UIView *superView = [self.view viewWithTag:TAG_PROJECT_LIST_VIEW];
    [superView addSubview:searchTextField];
    [searchTextField release];
    //搜索按钮
    CGRect searchButtonRect = CGRectMake(mySearchTextFieldRect.origin.x + mySearchTextFieldRect.size.width , mySearchTextFieldRect.origin.y, 60, mySearchTextFieldRect.size.height);
    [self creteeButtonWithFrame:searchButtonRect andTag:TAG_SEARCH_PUBLISH_PROJ_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_SearchPublishProj"] superViewTag:TAG_PROJECT_LIST_VIEW];


    //发布到显示屏
    CGRect rect9 = CGRectMake(5 , myProjectCtrl.view.frame.origin.y + (projectItemView.frame.size.height - 60 - (rect6.size.height+mySearchTextFieldRect.size.height) - 5) - 10, myProjectCtrl.view.frame.size.width - 10, 55);
    [self creteeButtonWithFrame:rect9 andTag:TAG_PUBLISH_PROJ_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_PublishProj"] superViewTag:TAG_PROJECT_LIST_VIEW];

    UIButton *myTempButton = (UIButton*)[self.view viewWithTag:TAG_PUBLISH_PROJ_BUTTON];
    myTempButton.hidden=YES;
    [myTempButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
}

-(void)cxonclick{
    CX_MACViewController *mac = [[CX_MACViewController alloc]init];
    [mac viewDidLoad];
}

//多屏同步按钮点击事件
-(void)tongBu_buttonOnClick:(NSString *)mianip andarr:(NSMutableArray *)arr
{
    if (arr.count==0) {
        [CXError NOipError];
    }else{
        //        获取主屏ip
        DLog(@"mian====%@",mianip);
        iparr = [[NSMutableArray alloc]init];
        for (NSString *str in arr) {
            [iparr addObject:str];
        }
        DLog(@"%@",iparr);
        mianipscrenn = mianip;
        ipAddressString = mianip;
        isLEDS = NO;
        [self LEDsxml:mianip andiparray:arr];
    }
    
}

/**
 *  设置退出播放按钮的是否隐藏属性
 *
 *  @param isHidden YES/NO
 */
-(void)setHiddenQuitPlayButton:(BOOL)isHidden{
    //退出播放按钮
    UIButton *tempPlayButton = (UIButton*)[self.view viewWithTag:TAG_QUIT_PLAY_BUTTON];
    [tempPlayButton setHidden:isHidden];

    //删除项目
    UIButton *deleteProjButton = (UIButton*)[self.view viewWithTag:TAG_DELETE_PROJ_BUTTON];
    [deleteProjButton setHidden:isHidden];


}


/**
 *  设置编辑项目按钮的是否隐藏属性
 *
 *  @param isHidden YES/NO
 */
-(void)changeEditPlayButton:(BOOL)isHidden{
    UIButton *tempEditPlayButton = (UIButton*)[self.view viewWithTag:TAG_EDIT_PROJ_BUTTON];
    if (isHidden) {
        [tempEditPlayButton setTitle:[Config DPLocalizedString:@"adedit_SaveProjandQuitEdit"] forState:UIControlStateNormal];
    }else{
        [tempEditPlayButton setTitle:[Config DPLocalizedString:@"adedit_EditProj"] forState:UIControlStateNormal];
    }

    //保存项目按钮
    UIButton *myButton = (UIButton*)[self.view viewWithTag:TAG_SAVE_AS_BUTTON];
    [myButton setHidden:isHidden];
}

/**
 *  区域设定视图
 */
-(void)editCtrlRegionSettings{

    UIView *supserView = [self.view viewWithTag:TAG_EDIT_CONTROLLER_VIEW];

    UIView *tempYView = [self.view viewWithTag:TAG_CONTROL_BUTTON_VIEW];


    UIView *myRegionSettingsView = [[UIView alloc]initWithFrame:CGRectMake(5, tempYView.frame.origin.y + tempYView.frame.size.height + 5, supserView.frame.size.width-10, supserView.frame.size.height-100)];
    [myRegionSettingsView setTag:TAG_REGION_SETTINGS_VIEW];
    myRegionSettingsView.layer.borderWidth = 2.0f;
    myRegionSettingsView.layer.borderColor = [[UIColor blackColor] CGColor];

    [myEditerCtrlViewArray addObject:myRegionSettingsView];

    [supserView addSubview:myRegionSettingsView];
    [myRegionSettingsView release];

    //Region的属性
    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,5, 90, 50)];
    [promptLabel setText:[Config DPLocalizedString:@"adedit_selectedRegion"]];
    [promptLabel setFont:[UIFont boldSystemFontOfSize:10]];
    [myRegionSettingsView addSubview:promptLabel];
    [promptLabel release];

    UILabel *regionTagLabel = [[UILabel alloc]initWithFrame:CGRectMake(promptLabel.frame.origin.x + promptLabel.frame.size.width,5, myRegionSettingsView.frame.size.width - promptLabel.frame.size.width - 10, 50)];
    [regionTagLabel setBackgroundColor:[UIColor grayColor]];
    [regionTagLabel setTag:TAG_REGION_TAG_LABEL];
    [regionTagLabel setTextColor:[UIColor whiteColor]];
    [myRegionSettingsView addSubview:regionTagLabel];

    CGRect xRect = CGRectMake(5, regionTagLabel.frame.origin.y +regionTagLabel.frame.size.height + 5, regionTagLabel.frame.size.width, 30);
    [self createRegionPropertiesViewWithFrame:xRect viewTag:REGION_TAG_EDITOR_2001 leftLabelText:@"X:" superViewTag:TAG_REGION_SETTINGS_VIEW defaultText:nil];

    CGRect yRect = CGRectMake(5, xRect.origin.y + xRect.size.height + 5, regionTagLabel.frame.size.width, 30);
    [self createRegionPropertiesViewWithFrame:yRect viewTag:REGION_TAG_EDITOR_2002 leftLabelText:@"Y:" superViewTag:TAG_REGION_SETTINGS_VIEW defaultText:nil];

    CGRect wRect = CGRectMake(5, yRect.origin.y + yRect.size.height + 5, regionTagLabel.frame.size.width, 30);
    [self createRegionPropertiesViewWithFrame:wRect viewTag:REGION_TAG_EDITOR_2003 leftLabelText:@"W:" superViewTag:TAG_REGION_SETTINGS_VIEW defaultText:nil];

    CGRect hRect = CGRectMake(5, wRect.origin.y + wRect.size.height + 5, regionTagLabel.frame.size.width, 30);
    [self createRegionPropertiesViewWithFrame:hRect viewTag:REGION_TAG_EDITOR_2004 leftLabelText:@"H:" superViewTag:TAG_REGION_SETTINGS_VIEW defaultText:nil];

    //应用按钮
    CGRect rectApplyReginButton = CGRectMake(hRect.origin.x  , hRect.origin.y + hRect.size.height + 5, hRect.size.width, 44);
    [self creteeButtonWithFrame:rectApplyReginButton andTag:TAG_APPLY_REGION_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_applyRegionbuttontitle"] superViewTag:TAG_REGION_SETTINGS_VIEW];

    //设置默认宽高为160X640
    CGRect rect7 = CGRectMake(rectApplyReginButton.origin.x  , rectApplyReginButton.origin.y + rectApplyReginButton.size.height + 5, rectApplyReginButton.size.width, 44);
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger ih = [ud integerForKey:@"ih"];
    if (ih == 0) {
        ih = 640;
    }
    [ud setInteger:ih forKey:@"ih"];
    NSInteger iw = [ud integerForKey:@"iw"];
    if (iw == 0) {
        iw = 160;
    }
    [ud setInteger:iw forKey:@"iw"];

    NSString *sButtonTitle = [[NSString alloc]initWithFormat:@"%@%ldX%ld",[Config DPLocalizedString:@"adedit_setDefaultAppplyTitle"],(long)iw,(long)ih];

    [self creteeButtonWithFrame:rect7 andTag:TAG_DEFAULT_REGION_BUTTON andAction:@selector(functionButtonClick:) andTitle:sButtonTitle superViewTag:TAG_REGION_SETTINGS_VIEW];

    //设置旋转角度的按钮

    CGRect rect8 = CGRectMake(rect7.origin.x  , rect7.origin.y + rect7.size.height + 5, rect7.size.width, 44);
    [self creteeButtonWithFrame:rect8 andTag:TAG_MAKE_ROTATION_REGION_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_rotation_45"] superViewTag:TAG_REGION_SETTINGS_VIEW];
    //设置屏幕亮度
    CGRect rect9 = CGRectMake(rect8.origin.x, rect8.origin.y+rect8.size.height+5, rect8.size.width, 44);
    [self creteeButtonWithFrame:rect9 andTag:
        TAG_BRIGHTNESS_REGION_BUTTON andAction:@selector(resetBrightness) andTitle:[Config DPLocalizedString:@"adedit_brightness"] superViewTag:TAG_REGION_SETTINGS_VIEW];
    //关机
    CGRect rect10 = CGRectMake(rect9.origin.x, rect9.origin.y+rect9.size.height+5, rect9.size.width, 44);
    [self creteeButtonWithFrame:rect10 andTag:
     TAG_GUANJI_REGION_BUTTON andAction:@selector(resetguanji) andTitle:[Config DPLocalizedString:@"adedit_guanji"] superViewTag:TAG_REGION_SETTINGS_VIEW];
    //云屏背景
    CGRect rect11 = CGRectMake(rect10.origin.x, rect10.origin.y+rect10.size.height+5, rect10.size.width, 44);
    [self creteeButtonWithFrame:rect11 andTag:
     TAG_GUANJI_REGION_BUTTON andAction:@selector(background) andTitle:[Config DPLocalizedString:@"adedit_background"] superViewTag:TAG_REGION_SETTINGS_VIEW];
}

/**
 *  云屏背景设置
 */
-(void)background{
    [self startSocket];
    [self alertload];
    back = YES;
//    [self ftpuser];
    }
-(void)alertload{
    v=[[UIView alloc]initWithFrame:CGRectMake(300,300, 400, 60)];
    v.backgroundColor=[UIColor cyanColor];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 50)];
    lab.text=@"请输入口令";
    textfid=[[UITextField alloc]initWithFrame:CGRectMake(120, 5, 200, 50)];
    textfid.backgroundColor=[UIColor whiteColor];
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(330, 5, 60, 50)];
    [btn setTitle:@"确定" forState:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(kouling) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];
    [v addSubview:textfid];
    [v addSubview:lab];
    [self.view addSubview:v];
}
-(void)kouling{
    if([textfid.text isEqual:@"zdec"]){
        v.hidden=YES;
        back=YES;
//        [self ftpuser]
        [myMasterCtrl setSAssetType:ASSET_TYPE_PHOTO];
        [myMasterCtrl setIAssetMaxSelect:1];
        [myMasterCtrl pickAssets:nil];
        [myMasterCtrl setIslist:NO];
    }else{
        v.hidden=YES;
    }
}
-(void)backg{
    if (!isConnect) {
        [self startSocket];
    }
    [self commandResetServerWithType:0x17 andContent:nil andContentLength:0];
}
/**
 *  项目音频设置
 */
-(void)musicSettingView{
    UIView *supserView = [self.view viewWithTag:TAG_EDIT_CONTROLLER_VIEW];

    UIView *tempYView = [self.view viewWithTag:TAG_CONTROL_BUTTON_VIEW];


    UIView *regionSubitemListView = [[UIView alloc]initWithFrame:CGRectMake(0, tempYView.frame.origin.y + tempYView.frame.size.height, tempYView.frame.size.width, supserView.frame.size.height - tempYView.frame.size.height - 20 - HEIGHT_OF_BUTTOM_BAR)];
    [regionSubitemListView setTag:TAG_MUSIC_SETTING_VIEW];
    [myEditerCtrlViewArray addObject:regionSubitemListView];
    [supserView addSubview:regionSubitemListView];
    [regionSubitemListView release];

    UIView *subitemView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, tempYView.frame.size.width, regionSubitemListView.frame.size.height/2 -tempYView.frame.size.height)];
    subitemView.layer.borderWidth = 2.0f;
    subitemView.layer.borderColor = [UIColor blackColor].CGColor;

    //音频列表
    myMusicPicker = [[MusicPickerTableViewController alloc]init];
    [myMusicPicker.view setFrame:CGRectMake(0, 0, subitemView.frame.size.width, subitemView.frame.size.height-60)];
    myMusicPicker.delegate = self;
    [subitemView addSubview:myMusicPicker.view];
    [regionSubitemListView addSubview:subitemView];
    [subitemView release];

    //声音调节滑块
    self.myVolumeTrackingSlider = [[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(25, myMusicPicker.view.frame.size.height, subitemView.frame.size.width-40, 44)];
    [self.myVolumeTrackingSlider setMaximumValue:100];
    [self.myVolumeTrackingSlider setMinimumValue:0];
    [self.myVolumeTrackingSlider setValue:50];
    [self.myVolumeTrackingSlider addTarget:self action:@selector(changeVolumeEvent:) forControlEvents:UIControlEventValueChanged];
    [regionSubitemListView addSubview:self.myVolumeTrackingSlider];
    [self.myVolumeTrackingSlider release];
    [myMusicPicker.myMusicPlayer setVolume:0.5];
    _musicVolume = @"50";

    //音频的简要信息
    CGRect rectMusicInfoView = CGRectMake(subitemView.frame.origin.x, subitemView.frame.origin.y + subitemView.frame.size.height +10, subitemView.frame.size.width, subitemView.frame.size.height);
    UIView *musicInformationView = [[UIView alloc]initWithFrame:rectMusicInfoView];
    [musicInformationView setTag:TAG_MUSIC_INFO_VIEW];
    musicInformationView.layer.borderWidth = 2.0f;
    musicInformationView.layer.borderColor = [UIColor blackColor].CGColor;
    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, rectMusicInfoView.size.width, 44)];
    [promptLabel setText:[Config DPLocalizedString:@"ad_edit_alerady_selected_music"]];
    [musicInformationView addSubview:promptLabel];
    [promptLabel release];
    musicNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(promptLabel.frame.origin.x, promptLabel.frame.origin.y+promptLabel.frame.size.height, promptLabel.frame.size.width, promptLabel.frame.size.height)];
    [musicInformationView addSubview:musicNameLabel];

    UILabel *promptLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(musicNameLabel.frame.origin.x, musicNameLabel.frame.origin.y+musicNameLabel.frame.size.height, rectMusicInfoView.size.width, 44)];
    [promptLabel1 setText:[Config DPLocalizedString:@"ad_edit_duration_music"]];
    [musicInformationView addSubview:promptLabel1];
    [promptLabel1 release];
    musicPlaytimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(promptLabel1.frame.origin.x, promptLabel1.frame.origin.y+promptLabel1.frame.size.height, promptLabel.frame.size.width, promptLabel.frame.size.height)];
    [musicInformationView addSubview:musicPlaytimeLabel];

    [regionSubitemListView addSubview:musicInformationView];
    [musicInformationView release];

    //清除歌曲按钮
    CGRect rect2 = CGRectMake(musicPlaytimeLabel.frame.origin.x , musicPlaytimeLabel.frame.origin.y + musicPlaytimeLabel.frame.size.height + 20, musicPlaytimeLabel.frame.size.width-10, 44);
    [self creteeButtonWithFrame:rect2 andTag:TAG_CLEAR_MUSIC_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_cleare_music"] superViewTag:TAG_MUSIC_INFO_VIEW];

}

/**
 *  区域内的子项列表
 */
-(void)regionSubitemList{
    UIView *supserView = [self.view viewWithTag:TAG_EDIT_CONTROLLER_VIEW];

    UIView *tempYView = [self.view viewWithTag:TAG_CONTROL_BUTTON_VIEW];


    UIView *regionSubitemListView = [[UIView alloc]initWithFrame:CGRectMake(0, tempYView.frame.origin.y + tempYView.frame.size.height, tempYView.frame.size.width, supserView.frame.size.height - tempYView.frame.size.height - 20 - HEIGHT_OF_BUTTOM_BAR)];
    [regionSubitemListView setTag:TAG_SUBITEM_LIST_VIEW];
    [myEditerCtrlViewArray addObject:regionSubitemListView];
    [supserView addSubview:regionSubitemListView];
    [regionSubitemListView release];

    UIView *subitemView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, tempYView.frame.size.width, regionSubitemListView.frame.size.height/2 - tempYView.frame.size.height)];
    subitemView.layer.borderWidth = 2.0f;
    subitemView.layer.borderColor = [UIColor blackColor].CGColor;

    myMasterCtrl = [[CTMasterViewController alloc]init];
    [myMasterCtrl.view setFrame:CGRectMake(0, 50, subitemView.frame.size.width, subitemView.frame.size.height-60)];
    [myMasterCtrl setSAssetType:ASSET_TYPE_PHOTO];
    [myMasterCtrl setIAssetMaxSelect:20];
    myMasterCtrl.delegate = self;
    [subitemView addSubview:myMasterCtrl.view];

    [regionSubitemListView addSubview:subitemView];
    [subitemView release];

    UIButton *removeListButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 10,130, 30)];
    [removeListButton setTitle:[Config DPLocalizedString:@"adedit_RemoveList"] forState:UIControlStateNormal];
    [removeListButton setTintColor:[UIColor blackColor]];
    [removeListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [removeListButton addTarget:myMasterCtrl action:@selector(clearAssets:) forControlEvents:UIControlEventTouchUpInside];
    [removeListButton setBackgroundColor:[UIColor colorWithRed:0.935 green:0.934 blue:0.933 alpha:1.000]];
    removeListButton.layer.borderColor = [UIColor greenColor].CGColor;
    removeListButton.layer.borderWidth = 0.5;
    [removeListButton.titleLabel setFont:[UIFont systemFontOfSize:BUTTON_TITILE_FONT]];
    [subitemView addSubview:removeListButton];
    [removeListButton release];

    //添加待选项目
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(removeListButton.frame.origin.x + removeListButton.frame.size.width + 20, 10, 130, 30)];
    [addButton setTitle:[Config DPLocalizedString:@"adedit_AddList"] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [addButton addTarget:myMasterCtrl action:@selector(pickAssets:) forControlEvents:UIControlEventTouchDragExit];
    [addButton addTarget:self action:@selector(addAssetButtonOpenTypeSeletor:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setBackgroundColor:[UIColor colorWithRed:0.935 green:0.934 blue:0.933 alpha:1.000]];
    addButton.layer.borderColor = [UIColor greenColor].CGColor;
    addButton.layer.borderWidth = 0.5;
    [addButton setTitleShadowColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [addButton.titleLabel setFont:[UIFont systemFontOfSize:BUTTON_TITILE_FONT]];
    [subitemView addSubview:addButton];
    [addButton release];

    //切换场景的按钮Switching scenes
    //范围设置
    //后场景按钮
    NSInteger buttonWidth = subitemView.frame.size.width/2;
    NSInteger buttonTag = 1004 + 5000;
    CGRect rect1 = CGRectMake(subitemView.frame.origin.x, subitemView.frame.origin.y + subitemView.frame.size.height + 11, buttonWidth, 44);
    [self creteeButtonWithFrame:rect1 andTag:buttonTag andAction:@selector(switchSceneButtonClickEvent:) andTitle:[Config DPLocalizedString:@"adedit_Behind_scene"] superViewTag:TAG_SUBITEM_LIST_VIEW];
    [self addSceneButtonToArrayWithTag:buttonTag];
    [self highlightSceneButtonWithTag:buttonTag];

    //前场景按钮
    buttonTag = 1006 + 5000;
    CGRect rect2 = CGRectMake(rect1.origin.x + rect1.size.width, subitemView.frame.origin.y + subitemView.frame.size.height + 11, buttonWidth, 44);
    [self creteeButtonWithFrame:rect2 andTag:buttonTag andAction:@selector(switchSceneButtonClickEvent:) andTitle:[Config DPLocalizedString:@"adedit_Before_scene"] superViewTag:TAG_SUBITEM_LIST_VIEW];
    [self addSceneButtonToArrayWithTag:buttonTag];

    //后场景层
    //后场景播放列表
    UIView *playitemView = [[UIView alloc]initWithFrame:CGRectMake(5, rect1.origin.y + rect1.size.height + 5, tempYView.frame.size.width, supserView.frame.size.height - tempYView.frame.size.height - subitemView.frame.size.height - rect1.size.height - 20 - 44 -10)];
    [playitemView setTag:TAG_PLAY_LIST_VIEW];
    playitemView.layer.borderWidth = 2.0f;
    playitemView.layer.borderColor = [UIColor blackColor].CGColor;
    [mySceneViewArray addObject:playitemView];
    [regionSubitemListView addSubview:playitemView];
    [playitemView release];

    //后场景播放列表
    if (myProjectCtrl) {
        RELEASE_SAFELY(myProjectCtrl);
    }
    myPlayListCtrl = [[MyPlayListViewController alloc]init];
    [myPlayListCtrl.view setFrame:CGRectMake(0, 5, playitemView.frame.size.width, playitemView.frame.size.height - 44)];
    myPlayListCtrl.delegate = self;
    [playitemView addSubview:myPlayListCtrl.view];

    //后场景清除图片列表
    UIButton *clearImageButton = [[UIButton alloc]initWithFrame:CGRectMake(5, myPlayListCtrl.view.frame.origin.y + myPlayListCtrl.view.frame.size.height + 0, 130, 39)];
    [clearImageButton setTitle:[Config DPLocalizedString:@"adedit_CleanList"] forState:UIControlStateNormal];
    [clearImageButton setTintColor:[UIColor blackColor]];
    [clearImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [clearImageButton addTarget:self action:@selector(clearImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [clearImageButton setBackgroundColor:[UIColor colorWithRed:0.935 green:0.934 blue:0.933 alpha:1.000]];
    clearImageButton.layer.borderColor = [UIColor greenColor].CGColor;
    clearImageButton.layer.borderWidth = 0.5;
    [clearImageButton.titleLabel setFont:[UIFont systemFontOfSize:BUTTON_TITILE_FONT]];
    [playitemView addSubview:clearImageButton];
    [clearImageButton release];
}


//选择相册之后
-(void)selectPhotoToLayerWithALAsset:(ALAsset *)asset cellIndexPath:(NSIndexPath *)cellIndexPath{
    
    
    
    NSString * nsALAssetPropertyType = [asset valueForProperty:ALAssetPropertyType];
    photoasset = asset;

    NSLog(@"素材名称===%@",nsALAssetPropertyType);
    if ([nsALAssetPropertyType isEqualToString:@"ALAssetTypePhoto"]) {
        
        
        MaterialObject *oneMaterialObject = [MaterialObject revertALAssetToMaterialObject:asset];
//        myphothpath = oneMaterialObject.material_path;
        NSLog(@"===%@",myphothpath);
        globalsVideoPath = oneMaterialObject.material_path;
        
        
        
//        //素材图片
//        ALAssetRepresentation* representation = [asset defaultRepresentation];
//        NSString* filename = [representation filename];
//        
//        NSArray *b = [filename componentsSeparatedByString:@"."];
//        
//        NSString *str = [NSString stringWithFormat:@"%@%@",b[0],[self getNowdateString]];
//
//       nametime = [NSString stringWithFormat:@"%@",[str md5Encrypt]];
//
//        
//        stringpath = [self documentGroupXMLDir];

        
        
        
        
        
//
        
//        textfield.text = b[0];
        

        
        return;
    }
    
    
    
    globalDuration = 0;
    globalsVideoPath = nil;
    if (globalDictFramesInfo) {
        [globalDictFramesInfo removeAllObjects];
        globalDictFramesInfo = nil;
    }
    UITextField *xField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2001];
    UITextField *yField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2002];
    UITextField *wField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2003];
    UITextField *hField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2004];
    NSInteger ix = 0;
    NSInteger iy = 0;
    NSInteger iw = 160;
    NSInteger ih = 640;
    if ([xField.text length]>0) {
        if ([self isPureInt:xField.text]) {
            ix = [xField.text integerValue];
        }
    }
    if ([yField.text length]>0) {
        if ([self isPureInt:yField.text]) {
            iy = [yField.text integerValue];
        }
    }
    if ([wField.text length]>1) {
        if ([self isPureInt:wField.text]) {
            iw = [wField.text integerValue];
            if (iw == 0) {
                iw = 160;
            }
        }
    }
    if ([hField.text length]>1) {
        if ([self isPureInt:hField.text]) {
            ih = [hField.text integerValue];
            if (ih == 0) {
                ih = 640;
            }
        }
    }
    YXM_VideoEditerViewController *videoEditerCtrl = [[YXM_VideoEditerViewController alloc]init];
    [videoEditerCtrl setMyAsset:asset];
    [videoEditerCtrl setViewfinderWidth:iw];
    [videoEditerCtrl setViewfinderHeight:ih];
    
    [self.navigationController pushViewController:videoEditerCtrl animated:YES];
    [videoEditerCtrl release];
}

/**
 *  从待选列表选择素材到指定编辑区域的素材列表
 *
 *  @param asset         被选择的素材信息
 *  @param cellIndexPath 待选列表被选择的索引
 */
-(void)selectPhotoToLayerWithMaterialObj:(MaterialObject *)asset cellIndexPath:(NSIndexPath *)cellIndexPath{
    
    
    
    
    
    
    
    
    
    
    
//    @try {
//
//        if (![myMasterCtrl.sAssetType isEqualToString:ASSET_TYPE_PHOTO]) {
//            return;
//        }

//        if (_currentSelectIndex == TAG_NO_SELECT_AREA) {
//            //必须选择一个编辑区域
//            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_selectaneditregion"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
//            [myAlertView show];
//            [myAlertView release];
//            return;
//        }
//
//        if (_currentSelectIndex == VIEW_TAG_TEXT_AREA_1005) {
//            //文字区域不能选择
//            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_textRegioncanntselect"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
//            [myAlertView show];
//            [myAlertView release];
//            return;
//        }
//
//        NSString *stringImagePath = [asset material_path];
//        UIImage *resolutionImage = [UIImage imageWithContentsOfFile:stringImagePath];
//
//        if ((resolutionImage==nil)||(![resolutionImage isKindOfClass:[UIImage class]])) {
//            NSString *sMaterialRootPath = [MaterialObject createMatrialRootPath];
//            stringImagePath = [NSString stringWithFormat:@"%@%@",sMaterialRootPath,stringImagePath];
//            resolutionImage = [UIImage imageWithContentsOfFile:stringImagePath];
//        }
//
//        UIView *tempView = [self.view viewWithTag:_currentSelectIndex];
//        UIImageView *tempImageView = (UIImageView*)[tempView viewWithTag:(TAG_IMAGE_VIEW+tempView.tag)];
//        [tempImageView setFrame:CGRectMake(0, 0, tempView.frame.size.width, tempView.frame.size.height)];
//        if (fangle>1) {
//            [tempImageView setFrame:CGRectMake(0, 0, tempView.bounds.size.width, tempView.bounds.size.height)];
//        }
//        [tempImageView setImage:resolutionImage];
////        [tempImageView setContentMode:UIViewContentModeScaleAspectFill];
//        [tempImageView setContentMode:UIViewContentModeTopLeft];
//
//
//        //根据选择可编辑区域的key区存储素材列表
//        [self validateCurrentScene];
//        NSString *myDuration = [[NSString alloc]initWithFormat:@"%ld",(long)[asset material_duration]];
//        if (!myDuration) {
//            myDuration = DEFAULT_TIME;
//        }
//        NSDictionary *assetDict = [[NSDictionary alloc]initWithObjectsAndKeys:myDuration,@"duration",asset,@"asset",nil];
//        NSMutableArray *selectAreaArray = [[NSMutableArray alloc]initWithArray:[_projectMaterialDictionary objectForKey:_currentScenes]];
//        [selectAreaArray addObject:assetDict];
//        [_projectMaterialDictionary setObject:selectAreaArray forKey:_currentScenes];
//        
//        //刷新素材列表
//        [self refreshScelectAreaMatrialListWithTag:[_currentScenes integerValue]];
//    }
//    @catch (NSException *exception) {
//        DLog(@"%@",exception);
//    }
//    @finally {
//    }
}


/**
 *  刷新被选择编辑区域的素材列表,并且刷新按钮上的素材数目
 */
-(void)refreshScelectAreaMatrialListWithTag:(NSInteger)iTag{
    //刷新素材列表
    NSString *sKey = [[NSString alloc]initWithFormat:@"%ld",(long)iTag];
    NSArray *myDataArray = [_projectMaterialDictionary objectForKey:sKey];
    [myPlayListCtrl reloadMyPlaylist:myDataArray];

    //刷新按钮
    NSInteger buttonTag = iTag + 5000;
    NSString *buttonTitlePrifix = nil;
    if (iTag==1004) {
        buttonTitlePrifix = [Config DPLocalizedString:@"adedit_Behind_scene"];
    }else{
        buttonTitlePrifix = [Config DPLocalizedString:@"adedit_Before_scene"];
    }
    UIButton *myButton = (UIButton*)[self.view viewWithTag:buttonTag];
    if (myButton) {
        if ([myButton isKindOfClass:[UIButton class]]) {
            NSString *buttonTitleString = [[NSString alloc]initWithFormat:@"%@(%lu)",buttonTitlePrifix,(unsigned long)[myDataArray count]];
            [myButton setTitle:buttonTitleString forState:UIControlStateNormal];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    DLog(@"内存警告LayoutYXMViewController");
    [self quitePlayProjAndResetEditer:YES];
//    [self closeEditerButtonClick:nil];
}

/**
 *  创建可编辑区域的视图
 *
 *  @param viewFrame 原点与宽高
 *  @param tag       标示TAG
 */
-(void)createViewFactory:(CGRect)viewFrame viewTag:(NSInteger)tag {
    UIScrollView *masterView = (UIScrollView*)[self.view viewWithTag:TAG_MASTER_SCREEN_VIEW];

    UIView *myView = [[UIView alloc]initWithFrame:viewFrame];
    [myView setTag:tag];

    [masterView addSubview:myView];
    [myView release];
    myView.hidden=YES;
    myView.layer.borderWidth = 1.0f;
    myView.layer.borderColor = [[UIColor whiteColor] CGColor];


    UIImage *tempImage = [UIImage imageWithCGImage:nil];
    UIImageView *tempImageView = [[UIImageView alloc]initWithImage:tempImage];
    [tempImageView setFrame:CGRectMake(0, 0, myView.frame.size.width, myView.frame.size.height)];
    [tempImageView setTag:(TAG_IMAGE_VIEW+tag)];
    [myView addSubview:tempImageView];
    [tempImageView release];

    //单击手势
    UITapGestureRecognizer *myTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapRecognizer:)];
    myTapGestureRecognizer.numberOfTouchesRequired = 1; //手指数
    myTapGestureRecognizer.numberOfTapsRequired = 1; //tap次数
    [myView addGestureRecognizer:myTapGestureRecognizer];
    [myTapGestureRecognizer release];
    //拖动手势
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    [myView addGestureRecognizer:panRecognizer];
    [panRecognizer release];

    UIView *regionView = [[UIView alloc]initWithFrame:CGRectMake(2, 0, 100, 20)];

    [regionView setBackgroundColor:[UIColor grayColor]];
    if (tag==VIEW_TAG_TEXT_AREA_1005) {
        [regionView setBackgroundColor:[UIColor blueColor]];
    }
    //    [regionView setTag:TAG_REGION_LABEL+tag+1];
    [regionView setTag:TAG_REGION_LABEL+tag];
    UILabel *myRegionLabel = [[UILabel alloc]initWithFrame:regionView.frame];
    [myRegionLabel setBackgroundColor:[UIColor clearColor]];
    [myRegionLabel setTag:(TAG_REGION_LABEL+tag+tag)];
    [myRegionLabel setText:[NSString stringWithFormat:@"%d",(int)tag]];
    [myRegionLabel setFont:[UIFont systemFontOfSize:8]];



    if (tag!=1006) {
        [regionView addSubview:myRegionLabel];
        [myRegionLabel release];
        [myView addSubview:regionView];
        [regionView release];
    }


}


-(void)handleTapRecognizer:(id*)sender{
    @try {
        //如果是播放态则取消手势下的动作执行
        if (isPlay) {
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:@"XCloudManager" message:[Config DPLocalizedString:@"adedit_quitplayafterswitch"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            return;
        }
        UITapGestureRecognizer *recongizer = (UITapGestureRecognizer *)sender;
        if (recongizer.numberOfTapsRequired == 1) {
            //单指单击
            //当前选中的屏幕区域
            _currentSelectIndex = recongizer.view.tag;
            DLog(@"当前选择区域的view.tag = %d",_currentSelectIndex);
            //选中一块屏幕
            [self selectOneScreenAreaWith:_currentSelectIndex];
            //使用可编辑区域的索引去刷新MyPlayList
            [self refreshMyPlayListWithScreenAreaIndex:_currentSelectIndex];
        }else if(recongizer.numberOfTapsRequired == 2){
            //单指双击
            DLog(@"单指双击");
            _currentSelectIndex = TAG_NO_SELECT_AREA;

            for (UIView *selectView in [self evaluateViews]) {
                selectView.layer.borderColor = [[UIColor whiteColor] CGColor];
            }
        }
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    @finally {

    }
}

/**
 *  按照索引去选中一块屏幕，并且将屏幕的边框线设置为红色
 *
 *  @param selectIndex 屏幕的索引1001、1002、1003、1004
 */
-(void)selectOneScreenAreaWith:(NSInteger)selectIndex{
    UIView *currentSelectView;

    for (UIView *selectView in [self evaluateViews]) {
        if (selectView.tag == selectIndex) {
            selectView.layer.borderColor = [[UIColor redColor] CGColor];
            currentSelectView = selectView;
        }else{
            selectView.layer.borderColor = [[UIColor whiteColor] CGColor];
        }

    }

    UILabel *tempLabel = (UILabel*)[self.view viewWithTag:TAG_REGION_TAG_LABEL];
    if (selectIndex==VIEW_TAG_TEXT_AREA_1005) {
        //如果区域编号等于VIEW_TAG_TEXT_AREA_1005，则提示为文本区域
        [tempLabel setText:[NSString stringWithFormat:@"%d(%@)",(int)selectIndex,[Config DPLocalizedString:@"ad_edit_text_area"]]];
    }else{
        [tempLabel setText:[NSString stringWithFormat:@"%d(%@)",(int)selectIndex,[Config DPLocalizedString:@"ad_edit_image_area"]]];
    }



    NSInteger x,y,w,h;
    x = currentSelectView.frame.origin.x;
    y = currentSelectView.frame.origin.y;
    w = currentSelectView.frame.size.width;
    h = currentSelectView.frame.size.height;
    if (fangle >1) {
        x = currentSelectView.frame.origin.x;
        y = currentSelectView.frame.origin.y;
        w = currentSelectView.bounds.size.width;
        h = currentSelectView.bounds.size.height;
    }

    UITextField *xField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2001];
    UITextField *yField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2002];
    UITextField *wField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2003];
    UITextField *hField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2004];

    [xField setText:[NSString stringWithFormat:@"%d",(int)x]];
    [yField setText:[NSString stringWithFormat:@"%d",(int)y]];
    [wField setText:[NSString stringWithFormat:@"%d",(int)w]];
    [hField setText:[NSString stringWithFormat:@"%d",(int)h]];
}

/**
 *  移动手势
 *
 *  @param sender
 */
- (void)handlePanRecognizer:(id)sender
{
    if (isPlay) {
        //如果是播放状态则禁止移动区域元素
        return;
    }
    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;

    if ([recongizer state] == UIGestureRecognizerStateBegan)
    {
        DLog(@"UIGestureRecognizerStateBegan");
    }

    NSArray *views = [self evaluateViews];
    //    __block UILabel *label = [self completionLabel];


    static void (^overlappingBlock)(UIView *overlappingView);
    overlappingBlock = ^(UIView *overlappingView) {

        [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

            UIView *aView = (UIView *)obj;

            // Style an overlapping view
            if (aView == overlappingView)
            {
                aView.layer.borderWidth = 2.0f;
                //                aView.layer.borderColor = [[UIColor whiteColor] CGColor];
            }
            // Remove styling on non-overlapping views
            else
            {
                aView.layer.borderWidth = 1.0f;
            }

            DLog(@"移动3");

            UILabel *tempLabel = (UILabel *)[aView viewWithTag:(TAG_REGION_LABEL+aView.tag+aView.tag)];

            //            NSInteger tempLabelTag = tempLabel.tag;
            NSInteger tempLabelX = aView.frame.origin.x;
            NSInteger tempLabelY = aView.frame.origin.y;

            NSInteger tempLabelW = aView.frame.size.width;
            NSInteger tempLabelH = aView.frame.size.height;
            if ([tempLabel isKindOfClass:[UILabel class]]) {
                [tempLabel setText:[NSString stringWithFormat:@"%d [%d,%d],[%d,%d]",aView.tag,tempLabelX,tempLabelY,tempLabelW,tempLabelH]];
            }

        }];
    };

    // Block to execute when gesture ends.
    static void (^completionBlock)(UIView *overlappingView);
    completionBlock = ^(UIView *overlappingView) {

        if (overlappingView)
        {

        }

        // Remove styling from all views
        [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView *aView = (UIView *)obj;
            aView.layer.borderWidth = 1.0f;
        }];
        DLog(@"移动2");

    };

    [recongizer dragViewWithinView:[self view]
           evaluateViewsForOverlap:views
   containedByOverlappingViewBlock:overlappingBlock
                        completion:completionBlock];

}



/**
 *  创建region属性输入框
 *
 *  @param rect     文本框的frame
 *  @param tag      文本框的tag
 *  @param leftText 左侧描述文字
 */
-(void)createRegionPropertiesViewWithFrame:(CGRect)rect viewTag:(NSInteger)tag leftLabelText:(NSString *)leftText superViewTag:(NSInteger)viewTag defaultText:(NSString *)defaultText{
    UITextField *regionPropertyTextField = [[UITextField alloc]initWithFrame:rect];
    [regionPropertyTextField setBorderStyle:UITextBorderStyleLine];
    if (tag!=TAG_PROJECT_NAME_TEXTFIELD) {

        [regionPropertyTextField setKeyboardType:UIKeyboardTypeNumberPad];
    }

    if (defaultText) {
        [regionPropertyTextField setText:defaultText];
    }

    [regionPropertyTextField setKeyboardAppearance:UIKeyboardAppearanceDark];
    [regionPropertyTextField setBackgroundColor:[UIColor clearColor]];


    NSInteger labelWidth = [leftText length]*9+10;
    if (labelWidth>100) {
        labelWidth = 70;
    }

    UILabel *regionPropertyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5,labelWidth, regionPropertyTextField.frame.size.height)];
    [regionPropertyLabel setText:leftText];
    [regionPropertyLabel setTextAlignment:NSTextAlignmentCenter];
    regionPropertyLabel.backgroundColor = [UIColor clearColor];
    [regionPropertyLabel setFont:[UIFont systemFontOfSize:BUTTON_TITILE_FONT]];
    [regionPropertyLabel.layer setBorderColor:[UIColor blackColor].CGColor];
    [regionPropertyLabel.layer setBorderWidth:0.5];
    [regionPropertyTextField setLeftView:regionPropertyLabel];
    regionPropertyTextField.leftViewMode = UITextFieldViewModeAlways;
    [regionPropertyTextField setTag:tag];
    regionPropertyTextField.delegate = self;


    UIView *superRegionSettingsView = [self.view viewWithTag:viewTag];
    [superRegionSettingsView addSubview:regionPropertyTextField];
}


/**
 *  创建文字大小设置控件
 *
 *  @param myFrame 控件的位置
 */
-(void)createSizeTextFieldWithFrame:(CGRect)myFrame andTag:(NSInteger)myTag superViewTag:(NSInteger)superTag{
    UIView *superView = [self.view viewWithTag:superTag];

    UIView *textView = [[UIView alloc]initWithFrame:myFrame];

    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, myFrame.size.height)];
    [myLabel setFont:[UIFont systemFontOfSize:10]];
    [myLabel setText:[Config DPLocalizedString:@"adedit_Size"]];


    /*设置大小*/
    sizeTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, myFrame.size.width-50, myFrame.size.height)];
    sizeTextField.delegate = self;
    sizeTextField.borderStyle = UITextBorderStyleLine;
    sizeTextField.textAlignment = NSTextAlignmentLeft;
    sizeTextField.keyboardType = UIKeyboardTypeNumberPad;
    sizeTextField.enabled = NO;
    //从滚动栏中读取默认字体大小
    JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
    sizeTextField.text = [NSString stringWithFormat:@"%0.0lf",ticker.tickerFont.pointSize];

    sizeTextField.tag = TAG_FONT_SIZE_TEXT;

    sizeArray = [[NSArray alloc] initWithObjects:@"12",@"14",@"16",@"18",@"20",@"24",@"28",@"36",@"48",@"72", nil];

    sizeIsOpend = NO;//判断下拉tableView是否打开
    sizeButton = [[BaseButton alloc] initWithFrame:CGRectMake(myFrame.size.width-30, 0, 30, 30) andNorImg:@"dropdown.png" andHigImg:nil andTitle:nil];
    [sizeButton addTarget:self action:@selector(sizeButton:) forControlEvents:UIControlEventTouchUpInside];

    sizeTableBlock = [[TableViewWithBlock alloc] initWithFrame:CGRectMake(myFrame.origin.x+50, myFrame.origin.y + myFrame.size.height, myFrame.size.width-50, 1) style:UITableViewStylePlain];

    [sizeTableBlock initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section){
        return (NSInteger)[sizeArray count];
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        [cell.lb setText:[sizeArray objectAtIndex:indexPath.row]];

        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath){
        SelectionCell *cell = (SelectionCell *)[tableView cellForRowAtIndexPath:indexPath];
        sizeTextField.text = cell.lb.text;

        //修改了字体的动态调整代码
        UIFont *myFont = nil;
        NSString *myFontName = nil;
        if (sizeTextField.text) {
            float textSize = [sizeTextField.text floatValue];
            JHTickerView *old_Ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
            if (fontTextField.text) {
                myFontName = fontTextField.text;
            }else{
                myFontName = @"Arial";
            }

            myFont = [UIFont fontWithName:myFontName size:textSize];

            [old_Ticker setTickerFont:myFont];
            [self createTextAreaWithFont:myFont];
        }


        [sizeButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    [sizeTableBlock.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [sizeTableBlock.layer setBorderWidth:2];

    [textView addSubview:myLabel];
    [textView addSubview:sizeTextField];
    [textView addSubview:sizeButton];
    [superView addSubview:sizeTableBlock];

    [superView addSubview:textView];
}

/**
 *  创建速度选择控件
 *
 *  @param myFrame  控件的位置
 *  @param superTag 控件的父视图
 */
-(void)createSpeedTextFieldWithFrame:(CGRect)myFrame andTag:(NSInteger)myTag superViewTag:(NSInteger)superTag{
    UIView *superView = [self.view viewWithTag:superTag];

    UIView *textView = [[UIView alloc]initWithFrame:myFrame];

    JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];

    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, myFrame.size.height)];
    [myLabel setFont:[UIFont systemFontOfSize:10]];
    [myLabel setText:[Config DPLocalizedString:@"adedit_Speed"]];

    /*设置速度*/
    speedTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, myFrame.size.width-50, myFrame.size.height)];
    speedTextField.delegate = self;
    speedTextField.borderStyle = UITextBorderStyleRoundedRect;
    speedTextField.textAlignment = NSTextAlignmentLeft;
    speedTextField.keyboardType = UIKeyboardTypeNumberPad;
    speedTextField.enabled = NO;
    //从滚动标签的属性去读取默认滚动速度
    NSString *myRollingSpeed = [[NSString alloc]initWithFormat:@"%d",((int)ticker.tickerSpeed)/10];
    [speedTextField setText:myRollingSpeed];
    speedTextField.tag = myTag;

    speedArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];

    speedIsOpend = NO;//判断下拉tableView是否打开
    speedButton = [[BaseButton alloc] initWithFrame:CGRectMake(myFrame.size.width-30, 0, 30, 30) andNorImg:@"dropdown.png" andHigImg:nil andTitle:nil];
    [speedButton addTarget:self action:@selector(speedButton:) forControlEvents:UIControlEventTouchUpInside];

    speedTableBlock = [[TableViewWithBlock alloc] initWithFrame:CGRectMake(myFrame.origin.x +50, myFrame.origin.y + myFrame.size.height, myFrame.size.width-50, 1) style:UITableViewStylePlain];

    [speedTableBlock initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section){
        return (NSInteger)[speedArray count];
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        [cell.lb setText:[speedArray objectAtIndex:indexPath.row]];

        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath){
        SelectionCell *cell = (SelectionCell *)[tableView cellForRowAtIndexPath:indexPath];
        speedTextField.text = cell.lb.text;
        //修改了调整字体滚动速度的代码
        float mySpeed = 0;
        if (speedTextField.text) {
            mySpeed = [speedTextField.text floatValue];
            JHTickerView *old_Ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
            [old_Ticker setTickerSpeed:mySpeed*10];
            [self createTextAreaWithSpeed:mySpeed*10];
        }

        [speedButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    [speedTableBlock.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [speedTableBlock.layer setBorderWidth:2];

    [textView addSubview:myLabel];
    [textView addSubview:speedTextField];
    [textView addSubview:speedButton];
    [superView addSubview:speedTableBlock];

    [superView addSubview:textView];
}


/**
 *  创建动画方向选择控件
 *
 *  @param myFrame  控件的位置
 *  @param superTag 控件的父视图
 */
-(void)createDirectionTextFieldWithFrame:(CGRect)myFrame andTag:(NSInteger)myTag superViewTag:(NSInteger)superTag andAssetDict:(NSDictionary*)myAssetDict{
    UIView *superView = [self.view viewWithTag:superTag];

    UIView *textView = [[UIView alloc]initWithFrame:myFrame];

    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, myFrame.size.height)];
    [myLabel setFont:[UIFont systemFontOfSize:10]];
    [myLabel setText:[Config DPLocalizedString:@"adedit_moreivew_direction"]];

    /*设置direction*/
    directionTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, myFrame.size.width-50, myFrame.size.height)];
    directionTextField.delegate = self;
    directionTextField.borderStyle = UITextBorderStyleRoundedRect;
    directionTextField.textAlignment = NSTextAlignmentLeft;
    directionTextField.keyboardType = UIKeyboardTypeNumberPad;
    directionTextField.enabled = NO;
    //从滚动标签的属性去读取默认滚动速度
    NSString *myDirectionString = [Config DPLocalizedString:@"adedit_direction_up_to_down"];
    //从配置文件中读取动画的方向
    MaterialObject *myMaterialObject = (MaterialObject*)[myAssetDict objectForKey:@"asset"];
    iDriection = 0;
    if ([myMaterialObject material_direction]) {
        myDirectionString = [myMaterialObject material_direction];
        iDriection = [myDirectionString integerValue];
    }

    switch (iDriection) {
        case 0:
        {
            myDirectionString = [Config DPLocalizedString:@"adedit_direction_up_to_noanimation"];
            imageScrollDirection = NO_ANIMATION;
        }
            break;
        case 1:
        {
            myDirectionString = [Config DPLocalizedString:@"adedit_direction_up_to_down"];
            imageScrollDirection = UP_TO_DOWN;
        }
            break;
        case 2:
        {
            myDirectionString = [Config DPLocalizedString:@"adedit_direction_right_to_left"];
            imageScrollDirection = RIGHT_TO_LEFT;
        }
            break;
        case 3:
        {
            myDirectionString = [Config DPLocalizedString:@"adedit_direction_down_to_up"];
            imageScrollDirection = DOWN_TO_UP;
        }
            break;
        case 4:
        {
            myDirectionString = [Config DPLocalizedString:@"adedit_direction_left_to_right"];
            imageScrollDirection = LEFT_TO_RIGHT;
        }
            break;
        case 5:
        {
            myDirectionString = [Config DPLocalizedString:@"adedit_direction_up_down_Shrink"];
            imageScrollDirection = UP_DOWN_SHRINK;
        }
            break;
        case 6:
        {
            myDirectionString = [Config DPLocalizedString:@"adedit_direction_right_left_Shrink"];
            imageScrollDirection = RIGHT_LEFT_SHRINK;
        }
            break;
        case 7:
        {
            myDirectionString = [Config DPLocalizedString:@"adedit_direction_Shrink"];
            imageScrollDirection = SHRINK;
        }
            break;
        case 8:
        {
            myDirectionString = [Config DPLocalizedString:@"adedit_direction_Unfold"];
            imageScrollDirection = UNFOLD;
        }
            break;
        default:
            break;
    }
    [directionTextField setText:myDirectionString];
    directionTextField.tag = myTag;

    directionArray = [[NSArray alloc] initWithObjects:[Config DPLocalizedString:@"adedit_direction_up_to_noanimation"],[Config DPLocalizedString:@"adedit_direction_up_to_down"],[Config DPLocalizedString:@"adedit_direction_right_to_left"],[Config DPLocalizedString:@"adedit_direction_down_to_up"],[Config DPLocalizedString:@"adedit_direction_left_to_right"],[Config DPLocalizedString:@"adedit_direction_up_down_Shrink"],[Config DPLocalizedString:@"adedit_direction_right_left_Shrink"],[Config DPLocalizedString:@"adedit_direction_Shrink"],[Config DPLocalizedString:@"adedit_direction_Unfold"], nil];

    directionIsOpend = NO;//判断下拉tableView是否打开
    directionButton = [[BaseButton alloc] initWithFrame:CGRectMake(myFrame.size.width-30, 0, 30, 30) andNorImg:@"dropdown.png" andHigImg:nil andTitle:nil];
    [directionButton addTarget:self action:@selector(directionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];


    directionTableBlock = [[TableViewWithBlock alloc] initWithFrame:CGRectMake(myFrame.origin.x +50, myFrame.origin.y + myFrame.size.height, myFrame.size.width-50, 1) style:UITableViewStylePlain];

    [directionTableBlock initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section){
        return (NSInteger)[directionArray count];
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        [cell.lb setText:[directionArray objectAtIndex:indexPath.row]];

        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath){
        SelectionCell *cell = (SelectionCell *)[tableView cellForRowAtIndexPath:indexPath];
        directionTextField.text = cell.lb.text;
        //滚动的方向
        NSString *myDirection = nil;
        if (directionTextField.text) {
            myDirection = directionTextField.text;
            NSInteger iDriectionArrayIndex = [directionArray indexOfObject:myDirection];
            switch (iDriectionArrayIndex) {
                case 0:
                    imageScrollDirection = NO_ANIMATION;
                    break;
                case 1:
                    imageScrollDirection = UP_TO_DOWN;
                    break;
                case 2:
                    imageScrollDirection = RIGHT_TO_LEFT;
                    break;
                case 3:
                    imageScrollDirection = DOWN_TO_UP;
                    break;
                case 4:
                    imageScrollDirection = LEFT_TO_RIGHT;
                    break;
                case 5:
                    imageScrollDirection = UP_DOWN_SHRINK;
                    break;
                case 6:
                    imageScrollDirection = RIGHT_LEFT_SHRINK;
                    break;
                case 7:
                    imageScrollDirection = SHRINK;
                    break;
                case 8:
                    imageScrollDirection = UNFOLD;
                    break;
                default:
                    break;
            }
        }
        DLog(@"imageScrollDirection = %@",imageScrollDirection);
        //更新行对象

        [self updateCellRowWithDirection:imageScrollDirection];

        [directionButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    [directionTableBlock.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [directionTableBlock.layer setBorderWidth:2];

    [textView addSubview:myLabel];
    [textView addSubview:directionTextField];
    [textView addSubview:directionButton];
    [superView addSubview:directionTableBlock];

    [superView addSubview:textView];
}


/**
 *  创建动画的Alpha
 *
 *  @param myFrame  控件的位置
 *  @param superTag 控件的父视图
 */
-(void)createAlphaFieldWithFrame:(CGRect)myFrame andTag:(NSInteger)myTag superViewTag:(NSInteger)superTag andAssetDict:(NSDictionary*)myAssetDict{
    UIView *superView = [self.view viewWithTag:superTag];

    UIView *textView = [[UIView alloc]initWithFrame:myFrame];

    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, myFrame.size.height)];
    [myLabel setFont:[UIFont systemFontOfSize:10]];
    [myLabel setText:[Config DPLocalizedString:@"adedit_moreivew_Alpha"]];

    /*设置direction*/
    UITextField *talpha = (UITextField*)[self.view viewWithTag:myTag];
    [talpha removeFromSuperview];
    alphaTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, myFrame.size.width-50, myFrame.size.height)];
    alphaTextField.delegate = self;
    alphaTextField.borderStyle = UITextBorderStyleRoundedRect;
    alphaTextField.textAlignment = NSTextAlignmentLeft;
    alphaTextField.keyboardType = UIKeyboardTypeNumberPad;
    alphaTextField.enabled = NO;
    //从滚动标签的属性去读取默认滚动速度
    NSString *myDirectionString = [Config DPLocalizedString:@"adedit_touming"];
    //从配置文件中读取动画的方向
    MaterialObject *myMaterialObject = (MaterialObject*)[myAssetDict objectForKey:@"asset"];
    ialpha = 0;
    if ([myMaterialObject material_alpha]) {
        NSString *myalphaString = [myMaterialObject material_alpha];
        ialpha = [myalphaString integerValue];
    }

    switch (ialpha) {
        case 0:
        {
            myDirectionString = [Config DPLocalizedString:@"adedit_touming"];
        }
            break;
        case 1:
        {
            myDirectionString = [Config DPLocalizedString:@"adedit_butouming"];
        }
        default:
            break;
    }
    [alphaTextField setText:myDirectionString];
    alphaTextField.tag = myTag;

    alphaArray = [[NSArray alloc] initWithObjects:[Config DPLocalizedString:@"adedit_touming"],[Config DPLocalizedString:@"adedit_butouming"], nil];

    alphaIsOpend = NO;//判断下拉tableView是否打开
    alphaButton = [[BaseButton alloc] initWithFrame:CGRectMake(myFrame.size.width-30, 0, 30, 30) andNorImg:@"dropdown.png" andHigImg:nil andTitle:nil];
    [alphaButton addTarget:self action:@selector(alphaButtonClicked:) forControlEvents:UIControlEventTouchUpInside];


    alphaTableBlock = [[TableViewWithBlock alloc] initWithFrame:CGRectMake(myFrame.origin.x +50, myFrame.origin.y + myFrame.size.height, myFrame.size.width-50, 1) style:UITableViewStylePlain];

    [alphaTableBlock initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section){
        return (NSInteger)[alphaArray count];
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        [cell.lb setText:[alphaArray objectAtIndex:indexPath.row]];

        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath){
        SelectionCell *cell = (SelectionCell *)[tableView cellForRowAtIndexPath:indexPath];
        alphaTextField.text = cell.lb.text;
        //透明值
        NSInteger imyalphaArrayIndex = 0;
        NSString *myalpha = [Config DPLocalizedString:@"adedit_touming"];
        if (alphaTextField.text) {
            myalpha = alphaTextField.text;


            if ([alphaArray indexOfObject:myalpha] != NSNotFound) {
                imyalphaArrayIndex = [alphaArray indexOfObject:myalpha];
            }
            DLog(@"imyalphaArrayIndex = %d",(int)imyalphaArrayIndex);
            //更新行对象
            [self updateCellRowWithAlpha:[[NSString alloc] initWithFormat:@"%d",(int)imyalphaArrayIndex]];
        }
        [self updateCellRowWithAlpha:[[NSString alloc] initWithFormat:@"%d",(int)imyalphaArrayIndex]];
        [alphaButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    [alphaTableBlock.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [alphaTableBlock.layer setBorderWidth:2];

    [textView addSubview:myLabel];
    [textView addSubview:alphaTextField];
    [textView addSubview:alphaButton];
    [superView addSubview:alphaTableBlock];
    
    [superView addSubview:textView];
}



/**
 *@brief 更新运动方向到素材列表选中的cell中
 */
-(void)updateCellRowWithDirection:(NSString *)directionString{
    @try {
        if ((directionString)&&([directionString length]>0)) {
            [self validateCurrentScene];
            NSMutableArray *selectAreaArray = [[NSMutableArray alloc]initWithArray:[_projectMaterialDictionary objectForKey:_currentScenes]];
            NSDictionary *selectDict = [selectAreaArray objectAtIndex:_currentSelectRow];
            MaterialObject *oneMaterialObj = [selectDict objectForKey:@"asset"];
            if ([oneMaterialObj.material_type isEqual:@"Photo"]) {
                [oneMaterialObj setMaterial_direction:directionString];
                NSDictionary *assetDict = [[NSDictionary alloc]initWithObjectsAndKeys:[selectDict objectForKey:@"duration"],@"duration",oneMaterialObj,@"asset",nil];
                [selectAreaArray replaceObjectAtIndex:_currentSelectRow withObject:assetDict];
                [_projectMaterialDictionary removeObjectForKey:_currentScenes];
                [_projectMaterialDictionary setObject:selectAreaArray forKey:_currentScenes];
                [myPlayListCtrl setDirectionToCell:[NSIndexPath indexPathForRow:_currentSelectRow inSection:0] myDirection:directionString];
            }else{
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_videodontsetduration"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
                [myAlertView release];
            }
        }else{
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_durationnotnull"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
        }
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    @finally {

    }
}


/**
 *@brief 更新透明值到素材列表选中的cell中
 */
-(void)updateCellRowWithAlpha:(NSString *)alphaString{
    @try {
        if ((alphaString)&&([alphaString length]>0)) {
            [self validateCurrentScene];
            NSMutableArray *selectAreaArray = [[NSMutableArray alloc]initWithArray:[_projectMaterialDictionary objectForKey:_currentScenes]];
            NSDictionary *selectDict = [selectAreaArray objectAtIndex:_currentSelectRow];
            MaterialObject *oneMaterialObj = [selectDict objectForKey:@"asset"];
            if ([oneMaterialObj.material_type isEqual:@"Photo"]) {
                [oneMaterialObj setMaterial_alpha:alphaString];
                NSDictionary *assetDict = [[NSDictionary alloc]initWithObjectsAndKeys:[selectDict objectForKey:@"duration"],@"duration",oneMaterialObj,@"asset",nil];
                [selectAreaArray replaceObjectAtIndex:_currentSelectRow withObject:assetDict];
                [_projectMaterialDictionary removeObjectForKey:_currentScenes];
                [_projectMaterialDictionary setObject:selectAreaArray forKey:_currentScenes];
                [myPlayListCtrl setAlphaToCell:[NSIndexPath indexPathForRow:_currentSelectRow inSection:0] myDirection:alphaString];
            }else{
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_videodontsetduration"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
                [myAlertView release];
            }
        }else{
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_durationnotnull"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
        }
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    @finally {

    }
}

/**
 *  创建字体选择控件
 *
 *  @param myFrame  控件的位置
 *  @param superTag 控件的父视图
 */
-(void)createTextFontTextFieldWithFrame:(CGRect)myFrame andTag:(NSInteger)myTag superViewTag:(NSInteger)superTag{
    UIView *superView = [self.view viewWithTag:superTag];

    UIView *textView = [[UIView alloc]initWithFrame:myFrame];

    //    JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];

    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, myFrame.size.height)];
    [myLabel setFont:[UIFont systemFontOfSize:10]];
    [myLabel setText:[Config DPLocalizedString:@"adedit_textfont"]];



    fontArray = [[NSArray alloc] initWithObjects:@"Arial",@"Savoye LET",@"Bradley Hand",@"Cochin", nil];

    /*设置字体*/
    fontTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, myFrame.size.width-50, myFrame.size.height)];
    fontTextField.delegate = self;
    fontTextField.borderStyle = UITextBorderStyleRoundedRect;
    fontTextField.textAlignment = NSTextAlignmentLeft;
    fontTextField.keyboardType = UIKeyboardTypeNumberPad;
    fontTextField.enabled = NO;
    //从滚动标签的属性去读取默认滚动速度

    [fontTextField setText:[fontArray objectAtIndex:0]];
    fontTextField.tag = myTag;



    fontIsOpend = NO;//判断下拉tableView是否打开
    fontButton = [[BaseButton alloc] initWithFrame:CGRectMake(myFrame.size.width-30, 0, 30, 30) andNorImg:@"dropdown.png" andHigImg:nil andTitle:nil];
    [fontButton addTarget:self action:@selector(fontButton:) forControlEvents:UIControlEventTouchUpInside];

    fontTableBlock = [[TableViewWithBlock alloc] initWithFrame:CGRectMake(myFrame.origin.x +50, myFrame.origin.y + myFrame.size.height, myFrame.size.width-50, 1) style:UITableViewStylePlain];

    [fontTableBlock initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section){
        return (NSInteger)[fontArray count];
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        [cell.lb setText:[fontArray objectAtIndex:indexPath.row]];

        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath){
        SelectionCell *cell = (SelectionCell *)[tableView cellForRowAtIndexPath:indexPath];
        fontTextField.text = cell.lb.text;
        //修改了调整字体的代码
        NSString *myFontName = nil;
        if (fontTextField.text) {
            myFontName = fontTextField.text;
            JHTickerView *old_Ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
            [old_Ticker setTickerFont:[UIFont fontWithName:myFontName size:[sizeTextField.text floatValue]]];

            [self createTextAreaWithFont:[UIFont fontWithName:myFontName size:old_Ticker.tickerFont.pointSize]];
        }

        [fontButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    [fontTableBlock.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [fontTableBlock.layer setBorderWidth:2];

    [textView addSubview:myLabel];
    [textView addSubview:fontTextField];
    [textView addSubview:fontButton];
    [superView addSubview:fontTableBlock];

    [superView addSubview:textView];
}

-(void)alphaButtonClicked:(UIButton *)sender{
    if (alphaIsOpend) {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"dropdown.png"];
            [alphaButton setImage:closeImage forState:UIControlStateNormal];

            CGRect frame=alphaTableBlock.frame;

            frame.size.height=1;
            [alphaTableBlock setFrame:frame];

        } completion:^(BOOL finished){
            alphaIsOpend=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"dropup.png"];
            [alphaButton setImage:openImage forState:UIControlStateNormal];

            CGRect frame = alphaTableBlock.frame;

            frame.size.height=[alphaArray count]*30;
            [alphaTableBlock setFrame:frame];
        } completion:^(BOOL finished){
            
            alphaIsOpend=YES;
        }];
    }
    
}


-(void)fontButton:(UIButton *)sender{
    if (fontIsOpend) {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"dropdown.png"];
            [fontButton setImage:closeImage forState:UIControlStateNormal];

            CGRect frame=fontTableBlock.frame;

            frame.size.height=1;
            [fontTableBlock setFrame:frame];

        } completion:^(BOOL finished){
            fontIsOpend=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"dropup.png"];
            [fontButton setImage:openImage forState:UIControlStateNormal];

            CGRect frame = fontTableBlock.frame;

            frame.size.height=[fontArray count]*30;
            [fontTableBlock setFrame:frame];
        } completion:^(BOOL finished){

            fontIsOpend=YES;
        }];
    }

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //点击return键将参数设置到选中的显示区域
    if ((textField.tag==REGION_TAG_EDITOR_2001)||(textField.tag==REGION_TAG_EDITOR_2002)||(textField.tag==REGION_TAG_EDITOR_2003)||(textField.tag==REGION_TAG_EDITOR_2004)) {
        [self applyRegionProperties];
        DLog(@"%@",textField);
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //编辑完毕将参数设置到选中的显示区域
    if ((textField.tag==REGION_TAG_EDITOR_2001)||(textField.tag==REGION_TAG_EDITOR_2002)||(textField.tag==REGION_TAG_EDITOR_2003)||(textField.tag==REGION_TAG_EDITOR_2004)) {
        [self applyRegionProperties];
        DLog(@"%@",textField);
    }
}

-(BOOL)textField:(UITextField *)field shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //当输入任何字符时，代理调用该方法，如果返回YES则这次输入可以成功，如果返回NO，不能输入成功
    //range表示光标位置，只有location，length == 0；
    //string表示这次输入的字符串。
    if ((field.tag == TAG_PROJECT_NAME_TEXTFIELD)) {
        return YES;
    }else{
        if ([self isPureInt:string]) {
            DLog(@"range = %@  string = %@",NSStringFromRange(range),string);
            return range.location < 4;
        }else{
            return NO;
        }

    }
}



-  (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;//NO不清除
}
/**
 *  @brief 判断输入的字符是否是纯数字
 *
 *  @param string 输入的字符串
 *
 *  @return 如果输入的字符串是纯数字则返回YES
 */
- (BOOL)isPureInt:(NSString*)string{
    if ([string length]==0) {
        return YES;
    }
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}


/**
 *  应用Frame设置,change region
 */
-(void)applyDefaultRegionWtihViewTag:(NSInteger)viewTag{
    if (viewTag != VIEW_TAG_TEXT_AREA_1005) {
        NSInteger ix = 0;
        NSInteger iy = 0;
        NSInteger iw = 160;
        NSInteger ih = 640;
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([ud integerForKey:@"iw"]) {
            ix = [ud integerForKey:@"ix"];
            iy = [ud integerForKey:@"iy"];
            iw = [ud integerForKey:@"iw"];
            ih = [ud integerForKey:@"ih"];
        }

        UITextField *xField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2001];
        [xField setText:[NSString stringWithFormat:@"%d",(int)ix]];
        UITextField *yField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2002];
        [yField setText:[NSString stringWithFormat:@"%d",(int)iy]];
        UITextField *wField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2003];
        [wField setText:[NSString stringWithFormat:@"%d",(int)iw]];
        UITextField *hField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2004];
        [hField setText:[NSString stringWithFormat:@"%d",(int)ih]];

        NSInteger xFieldText = [xField.text integerValue];
        NSInteger yFieldText = [yField.text integerValue];
        NSInteger wFieldText = [wField.text integerValue];
        NSInteger hFieldText = [hField.text integerValue];

        JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];

        UIView *tempView = [self.view viewWithTag:viewTag];
        UIView *tempView5 = [self.view viewWithTag:VIEW_TAG_TEXT_AREA_1005];
        UIImageView *tempImageView = (UIImageView*)[self.view viewWithTag:TAG_IMAGE_VIEW+tempView.tag];
        [tempImageView setFrame:CGRectMake(0, 0, wFieldText, hFieldText)];
        [tempView setFrame:CGRectMake(xFieldText, yFieldText,wFieldText, hFieldText)];
        [tempView5 setFrame:CGRectMake(tempView.frame.origin.x + tempView.frame.size.width, 0, ticker.frame.size.width, ticker.frame.size.height)];
    }
}

-(BOOL)textFieldValidate:(UITextField *)myTextfield{
    if (myTextfield) {
        if ([myTextfield.text length]<1) {
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_inputdontisnull"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            [myTextfield becomeFirstResponder];
            return NO;
        }else{
            return YES;
        }
    }else{
        return NO;
    }
}

/**
 *  应用Frame设置,change region
 */
-(void)applyRegionProperties{
    UITextField *xField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2001];
    UITextField *yField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2002];
    UITextField *wField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2003];
    UITextField *hField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2004];

    NSInteger xFieldText = [xField.text integerValue];
    NSInteger yFieldText = [yField.text integerValue];
    NSInteger wFieldText = [wField.text integerValue];
    NSInteger hFieldText = [hField.text integerValue];

    globalWHScale = (wFieldText*1.0) / (hFieldText*1.0);

    JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];

    UIView *tempView = [self.view viewWithTag:_currentSelectIndex];
    if (tempView) {
        if (_currentSelectIndex == VIEW_TAG_TEXT_AREA_1005) {
            [ticker setFrame:CGRectMake(0, 0, wFieldText, hFieldText)];
        }else{
            UIImageView *tempImageView = (UIImageView*)[self.view viewWithTag:TAG_IMAGE_VIEW+tempView.tag];
            [tempImageView setFrame:CGRectMake(0, 0, wFieldText, hFieldText)];
        }

        [tempView setFrame:CGRectMake(xFieldText, yFieldText,wFieldText, hFieldText)];
    }

    [xField resignFirstResponder];
    [yField resignFirstResponder];
    [wField resignFirstResponder];
    [hField resignFirstResponder];
}


/**
 *  清理层内的图片
 *
 *  @param sender 点击的button
 */
-(void)clearImageButtonClick:(UIButton *)sender{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_promptclearImageList"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptno"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptyes"], nil];
    [myAlertView setTag:TAG_IS_CLEAR_IMAGE_LIST_ALERT];
    [myAlertView show];
    [myAlertView release];
}


-(void)functionButtonClick:(UIButton *)sender{
    if (sender.tag == TAG_SETTIONG_REGION_BUTTON) {
        DLog(@"范围设置");
        if (isPlay) {
            [self showExitPromptDialog];
            return;
        }
        [self showOneEditerCtrlViewWithTag:TAG_REGION_SETTINGS_VIEW];
        [self highlightButtonWithTag:sender.tag];
    }
    
    
    if (sender.tag == TAG_SAVE_PROJECT_BUTTON) {
        
        if (loginPage != NULL) {
            
            [loginPage removeFromSuperview];
        }
        
        if (registeredPage != NULL) {
            
            [registeredPage removeFromSuperview];
            
        }
        
        DLog(@"保存项目视图");
        UITextField *fil=(UITextField *)[self.view viewWithTag:TAG_PROJECT_NAME_TEXTFIELD];
        [fil setText:pname];
        [self showOneEditerCtrlViewWithTag:TAG_PROJECT_SETTING_VIEW];
        [self highlightButtonWithTag:sender.tag];
        [myProjectCtrl reloadMyPlaylist];
    }
    if (sender.tag == TAG_WIFI_SET_BUTTON) {
        
        if (loginPage != NULL) {
            
            [loginPage removeFromSuperview];
        }
        
        CX_WIFIViewController *wifi = [[CX_WIFIViewController alloc]init];
        [self.view addSubview:wifi.view];
    }
    
//    点击登陆  云备份
    if (sender.tag == TAG_LOGIN_SETBUTTON) {
        
        if (loginPage != NULL) {
            
            [loginPage removeFromSuperview];
        }
        
        loginPage = [[YXM_LoginPage alloc]initWithFrame:CGRectMake(self.view.frame.size.width-320, 50, 320, 240)];
        
        loginPage.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:loginPage];
        
      __block   LayoutYXMViewController *VC = self;
        
        loginPage.userName_text = ^(NSString *userName_text){
        
            
            NSLog(@"获取登陆名字%@",userName_text);
            VC.loginUserNameString = userName_text;
            
        };
        
        loginPage.passWord_text = ^(NSString *passWord_text){
        
        
            NSLog(@"获取登陆密码%@",passWord_text);
        
            VC.loginPassWordString = passWord_text;
        };
        
        loginPage.loginButtonOnClick = ^(void){
//        登陆
            [self landing];
            
        };
        
        loginPage.registeredButtonOnClick = ^(void){
        
//            注册
            [self registeredView_load];
        };
        
        loginPage.message_text = ^(NSString *message_text){
//            
            VC.loginMessageString = message_text;
        
        };
        
        
        NSLog(@"1111");
    }
    
    
    if (sender.tag == TAG_TEXT_EDIT_BUTTON) {
        
        if (loginPage != NULL) {
            
            [loginPage removeFromSuperview];
        }
       
        if (registeredPage != NULL) {
            
            [registeredPage removeFromSuperview];
        
        }
        
        DLog(@"文字区域设置");
        if (isPlay) {
            [self showExitPromptDialog];
            return;
        }
        [self showOneEditerCtrlViewWithTag:TAG_TEXT_REGION_SETTING_VIEW];
        [self highlightButtonWithTag:sender.tag];
    }
    if (sender.tag == TAG_MUSIC_EDIT_BUTTON) {
        DLog(@"音频设置");
        if (isPlay) {
            [self showExitPromptDialog];
            return;
        }
        [self showOneEditerCtrlViewWithTag:TAG_MUSIC_SETTING_VIEW];
        [self highlightButtonWithTag:sender.tag];
        //刷新音频列表
        [myMusicPicker reloadMusicList];
    }
    if (sender.tag == TAG_ITEM_SETTING_BUTTON) {
        
        if (loginPage != NULL) {
            
            [loginPage removeFromSuperview];
        }
        if (registeredPage != NULL) {
            
            [registeredPage removeFromSuperview];
            
        }
        
        DLog(@"播放列表设置");
        if (isPlay) {
            [self showExitPromptDialog];
            return;
        }
        [self showOneEditerCtrlViewWithTag:TAG_SUBITEM_LIST_VIEW];
        [self highlightButtonWithTag:sender.tag];
    }


    //应用原点和宽高设置
    if (sender.tag == TAG_APPLY_REGION_BUTTON) {
        DLog(@"应用文本的宽高");
        UITextField *xField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2001];
        if (![self textFieldValidate:xField]) {
            return;
        }
        UITextField *yField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2002];
        if (![self textFieldValidate:yField]) {
            return;
        }
        UITextField *wField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2003];
        if (![self textFieldValidate:wField]) {
            return;
        }
        UITextField *hField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2004];
        if (![self textFieldValidate:hField]) {
            return;
        }
        [self applyRegionProperties];
    }

    
//    保存播放素材
    if (sender.tag == TAG_SAVE_AS_BUTTON) {
        DLog(@"点击了保存播放项目");

        @try {
            if (isPlay) {
                return;
            }
            UITextField *projectNameText = (UITextField *)[self.view viewWithTag:TAG_PROJECT_NAME_TEXTFIELD];
            [projectNameText resignFirstResponder];
            NSString *myProjectNameString = [projectNameText text];
            DLog(@"%@",myProjectNameString);
            if (myProjectNameString) {
                if ([myProjectNameString length]>0) {
                    [self saveProjectWithProjectName:myProjectNameString andProjectXMLFilePath:nil];
                }else{
                    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_projectnamenotnull"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                    [myAlertView show];
                    [myAlertView release];
                }
            }else{
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_projectnamenotnull"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
                [myAlertView release];
            }

        }
        @catch (NSException *exception) {
            DLog(@"%@",exception);
        }
        @finally {

        }
    }

    //保存文字
    if (sender.tag == TAG_SAVE_TEXT_BUTTON) {
        DLog(@"保存文字");

        JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];

        UITextView *myTextView = (UITextView *)[self.view viewWithTag:5001];
        NSString *myTextString = myTextView.text;
        if (myTextString) {
            [ticker setTickerStrings:[[NSArray alloc]initWithObjects:myTextString, nil]];
        }
        if ([myTextString length]>0) {
            [ticker setHidden:NO];
        }else{
            [ticker setHidden:YES];
        }

        UITextField *fontSizeText = (UITextField *)[self.view viewWithTag:TAG_FONT_SIZE_TEXT];
        NSString *fontSizeString = fontSizeText.text;
        if (fontSizeString) {
            float myFontSize = [fontSizeString floatValue];
            [ticker setTickerFont:[UIFont systemFontOfSize:myFontSize]];
        }

        UITextField *rollingSpeedText = (UITextField *)[self.view viewWithTag:TAG_ROLLING_SPEED_TEXT];
        NSString *rollingSpeedString = rollingSpeedText.text;
        if (rollingSpeedString) {
            float iMySpeed = [rollingSpeedString floatValue];
            iMySpeed = iMySpeed*10;
            [ticker setTickerSpeed:(iMySpeed)];
        }

        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"Successanddangqiangundong"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }

    //退出播放模式
    if (sender.tag == TAG_QUIT_PLAY_BUTTON) {
        
        
        
        
        
        
        DLog(@"退出播放模式");
        [self quitePlayProjAndResetEditer:YES];
        [_projectMaterialDictionary removeAllObjects];
        _musicFilePath = nil;
        myMusicTotalPlayTime = 0;
        [musicPlaytimeLabel setText:@""];
        [musicNameLabel setText:@""];
        _musicDuration = nil;
        _musicVolume = nil;
        _musicName = nil;
        UIButton * btn1 = (UIButton *)[self.view viewWithTag:TAG_SAVE_AS_BUTTON];
        btn1.hidden=NO;
        UIButton * btn2 = (UIButton *)[self.view viewWithTag:TAG_REST_SCREEN_AS_BUTTON];
        btn2.hidden=NO;
        UIButton * btn4 = (UIButton *)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_BUTTON];
        btn4.hidden=NO;
        UIButton * btn3 = (UIButton *)[self.view viewWithTag:TAG_EDIT_PROJ_BUTTON];
        btn3.hidden=YES;
        UIButton *myTempButton = (UIButton*)[self.view viewWithTag:TAG_PUBLISH_PROJ_BUTTON];
        myTempButton.hidden=YES;
        UITextField *fil=(UITextField *)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
        fil.hidden=NO;

    }

    //删除项目
    if (sender.tag == TAG_DELETE_PROJ_BUTTON) {
        DLog(@"删除项目");
        if ((!_currentPlayProjectFilename)||([_currentPlayProjectFilename length]<1)) {
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_Pleaseselectanitem"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            return;
        }else{
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_suretodelete"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptno"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptyes"], nil];
            myAlertView.delegate = self;
            myAlertView.tag = 10020;
            [myAlertView show];
            [myAlertView release];
        }
    }

    //发布项目
    if (sender.tag == TAG_PUBLISH_PROJ_BUTTON) {
        if (selectIpArr.count==0) {
            [CXError NOipError];
        }else{
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_Publishoperation"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptno"] otherButtonTitles:[Config DPLocalizedString:@"adedit_PublishProj"], nil];
        [myAlertView setTag:10021];
        myAlertView.delegate = self;
        [myAlertView show];
        [myAlertView release];
        }
    }

    //编辑项目
    if (sender.tag == TAG_EDIT_PROJ_BUTTON) {
        DLog(@"编辑项目,需要检查素材信息临时存放字典是否为空");
        if ((!_currentPlayProjectFilename) || ([_currentPlayProjectName length]<1)) {
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_selectanProject"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            return;
        }

        //项目名称
        UITextField *projectNameText = (UITextField *)[self.view viewWithTag:TAG_PROJECT_NAME_TEXTFIELD];
        [projectNameText resignFirstResponder];
        myProjectTextString = [projectNameText text];
        if ([myProjectTextString length]<1) {
            myProjectTextString = _currentPlayProjectName;
        }

        //编辑项目之前需要先退出播放
        [self quitePlayProjAndResetEditer:NO];

        if (isEditProject) {
            //如果项目处于编辑状态下点击按钮，发生以下情况
            /*
             1、显示保存项目按钮
             2、如果项目名称不变的情况下覆盖原项目；如果项目名称改变了则新增一个项目
             3、改变编辑按钮上的文字为Edit Proj
             */
            //需要单独写一个编辑的方法

            BOOL isEditResult = NO;
            isEditResult = [self saveProjectWithProjectName:myProjectTextString andProjectXMLFilePath:_currentPlayProjectFilename];
            if (isEditResult) {
                [self changeEditPlayButton:NO];
                isEditProject = NO;
                //删除蒙板
                UIView *tempView = [self.view viewWithTag:TAG_MAKE_OPACITY_MASK];
                [tempView removeFromSuperview];

                //清空项目名称文本框
                [self cleanProjectName];
                //清理编辑时使用过的资源
                [self cleanEditerResources];
            }else{
                //提示保存修改出错
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_saveediterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
                [myAlertView release];
                return;
            }
        }else{
            //如果项目被选中，不是编辑状态下，点击按钮，发生以下情况
            /*
             1、隐藏保存项目按钮
             2、将项目加载到编辑器中
             3、改变编辑按钮上的文字为Save Proj & Quit Edit
             */
            //选中项目播放的时候已经将旧的资源和信息读取到编辑器的数据容器中了

            [self changeEditPlayButton:YES];
            isEditProject = YES;

            //点击编辑项目之后使列表不可点击,添加透明蒙板
            CGRect myPFrame = myProjectCtrl.view.frame;
            UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, myPFrame.size.width, myPFrame.size.height)];
            [myView setTag:TAG_MAKE_OPACITY_MASK];
            UITapGestureRecognizer *myTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPromptPexitEdit:)];
            [myView addGestureRecognizer:myTapGestureRecognizer];
            [myProjectCtrl.view addSubview:myView];
        }
    }

    if (sender.tag == TAG_MY_MORE_RUNC_VIEW_BACKBUTTON) {
        //更多功能区域的返回事件
        //设置播放时间
        [self setTimeToCell];
        //隐藏更多设置视图
        UIView *myMoreFuncView = [self.view viewWithTag:TAG_MY_MORE_RUNC_VIEW];
        CGRect myMoreRect = CGRectMake(myMoreFuncView.frame.origin.x+myMoreFuncView.frame.size.width, myMoreFuncView.frame.origin.y, myMoreFuncView.frame.size.width, myMoreFuncView.frame.size.height);
        [UIView animateWithDuration:0.6 animations:^{
            [myMoreFuncView setFrame:myMoreRect];
        } completion:^(BOOL finished) {
            [[self.view viewWithTag:TAG_MY_MORE_RUNC_VIEW] removeFromSuperview];
        }];

    }

    if (sender.tag == TAG_MY_MORE_RUNC_VIEW_DELETE_BUTTON) {
        //更多功能区域的删除事件
        [self validateCurrentScene];
        NSMutableArray *selectAreaArray = [[NSMutableArray alloc]initWithArray:[_projectMaterialDictionary objectForKey:_currentScenes]];
        if ([selectAreaArray indexOfObject:myMoreDict] != NSNotFound) {
            [selectAreaArray removeObject:myMoreDict];
            [myPlayListCtrl deleteSelectRowWithOneAssetDict:myMoreDict cellIndexPath:myMoreIndexPath andSwipeTableViewCell:myMoreCell isEdit:isEditProject];
            [_projectMaterialDictionary removeObjectForKey:_currentScenes];
            [_projectMaterialDictionary setObject:selectAreaArray forKey:_currentScenes];
        }
        //如果处于编辑状态，则需要删除对应的文件
        [self refreshScelectAreaMatrialListWithTag:[_currentScenes integerValue]];
        //删除更多视图
        [[self.view viewWithTag:TAG_MY_MORE_RUNC_VIEW] removeFromSuperview];
    }
    //设置默认屏体大小为160X640
    if (sender.tag == TAG_DEFAULT_REGION_BUTTON) {
        _currentSelectIndex = 1004;

        [self applyDefaultRegionWtihViewTag:_currentSelectIndex];
        //选中一块屏幕
        [self selectOneScreenAreaWith:_currentSelectIndex];
    }
    if (sender.tag == TAG_SEARCH_PUBLISH_PROJ_BUTTON) {
        DLog(@"搜索已经编辑好的项目");
        [self clearSelectBox];

        UITextField *searchTextField = (UITextField*)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
        DLog(@"%@",searchTextField.text);
        [searchTextField resignFirstResponder];
        NSString *mySearchTextString = searchTextField.text;
        if ((mySearchTextString)&&([mySearchTextString length]>0)) {
            [self performSelectorInBackground:@selector(startSearchActi) withObject:nil];
            [myProjectCtrl searchProjectListWithProjectName:mySearchTextString];
            [self stopSearchActi];
        }else{
            [myProjectCtrl reloadMyPlaylist];
        }
    }

    //创建项目分组
    if (sender.tag == TAG_CREATE_GROUP_BUTTON) {
        if (selectIpArr.count==0) {
            [CXError NOipError];
        }else{
        NSString *groupNameString = @"连续播放";
        //开始创建分组文件
        NSDictionary *myGroupDict = [[NSDictionary alloc]initWithObjectsAndKeys:groupNameString,@"playlistname",mySelectedProjectArray,@"playlist" ,nil];
        [self createGroupXMLFileWithDictionary:myGroupDict andSavePath:nil andEdit:NO];
        [_waitForUploadFilesArray removeAllObjects];
        [_waitForUploadFilesArray addObject:xmlfilePath];
        isContinusPlay = YES;
        [self startupPublish];
        }
    }


    if (TAG_REST_SCREEN_AS_BUTTON == sender.tag) {
        //重置
        if (selectIpArr.count==0) {
            [CXError NOipError];
        }else{
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_resetscreenbutton"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptno"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptyes"], nil];
        [myAlertView setTag:TAG_ALTERVIEW_TAG_REST_SCREEN_AS_BUTTON];
        myAlertView.delegate = self;
        [myAlertView show];
        [myAlertView release];
        }

    }

    if (sender.tag == TAG_MAKE_ROTATION_REGION_BUTTON) {
        //旋转_currentSelectIndex
        if (_currentSelectIndex != 1004) {
            return;
        }
        if (isRotation) {
            fangle = 0;
            UIView *myMainView = [self.view viewWithTag:_currentSelectIndex];
            myMainView.transform = CGAffineTransformMakeRotation(DEGRESS_TO_RADIANS(0));
            isRotation = NO;
            UIView *myTextView = [self.view viewWithTag:VIEW_TAG_TEXT_AREA_1005];
            [myTextView setHidden:NO];
        }else{
            fangle = 45;
            UIView *myMainView = [self.view viewWithTag:_currentSelectIndex];
            myMainView.transform = CGAffineTransformMakeRotation(DEGRESS_TO_RADIANS(45));
            isRotation = YES;
            UITextField *xField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2001];
            UITextField *yField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2002];
            UITextField *wField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2003];
            UITextField *hField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2004];

            NSInteger xFieldText = [xField.text integerValue];
            NSInteger yFieldText = [yField.text integerValue];
            NSInteger wFieldText = [wField.text integerValue];
            NSInteger hFieldText = [hField.text integerValue];
//            [myMainView setFrame:CGRectMake(myMainView.frame.origin.x, myMainView.frame.origin.y, wFieldText, hFieldText)];
            [myMainView setBounds:CGRectMake(0,0, wFieldText, hFieldText)];
            //点击了旋转45度之后隐藏文字框
            UIView *myTextView = [self.view viewWithTag:VIEW_TAG_TEXT_AREA_1005];
            [myTextView setHidden:YES];
        }

    }

    if (sender.tag == TAG_CLEAR_MUSIC_BUTTON) {
        DLog(@"清理音频文件");
        _musicFilePath = nil;
        [musicNameLabel setText:@""];
        [musicPlaytimeLabel setText:@""];
        _musicVolume = @"50";
        _musicDuration = @"";
        _musicName = nil;
        myMusicTotalPlayTime = 0;
    }
    
    if(sender.tag==TAG_SCREEN_PLAYLIST_BUTTON){
        [myProjectCtrl addgroup];
//        DLog(@"%@",[_waitForUploadFilesArray[0] lastPathComponent]);
//        [myProjectCtrl delete:[_waitForUploadFilesArray[0] lastPathComponent]];
//        [myProjectCtrl delete:[_waitForUploadFilesArray[1] lastPathComponent]];
    }
    if(sender.tag == TAG_LED_DETECT_BUTTON){
        DLog(@"添加分组");
        CX_AddGroupController *addgroup = [[CX_AddGroupController alloc]init];
        [self.view addSubview:addgroup.view];
    }

}



/**
 *  //清理编辑器资源
 */
-(void)cleanEditerResources{
    //清理视频编辑的字典信息
    if (globalDictFramesInfo) {
        if ([globalDictFramesInfo count]>0) {
            [globalDictFramesInfo removeAllObjects];
            globalDictFramesInfo = nil;
            globalsVideoPath = nil;
            globalDuration = 0;
        }
    }
    //清理临时图片存储路径
    [self removeMaterialRootPath];
    //清理当前发送项目的临时存储区、项目xml、项目名称
    [_currentDataArray removeAllObjects];
    _currentPlayProjectFilename = nil;
    _currentPlayProjectName = nil;
    //清理正在编辑素材字典容器
    [_projectMaterialDictionary removeAllObjects];
    //已选播放列表重新加载
    [myPlayListCtrl reloadMyPlaylist:nil];
    //清理待选素材列表
    [myMasterCtrl clearAssets:nil];
    //删除播放窗口内的子视图
    for (UIView *subView in [[self.view viewWithTag:1004] subviews]) {
        [subView removeFromSuperview];
    }
    UIImageView *myImageView = [[UIImageView alloc]init];
    [myImageView setTag:TAG_IMAGE_VIEW+1004];
    [[self.view viewWithTag:1004] addSubview:myImageView];
    //清理文字滚动条中的文字
    JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
    [ticker setTickerStrings:[[NSArray alloc]initWithObjects:@"", nil]];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10020) {
        if (buttonIndex==1) {
            //删除项目
            [self deletePlayProject:nil];
            [self cleanEditerResources];
        }
    }
    if (alertView.tag == 10021) {
        //发布按钮点击
        if (buttonIndex == 1) {
            DLog(@"发布项目前先检查网络");
            [self startupPublish];

        }

    }
    if (alertView.tag == TAG_RECONNECT_ALERTVIEW) {
        //重新连接网络
        if (buttonIndex==1) {
            isReconnect = YES;
            [self startSocket];
        }

    }
    


    if (alertView.tag == TAG_ALTERVIEW_GROUPNAME_INPUT) {
        if (buttonIndex==1) {
            DLog(@"输入分组名称");
            //得到输入框
            UITextField *groupNameTextField = [alertView textFieldAtIndex:0];
            DLog(@"%@",groupNameTextField.text);
            NSString *groupNameString = groupNameTextField.text;
            //开始创建分组文件
            NSDictionary *myGroupDict = [[NSDictionary alloc]initWithObjectsAndKeys:groupNameString,@"playlistname",mySelectedProjectArray,@"playlist" ,nil];
            [self createGroupXMLFileWithDictionary:myGroupDict andSavePath:nil andEdit:NO];
        }
    }

    if (alertView.tag == TAG_ALTERVIEW_TAG_REST_SCREEN_AS_BUTTON) {
        if (buttonIndex==1) {
            DLog(@"重置");
            [self resetScreenPlayList];

        }
    }
    if (alertView.tag == TAG_REST_SCREEN_ALERT) {
        [myProjectCtrl reloadMyPlaylist];
    }
    if (alertView.tag == TAG_IS_CLEAR_IMAGE_LIST_ALERT) {
        if (buttonIndex==1) {
            DLog(@"确认是否清除列表");
            [self clearImageListWithCurrentScene];
        }
    }

    if (alertView.tag == TAG_IS_TRANS_TYPE_ALERT) {
        if (buttonIndex==1) {
            DLog(@"使用旧传输协议传文件");

        }
    }
}

/**
 *  //在确认连接成功之后开始发布
 */

-(void)startupPublish{
//    isloops = YES;
//    if (isloops) {
        ipAddressString = selectIpArr[Num];
//    }
//    if (!isConnect) {
        isConnect = NO;
        [self startSocket];
//    }
    _currentDataAreaIndex = 0;
    //启动发布的进度条
    [self startPuslisProgress];
    //计算文件总大小
    for (NSString *sFielPath in _waitForUploadFilesArray) {
        _uploadFileTotalSize += [LayoutYXMViewController fileSizeAtPath:sFielPath];
    }
    //开始发送文件，使用ftp的方式
    [self useFTPSendProject];
}

/**
 *  请求当前屏幕亮度
 */
-(void)resetBrightness{
    if (!isConnect) {
        [self startSocket];
    }
    //0x13
    [self commandResetServerWithType:0x12 andContent:nil andContentLength:0];
}
//关机
-(void)resetguanji{
//    if (!isConnect) {
    [self ceshi];
//    }
    DLog(@"关机");
    //0x16
    [self commandResetServerWithType:0x16 andContent:nil andContentLength:0];
}
/**
 *  上传当前屏幕亮度
 */
-(void)UploadBrightness{
    if (!isConnect) {
        [self startSocket];
    }
    //0x13
    [self commandServerWithType:0x13 andContent:nil andContentLength:0];

}


-(void)ceshi{
    ipAddressString = selectIpArr[Num];
    isConnect = NO;
    [self startSocket];
}

/**
 *  重置播放列表
 */
-(void)resetScreenPlayList{
//    if (!isConnect) {
    [self ceshi];
//    }
    //0x1C
    [self commandResetServerWithType:0x1C andContent:nil andContentLength:0];
}

/**
 *  重置连续播放列表
 */
-(void)resetContinuesPlayList{
//    if (!isConnect) {
        isConnect = NO;
        [self startSocket];
//    }
    //0x2D
    [self commandResetServerWithType:0x2D andContent:nil andContentLength:0];
}


/**
 *  启动发布进度条
 */
-(void)startPuslisProgress{
    //发送状态设置为发送中
    isSendState = YES;
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT,self.view.frame.size.height, self.view.frame.size.width)];
//    if (OS_VERSION_FLOAT>7.9) {
        [myView setFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
//    }
    [myView setBackgroundColor:[UIColor whiteColor]];
    [myView setAlpha:0.9];
    [myView setTag:8000088];
    [myView setUserInteractionEnabled:YES];
    [self.view addSubview:myView];


    myMRProgressView = [MRProgressOverlayView showOverlayAddedTo:myView title:[Config DPLocalizedString:@"adedit_publishprojecting"] mode:MRProgressOverlayViewModeDeterminateHorizontalBar animated:YES stopBlock:^(MRProgressOverlayView *progressOverlayView) {
        progressOverlayView.mode = MRProgressOverlayViewModeCheckmark;
        progressOverlayView.titleLabelText = @"Succeed";
        [progressOverlayView dismiss:YES];
    }];

    [myMRProgressView setFrame:CGRectMake(myMRProgressView.frame.origin.x-40, myMRProgressView.frame.origin.y - 40, myMRProgressView.frame.size.width + 80, myMRProgressView.frame.size.height + 80)];

    //取消发布按钮
    UIButton *cancelPublishButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_CGSIZE_2HEIGHT - 320, SCREEN_CGSIZE_2WIDTH - 90, 320, 55)];
    if (OS_VERSION_FLOAT>7.9) {
        [cancelPublishButton setFrame:CGRectMake(SCREEN_CGSIZE_2WIDTH - 320, SCREEN_CGSIZE_2HEIGHT - 90, 320, 55)];
    }
    [cancelPublishButton setBackgroundColor:[UIColor grayColor]];
    [cancelPublishButton setTitle:[Config DPLocalizedString:@"adedit_CancelPublish"] forState:UIControlStateNormal];
    [cancelPublishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelPublishButton.layer.borderWidth = 1;
    cancelPublishButton.layer.borderColor = [UIColor blackColor].CGColor;
    [cancelPublishButton addTarget:self action:@selector(cancelPublishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelPublishButton setAlpha:1];
    [myView addSubview:cancelPublishButton];


}

/**
 *  取消发布按钮的处理方法
 *
 *  @param sender 发送者
 */
-(void)cancelPublishButtonClick:(UIButton *)sender{
    [self stopPublishProgress];
}

/**
 *  停止发布进度条需要处理的事件
 */
-(void)stopPublishProgress{
    @try {
        isSendState = NO;
        UIView *myView = [self.view viewWithTag:8000088];
        UIActivityIndicatorView *myIndicatorView = (UIActivityIndicatorView*)[self.view viewWithTag:8000089];
        UILabel *myLabel = (UILabel*)[self.view viewWithTag:8000090];
        if (myIndicatorView) {
            //停止指示器
            [myIndicatorView stopAnimating];
            [myIndicatorView removeFromSuperview];
        }

        if (myView) {
            //删除遮罩视图
            [myView removeFromSuperview];
        }

        if (myLabel) {
            //删除提示标签
            [myLabel removeFromSuperview];
        }
        if (myProgressView) {
            //删除进度条
            [myProgressView removeFromSuperview];
            [myProgressView release],myProgressView = nil;
        }
        //将发送索引置于不可达处
        _currentDataAreaIndex = TAG_MAX_NUMBER;
        if (_currentDataArray) {
            //清理发送数据池
            [_currentDataArray removeAllObjects];
        }

        if (myPublishCompleteTimer) {
            if ([myPublishCompleteTimer isValid]) {
                [myPublishCompleteTimer invalidate];
                myPublishCompleteTimer = nil;
            }
        }
        //初始化继续播放变量
//        isContinusPlay = NO;
        //重置分组信息
        [myProjectCtrl useGroupInfoReloadProjectList];
        //重新加载播放列表
        [myProjectCtrl reloadMyPlaylist];
        //改变删除按钮和编辑按钮的状态
        [self changeDeleteBAndEditBState];
    }
    @catch (NSException *exception) {
        DLog(@"exception = %@",exception);
    }
    @finally {
    }
}

/**
 *  发送文件信息
 *
 *  @param commandType   命令类型
 *  @param contentBytes  数据内容
 *  @param contentLength 数据长度
 */
-(void)commandFileInfoWithType:(Byte)commandType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength
{
    int byteLength = contentLength+7;
    Byte outdate[byteLength];
    memset(outdate, 0x00, byteLength);
    outdate[0]=0x7D;
    outdate[1]=commandType;//命令类型
    outdate[2]=0x03; /*命令执行与状态检查2：获取服务器端的数据*/
    outdate[3]=0x00;
    for (int i=0; i<contentLength; i++) {
        outdate[i+4]=contentBytes[i];
    }
    outdate[byteLength-3]=(Byte)byteLength;
    outdate[byteLength-2]=(Byte)(byteLength>>8);
    int sumByte = 0;
    for (int j=0; j<(byteLength-1); j++) {
        sumByte += outdate[j];
    }
    //校验码计算（包头到校验码前所有字段求和取反+1）
    outdate[(byteLength-1)]=~(sumByte)+1;
    long tag = outdate[1];
    DLog(@"命令类型 commandType = %d",(int)commandType);
    NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:byteLength];
    [_sendPlayerSocket writeData:udpPacketData withTimeout:-1 tag:tag];
}

/**
 *  传输文件内容
 *
 *  @param commandType   命令类型
 *  @param sendType      发送类型
 *  @param contentBytes  内容byte数组
 *  @param contentLength 内容长度
 *  @param pageNumber    页码
 */
-(void)commandContentWithType:(Byte)commandType andSendType:(Byte)sendType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength andPageNumber:(NSInteger)pageNumber
{
    int byteLength = 7;
    if (sendType == 0x01 ) {
        byteLength = 11 + contentLength;
    }
    DLog(@"byteLength = %d",byteLength);
    Byte outdate[byteLength];
    memset(outdate, 0x00, byteLength);
    outdate[0]=0x7D;
    outdate[1]=commandType;//命令类型
    outdate[2]=0x03; //传输数据到客户端
    outdate[3]=sendType;
    if (sendType == 0x01) {
//        DLog(@"pageNumber = %d",pageNumber);
        pageNumber = pageNumber + 1;
        outdate[4]=(Byte)pageNumber;
        outdate[5]=(Byte)(pageNumber>>8);
        outdate[6]=(Byte)(pageNumber>>16);
        outdate[7]=(Byte)(pageNumber>>24);
        for (int i=0; i<contentLength; i++) {
            outdate[i+8]=contentBytes[i];
            //DLog(@"%x",contentBytes[i]);
        }
    }
    outdate[byteLength-3]=(Byte)byteLength;
    outdate[byteLength-2]=(Byte)(byteLength>>8);
    int sumByte = 0;
    for (int j=0; j<(byteLength-1); j++) {
        sumByte += outdate[j];
    }
    //校验码计算（包头到校验码前所有字段求和取反+1）
    outdate[(byteLength-1)]=~(sumByte)+1;
    long tag = outdate[1];
    DLog(@"tag = %ld",tag);
    NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:byteLength];
//    DLog(@"pageNumber = %d",pageNumber);
    if (pageNumber==TAG_MAX_NUMBER) {
        DLog(@"发送文件数据传输完成命令");

    }
    [_sendPlayerSocket writeData:udpPacketData withTimeout:-1 tag:tag];

}


/**
 *  传输项目完成
 *
 *  @param commandType   命令类型
 *  @param sendType      发送类型
 *  @param contentBytes  内容byte数组
 *  @param contentLength 内容长度
 *  @param pageNumber    页码
 */
-(void)commandCompleteWithType:(Byte)commandType andSendType:(Byte)sendType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength andPageNumber:(NSInteger)pageNumber
{
    int byteLength = 7;
    if (sendType == 0x01 ) {
        byteLength = 11 + contentLength;
    }
    DLog(@"byteLength = %d",byteLength);
    Byte outdate[byteLength];
    memset(outdate, 0x00, byteLength);
    outdate[0]=0x7D;
    outdate[1]=commandType;//命令类型
    outdate[2]=0x03; //传输数据到客户端
    outdate[3]=sendType;

    if (sendType == 0x01) {
//        DLog(@"pageNumber = %d",pageNumber);
        pageNumber = pageNumber + 1;
        outdate[4]=(Byte)pageNumber;
        outdate[5]=(Byte)(pageNumber>>8);
        outdate[6]=(Byte)(pageNumber>>16);
        outdate[7]=(Byte)(pageNumber>>24);
        for (int i=0; i<contentLength; i++) {
            outdate[i+8]=contentBytes[i];
        }
    }
    outdate[byteLength-3]=(Byte)byteLength;
    outdate[byteLength-2]=(Byte)(byteLength>>8);
    int sumByte = 0;
    for (int j=0; j<(byteLength-1); j++) {
        sumByte += outdate[j];
    }
    //校验码计算（包头到校验码前所有字段求和取反+1）
    outdate[(byteLength-1)]=~(sumByte)+1;
    long tag = outdate[1];
    NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:byteLength];
    if (pageNumber==TAG_MAX_NUMBER) {
        DLog(@"发送文件数据传输完成命令");
    }
    DLog(@"udpPacketData = %@",udpPacketData);
    [_sendPlayerSocket writeData:udpPacketData withTimeout:-1 tag:tag];
}


/**
 *  启动网络连接
 */
-(void)startSocket{
//    if (!_sendPlayerSocket) {
        _sendPlayerSocket = [[AsyncSocket alloc] initWithDelegate:self];
//    }
    DLog(@"ipAddressString = %@",ipAddressString);
    if (ipAddressString) {
        DLog(@"ipaddress = %@",ipAddressString);
        if (!isConnect) {
            isConnect = [_sendPlayerSocket connectToHost:ipAddressString onPort:PORT_OF_TRANSCATION_PLAY error:nil];
            [_sendPlayerSocket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
            if (!isConnect) {
                DLog(@"连接失败");
            }else{
                DLog(@"连接成功");
            }
        }
    }else{
        isConnect = NO;
        DLog(@"ipaddress is null");
    }


    //初始化数据仓库
    if (!_currentDataArray) {
        _currentDataArray = [[NSMutableArray alloc]init];
    }


    //发送索引
    _currentDataAreaIndex = 0;
}



/**
 *  发送配置文件
 *
 *  @param filePath 文件路径
 *  @param fielLength 文件长度
 */
-(void)sendProjectConfigToServer:(NSString*)filePath andFileLength:(NSInteger)fielLength{


    //通过流打开一个文件
    NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath:filePath];
    [inputStream open];

    //缓冲区大小
    NSInteger maxLength = 1000;
    uint8_t readBuffer[maxLength];
    memset(readBuffer, 0, maxLength);
    //是否已经到结尾标识
    BOOL endOfStreamReached = NO;
    [_currentDataArray removeAllObjects];
    while (! endOfStreamReached)
    {
        NSInteger bytesRead = [inputStream read:readBuffer maxLength:maxLength];
        if (bytesRead == 0)
        {//文件读取到最后
            endOfStreamReached = YES;
            DLog(@"文件读取到最后 sendProjectConfigToServer");

        }
        else if (bytesRead == -1)
        {//文件读取错误
            endOfStreamReached = YES;
            DLog(@"文件读取错误 sendProjectConfigToServer");

        }
        else
        {

            NSData *tempData = [[NSData alloc]initWithBytes:readBuffer length:bytesRead];
            [_currentDataArray addObject:tempData];

        }
    }
    [inputStream close];
    [inputStream release];
}


//创建多屏同步的xml
-(void)LEDsxml:(NSString *)strip andiparray:(NSMutableArray *)ipselectarray
{

    
    
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"ip"];
    
    //    主屏ip
    //    GDataXMLElement *mainele = [GDataXMLNode elementWithName:@"mainip" stringValue:strip];
    
    //    [rootElement addChild:mainele];
    
    GDataXMLElement *numberip = [GDataXMLNode elementWithName:@"numberip"];
    
    GDataXMLElement *explanation = [GDataXMLNode elementWithName:@"explanation"];
    [numberip addChild:explanation];
    GDataXMLElement *NUM = [GDataXMLNode elementWithName:@"num" stringValue:[NSString stringWithFormat:@"%lu",(unsigned long)ipselectarray.count]];
    [numberip addChild:NUM];
    
    
    [rootElement addChild:numberip];
    
    
    
    for (int i = 0; i<ipselectarray.count; i++) {
        if (![ipselectarray[i] isEqualToString:mianipscrenn]) {
            GDataXMLElement *play = [GDataXMLNode elementWithName:@"play"];
            GDataXMLElement *explanation = [GDataXMLNode elementWithName:@"explanation"];
            [play addChild:explanation];
            
            GDataXMLElement *data = [GDataXMLNode elementWithName:@"data" stringValue:ipselectarray[i]];
            
            [play addChild:data];
            
            [rootElement addChild:play];
        }
    }
    
    
    //    本地用的
    for (int k=0; k<ipselectarray.count; k++) {
        GDataXMLElement *lastset = [GDataXMLNode elementWithName:@"lastset"];
        GDataXMLElement *name = [GDataXMLNode elementWithName:@"name" stringValue:ipselectarray[k]];
        GDataXMLElement *ipa = [GDataXMLNode elementWithName:@"ip" stringValue:ipselectarray[k]];
        NSString *mian = @"0";
        if ([ipselectarray[k] isEqualToString:mianipscrenn]) {
            mian = @"1";
        }
        GDataXMLNode *ismain = [GDataXMLNode elementWithName:@"ismain" stringValue:mian];
        [lastset addChild:name];
        [lastset addChild:ipa];
        [lastset addChild:ismain];
//        [rootElement addChild:lastset];
        
    }
    
    
    
    
    //使用根节点创建xml文档
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    DLog(@"11111%@",rootDoc);
    //设置使用的xml版本号
    [rootDoc setVersion:@"1.0"];
    //设置xml文档的字符编码
    [rootDoc setCharacterEncoding:@"utf-8"];
    //获取并打印xml字符串
    NSString *XMLDocumentString = [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    DLog(@"22%@",XMLDocumentString);
    //文件字节大小
    fileSize = [rootDoc.XMLData length];
    DLog(@"%ld",(long)fileSize);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    xmlfilePath = [[NSString alloc]initWithFormat:@"%@/ip.xml",documentsDirectoryPath];
    NSError *error = nil;
    BOOL writeFileBool = [XMLDocumentString writeToFile:xmlfilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSArray *files = [fileManager subpathsAtPath: documentsDirectoryPath];
    NSLog(@"%@",files);
    NSDictionary * dict = [fileManager attributesOfItemAtPath:xmlfilePath error:nil];
    //方法一:
    
    NSLog(@"ftpxml的地址 = %@",xmlfilePath);
    
    if (writeFileBool) {
        isLEDS = YES;
        //        isConnect = NO;
        //        [self startSocket];
        [self ftpuser2:strip];
    }

}

/**
 *  创建需要传送给服务端的文件
 */
-(BOOL)createXMLFileWithDictionary:(NSDictionary*)myDict andSavePath:(NSString *)savePath andEdit:(BOOL)isEditXML{

    @try {
        if ((!myDict)||(![myDict isKindOfClass:[NSDictionary class]])) {
            return NO;
        }
        
        DLog(@"创建xml");
        //创建根节点
        GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"project"];

        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithDictionary:myDict];

        //创建项目名称节点
        NSString *proejctName = [tempDictionary objectForKey:@"projectName"];
        GDataXMLElement *projectNameElement = [GDataXMLNode elementWithName:@"projectName" stringValue:proejctName];
        //添加子节点到根节点上
        [rootElement addChild:projectNameElement];
        [tempDictionary removeObjectForKey:@"projectName"];

        //创建文本节点
        GDataXMLElement *textElement = [GDataXMLNode elementWithName:@"text"];

        NSDictionary *textItemDict = [tempDictionary objectForKey:@"text"];
        //文本
        NSString *textContent = [textItemDict objectForKey:@"textContent"];
        GDataXMLElement *textContentElement = [GDataXMLNode elementWithName:@"textContent" stringValue:textContent];
        [textElement addChild:textContentElement];
        //文本颜色
        //R
        NSString *textRColor = [textItemDict objectForKey:@"textRColor"];
        float trcFloat = [textRColor floatValue];
        int trcInt = trcFloat*255;

        GDataXMLElement *textRColorElement = [GDataXMLNode elementWithName:@"textRColor" stringValue:[NSString stringWithFormat:@"%d",trcInt]];
        [textElement addChild:textRColorElement];
        //G
        NSString *textGColor = [textItemDict objectForKey:@"textGColor"];
        float tgcFloat = [textGColor floatValue];
        int tgcInt = tgcFloat*255;
        GDataXMLElement *textGColorElement = [GDataXMLNode elementWithName:@"textGColor" stringValue:[NSString stringWithFormat:@"%d",tgcInt]];
        [textElement addChild:textGColorElement];
        //B

        NSString *textBColor = [textItemDict objectForKey:@"textBColor"];
        float tbcFloat = [textBColor floatValue];
        int tbcInt = tbcFloat*255;
        GDataXMLElement *textBColorElement = [GDataXMLNode elementWithName:@"textBColor" stringValue:[NSString stringWithFormat:@"%d",tbcInt]];
        [textElement addChild:textBColorElement];
        //文本背景颜色
        //R
        NSString *textBackgroundRColor = [textItemDict objectForKey:@"textBackgroundRColor"];
        float trbcFloat = [textBackgroundRColor floatValue];
        int trbcInt = trbcFloat*255;
        GDataXMLElement *textBackgroundRColorElement = [GDataXMLNode elementWithName:@"textBackgroundRColor" stringValue:[NSString stringWithFormat:@"%d",trbcInt]];
        [textElement addChild:textBackgroundRColorElement];
        //G
        NSString *textBackgroundGColor = [textItemDict objectForKey:@"textBackgroundGColor"];
        float tgbcFloat = [textBackgroundGColor floatValue];
        int tgbcInt = tgbcFloat*255;
        GDataXMLElement *textBackgroundGColorElement = [GDataXMLNode elementWithName:@"textBackgroundGColor" stringValue:[NSString stringWithFormat:@"%d",tgbcInt]];
        [textElement addChild:textBackgroundGColorElement];
        //B
        NSString *textBackgroundBColor = [textItemDict objectForKey:@"textBackgroundBColor"];
        float tbbcFloat = [textBackgroundBColor floatValue];
        int tbbcInt = tbbcFloat*255;
        GDataXMLElement *textBackgroundBColorElement = [GDataXMLNode elementWithName:@"textBackgroundBColor" stringValue:[NSString stringWithFormat:@"%d",tbbcInt]];
        [textElement addChild:textBackgroundBColorElement];
        //Alpha
        NSString *textBackgroundAlpha = [textItemDict objectForKey:@"textBackgroundAlpha"];
        GDataXMLElement *textBackgroundAlphaElement = [GDataXMLNode elementWithName:@"textBackgroundAlpha" stringValue:textBackgroundAlpha];
        [textElement addChild:textBackgroundAlphaElement];
        //字体大小
        NSString *textFontSize = [textItemDict objectForKey:@"textFontSize"];
        GDataXMLElement *textFontSizeElement = [GDataXMLNode elementWithName:@"textFontSize" stringValue:textFontSize];
        [textElement addChild:textFontSizeElement];
        //字体名称
        NSString *textFontName = [textItemDict objectForKey:@"textFontName"];
        GDataXMLElement *textFontNameElement = [GDataXMLNode elementWithName:@"textFontName" stringValue:textFontName];
        [textElement addChild:textFontNameElement];
        //文字滚动速度
        NSString *textRollingSpeed = [textItemDict objectForKey:@"textRollingSpeed"];
        GDataXMLElement *textRollingSpeedElement = [GDataXMLNode elementWithName:@"textRollingSpeed" stringValue:textRollingSpeed];
        [textElement addChild:textRollingSpeedElement];
        //文字区域的原点X
        NSString *textRegionX = [textItemDict objectForKey:@"textX"];
        GDataXMLElement *textRegionXElement = [GDataXMLNode elementWithName:@"textX" stringValue:textRegionX];
        [textElement addChild:textRegionXElement];
        //文字区域的原点Y
        NSString *textRegionY = [textItemDict objectForKey:@"textY"];
        GDataXMLElement *textRegionYElement = [GDataXMLNode elementWithName:@"textY" stringValue:textRegionY];
        [textElement addChild:textRegionYElement];
        //文字区域的宽度
        NSString *textRegionW = [textItemDict objectForKey:@"textW"];
        GDataXMLElement *textRegionWElement = [GDataXMLNode elementWithName:@"textW" stringValue:textRegionW];
        [textElement addChild:textRegionWElement];
        //文字区域的高度
        NSString *textRegionH = [textItemDict objectForKey:@"textH"];
        GDataXMLElement *textRegionHElement = [GDataXMLNode elementWithName:@"textH" stringValue:textRegionH];
        [textElement addChild:textRegionHElement];

        [rootElement addChild:textElement];
        [tempDictionary removeObjectForKey:@"text"];


        //屏体的尺寸
        //创建屏体的尺寸节点
        GDataXMLElement *masterScreenFrameElement = [GDataXMLNode elementWithName:@"masterScreenFrame"];

        NSDictionary *masterScreenFrameDict = [tempDictionary objectForKey:@"masterScreenFrame"];
        //X
        NSString *masterScreenX = [masterScreenFrameDict objectForKey:@"masterScreenX"];
        GDataXMLElement *masterScreenXElement = [GDataXMLElement elementWithName:@"masterScreenX" stringValue:masterScreenX];
        [masterScreenFrameElement addChild:masterScreenXElement];
        //Y
        NSString *masterScreenY = [masterScreenFrameDict objectForKey:@"masterScreenY"];
        GDataXMLElement *masterScreenYElement = [GDataXMLElement elementWithName:@"masterScreenY" stringValue:masterScreenY];
        [masterScreenFrameElement addChild:masterScreenYElement];
        //W
        NSString *masterScreenW = [masterScreenFrameDict objectForKey:@"masterScreenW"];
        GDataXMLElement *masterScreenWElement = [GDataXMLElement elementWithName:@"masterScreenW" stringValue:masterScreenW];
        [masterScreenFrameElement addChild:masterScreenWElement];
        //H
        NSString *masterScreenH = [masterScreenFrameDict objectForKey:@"masterScreenH"];
        GDataXMLElement *masterScreenHElement = [GDataXMLElement elementWithName:@"masterScreenH" stringValue:masterScreenH];
        [masterScreenFrameElement addChild:masterScreenHElement];
        [rootElement addChild:masterScreenFrameElement];
        //删除屏体的尺寸
        [tempDictionary removeObjectForKey:@"masterScreenFrame"];

        //音频
        NSDictionary *projectMusicElementDict = [tempDictionary objectForKey:@"projectMusicElement"];
        if (projectMusicElementDict) {
            if ([projectMusicElementDict isKindOfClass:[NSDictionary class]]) {
                GDataXMLElement *projectMusicElement = [GDataXMLNode elementWithName:@"projectMusicElement"];
                //名称
                NSString *musicN = [projectMusicElementDict objectForKey:@"musicName"];
                GDataXMLElement *musicNameElement = [GDataXMLElement elementWithName:@"musicName" stringValue:musicN];
                [projectMusicElement addChild:musicNameElement];

                NSString *musicD = [projectMusicElementDict objectForKey:@"musicDuration"];
                GDataXMLElement *musicDurationElement = [GDataXMLElement elementWithName:@"musicDuration" stringValue:musicD];
                [projectMusicElement addChild:musicDurationElement];

                NSString *musicVo = [projectMusicElementDict objectForKey:@"musicVolume"];
                GDataXMLElement *musicVolumeElement = [GDataXMLElement elementWithName:@"musicVolume" stringValue:musicVo];
                [projectMusicElement addChild:musicVolumeElement];

                [rootElement addChild:projectMusicElement];
                [tempDictionary removeObjectForKey:@"projectMusicElement"];
            }
        }


        //素材列表
        NSDictionary *materialDictionary = [tempDictionary objectForKey:@"materiallist"];
        if (materialDictionary&&([materialDictionary isKindOfClass:[NSDictionary class]]&&([[materialDictionary allKeys] count]>0))) {
            //排序key
            NSArray *allTempKeyArray = [materialDictionary allKeys];
            allTempKeyArray = [self sortedArrayWithArray:allTempKeyArray];

            for (NSString *oneKey1 in allTempKeyArray) {
                //创建素材列表节点
                GDataXMLElement *materialListElement = [GDataXMLNode elementWithName:@"materialListElement"];
                GDataXMLElement *selectAreaIndexElement = [GDataXMLElement elementWithName:@"key" stringValue:oneKey1];
                [materialListElement addChild:selectAreaIndexElement];

                NSDictionary *itemListDictionary = [materialDictionary objectForKey:oneKey1];
                NSArray *allTempKeyArray1 = [itemListDictionary allKeys];
                allTempKeyArray1 = [self sortedArrayWithArray:allTempKeyArray1];
                for (NSString *oneKey in allTempKeyArray1) {

                    NSDictionary *oneDictionary = [itemListDictionary objectForKey:oneKey];
                    DLog(@"每个图片 = %@",oneDictionary);

                    GDataXMLElement *listItemElement = [GDataXMLNode elementWithName:@"listItemElement"];
                    //itemIndex
                    GDataXMLElement *itemIndexElement = [GDataXMLElement elementWithName:@"itemIndex" stringValue:oneKey];
                    [listItemElement addChild:itemIndexElement];
                    //duration
                    NSString *duration = [oneDictionary objectForKey:@"duration"];
                    GDataXMLElement *durationElement = [GDataXMLElement elementWithName:@"duration" stringValue:duration];
                    [listItemElement addChild:durationElement];
                    //filename
                    NSString *filename = [oneDictionary objectForKey:@"filepath"];

                    NSString *uploadsuccessmark = [filename lastPathComponent];
                    NSMutableString *bmpextmark = [[NSMutableString alloc]initWithString:uploadsuccessmark];

                    GDataXMLElement *filenameElement = [GDataXMLElement elementWithName:@"filename" stringValue:bmpextmark];
                    [listItemElement addChild:filenameElement];
                    //filetype
                    NSString *filetype = [oneDictionary objectForKey:@"filetype"];
                    GDataXMLElement *filetypeElement = [GDataXMLElement elementWithName:@"filetype" stringValue:filetype];
                    [listItemElement addChild:filetypeElement];
                    //x
                    NSString *x = [oneDictionary objectForKey:@"x"];
                    if (x==nil) {
                        x = @"0";
                    }
                    GDataXMLElement *xElement = [GDataXMLElement elementWithName:@"x" stringValue:x];
                    [listItemElement addChild:xElement];
                    //y
                    NSString *y = [oneDictionary objectForKey:@"y"];
                    if (y==nil) {
                        y = @"0";
                    }
                    GDataXMLElement *yElement = [GDataXMLElement elementWithName:@"y" stringValue:y];
                    [listItemElement addChild:yElement];
                    //w
                    NSString *w = [oneDictionary objectForKey:@"w"];
                    if (w==nil) {
                        w = @"160";
                    }
                    GDataXMLElement *wElement = [GDataXMLElement elementWithName:@"w" stringValue:w];
                    [listItemElement addChild:wElement];
                    //h
                    NSString *h = [oneDictionary objectForKey:@"h"];
                    if (h==nil) {
                        h = @"640";
                    }
                    GDataXMLElement *hElement = [GDataXMLElement elementWithName:@"h" stringValue:h];
                    [listItemElement addChild:hElement];
                    //direction图片运动的方向
                    NSString *direction = [oneDictionary objectForKey:@"direction"];
                    if (direction==nil) {
                        direction = @"0";
                    }
                    GDataXMLElement *directionElement = [GDataXMLElement elementWithName:@"direction" stringValue:direction];
                    [listItemElement addChild:directionElement];

                    //图片运动的角度
                    NSString *fangleString = [[NSString alloc]initWithFormat:@"%d",fangle];
                    if (fangleString==nil) {
                        fangleString = @"0";
                    }
                    GDataXMLElement *angleElement = [GDataXMLElement elementWithName:@"angle" stringValue:fangleString];
                    [listItemElement addChild:angleElement];

                    //图片是否透明
                    NSString *alphaString = [oneDictionary objectForKey:@"alpha"];
                    if (alphaString==nil) {
                        alphaString = @"0";
                    }
                    if (![alphaString isKindOfClass:[NSString class]]) {
                        alphaString = @"0";
                    }
                    GDataXMLElement *alphaElement = [GDataXMLElement elementWithName:@"alpha" stringValue:alphaString];
                    [listItemElement addChild:alphaElement];
                    
                    [materialListElement addChild:listItemElement];
                }
                [rootElement addChild:materialListElement];
            }
        }else{
            //XML文件名
            NSString *sXmlFileName =  [savePath lastPathComponent];
            //项目文件夹的路径
            NSString *sProjectDirPath = [savePath stringByReplacingOccurrencesOfString:sXmlFileName withString:@""];
            
            [rootElement addChild:[self createVideoNodeWithProDir:sProjectDirPath]];

        }

        //使用根节点创建xml文档
        GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
        //设置使用的xml版本号
        [rootDoc setVersion:@"1.0"];
        //设置xml文档的字符编码
        [rootDoc setCharacterEncoding:@"utf-8"];
        //获取并打印xml字符串
        NSString *XMLDocumentString = [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
        //文件字节大小
        fileSize = [rootDoc.XMLData length];
        xmlfilePath = [[NSString alloc]initWithFormat:@"%@",savePath];
        NSError *error = nil;
        DLog(@"素材的xml＝＝＝＝＝＝%@",XMLDocumentString);

        BOOL writeFileBool = [XMLDocumentString writeToFile:xmlfilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        return writeFileBool;
    }
    @catch (NSException *exception) {
        return NO;
        DLog(@"保存配置文件为xml出错；exception = %@", exception);
    }
    @finally {

    }
}

-(GDataXMLElement *)createVideoNodeWithProDir:(NSString *)sProDir{
    //创建素材列表节点

    GDataXMLElement *materialListElement = [GDataXMLNode elementWithName:@"materialListElement"];

    GDataXMLElement *selectAreaIndexElement = [GDataXMLElement elementWithName:@"key" stringValue:@"1004"];

    [materialListElement addChild:selectAreaIndexElement];



    GDataXMLElement *listItemElement = [GDataXMLNode elementWithName:@"listItemElement"];

    //itemIndex

    GDataXMLElement *itemIndexElement = [GDataXMLElement elementWithName:@"itemIndex" stringValue:@"item0"];

    [listItemElement addChild:itemIndexElement];

    //duration

    NSString *duration = [[NSString alloc]initWithFormat:@"%lf",globalDuration];

    GDataXMLElement *durationElement = [GDataXMLElement elementWithName:@"duration" stringValue:duration];

    [listItemElement addChild:durationElement];

//    NSString * nsALAssetPropertyType = [photoasset valueForProperty:ALAssetPropertyType];

    
    //文件名
    NSString *sFileName = [globalsVideoPath lastPathComponent];

    
    
    
    
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSError *moveFileError = nil;
    //需要移动到文件夹里的文件
    NSString *sDist = [sProDir stringByAppendingString:sFileName];
    
    BOOL moveResult = [fileMgr moveItemAtPath:globalsVideoPath toPath:sDist error:&moveFileError];
    
    if (!moveResult) {
        DLog(@"错误信息 = %@",moveFileError);
    }

    GDataXMLElement *filenameElement = [GDataXMLElement elementWithName:@"filename" stringValue:sFileName];

    [listItemElement addChild:filenameElement];

    //文件类型

    NSString *filetype = @"Video";
    
    GDataXMLElement *filetypeElement = [GDataXMLElement elementWithName:@"filetype" stringValue:filetype];

    

    
    [listItemElement addChild:filetypeElement];

    //x

    NSString *x = @"0";

    GDataXMLElement *xElement = [GDataXMLElement elementWithName:@"x" stringValue:x];

    [listItemElement addChild:xElement];

    //y

    NSString *y = @"0";

    GDataXMLElement *yElement = [GDataXMLElement elementWithName:@"y" stringValue:y];

    [listItemElement addChild:yElement];

    //w

    NSString *w = @"160";

    GDataXMLElement *wElement = [GDataXMLElement elementWithName:@"w" stringValue:w];

    [listItemElement addChild:wElement];

    //h

    NSString *h = @"640";

    GDataXMLElement *hElement = [GDataXMLElement elementWithName:@"h" stringValue:h];

    [listItemElement addChild:hElement];



    //direction图片运动的方向

    NSString *direction = @"0";

    GDataXMLElement *directionElement = [GDataXMLElement elementWithName:@"direction" stringValue:direction];

    [listItemElement addChild:directionElement];



    //图片运动的角度

    NSString *fangleString = @"0";

    GDataXMLElement *angleElement = [GDataXMLElement elementWithName:@"angle" stringValue:fangleString];

    [listItemElement addChild:angleElement];



    //帧截取数据  视频的数据

    GDataXMLElement *video_frame_listElement = [GDataXMLNode elementWithName:@"video_frame_list"];

    NSArray *arrKeys = [globalDictFramesInfo allKeys];

    
    
    arrKeys = [arrKeys sortedArrayUsingSelector:@selector(compare:)];
    DLog(@"arrkeys＝＝＝＝%@",arrKeys);

    for (NSString *sKey in arrKeys) {

        GDataXMLElement *frameElement = [GDataXMLNode elementWithName:@"frame"];



        YXM_VideoFrameActionObject *fObj = [globalDictFramesInfo objectForKey:sKey];

        GDataXMLElement *fiElement = [GDataXMLElement elementWithName:@"i" stringValue:sKey];

        [frameElement addChild:fiElement];

        GDataXMLElement *fxElement = [GDataXMLElement elementWithName:@"x" stringValue:[NSString stringWithFormat:@"%d",fObj.x]];

        [frameElement addChild:fxElement];

        GDataXMLElement *fyElement = [GDataXMLElement elementWithName:@"y" stringValue:[NSString stringWithFormat:@"%d",fObj.y]];

        [frameElement addChild:fyElement];

        GDataXMLElement *fwElement = [GDataXMLElement elementWithName:@"w" stringValue:[NSString stringWithFormat:@"%d",fObj.w]];

        [frameElement addChild:fwElement];

        GDataXMLElement *fhElement = [GDataXMLElement elementWithName:@"h" stringValue:[NSString stringWithFormat:@"%d",fObj.h]];
        
        [frameElement addChild:fhElement];

        float ffobjsw = fObj.sw;
        if (!fObj.sw) {
            ffobjsw = 1;
        }
        NSString *fobjsw = [[NSString alloc]initWithFormat:@"%0.3lf",ffobjsw];
        GDataXMLElement *swElement = [GDataXMLElement elementWithName:@"sw" stringValue:fobjsw];

        [frameElement addChild:swElement];

        float ffobjsh = fObj.sh;
        if (!fObj.sh) {
            ffobjsh = 1;
        }
        NSString *fobjsh = [[NSString alloc]initWithFormat:@"%0.3lf",ffobjsh];
        GDataXMLElement *shElement = [GDataXMLElement elementWithName:@"sh" stringValue:fobjsh];

        [frameElement addChild:shElement];
        
        [video_frame_listElement addChild:frameElement];
        
    }
    if (arrKeys.count==0) {
        
        GDataXMLElement *frameElement = [GDataXMLNode elementWithName:@"frame"];
        GDataXMLElement *fiElement = [GDataXMLElement elementWithName:@"i" stringValue:@"1"];
        [frameElement addChild:fiElement];
        GDataXMLElement *fxElement = [GDataXMLElement elementWithName:@"x" stringValue:[NSString stringWithFormat:@"%d",0]];
        [frameElement addChild:fxElement];
        GDataXMLElement *fyElement = [GDataXMLElement elementWithName:@"y" stringValue:[NSString stringWithFormat:@"%d",0]];
        [frameElement addChild:fyElement];
        GDataXMLElement *fwElement = [GDataXMLElement elementWithName:@"w" stringValue:[NSString stringWithFormat:@"%d",160]];
        [frameElement addChild:fwElement];
        GDataXMLElement *fhElement = [GDataXMLElement elementWithName:@"h" stringValue:[NSString stringWithFormat:@"%d",640]];
        [frameElement addChild:fhElement];
        GDataXMLElement *swElement = [GDataXMLElement elementWithName:@"sw" stringValue:@"1"];
        [frameElement addChild:swElement];
        GDataXMLElement *shElement = [GDataXMLElement elementWithName:@"sh" stringValue:@"1"];
        [frameElement addChild:shElement];
        [video_frame_listElement addChild:frameElement];

    }
    
    
    [listItemElement addChild:video_frame_listElement];
    
    
    
    [materialListElement addChild:listItemElement];
    
    
    
    return materialListElement;
}



/**
 *  停止播放音频
 */
-(void)stopMusicPicker{
    [myMusicPicker stopMusicPlayer];
}

/**
 *  删除播放项目
 */
-(void)deletePlayProject:(NSString *)projectName{
    @try {
        //停止音频
        [self stopMusicPicker];

        if ([currentPlayProObject.project_list_type isEqualToString:IS_GROUP_XML]) {
            [[NSFileManager defaultManager] removeItemAtPath:currentPlayProObject.project_filename error:nil];
            [myProjectCtrl loadProjectList];
        }else{
            if ((!_currentPlayProjectFilename)||([_currentPlayProjectFilename length]<1)) {
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_Pleaseselectanitem"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
                [myAlertView release];
                return;
            }

            //清空项目名称文本框
            [self cleanProjectName];

            //通过项目的文件名找到项目的配置文件，先删除配置文件下管理的资源，最后删除配置文件
            NSString *sXmlFileName =  [_currentPlayProjectFilename lastPathComponent];
            NSString *sProjectDirPath = [[NSString alloc] initWithString:_currentPlayProjectFilename];
            NSString *sProjectDir = [sProjectDirPath stringByReplacingOccurrencesOfString:sXmlFileName withString:@""];

            if (isPlay) {
                [self quitePlayProjAndResetEditer:YES];
            }

            NSFileManager *myFileManager = [NSFileManager defaultManager];
            [myFileManager removeItemAtPath:sProjectDirPath error:nil];
            BOOL deleteFileResult = [myFileManager removeItemAtPath:sProjectDir error:nil];
            if (deleteFileResult) {
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_deleteprojectsuccess"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
                [myAlertView release];
            }else{
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_deleteprojectfailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
                [myAlertView release];
            }
            //重新加载视频播放列表
            [myProjectCtrl reloadMyPlaylist];

            //重置编辑视图
            [self resetEditerViewFrame];

            _currentPlayProjectName = nil;
            _currentPlayProjectFilename = nil;

            //清理资源
            [self cleanEditerResources];

            [myProjectCtrl  shangchu:sProjectDirPath];
        }
    }
    @catch (NSException *exception) {
        DLog(@"删除播放项目数据异常 = %@",exception);
    }
    @finally {
    }
}

/**
 *  退出播放项目
 */
-(void)quitePlayProjAndResetEditer:(BOOL)isResetEditer{
    @try {
        
        UIButton *sender = (UIButton *)[self.view viewWithTag:922];
        sender.hidden = !isResetEditer;
        

        
        NSInteger masterScreenHeight = self.view.frame.size.width - 46;
        CGRect rectMasterView = CGRectMake(5, NAVIGATION_BAR_HEIGHT+1, SCREEN_CGSIZE_2HEIGHT-320 - 10, masterScreenHeight);

        if (OS_VERSION_FLOAT>7.9) {
            masterScreenHeight = self.view.frame.size.height-46;
            rectMasterView = CGRectMake(5, NAVIGATION_BAR_HEIGHT+1, SCREEN_CGSIZE_2WIDTH-320 - 10, masterScreenHeight);
        }

        UIScrollView *masterView = (UIScrollView*)[self.view viewWithTag:TAG_MASTER_SCREEN_VIEW];
        [masterView setFrame:rectMasterView];

        isPlay = NO;
        //停止播放音频
        [self stopMusicPicker];
        //清理滚动图片的定时器
        [self clearAllTimer];

        //停止视频播放器
        [_myVideoPlayer pause];
        if (_myVideoPlayer) {
            [_myVideoPlayerLayer removeFromSuperlayer];
        }
        _myVideoPlayer = nil;

        [self clearMaskView];

        //清理滚动文字
        JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
        [ticker setTickerStrings:[[NSArray alloc]initWithObjects:@"", nil]];
        [ticker setHidden:YES];


        for (UIView *oneView in self.evaluateViews) {
            UIImageView *tempImageView = (UIImageView*)[self.view viewWithTag:(TAG_IMAGE_VIEW+oneView.tag)];
            [tempImageView setImage:nil];
        }

        [movewController stop];
        [movewController setContentURL:nil];
        [movewController.view removeFromSuperview];

        //退出播放按钮是否隐藏
        [self setHiddenQuitPlayButton:YES];

        //隐藏非播放区域
        [self hiddenNoPlayArea:NO];

        if (isResetEditer) {
            //重置编辑视图
            [self resetEditerViewFrame];
            //清理编辑时使用过的资源
            [self cleanEditerResources];
        }

        //清空项目名称文本框
        [self cleanProjectName];
        //清空前景
        UIImageView *oldImageView = (UIImageView*)[self.view viewWithTag:TAG_BEFORE_IMAGEVIEW];
        [oldImageView removeFromSuperview];

        [[self.view viewWithTag:TAG_BLACK_SHADE_VIEW] removeFromSuperview];

        [self deletViewWithKey:1006];
    }
    @catch (NSException *exception) {
        DLog(@"exception = %@",exception);
    }
    @finally {

    }
}

/**
 *  获得当前时间组成的字符串
 *
 *  @return 当前时间组成的字符串
 */
-(NSString *)getNowdateString{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    return [formatter stringFromDate:[NSDate date]];
}

/**
 * 保存播放项目  保存播放素材
 *
 */
-(BOOL)saveProjectWithProjectName:(NSString *)psProjectName andProjectXMLFilePath:(NSString *)psProjectXMLFilePath{
    @try {
        if (!_projectMaterialDictionary || (![_projectMaterialDictionary isKindOfClass:[NSMutableDictionary class]]) || ([[_projectMaterialDictionary allKeys] count]<1)) {
            NSString * nsALAssetPropertyType = [photoasset valueForProperty:ALAssetPropertyType];

            if ((!globalDictFramesInfo)||(![globalDictFramesInfo isKindOfClass:[NSMutableDictionary class]])) {
                //视频判断
                if ([nsALAssetPropertyType isEqualToString:@"ALAssetTypeVideo"]) {
                    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_Projectcannotbeempty"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                    [myAlertView show];
                    [myAlertView release];
                    return NO;

                }
            }
        }

        if (!psProjectName) {
            DLog(@"项目名称不能为空");
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_Projectnamecannotbeempty"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            return NO;
        }



        //项目文件夹的名称
        NSString *sProjectDir = nil;
        //项目存放根目录
        NSString *sProjectRootPath = nil;
        //项目文件夹的路径
        NSString *sProjectDirPath = nil;
        //项目的XML文件的路径
        NSString *sProjectXmlFilePath = nil;

        //项目存放根目录
        sProjectRootPath = [LayoutYXMViewController defaultProjectRootPath];
        if (isEditProject) {
            //如果是编辑项目的状态

            //XML文件名
            NSString *sXmlFileName =  [psProjectXMLFilePath lastPathComponent];
            //项目文件夹的路径
            sProjectDirPath = [psProjectXMLFilePath stringByReplacingOccurrencesOfString:sXmlFileName withString:@""];
            //项目的XML文件的路径
            sProjectXmlFilePath = psProjectXMLFilePath;
        }else{
            //项目文件夹
            sProjectDir = [[NSString alloc]initWithFormat:@"%@%@",psProjectName,[self getNowdateString]];
            
            sProjectDir = [sProjectDir md5Encrypt];

            //如果项目名称为空，则使用当前时间字符串代替
            if (!psProjectName) {

                psProjectName = [self getNowdateString];
            }

            //项目文件夹的路径
            sProjectDirPath = [self customeProjectDirPathWith:sProjectDir];
            //项目的XML文件的路径
            sProjectXmlFilePath = [self customeXMLFilePathWithProjectDir:sProjectDir];
        }

        NSMutableDictionary *playListDictionary = [[NSMutableDictionary alloc] init];
        //项目名称
        [playListDictionary setObject:[NSString stringWithFormat:@"%@",psProjectName] forKey:@"projectName"];

        //加入主屏幕的坐标与宽高信息
        NSDictionary *masterScreenDict = [self createMasterScreenDictionary];
        if (masterScreenDict) {
            [playListDictionary setObject:masterScreenDict forKey:@"masterScreenFrame"];
        }else{
            return NO;
        }

        //加入可编辑区域素材列表的字典
        NSDictionary *materialDictionary = [self createMaterialInfoDictionaryWithProjectDirPath:sProjectDirPath];
        if (materialDictionary) {
            [playListDictionary setObject:materialDictionary forKey:@"materiallist"];
        }else{
            if ((!globalDictFramesInfo)||(![globalDictFramesInfo isKindOfClass:[NSMutableDictionary class]])) {
                return NO;
            }
        }

        //加入滚动文字的字典
        NSDictionary *oneTextDict = [self createTextInfoDictionary];
        if (oneTextDict) {
            [playListDictionary setObject:oneTextDict forKey:@"text"];
        }

        //加入音频文件信息的字典
        NSDictionary *musicInfoDict = [self createMusicInfoDictionary];
        if (musicInfoDict) {
            [playListDictionary setObject:musicInfoDict forKey:@"projectMusicElement"];
            //移动音乐文件
            [self moveMusicFileToProjectDirWithFilePath:_musicFilePath AndProjectDirPath:sProjectDirPath];
        }
        
        
        DLog(@"playListDictionary===%@",playListDictionary);
        //从字典中创建xml文件
        BOOL createXMLResult = [self createXMLFileWithDictionary:playListDictionary andSavePath:sProjectXmlFilePath andEdit:YES];
        if (createXMLResult) {
            //刷新项目列表
            [myProjectCtrl reloadMyPlaylist];

            //清空项目名称文本框
            [self cleanProjectName];

            //清理编辑时使用过的资源
            [self cleanEditerResources];

            //提示项目保存成功
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_projectsavesuccess"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            pname=@"";
            [myAlertView show];
            [myAlertView release];
            
            
            //保存到数据里面
            NSUserDefaults *mysqlarray = [NSUserDefaults standardUserDefaults];
            NSArray *_numarray = [mysqlarray objectForKey:@"mysqlprojects"];
            
            NSMutableArray *_yunsi = [[NSMutableArray alloc]initWithArray:_numarray];
            
            if (_yunsi.count==0) {
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                [dic setObject:[Config DPLocalizedString:@"adedit_Notgrouped"] forKey:@"name"];
                NSMutableArray *arr = [[NSMutableArray alloc]init];
                
                [dic setObject:arr forKey:@"myproject"];
                
                [_yunsi addObject:dic];
                
            }
            
            NSLog(@"=====%@",_yunsi);
            //
            NSDictionary *dic = _yunsi[0];
            
            NSArray *arr = dic[@"myproject"];
            
            
            NSMutableArray *nextarr = [NSMutableArray arrayWithArray:arr];
            
            
            
            NSLog(@"woyaode======%@",[sProjectXmlFilePath lastPathComponent]);
            NSString *onestr = [sProjectXmlFilePath lastPathComponent];
            //        新数组
            [nextarr addObject:onestr];
            
            NSMutableDictionary *mydic = [[NSMutableDictionary alloc]init];
            [mydic setObject:[Config DPLocalizedString:@"adedit_Notgrouped"] forKey:@"name"];
            [mydic setObject:nextarr forKey:@"myproject"];
            
            [_yunsi replaceObjectAtIndex:0 withObject:mydic];
            
            [mysqlarray removeObjectForKey:@"mysqlprojects"];
            
            [mysqlarray setObject:_yunsi forKey:@"mysqlprojects"];
            
            NSLog(@"woyaode======%@",_yunsi);
            
            [myProjectCtrl addreloadview];
            
            

            
            
            
            
        }else{
            //提示项目保存失败
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_saveprojecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
        }
        return createXMLResult;
    }
    @catch (NSException *exception) {
        return NO;
        DLog(@"Save Project Exception = %@",exception);
    }
    @finally {

    }
}



/**
 *  播放已经选择的图片，单个区域的素材列表的回调方法
 *
 *  @param asset 播放素材，cellIndexPath 播放的索引
 */
-(void)playOneWithALAsset:(NSDictionary *)assetDict cellIndexPath:(NSIndexPath*)cellIndexPath{
    
    _currentSelectRow = cellIndexPath.row;
    MaterialObject *asset = (MaterialObject*)[assetDict objectForKey:@"asset"];
    NSString *stringImagePath = [asset material_path];

    if ([[asset material_type] isEqualToString:@"Photo"]) {
        UIImage *resolutionImage = nil;
        if ([UIImage imageWithContentsOfFile:stringImagePath]) {
            resolutionImage = [UIImage imageWithContentsOfFile:stringImagePath];
        }else{
            NSString *sMaterialRootPath = [MaterialObject createMatrialRootPath];
            stringImagePath = [NSString stringWithFormat:@"%@%@",sMaterialRootPath,stringImagePath];
            resolutionImage = [UIImage imageWithContentsOfFile:stringImagePath];
        }

        //在屏幕中未做任何选中的时候默认使用1004进行设置
        if (_currentSelectIndex == TAG_NO_SELECT_AREA) {
            //提示需要选择屏幕的某个可编辑区域
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_selectaneditregion"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            return;
        }

        UIView *tempView = [self.view viewWithTag:_currentSelectIndex];
        UIImageView *tempImageView = (UIImageView*)[tempView viewWithTag:(TAG_IMAGE_VIEW+tempView.tag)];
        [tempImageView setContentMode:UIViewContentModeTopLeft];
        [tempImageView setImage:resolutionImage];
        DLog(@"tempView.frame.size.width = %lf,tempView.frame.size.height = %lf",tempView.frame.size.width,tempView.frame.size.height);
        
            [tempImageView setFrame:CGRectMake(0, 0, tempView.frame.size.width,tempView.frame.size.height)];



    }

}

/**
 *  供定时器调用来播放图片
 *
 *  @param myTimer 定时器对象需要携带播放的素材的路径
 */
-(void)setImageToLayerDict:(NSTimer*)myTimer{
    @try {
        
        
        
        NSDictionary *tempDictionary = [myTimer userInfo];

        //持续时间
        NSString *durationString = [tempDictionary objectForKey:@"durationString"];
        float iDuration = [durationString floatValue];

        //要播放的图片以及宽高
        NSString *playFilePath = [[NSString alloc]initWithFormat:@"%@%@",_currentProjectPathRoot,[tempDictionary objectForKey:@"filename"]];
        UIImage *resolutionImage = [UIImage imageWithContentsOfFile:playFilePath];
        float widthResolutionImage = resolutionImage.size.width;
        float heightResolutionImage = resolutionImage.size.height;

        //文件类型
        NSString *playFileType = [tempDictionary objectForKey:@"filetype"];

        //获得当前要播放的屏幕的属性
//        NSString *w = [tempDictionary objectForKey:@"w"];
//        NSString *h = [tempDictionary objectForKey:@"h"];
//        NSString *x = [tempDictionary objectForKey:@"x"];
//        NSString *y = [tempDictionary objectForKey:@"y"];

        //屏幕旋转的方向
        NSString *screenRotationAngle = [tempDictionary objectForKey:@"angle"];
        int fScreenRotationAngle = [screenRotationAngle intValue];


        //要播放的素材对应的播放区域的索引
        NSInteger areaIndex = [[tempDictionary objectForKey:@"areaIndex"] intValue];
        if (areaIndex<1000) {
            areaIndex = TAG_NO_SELECT_AREA;
        }

        //层的视图
        UIView *layerView = [self.view viewWithTag:areaIndex];
//        [layerView setFrame:CGRectMake([x intValue], [y intValue], [w intValue], [h intValue])];

        //设置旋转方向
        layerView.transform = CGAffineTransformMakeRotation(DEGRESS_TO_RADIANS(fScreenRotationAngle));
        if (fScreenRotationAngle == 0) {

        }
        if (fScreenRotationAngle >1) {
            [layerView setBounds:CGRectMake(0, 0, widthResolutionImage, heightResolutionImage)];
        }

        //层下面的子视图
        UIImageView *layerOfSubImageView = (UIImageView*)[self.view viewWithTag:(TAG_IMAGE_VIEW+layerView.tag)];
        if ((!layerOfSubImageView)&&(![layerOfSubImageView isKindOfClass:[UIImageView class]])) {
            layerOfSubImageView = [[UIImageView alloc]init];
            [layerOfSubImageView setTag:(TAG_IMAGE_VIEW+layerView.tag)];
            [layerView addSubview:layerOfSubImageView];
        }
        [layerOfSubImageView setContentMode:UIViewContentModeTopLeft];

        //如果播放素材是图片则通过图片路径获得图像对象
        if ([playFileType isEqualToString:@"Photo"]) {
            imageScrollDirection = [tempDictionary objectForKey:@"direction"];
            if (imageScrollDirection == nil) {
                imageScrollDirection = NO_ANIMATION;
            }

            CGRect myImageInitRect1 = CGRectMake(0, 0, widthResolutionImage, heightResolutionImage);
            CGRect distImageInitRect = CGRectMake(0, 0, widthResolutionImage, heightResolutionImage);


            //从左向右
            if ([imageScrollDirection isEqualToString:LEFT_TO_RIGHT]) {
                myImageInitRect1 = CGRectMake(-widthResolutionImage, 0, widthResolutionImage, heightResolutionImage);
                distImageInitRect = CGRectMake(0, 0, widthResolutionImage, heightResolutionImage);
                if (fScreenRotationAngle == 45) {
                    myImageInitRect1 = CGRectMake(-widthResolutionImage, heightResolutionImage, widthResolutionImage, heightResolutionImage);
                    distImageInitRect = CGRectMake(0, 0, widthResolutionImage, heightResolutionImage);
                }
            }
            //从右向左
            if ([imageScrollDirection isEqualToString:RIGHT_TO_LEFT]) {
                myImageInitRect1 = CGRectMake(layerView.frame.size.width, 0, widthResolutionImage, heightResolutionImage);
                distImageInitRect = CGRectMake(layerView.frame.size.width-widthResolutionImage, 0, widthResolutionImage, heightResolutionImage);
                if (fScreenRotationAngle == 45) {
                    myImageInitRect1 = CGRectMake(widthResolutionImage, -heightResolutionImage, widthResolutionImage, heightResolutionImage);
                    distImageInitRect = CGRectMake(0, 0, widthResolutionImage, heightResolutionImage);
                }
            }

            //从上向下
            if ([imageScrollDirection isEqualToString:UP_TO_DOWN]) {
                myImageInitRect1 = CGRectMake(0, -heightResolutionImage, widthResolutionImage, heightResolutionImage);
                distImageInitRect = CGRectMake(0, 0, widthResolutionImage, heightResolutionImage);
                if (fScreenRotationAngle == 45) {
                    myImageInitRect1 = CGRectMake(-widthResolutionImage, -heightResolutionImage, widthResolutionImage, heightResolutionImage);
                    distImageInitRect = CGRectMake(0, 0, widthResolutionImage, heightResolutionImage);
                }
            }

            //从下向上
            if ([imageScrollDirection isEqualToString:DOWN_TO_UP]) {
                myImageInitRect1 = CGRectMake(0, layerView.frame.size.height, widthResolutionImage, heightResolutionImage);
                distImageInitRect = CGRectMake(layerView.frame.size.height-heightResolutionImage, 0, widthResolutionImage, heightResolutionImage);
                if (fScreenRotationAngle == 45) {
                    myImageInitRect1 = CGRectMake(widthResolutionImage, heightResolutionImage, widthResolutionImage, heightResolutionImage);
                    distImageInitRect = CGRectMake(0, 0, widthResolutionImage, heightResolutionImage);
                }
            }


            //背景切换的时候，如果有动画，那么当动画完成的时候上一张才消失
            if ([imageScrollDirection isEqualToString:NO_ANIMATION]) {
                [layerOfSubImageView setImage:resolutionImage];
                [layerOfSubImageView setFrame:distImageInitRect];
            }else{
                [layerOfSubImageView setFrame:myImageInitRect1];
                [layerOfSubImageView setImage:resolutionImage];
                [UIView animateWithDuration:iDuration animations:^{
                    [layerOfSubImageView setFrame:distImageInitRect];
                } completion:^(BOOL finished) {
                }];
            }
            resolutionImage = nil;
        }



        //如果播放素材是视频
        if ([playFileType isEqualToString:@"Video"]) {
            //隐藏或显示控制区域
//            [self hiddenOrShowCtrlView:nil];
            [layerOfSubImageView setImage:nil];
            NSDictionary *dict_video_frame_list = [tempDictionary objectForKey:@"video_frame_list"];
            NSMutableDictionary *dictFramesSubRectInfo = [[NSMutableDictionary alloc]init];
            if (dict_video_frame_list) {
                if ([[dict_video_frame_list objectForKey:@"frame"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dict_frame = [dict_video_frame_list objectForKey:@"frame"];
                    YXM_VideoFrameActionObject *fObj = [[YXM_VideoFrameActionObject alloc]init];

                    NSString *scrubberOffset = [self decimalwithFormat:@"0.000" floatV:[[dict_frame objectForKey:@"i"] floatValue]];
                    [fObj setFrameTimeline:scrubberOffset];
                    [fObj setX:[[dict_frame objectForKey:@"x"] intValue]];
                    [fObj setY:[[dict_frame objectForKey:@"y"] intValue]];
                    [fObj setW:[[dict_frame objectForKey:@"w"] intValue]];
                    [fObj setH:[[dict_frame objectForKey:@"h"] intValue]];

                    
                    [dictFramesSubRectInfo setObject:fObj forKey:scrubberOffset];
                    [fObj release];
                }
                if ([[dict_video_frame_list objectForKey:@"frame"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dict_frame in [dict_video_frame_list objectForKey:@"frame"]) {

                        YXM_VideoFrameActionObject *fObj = [[YXM_VideoFrameActionObject alloc]init];

                        NSString *scrubberOffset = [self decimalwithFormat:@"0.000" floatV:[[dict_frame objectForKey:@"i"] floatValue]];
                        [fObj setFrameTimeline:scrubberOffset];
                        [fObj setX:[[dict_frame objectForKey:@"x"] intValue]];
                        [fObj setY:[[dict_frame objectForKey:@"y"] intValue]];
                        [fObj setW:[[dict_frame objectForKey:@"w"] intValue]];
                        [fObj setH:[[dict_frame objectForKey:@"h"] intValue]];


                        [dictFramesSubRectInfo setObject:fObj forKey:scrubberOffset];
                        [fObj release];
                    }
                }
            }

            UIScrollView *masterView = (UIScrollView*)[self.view viewWithTag:TAG_MASTER_SCREEN_VIEW];

            //获得视频显示的比例
            YXM_VideoFrameActionObject *firstObj = [dictFramesSubRectInfo objectForKey:[[dictFramesSubRectInfo allKeys] firstObject]];

            NSURL *sourceMovieURL = [NSURL fileURLWithPath:playFilePath];
            AVAsset *movieAsset	= [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
            AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
            _myVideoPlayer = [AVPlayer playerWithPlayerItem:playerItem];
            _myVideoPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_myVideoPlayer];

            AVAssetImageGenerator *myImageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:movieAsset];
            myImageGenerator.requestedTimeToleranceBefore = kCMTimeZero;
            myImageGenerator.requestedTimeToleranceAfter = kCMTimeZero;
            myImageGenerator.appliesPreferredTrackTransform = YES;
            CGImageRef myImageRef = [myImageGenerator copyCGImageAtTime:CMTimeMake(1, 1) actualTime:NULL error:nil];
            UIImage *imageFrame = [UIImage imageWithCGImage:myImageRef];

            if (!imageFrame) {
                DLog(@"获取视频第一帧失败");
                return;
            }
            [masterView setFrame:CGRectMake(5, 5, imageFrame.size.width, imageFrame.size.height)];
            float originFrameWidth = imageFrame.size.width;
            float originFrameHeight = imageFrame.size.height;
            //视频源文件的对角线尺寸

            //原视频的宽高比
            float originScale = originFrameWidth/originFrameHeight;
            float originScaleW = masterView.frame.size.width/originFrameWidth;
            float originScaleH = masterView.frame.size.height/originFrameHeight;
            DLog(@"originScale = %lf,originScaleW =%lf,originScaleH =%lf",originScale,originScaleW,originScaleH);

            _myVideoPlayerLayer.frame = CGRectMake(0, 0, masterView.frame.size.width, masterView.frame.size.height);
            //视频源文件的对角线尺寸
            float originDiagonal = [MyTool diagonalCalculateWithA:originFrameWidth andB:originFrameHeight];
            //视频显示区域的对角线尺寸
            float showAreaDiagonal = [MyTool diagonalCalculateWithA:masterView.frame.size.width andB:masterView.frame.size.height];


            if (originDiagonal>showAreaDiagonal) {
                float showAreaWidth = [MyTool widthCalculateWithDiagonal:showAreaDiagonal andhwScale:originScale];
                float showAreaHeight = [MyTool heightCalculateWithDiagonal:showAreaDiagonal andhwScale:originScale];
                masterView.frame = CGRectMake(0, 0, showAreaWidth, showAreaHeight);
            }else{
                masterView.frame = CGRectMake(0, 0, masterView.frame.size.width, masterView.frame.size.height);
            }



            _myVideoPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;

            [masterView.layer addSublayer:_myVideoPlayerLayer];
            [_myVideoPlayer play];

            iParentX = masterView.frame.origin.x;
            iParentY = masterView.frame.origin.y;
            iParentCenterX = masterView.frame.origin.x;
            iParentCenterY = masterView.frame.origin.y;
            [_myVideoPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 120) queue:NULL usingBlock:^(CMTime time) {
                float duration = CMTimeGetSeconds(time);
                NSString *timeKey = [self decimalwithFormat:@"0.000" floatV:duration];

                YXM_VideoFrameActionObject *fObj = [dictFramesSubRectInfo objectForKey:timeKey];

                if (fObj) {
                    [self createMaskViewWithShowRect:CGRectMake( fObj.x , fObj.y , fObj.w , fObj.h ) andParentView:masterView];
                }
                timeKey = nil;
            }];
        }
    }
    @catch (NSException *exception) {
        DLog(@"设置图片的时候报错 = %@",exception);
    }
    @finally {

    }
}

/**
 *  是否隐藏非播放区域和frame显示框
 *
 *  @param isHidden YES/NO
 */
-(void)hiddenNoPlayArea:(BOOL)isHidden{
    for (UIView *oneView in self.evaluateViews) {
        UILabel *tempLabel = (UILabel *)[self.view viewWithTag:(TAG_REGION_LABEL+oneView.tag)];
        UILabel *tempLabelSuserView = (UILabel *)[self.view viewWithTag:(TAG_REGION_LABEL+oneView.tag+oneView.tag)];
        if (isHidden) {
            oneView.layer.borderWidth = 0;
        }else{
            oneView.layer.borderWidth = 1;
        }
        [tempLabel setHidden:isHidden];
        [tempLabelSuserView setHidden:isHidden];
    }
}


/**
 *  项目列表点击的回调，开始模拟播放已经编辑好的项目
 *
 *  @param asset 输入播放对象
 *  @param cellIndexPath 以及项目的索引
 */
-(void)playOneWithProjectObj:(ProjectListObject *)asset cellIndexPath:(NSIndexPath *)cellIndexPath{
    NSInteger masterScreenHeight = self.view.frame.size.width - 46;

    DLog(@"播放项目");
    if (viewdown) {
        
        UIView *view = [self.view viewWithTag:924];


        if (view.frame.origin.y == 0) {
            [UIView animateWithDuration:0.5 animations:^{
                
                [view setFrame:CGRectMake(view.frame.origin.x, - masterScreenHeight, view.frame.size.width, view.frame.size.height)];
            }];            //            sender.transform =
            
            //            _leftButton.imageView.transform = letf ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
            viewdown = NO;
            
            
        }

    
        
    }

    UIButton *sender = (UIButton *)[self.view viewWithTag:922];
    sender.hidden = YES;
    
    if (isPlay) {
        [self quitePlayProjAndResetEditer:YES];
    }
    CGRect rectMasterView = CGRectMake(5, NAVIGATION_BAR_HEIGHT+1, SCREEN_CGSIZE_2HEIGHT-320 - 10, masterScreenHeight);

    if (OS_VERSION_FLOAT>7.9) {
        masterScreenHeight = self.view.frame.size.height-46;
        rectMasterView = CGRectMake(5, NAVIGATION_BAR_HEIGHT+1, SCREEN_CGSIZE_2WIDTH-320 - 10, masterScreenHeight);
    }

    UIScrollView *masterView = (UIScrollView*)[self.view viewWithTag:TAG_MASTER_SCREEN_VIEW];
    [masterView setFrame:rectMasterView];

    DLog(@"=====%@",asset.project_name);
    
    
    [_projectMaterialDictionary removeAllObjects];
    _musicFilePath = nil;
    myMusicTotalPlayTime = 0;
    [musicPlaytimeLabel setText:@""];
    [musicNameLabel setText:@""];
    _musicDuration = nil;
    _musicVolume = nil;
    _musicName = nil;
    [_waitForUploadFilesArray removeAllObjects];
    [mySelectedProjectArray removeAllObjects],mySelectedProjectArray = nil;
    UIButton *myPublishOrButton = (UIButton *)[self.view viewWithTag:TAG_CREATE_GROUP_BUTTON];
    [myPublishOrButton setTag:TAG_PUBLISH_PROJ_BUTTON];
    isContinusPlay = NO;

    currentPlayProObject = asset;

    DLog(@"播放的项目名称 = %@",asset.project_name);
    _currentPlayProjectFilename = asset.project_filename;
    DLog(@"播放的项目配置文件路径 = %@",asset.project_filename);
    
//    //段雨田
//    NSString *xmlstr = [NSString stringWithContentsOfFile:asset.project_filename encoding:NSUTF8StringEncoding error:nil];
//    DLog(@"需要解析的xml   %@",xmlstr);
    
    [_waitForUploadFilesArray addObject:asset.project_filename];
    _currentPlayProjectName = asset.project_name;
    /**
     *  当前播放的项目索引
     */
    _currentPlayProjIndex = cellIndexPath;

    @try {
        //隐藏非播放区域
        [self hiddenNoPlayArea:YES];

        if (!timerKillerArray) {
            timerKillerArray = [[NSMutableArray alloc]init];
        }
        [timerKillerArray removeAllObjects];

        //获得项目的根目录
        NSString *projectFileLastString =  [_currentPlayProjectFilename lastPathComponent];
        _currentProjectPathRoot = [[NSString alloc]initWithFormat:@"%@",[_currentPlayProjectFilename stringByReplacingOccurrencesOfString:projectFileLastString withString:@""]];

        //缓存文件夹的路径
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithXMLFile:asset.project_filename]];

        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithDictionary:dataDictionary];
        [tempDictionary removeObjectForKey:@"projectName"];

        //设置屏端宽高
        NSDictionary *masterScreenDict = [tempDictionary objectForKey:@"masterScreenFrame"];
        [self applyMasterScreenDictionaryWithDict:masterScreenDict];
        //删除屏端宽高
        [tempDictionary removeObjectForKey:@"masterScreenFrame"];

        //播放音频
        NSDictionary *musicDict = [tempDictionary objectForKey:@"projectMusicElement"];
        if (musicDict) {
            if ([musicDict isKindOfClass:[NSDictionary class]]) {
                NSString *musicNameString = [musicDict objectForKey:@"musicName"];
                _musicFilePath = [[NSString alloc]initWithFormat:@"%@%@",_currentProjectPathRoot,musicNameString];
                [_waitForUploadFilesArray addObject:_musicFilePath];
                [myMusicPicker playMusicWithPath:_musicFilePath];
                _musicVolume = [musicDict objectForKey:@"musicVolume"];
                DLog(@"vString floatValue = %lf",[_musicVolume floatValue]);
                [myMusicPicker.myMusicPlayer setVolume:([_musicVolume floatValue]/100)];
                [tempDictionary removeObjectForKey:@"projectMusicElement"];
            }
        }

        //文本
        NSDictionary *textItemDict = [[NSDictionary alloc]initWithDictionary:[tempDictionary objectForKey:@"text"]];
        [tempDictionary removeObjectForKey:@"text"];

        DLog(@"materialListElementempDictionary = %@",tempDictionary);
        NSArray *materiallistArray = [tempDictionary objectForKey:@"materialListElement"];
        if (materiallistArray) {
            if ([materiallistArray isKindOfClass:[NSArray class]]) {
                for (NSDictionary *oneMaterialListElement in materiallistArray) {
                    NSString *oneMaterialListElementOfKey = [oneMaterialListElement objectForKey:@"key"];
                    NSMutableArray *tempObjectArray =  [[NSMutableArray alloc]init];
                    NSArray *listItemArray = [oneMaterialListElement objectForKey:@"listItemElement"];
                    if (listItemArray) {
                        if ([listItemArray isKindOfClass:[NSArray class]]) {
                            for (NSDictionary *oneListItemDict in listItemArray) {
                                [tempObjectArray addObject:[self analysisDataToMaterialObjectWith:oneListItemDict]];
                            }
                            [_projectMaterialDictionary setObject:tempObjectArray forKey:oneMaterialListElementOfKey];
                        }else{
                            [tempObjectArray removeAllObjects];
                            [tempObjectArray addObject:[self analysisDataToMaterialObjectWith:[oneMaterialListElement objectForKey:@"listItemElement"]]];
                            [_projectMaterialDictionary setObject:tempObjectArray forKey:oneMaterialListElementOfKey];
                        }
                    }
                }
            }else{
                NSDictionary *oneMaterialListElement = [tempDictionary objectForKey:@"materialListElement"];
                NSString *oneMaterialListElementOfKey = [oneMaterialListElement objectForKey:@"key"];
                NSMutableArray *tempObjectArray =  [[NSMutableArray alloc]init];
                NSArray *listItemArray = [oneMaterialListElement objectForKey:@"listItemElement"];
                if (listItemArray) {
                    if ([listItemArray isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *oneListItemDict in listItemArray) {
                            [tempObjectArray addObject:[self analysisDataToMaterialObjectWith:oneListItemDict]];
                        }
                        [_projectMaterialDictionary setObject:tempObjectArray forKey:oneMaterialListElementOfKey];
                    }else{
                        [tempObjectArray removeAllObjects];
                        [tempObjectArray addObject:[self analysisDataToMaterialObjectWith:[oneMaterialListElement objectForKey:@"listItemElement"]]];
                        [_projectMaterialDictionary setObject:tempObjectArray forKey:oneMaterialListElementOfKey];
                    }
                }
            }
        }


        NSMutableDictionary *playDictionary = [[NSMutableDictionary alloc]init];
        if (materiallistArray) {
            if ([materiallistArray isKindOfClass:[NSArray class]]) {
                for (NSDictionary *oneMaterialListElement in materiallistArray) {
                    NSString *oneMaterialListElementOfKey = [oneMaterialListElement objectForKey:@"key"];
                    NSMutableDictionary *tempObjectDictionary =  [[NSMutableDictionary alloc]init];
                    NSArray *listItemArray = [oneMaterialListElement objectForKey:@"listItemElement"];
                    if ([listItemArray isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *oneListItemDict in listItemArray) {
                            [tempObjectDictionary setObject:oneListItemDict forKey:[oneListItemDict objectForKey:@"itemIndex"]];
                        }
                    }else{
                        [tempObjectDictionary setObject:[oneMaterialListElement objectForKey:@"listItemElement"] forKey:[[oneMaterialListElement objectForKey:@"listItemElement"] objectForKey:@"itemIndex"]];
                    }

                    [playDictionary setObject:tempObjectDictionary forKey:oneMaterialListElementOfKey];
                    [tempObjectDictionary release];
                }
            }else{
                NSDictionary *materiallistDictionary = [tempDictionary objectForKey:@"materialListElement"];
                if (materiallistDictionary) {
                    if ([materiallistDictionary isKindOfClass:[NSDictionary class]]) {
                        NSString *oneMaterialListElementOfKey = [materiallistDictionary objectForKey:@"key"];
                        NSMutableDictionary *tempObjectDictionary =  [[NSMutableDictionary alloc]init];
                        NSArray *listItemArray = [materiallistDictionary objectForKey:@"listItemElement"];
                        if ([listItemArray isKindOfClass:[NSArray class]]) {
                            for (NSDictionary *oneListItemDict in listItemArray) {
                                [tempObjectDictionary setObject:oneListItemDict forKey:[oneListItemDict objectForKey:@"itemIndex"]];
                            }
                        }else{
                            [tempObjectDictionary setObject:[materiallistDictionary objectForKey:@"listItemElement"] forKey:[[materiallistDictionary objectForKey:@"listItemElement"] objectForKey:@"itemIndex"]];
                        }
                        [playDictionary setObject:tempObjectDictionary forKey:oneMaterialListElementOfKey];
                        [tempObjectDictionary release];
                    }
                }
            }
        }

        //准备创建播放层的key数组，key数组从小到大排序
        NSArray *allPlayKeyArray = [playDictionary allKeys];
        if (allPlayKeyArray) {
            if ([allPlayKeyArray isKindOfClass:[NSArray class]]) {
                allPlayKeyArray = [self sortedArrayWithArray:allPlayKeyArray];
            }
        }

        NSInteger iAllPlayKeyArrayCount = [allPlayKeyArray count];

        for (int i=0; i<iAllPlayKeyArrayCount; i++) {
            NSString *sAreaKey = [allPlayKeyArray objectAtIndex:i];
            if (sAreaKey) {
                if ([sAreaKey isKindOfClass:[NSString class]]) {
                    NSDictionary *oneAreaDict = [playDictionary objectForKey:sAreaKey];;
                    if (oneAreaDict) {
                        if ([oneAreaDict isKindOfClass:[NSDictionary class]]) {
                            [self createPlayAreaView:masterScreenDict andAreaKey:sAreaKey];
                            [self playAreaWithAreaIndex:sAreaKey andAreaDict:oneAreaDict];
                        }
                    }
                }
            }
        }
        
        
        
        //应用文字信息播放
        [self applyTextInfoWithDict:textItemDict];
        
        //停止项目播放的定时器
        stopPhotoTimer = [NSTimer scheduledTimerWithTimeInterval:myPhotoTotalDuration target:self selector:@selector(stopPhotoEvent:) userInfo:nil repeats:NO];

        //设置正在播放
        isPlay = YES;
        //隐藏退出播放按钮
        [self setHiddenQuitPlayButton:NO];
        UIButton * btn1 = (UIButton *)[self.view viewWithTag:TAG_SAVE_AS_BUTTON];
        btn1.hidden=NO;
        UIButton * btn2 = (UIButton *)[self.view viewWithTag:TAG_REST_SCREEN_AS_BUTTON];
        btn2.hidden=YES;
        UIButton * btn4 = (UIButton *)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_BUTTON];
        btn4.hidden=YES;
        UIButton * btn3 = (UIButton *)[self.view viewWithTag:TAG_EDIT_PROJ_BUTTON];
        btn3.hidden=NO;
        UIButton *myTempButton = (UIButton*)[self.view viewWithTag:TAG_PUBLISH_PROJ_BUTTON];
        myTempButton.hidden=NO;
        UITextField *fil=(UITextField *)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
        fil.hidden=YES;
        //给项目名称文本框赋值
        UITextField *myProjectNameField = (UITextField *)[self.view viewWithTag:TAG_PROJECT_NAME_TEXTFIELD];
        [myProjectNameField setText:_currentPlayProjectName];

        [self.view bringSubviewToFront:[self.view viewWithTag:1006]];


    }
    @catch (NSException *exception) {
        DLog(@"exception = %@",exception);
        isPlay = NO;
    }
    @finally {

    }
}






/**
 *  //隐藏或显示控制区域
 */
-(void)hiddenOrShowCtrlView:(UIButton *)sender{
    //隐藏控制区域
    UIView *ctrView = [self.view viewWithTag:TAG_EDIT_CONTROLLER_VIEW];
    [UIView animateWithDuration:0.5 animations:^{
        if (ctrView.frame.origin.x>self.view.frame.size.width) {
            [ctrView setFrame:CGRectMake(ctrView.frame.origin.x - ctrView.frame.size.width - 1, ctrView.frame.origin.y, ctrView.frame.size.width, ctrView.frame.size.height)];
            if (sender) {
                if (loginPage != NULL) {
                    loginPage.hidden = NO;
                }
                
                [sender setTitle:[Config DPLocalizedString:@"adedit_hide"] forState:UIControlStateNormal];
            }
        }else{
            [ctrView setFrame:CGRectMake(ctrView.frame.origin.x + ctrView.frame.size.width+1, ctrView.frame.origin.y, ctrView.frame.size.width, ctrView.frame.size.height)];
            
            if (loginPage != NULL) {
                loginPage.hidden = YES;
                if (registeredPage != NULL) {
                    [registeredPage removeFromSuperview];
                }
            }
            if (sender) {
                [sender setTitle:[Config DPLocalizedString:@"adedit_show"] forState:UIControlStateNormal];
            }
        }
    }];
}

//滑动手势响应时间
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    UIButton *utton = (UIButton *)[self.view viewWithTag:922];
    NSInteger masterScreenHeight = self.view.frame.size.width - 46;

    UIView *view = [self.view viewWithTag:924];
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown&&viewdown==NO) {
        DLog(@"swipe down");
        //执行程序
        if (view.frame.origin.y < 0) {
            [UIView animateWithDuration:0.5 animations:^{
                [view setFrame:CGRectMake(view.frame.origin.x, 0, view.frame.size.width, view.frame.size.height)];
            }];
        }
        utton.hidden = YES;

        viewdown = YES;
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp&&viewdown==YES) {
        viewdown = NO;
        utton.hidden = NO;
        DLog(@"swipe up");
        //执行程序
        [UIView animateWithDuration:0.5 animations:^{
            [view setFrame:CGRectMake(view.frame.origin.x,-masterScreenHeight, view.frame.size.width, view.frame.size.height)];
        }];

        [myProjectCtrl reloadMyPlaylist];
    }
    
}

-(void)myviewup:(UIButton *)sender
{
    UIView *view = [self.view viewWithTag:924];
    NSInteger masterScreenHeight = self.view.frame.size.width - 46;

        DLog(@"swipe down");
        //执行程序
        if (view.frame.origin.y < 0) {
            [UIView animateWithDuration:0.5 animations:^{
                [view setFrame:CGRectMake(0, 0, view.frame.size.width, masterScreenHeight)];
            }];
//            sender.transform =
            
//            _leftButton.imageView.transform = letf ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
            sender.hidden = YES;
            viewdown = YES;
            
        }else {
        
        DLog(@"swipe up");
            viewdown = NO;
        //执行程序
        [UIView animateWithDuration:0.5 animations:^{
            [view setFrame:CGRectMake(view.frame.origin.x, -masterScreenHeight, view.frame.size.width, view.frame.size.height)];
        }];
        
        [myProjectCtrl reloadMyPlaylist];
    }

    
    

}

/**
 *  某个区域的播放
 *
 *  @param areaIndex 区域的索引
 *  @param tempDictionary 区域内播放素材的字典
 */
-(void)playAreaWithAreaIndex:(NSString *)areaIndex andAreaDict:(NSDictionary *)tempDictionary{
    @try {
        if (!tempDictionary) {
            return;
        }
        
        
        //排序key
        NSArray *allTempKeyArray = [tempDictionary allKeys];
        allTempKeyArray = [self sortedArrayWithArray:allTempKeyArray];
        //获得一层的运行时间
        NSInteger totalSchedule=0;
        for (NSString *oneKey in allTempKeyArray) {
            NSDictionary *oneDictionary = [tempDictionary objectForKey:oneKey];
            NSString *durationString = [oneDictionary objectForKey:@"duration"];
            int sleepSecond = [durationString intValue];
            totalSchedule +=sleepSecond;
        }
        
        //在所有的时间中取最长的时间
        if (totalSchedule>myPhotoTotalDuration) {
            myPhotoTotalDuration = totalSchedule;
        }

        //区域的索引
        NSString *myAreaIndex = [[NSString alloc]initWithString:areaIndex];

        NSDictionary *myDict = [[NSDictionary alloc]initWithObjectsAndKeys:allTempKeyArray,@"allTempKeyArray",tempDictionary,@"tempDictionary",myAreaIndex,@"areaIndex",nil];

        [self performSelector:@selector(myPlayEvent:) withObject:myDict afterDelay:0];
        [myAreaIndex release];

    }
    @catch (NSException *exception) {
        NSLog(@"playAreaWithAreaInde.xexception = %@",exception);
    }
    @finally {

    }
}

/**
 *  @brief  获得指定目录下，指定后缀名的文件列表
 *
 *  @param  type    文件后缀名
 *  @param  dirPath     指定目录
 *
 *  @return 文件名列表
 */
+(NSArray *)getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)myDirPath
                    AndIsGroupDir:(BOOL)isGroupDir{
    @try {
        NSFileManager *myFileManager = [NSFileManager defaultManager];
        NSMutableArray *filenamelist = [[[NSMutableArray alloc]init] autorelease];
        NSArray *dirArray = [myFileManager contentsOfDirectoryAtPath:myDirPath error:nil];
        DLog(@"======dirPath = %@,\n =============dirArray = %@,",myDirPath,dirArray);
        if (isGroupDir) {
            for (NSString *dirName in dirArray) {
                NSString *filePath = [myDirPath stringByAppendingPathComponent:dirName];
                if ([self isFileExistAtPath:filePath]) {
                    if (type) {
                        if ([[filePath pathExtension] isEqualToString:type]) {
                            [filenamelist  addObject:filePath];
                        }
                    }else{
                        if (![[filePath pathExtension] isEqualToString:@"xml"]) {
                            [filenamelist  addObject:filePath];
                        }
                    }
                }
            }
        }else{
            for (NSString *dirName in dirArray) {
                NSString *dirPath = [myDirPath stringByAppendingPathComponent:dirName];
                BOOL isDir;
                if ([myFileManager fileExistsAtPath:dirPath isDirectory:&isDir]) {
                    if (isDir){ // isDir判断是否为文件夹
                        NSArray *fileListArray = [myFileManager contentsOfDirectoryAtPath:dirPath error:nil];
                        for (NSString *fileName in fileListArray) {
                            NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
                            if ([self isFileExistAtPath:filePath]) {
                                if (type) {
                                    if ([[filePath pathExtension] isEqualToString:type]) {
                                        [filenamelist  addObject:filePath];
                                    }
                                }else{
                                    if (![[filePath pathExtension] isEqualToString:@"xml"]) {
                                        [filenamelist  addObject:filePath];
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return filenamelist;
    }
    @catch (NSException *exception) {
        DLog(@"读取项目描述文件出错 = %@",exception);
    }
    @finally {

    }

}

/**
 *  判断文件是否存在
 *
 *  @param fileFullPath
 *
 *  @return YES/NO
 */
+(BOOL)isFileExistAtPath:(NSString*)fileFullPath {
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    return isExist;
}



/**
 *  创建文字滚动区域
 */
-(void)createTextArea{

    UIView *myView = [self.view viewWithTag:VIEW_TAG_TEXT_AREA_1005];

    NSArray *tickerStrings = [[NSArray alloc]initWithObjects:@"", nil];
    CGRect textRectLabel = CGRectMake(0, 0, myView.frame.size.width,myView.frame.size.height);

    JHTickerView *old_Ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
    if (old_Ticker) {
        if (old_Ticker.tag == TAG_TEXT_AREA_LABEL) {
            [old_Ticker removeFromSuperview];
        }
    }

    JHTickerView *ticker = [[JHTickerView alloc] initWithFrame:textRectLabel];
    [ticker setTag:TAG_TEXT_AREA_LABEL];

    [ticker setDirection:JHTickerDirectionLTR];
    [ticker setTickerStrings:tickerStrings];
    [ticker setTickerSpeed:20.0f];
    [ticker setTickerColor:[UIColor colorWithRed:0.988 green:0.988 blue:0.988 alpha:1]];

    [ticker setTickerFont:[UIFont boldSystemFontOfSize:18]];
    [ticker setBackgroundColor:[UIColor colorWithRed:0.01 green:0.02 blue:0.01 alpha:0.01]];
    [ticker start];
    [myView addSubview:ticker];
    [ticker release];
//    [tickerStrings release];
}


/**
 *  修改了文字编辑区域的颜色
 */
-(void)createTextAreaWithColor:(UIColor *)myColor{
    UIView *myView = [self.view viewWithTag:VIEW_TAG_TEXT_AREA_1005];

    //滚动文字的区域
    CGRect textRectLabel = CGRectMake(0, 0, myView.frame.size.width,myView.frame.size.height);
    //滚动文字的内容
    NSArray *tickerStrings = [[NSArray alloc]initWithObjects:@"", nil];
    //滚动文字的速度
    float tickerSpeed = 20.0f;
    //滚动文字的颜色
    UIColor *tickerFontColor = [UIColor colorWithRed:0.988 green:0.988 blue:0.988 alpha:1];
    //滚动文字的大小
    UIFont *tickerFont = [UIFont boldSystemFontOfSize:18];
    JHTickerView *old_Ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
    if (old_Ticker) {
        if (old_Ticker.tag == TAG_TEXT_AREA_LABEL) {
            tickerStrings = old_Ticker.tickerStrings;
            tickerSpeed = old_Ticker.tickerSpeed;
            tickerFont = old_Ticker.tickerFont;
            [old_Ticker removeFromSuperview];
        }
    }

    JHTickerView *ticker = [[JHTickerView alloc] initWithFrame:textRectLabel];

    [ticker setTag:TAG_TEXT_AREA_LABEL];
    [ticker setDirection:JHTickerDirectionLTR];
    [ticker setTickerStrings:tickerStrings];
    [ticker setTickerSpeed:tickerSpeed];
    [ticker setTickerColor:tickerFontColor];
    [ticker setTickerFont:tickerFont];
    [ticker setBackgroundColor:[UIColor colorWithRed:0.01 green:0.02 blue:0.01 alpha:0.01]];
    [ticker start];
    [myView addSubview:ticker];
    [ticker release];
}


/**
 *  修改了文字编辑区域的滚动速度
 */
-(void)createTextAreaWithSpeed:(float)mySpeed{
    UIView *myView = [self.view viewWithTag:VIEW_TAG_TEXT_AREA_1005];

    //滚动文字的区域
    CGRect textRectLabel = CGRectMake(0, 0, myView.frame.size.width,myView.frame.size.height);
    //滚动文字的内容
    NSArray *tickerStrings = [[NSArray alloc]initWithObjects:[Config DPLocalizedString:@"adedit_defaultText"], nil];
    //滚动文字的速度
    float tickerSpeed = 20.0f;
    //滚动文字的颜色
    UIColor *tickerFontColor = [UIColor colorWithRed:0.988 green:0.988 blue:0.988 alpha:1];
    //滚动文字的大小
    UIFont *tickerFont = [UIFont boldSystemFontOfSize:18];
    JHTickerView *old_Ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
    if (old_Ticker) {
        if (old_Ticker.tag == TAG_TEXT_AREA_LABEL) {
            tickerStrings = old_Ticker.tickerStrings;
            tickerSpeed = mySpeed;
            tickerFontColor = old_Ticker.tickerColor;
            tickerFont = old_Ticker.tickerFont;
            [old_Ticker removeFromSuperview];
        }
    }

    JHTickerView *ticker = [[JHTickerView alloc] initWithFrame:textRectLabel];

    [ticker setTag:TAG_TEXT_AREA_LABEL];
    [ticker setDirection:JHTickerDirectionLTR];
    [ticker setTickerStrings:tickerStrings];
    [ticker setTickerSpeed:tickerSpeed];
    [ticker setTickerColor:tickerFontColor];
    [ticker setTickerFont:tickerFont];
    [ticker setBackgroundColor:[UIColor colorWithRed:0.01 green:0.02 blue:0.01 alpha:0.01]];
    [ticker start];
    [myView addSubview:ticker];
    [ticker release];
}


/**
 *  修改了文字编辑区域的滚动速度
 */
-(void)createTextAreaWithFont:(UIFont *)myFont{
    UIView *myView = [self.view viewWithTag:VIEW_TAG_TEXT_AREA_1005];

    //滚动文字的区域
    CGRect textRectLabel = CGRectMake(0, 0, myView.frame.size.width,myView.frame.size.height);
    //滚动文字的内容
    NSArray *tickerStrings = [[NSArray alloc]initWithObjects:[Config DPLocalizedString:@"adedit_defaultText"], nil];
    //滚动文字的速度
    float tickerSpeed = 20.0f;
    //滚动文字的颜色
    UIColor *tickerFontColor = [UIColor colorWithRed:0.988 green:0.988 blue:0.988 alpha:1];
    //滚动文字的大小
    UIFont *tickerFont = [UIFont boldSystemFontOfSize:18];
    JHTickerView *old_Ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
    if (old_Ticker) {
        if (old_Ticker.tag == TAG_TEXT_AREA_LABEL) {
            tickerStrings = old_Ticker.tickerStrings;
            tickerSpeed = old_Ticker.tickerSpeed;
            tickerFontColor = old_Ticker.tickerColor;
            tickerFont = myFont;
            [old_Ticker removeFromSuperview];
        }
    }

    JHTickerView *ticker = [[JHTickerView alloc] initWithFrame:textRectLabel];

    [ticker setTag:TAG_TEXT_AREA_LABEL];
    [ticker setDirection:JHTickerDirectionLTR];
    [ticker setTickerStrings:tickerStrings];
    [ticker setTickerSpeed:tickerSpeed];
    [ticker setTickerColor:tickerFontColor];
    [ticker setTickerFont:tickerFont];
    [ticker setBackgroundColor:[UIColor colorWithRed:0.01 green:0.02 blue:0.01 alpha:0.01]];
    [ticker start];
    [myView addSubview:ticker];
    [ticker release];
}


/**
 *  修改了文字编辑区域的颜色
 */
-(void)createTextAreaWithMyColor:(UIColor *)myColor mySpeed:(float)mySpeed myFont:(UIFont*)myFont myText:(NSString *)myText{
    UIView *myView = [self.view viewWithTag:VIEW_TAG_TEXT_AREA_1005];

    //滚动文字的区域
    CGRect textRectLabel = CGRectMake(0, 0, myView.frame.size.width,myView.frame.size.height);
    //滚动文字的内容
    NSArray *tickerStrings = nil;
    //滚动文字的速度
    float tickerSpeed = 20.0f;
    //滚动文字的颜色
    UIColor *tickerFontColor = [UIColor colorWithRed:0.988 green:0.988 blue:0.988 alpha:1];
    //滚动文字的大小
    UIFont *tickerFont = [UIFont boldSystemFontOfSize:18];
    JHTickerView *old_Ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
    if (old_Ticker) {
        if (old_Ticker.tag == TAG_TEXT_AREA_LABEL) {
            if ([myText length]>1) {
                tickerStrings = [[NSArray alloc]initWithObjects:myText, nil];
            }
            tickerSpeed = mySpeed;
            tickerFontColor = myColor;
            tickerFont = myFont;
            [old_Ticker removeFromSuperview];
        }
    }

    JHTickerView *ticker = [[JHTickerView alloc] initWithFrame:textRectLabel];

    [ticker setTag:TAG_TEXT_AREA_LABEL];
    [ticker setDirection:JHTickerDirectionLTR];
    if (tickerStrings) {
        [ticker setTickerStrings:tickerStrings];
    }
    [ticker setTickerSpeed:tickerSpeed];
    [ticker setTickerColor:tickerFontColor];
    [ticker setTickerFont:tickerFont];
    [ticker setBackgroundColor:[UIColor colorWithRed:0.01 green:0.02 blue:0.01 alpha:0.01]];
    [ticker start];
    [myView addSubview:ticker];

    [ticker release];
}



/**
 *  对数组进行排序
 *
 *  @param soruceArray 排序的源
 *
 *  @return 排序之后的数组
 */
-(NSArray *)sortedArrayWithArray:(NSArray *)soruceArray{
    return [soruceArray sortedArrayUsingSelector:@selector(compare:)];
}


-(void)myPlayEvent:(NSDictionary *)dataDict{
    
    NSArray *allTempKeyArray = [dataDict objectForKey:@"allTempKeyArray"];
    NSDictionary *tempDictionary = [dataDict objectForKey:@"tempDictionary"];
    NSInteger totalSchedule=0;
    for (NSString *oneKey in allTempKeyArray) {
        NSDictionary *oneDictionary = [tempDictionary objectForKey:oneKey];
        NSString *durationString = [oneDictionary objectForKey:@"duration"];
        int sleepSecond = [durationString intValue];

        NSString *w = [oneDictionary objectForKey:@"w"];
        NSString *h = [oneDictionary objectForKey:@"h"];
        NSString *x = [oneDictionary objectForKey:@"x"];
        NSString *y = [oneDictionary objectForKey:@"y"];

        NSDictionary *dict_video_frame_list = [oneDictionary objectForKey:@"video_frame_list"];
        NSString *key_dict_video_frame_list = nil;
        if (dict_video_frame_list) {
            key_dict_video_frame_list = @"video_frame_list";
        }

        NSDictionary *myDict = [[NSDictionary alloc]initWithObjectsAndKeys:[oneDictionary objectForKey:@"filename"],@"filename",w,@"w",h,@"h",x,@"x",y,@"y",[dataDict objectForKey:@"areaIndex"],@"areaIndex",[oneDictionary objectForKey:@"filetype"],@"filetype",[oneDictionary objectForKey:@"direction"],@"direction",durationString,@"durationString",[oneDictionary objectForKey:@"angle"],@"angle",dict_video_frame_list,key_dict_video_frame_list,nil];

        
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:totalSchedule target:self selector:@selector(setImageToLayerDict:) userInfo:myDict repeats:NO];
        
        
        [myDict release];
        
        [timerKillerArray addObject:timer];
        
        totalSchedule += sleepSecond;
    }

}

/**
 *  播放项目的定时器处理事件
 *
 *  @param myTimer 播放定时器对象
 */
-(void)myTimerEvent:(NSTimer *)myTimer{
    NSDictionary *dataDict = [myTimer userInfo];
    [self myPlayEvent:dataDict];
}



/**
 *  创建亮度选择器
 */
-(UIView *)createBrightnessSwithView:(CGRect)rect viewTag:(NSInteger)tag supserViewTag:(NSInteger)supserViewTag andColor:(UIColor*)myColor{
    DLog(@"获取的亮度%ld,%ld,%ld,%ld,%ld,%ld",(long)_alpha2,(long)_red2,(long)_green2,(long)_blue2,(long)_width2,(long)_height2);
    UIView *rgbView = [[UIView alloc]initWithFrame:rect];

    self.delegate = [[RGBColorSliderDelegate alloc] init];
    self.delegate.delegate = self;

    NSInteger sliderWidth = rect.size.width - 40;
    NSInteger sliderHeight = 30;

    //    暂时屏蔽透明度
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 20, 20)];
    [label4 setBackgroundColor:[UIColor clearColor]];
    [label4 setTag:TAG_ALPHA_COLOR_LABEL];
    [label4 setText:@"A:"];
    alphaSlider = [[RGBColorSlider alloc] initWithFrame:CGRectMake(20, label4.frame.origin.y + label4.frame.size.height , sliderWidth, sliderHeight) sliderColor:RGBColorTypeAlpha trackHeight:6 delegate:self.delegate];
    [alphaSlider.delegate slider:alphaSlider valueDidChangeTo:255 forSliderColor:RGBColorTypeRed];
    alphaSlider.value = 255;

    NSLog(@"111111111111111111111=%ld",(long)_alpha2);

    fieldA=[[UITextField alloc]initWithFrame:CGRectMake(label4.frame.origin.x+label4.frame.size.width+10, label4.frame.origin.y, 45, 20)];
    fieldA.backgroundColor=[UIColor cyanColor];
    fieldA.text=[NSString stringWithFormat:@"%ld",(long)_alpha2];
    DLog(@"亮度%@",fieldA.text);
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, alphaSlider.frame.origin.y + alphaSlider.frame.size.height + 20, 20, 20)];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTag:TAG_RED_COLOR_LABEL];
    [label1 setText:@"R:"];
    fieldR=[[UITextField alloc]initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width+10, label1.frame.origin.y, 45, 20)];
    fieldR.backgroundColor=[UIColor cyanColor];
    fieldR.text=[NSString stringWithFormat:@"%ld",(long)_red2];
    RGBColorSlider *redSlider = [[RGBColorSlider alloc] initWithFrame:CGRectMake(20, label1.frame.origin.y + label1.frame.size.height , sliderWidth, sliderHeight) sliderColor:RGBColorTypeRed trackHeight:6 delegate:self.delegate];
    [redSlider.delegate slider:redSlider valueDidChangeTo:255 forSliderColor:RGBColorTypeRed];
    redSlider.value =255;

    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, redSlider.frame.origin.y + redSlider.frame.size.height + 20, 20, 20)];
    [label2 setBackgroundColor:[UIColor clearColor]];
    [label2 setTag:TAG_GREEN_COLOR_LABEL];
    [label2 setText:@"G:"];
    RGBColorSlider *greenSlider = [[RGBColorSlider alloc] initWithFrame:CGRectMake(20, label2.frame.origin.y + label2.frame.size.height , sliderWidth, sliderHeight) sliderColor:RGBColorTypeGreen trackHeight:6 delegate:self.delegate];
    [greenSlider.delegate slider:greenSlider valueDidChangeTo:255 forSliderColor:RGBColorTypeRed];
    greenSlider.value =255;
    fieldG=[[UITextField alloc]initWithFrame:CGRectMake(label2.frame.origin.x+label2.frame.size.width+10, label2.frame.origin.y, 45, 20)];
    fieldG.backgroundColor=[UIColor cyanColor];
    fieldG.text=[NSString stringWithFormat:@"%ld",(long)_green2];
    fieldG.delegate = self;
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(20, greenSlider.frame.origin.y + greenSlider.frame.size.height + 20, 20, 20)];
    [label3 setBackgroundColor:[UIColor clearColor]];
    [label3 setTag:TAG_BLUE_COLOR_LABEL];
    [label3 setText:@"B:"];
    RGBColorSlider *blueSlider = [[RGBColorSlider alloc] initWithFrame:CGRectMake(20, label3.frame.origin.y + label3.frame.size.height , sliderWidth, sliderHeight) sliderColor:RGBColorTypeBlue trackHeight:6 delegate:self.delegate];
    [blueSlider.delegate slider:blueSlider valueDidChangeTo:255 forSliderColor:RGBColorTypeRed];
    blueSlider.value = 255;
    fieldB=[[UITextField alloc]initWithFrame:CGRectMake(label3.frame.origin.x+label3.frame.size.width+10, label3.frame.origin.y, 45, 20)];
    fieldB.backgroundColor=[UIColor cyanColor];
    fieldB.text=[NSString stringWithFormat:@"%ld",(long)_blue2];


    UILabel *lableH=[[UILabel alloc]initWithFrame:CGRectMake(20 ,blueSlider.frame.origin.y+blueSlider.frame.size.height+20, 20, 20)];
    lableH.text=@"W";
    fieldH=[[UITextField alloc]initWithFrame:CGRectMake(lableH.frame.origin.x+lableH.frame.size.width, lableH.frame.origin.y, 70, 30)];
    fieldH.backgroundColor=[UIColor cyanColor];
    fieldH.text=[NSString stringWithFormat:@"%ld",(long)_height2];
    fieldH.textColor=[UIColor blackColor];
    UILabel *lableW=[[UILabel alloc]initWithFrame:CGRectMake(lableH.frame.origin.x+130 ,blueSlider.frame.origin.y+blueSlider.frame.size.height+20, 20, 20)];
    lableW.text=@"H";
    fieldW=[[UITextField alloc]initWithFrame:CGRectMake(lableW.frame.origin.x+lableW.frame.size.width, lableW.frame.origin.y, 70, 30)];
    fieldW.backgroundColor=[UIColor cyanColor];
    fieldW.textColor=[UIColor blackColor];
    [fieldW setText:[NSString stringWithFormat:@"%ld",(long)_width2]];


    UILabel *lableA=[[UILabel alloc]initWithFrame:CGRectMake(fieldA.frame.origin.x+fieldA.frame.size.width+30, fieldA.frame.origin.y, 90, 20)];
    [lableA setText:[Config DPLocalizedString:@"adedit_Last_Set"]];
    fieldA1=[[UILabel alloc]initWithFrame:CGRectMake(lableA.frame.origin.x+lableA.frame.size.width+10, lableA.frame.origin.y, 45, 20)];
    UILabel *lableR=[[UILabel alloc]initWithFrame:CGRectMake(fieldR.frame.origin.x+fieldR.frame.size.width+30, fieldR.frame.origin.y, 90, 20)];
    [lableR setText:[Config DPLocalizedString:@"adedit_Last_Set"]];
    fieldR1=[[UILabel alloc]initWithFrame:CGRectMake(lableR.frame.origin.x+lableR.frame.size.width+10, lableR.frame.origin.y, 45, 20)];

    UILabel *lableG=[[UILabel alloc]initWithFrame:CGRectMake(fieldG.frame.origin.x+fieldG.frame.size.width+30, fieldG.frame.origin.y, 90, 20)];
    [lableG setText:[Config DPLocalizedString:@"adedit_Last_Set"]];
    fieldG1=[[UILabel alloc]initWithFrame:CGRectMake(lableG.frame.origin.x+lableG.frame.size.width+10, lableG.frame.origin.y, 45, 20)];
    UILabel *lableB=[[UILabel alloc]initWithFrame:CGRectMake(fieldB.frame.origin.x+fieldB.frame.size.width+30, fieldB.frame.origin.y, 90, 20)];
    [lableB setText:[Config DPLocalizedString:@"adedit_Last_Set"]];

    fieldB1=[[UILabel alloc]initWithFrame:CGRectMake(lableB.frame.origin.x+lableB.frame.size.width+10, lableB.frame.origin.y, 45, 20)];
    fieldA1.text=[NSString stringWithFormat:@"%ld",(long)_alpha2];
    fieldR1.text=[NSString stringWithFormat:@"%ld",(long)_red2];
    fieldG1.text=[NSString stringWithFormat:@"%ld",(long)_green2];
    fieldB1.text=[NSString stringWithFormat:@"%ld",(long)_blue2];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(fieldW.frame.origin.x+fieldW.frame.size.width-100, fieldW.frame.origin.y+fieldW.frame.size.height+20, 130, 20)];
    [label setText:[Config DPLocalizedString:@"adedit_Complete_set"]];
    [rgbView addSubview:label];
    [rgbView addSubview:lableA];
    [rgbView addSubview:lableR];
    [rgbView addSubview:lableG];
    [rgbView addSubview:lableB];
    [rgbView addSubview:fieldA1];
    [rgbView addSubview:fieldR1];
    [rgbView addSubview:fieldG1];
    [rgbView addSubview:fieldB1];
    [rgbView addSubview:lableH];
    [rgbView addSubview:lableW];
    [rgbView addSubview:fieldH];
    [rgbView addSubview:fieldW];
    [rgbView addSubview:fieldA];
    [rgbView addSubview:fieldR];
    [rgbView addSubview:fieldG];
    [rgbView addSubview:fieldB];
    [rgbView addSubview:label1];
    [rgbView addSubview:redSlider];
    [rgbView addSubview:label2];
    [rgbView addSubview:greenSlider];
    [rgbView addSubview:label3];
    [rgbView addSubview:blueSlider];
    [rgbView addSubview:label4];
    [rgbView addSubview:alphaSlider];
    
    [label release];
    [lableA release];
    [lableR release];
    [lableG release];
    [lableB release];
    [fieldA1 release];
    [fieldR1 release];
    [fieldG1 release];
    [fieldB1 release];
    [lableW release];
    [lableH release];
    [fieldW release];
    [fieldH release];
    [fieldA release];
    [fieldR release];
    [fieldG release];
    [fieldB release];
    [label1 release];
    [redSlider release];
    [label2 release];
    [greenSlider release];
    [label3 release];
    [blueSlider release];
    [label4 release];
    [alphaSlider release];

    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(alphaSlider.frame.origin.x , alphaSlider.frame.origin.y + alphaSlider.frame.size.height + 40, 160, 30)];
    [myLabel setText:[Config DPLocalizedString:@"adedit_closeBrightnessPicker"]];
    [myLabel setUserInteractionEnabled:NO];
//    [rgbView addSubview:myLabel];
    [myLabel release];
    
    return rgbView;
}



/**
 *  创建颜色选择器
 */
-(UIView *)createColorSwithView:(CGRect)rect viewTag:(NSInteger)tag supserViewTag:(NSInteger)supserViewTag andColor:(UIColor*)myColor{

    UIView *rgbView = [[UIView alloc]initWithFrame:rect];

    self.delegate = [[RGBColorSliderDelegate alloc] init];
    self.delegate.delegate = self;

    NSInteger sliderWidth = rect.size.width - 40;
    NSInteger sliderHeight = 44;

    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, sliderWidth, 20)];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setTag:TAG_RED_COLOR_LABEL];
    [label1 setText:@"Red:"];
    RGBColorSlider *redSlider = [[RGBColorSlider alloc] initWithFrame:CGRectMake(20, label1.frame.origin.y + label1.frame.size.height + 5, sliderWidth, sliderHeight) sliderColor:RGBColorTypeRed trackHeight:6 delegate:self.delegate];

    const CGFloat *c = CGColorGetComponents(myColor.CGColor);
    [redSlider.delegate slider:redSlider valueDidChangeTo:((float)c[0]) forSliderColor:RGBColorTypeRed];

    redSlider.value = ((float)c[0]);

    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, redSlider.frame.origin.y + redSlider.frame.size.height + 20, sliderWidth, 20)];
    [label2 setBackgroundColor:[UIColor clearColor]];
    [label2 setTag:TAG_GREEN_COLOR_LABEL];
    [label2 setText:@"Green:"];
    RGBColorSlider *greenSlider = [[RGBColorSlider alloc] initWithFrame:CGRectMake(20, label2.frame.origin.y + label2.frame.size.height + 5, sliderWidth, sliderHeight) sliderColor:RGBColorTypeGreen trackHeight:6 delegate:self.delegate];


    [greenSlider.delegate slider:greenSlider valueDidChangeTo:((float)c[1]) forSliderColor:RGBColorTypeRed];

    greenSlider.value = ((float)c[1]);

    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(20, greenSlider.frame.origin.y + greenSlider.frame.size.height + 20, sliderWidth, 20)];
    [label3 setBackgroundColor:[UIColor clearColor]];
    [label3 setTag:TAG_BLUE_COLOR_LABEL];
    [label3 setText:@"Blue:"];
    RGBColorSlider *blueSlider = [[RGBColorSlider alloc] initWithFrame:CGRectMake(20, label3.frame.origin.y + label3.frame.size.height + 5, sliderWidth, sliderHeight) sliderColor:RGBColorTypeBlue trackHeight:6 delegate:self.delegate];


    [blueSlider.delegate slider:blueSlider valueDidChangeTo:((float)c[2]) forSliderColor:RGBColorTypeRed];

    blueSlider.value = ((float)c[2]);

    //暂时屏蔽透明度
    //    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(20, blueSlider.frame.origin.y + blueSlider.frame.size.height + 20, sliderWidth, 20)];
    //    [label4 setBackgroundColor:[UIColor clearColor]];
    //    [label4 setTag:TAG_ALPHA_COLOR_LABEL];
    //    [label4 setText:@"Alpha:"];
    //    RGBColorSlider *alphaSlider = [[RGBColorSlider alloc] initWithFrame:CGRectMake(20, label4.frame.origin.y + label4.frame.size.height + 5, sliderWidth, sliderHeight) sliderColor:RGBColorTypeAlpha trackHeight:6 delegate:self.delegate];

    [rgbView addSubview:label1];
    [rgbView addSubview:redSlider];
    [rgbView addSubview:label2];
    [rgbView addSubview:greenSlider];
    [rgbView addSubview:label3];
    [rgbView addSubview:blueSlider];

    [label1 release];
    [redSlider release];
    [label2 release];
    [greenSlider release];
    [label3 release];
    [blueSlider release];

    //透明度
    //    [rgbView addSubview:label4];
    //    [rgbView addSubview:alphaSlider];

    //关闭引导文字
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(blueSlider.frame.origin.x , blueSlider.frame.origin.y + blueSlider.frame.size.height + 40, 160, 30)];
    [myLabel setText:[Config DPLocalizedString:@"adedit_closeColorPicker"]];
    [myLabel setUserInteractionEnabled:NO];
    [rgbView addSubview:myLabel];
    [myLabel release];

    return rgbView;
}

/**
 *  颜色选择器的回调，改变指定对象的颜色
 *
 *  @param color UIcolor
 */
- (void)updateColor:(UIColor *)color
{

    JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];

    if (_currentChangeColorViewTag == (ticker.tag+1)) {
        [ticker setTickerColor:color];
        [ticker.tickerLabel setTextColor:color];
    }
    if (_currentChangeColorViewTag == ticker.tag ) {
        [ticker setBackgroundColor:color];
    }
    [self updateRGBLabelValueWithColor:color];
//    alphaSlider.value = _alpha2;

}

-(void)updateRGBLabelValueWithColor:(UIColor *)color{
    @try {
        const CGFloat *c = CGColorGetComponents(color.CGColor);
//        DLog(@"c的颜色===%f,%f,%f,%f",c[0],c[1],c[2],c[3]);
//        UILabel *redLabel = (UILabel *)[self.view viewWithTag:TAG_RED_COLOR_LABEL];
//        [redLabel setText:[NSString stringWithFormat:@"Red:%d",(int)(c[0]*255)]];
//        UILabel *greenLabel = (UILabel *)[self.view viewWithTag:TAG_GREEN_COLOR_LABEL];
//        [greenLabel setText:[NSString stringWithFormat:@"Green:%d",(int)(c[1]*255)]];
//        UILabel *blueLabel = (UILabel *)[self.view viewWithTag:TAG_BLUE_COLOR_LABEL];
//        [blueLabel setText:[NSString stringWithFormat:@"Blue:%d",(int)(c[2]*255)]];
//        UILabel *alphaLabel = (UILabel *)[self.view viewWithTag:TAG_ALPHA_COLOR_LABEL];
//        [alphaLabel setText:[NSString stringWithFormat:@"Alpha:%d",(int)(c[3])*255]];
        _red1=(c[0]*255);
        _blue1=(c[2]*255);
        _green1=(c[1]*255);
        _alpha1=(c[3]*255);
        fieldR.text=[NSString stringWithFormat:@"%ld",(long)_red1];
        fieldG.text=[NSString stringWithFormat:@"%ld",(long)_green1];
        fieldB.text=[NSString stringWithFormat:@"%ld",(long)_blue1];
        fieldA.text=[NSString stringWithFormat:@"%ld",(long)_alpha1];

//        DLog(@"rgba2===%d,%d,%d,%ld",_red2,_green2,_blue2,(long)_alpha2);
        UILabel *redLabel = (UILabel *)[self.view viewWithTag:TAG_RED_COLOR_LABEL];
        [redLabel setText:[NSString stringWithFormat:@"Red:%d",(int)_red2]];
        UILabel *greenLabel = (UILabel *)[self.view viewWithTag:TAG_GREEN_COLOR_LABEL];
        [greenLabel setText:[NSString stringWithFormat:@"Green:%d",(int)_green2]];
        UILabel *blueLabel = (UILabel *)[self.view viewWithTag:TAG_BLUE_COLOR_LABEL];
        [blueLabel setText:[NSString stringWithFormat:@"Blue:%d",(int)_blue2]];
        UILabel *alphaLabel = (UILabel *)[self.view viewWithTag:TAG_ALPHA_COLOR_LABEL];
        [alphaLabel setText:[NSString stringWithFormat:@"Alpha:%d",(int)_alpha2]];

//        DLog(@"aaargba===%d,%d,%d,%d",_red1,_green1,_blue1,_alpha1);
    }
    @catch (NSException *exception) {
        DLog(@"exception = %@",exception);
    }
    @finally {

    }
}

#pragma mark - Socket
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    DLog(@"%s %d", __FUNCTION__, __LINE__);
    [_sendPlayerSocket readDataWithTimeout: -1 tag: 0];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    DLog(@"%s %d, tag = %ld", __FUNCTION__, __LINE__, tag);
    DLog(@"写数据完成");
    [_sendPlayerSocket readDataWithTimeout: -1 tag: tag];
}


- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    DLog(@"返回的数据-------%d",data.length);
    Byte *AckByte = (Byte *)[data bytes];

    DLog(@"ack[0]=%x",AckByte[0]);
    DLog(@"ack[1]=%x",AckByte[1]);
    DLog(@"ack[2]=%x",AckByte[2]);
    DLog(@"ack[3]=%x",AckByte[3]);
    DLog(@"ack[4]=%x",AckByte[4]);
    DLog(@"ack[5]=%x",AckByte[5]);
    DLog(@"ack[6]=%x",AckByte[6]);
    DLog(@"ack[7]=%x",AckByte[7]);
    DLog(@"ack[8]=%x",AckByte[8]);
    DLog(@"ack[9]=%x",AckByte[9]);
    DLog(@"ack[10]=%x",AckByte[10]);

    if (AckByte[1] == 0x1D) {
        DLog(@"发送图数据成功");
        [self myFinishedPublishEvent];
    }
    if (AckByte[1] == 0x1c) {
        DLog(@"发送重置命令成功");
        if (AckByte[2]==0x00) {
            //重置完成
            Num++;
            if (Num<selectIpArr.count) {
                [self resetScreenPlayList];
            }else{
                Num = 0;
            [self showRestScreenSuccess];
            }

        }else{
            //重置失败
            [self showRestScreenfailed];
        }
    }

    if (AckByte[1] == 0x2C) {
        DLog(@"发送连续播放数据成功");
        isContinusPlay = YES;
        [self myFinishedPublishEvent];
        Num++;
        if (Num<selectIpArr.count) {
            isContinusPlay = YES;
            [self startupPublish];
        }else{
            Num = 0;
//            isloops = NO;

        }

    }
    if (AckByte[1] == 0x4c) {
        Num++;
        if (Num<iparr.count) {
            [self qxzp];
        }else{
            Num = 0;
        }
    }
    if(AckByte[1]==0x12){
        DLog(@"获取屏幕亮度成功");
        NSString *red=[NSString stringWithFormat:@"%x",AckByte[4]];
        NSString *green=[NSString stringWithFormat:@"%x",AckByte[5]];
        NSString *blue=[NSString stringWithFormat:@"%x",AckByte[6]];
        NSString *alpha=[NSString stringWithFormat:@"%x",AckByte[3]];
        _red2=strtoul([red UTF8String], 0, 16);
        _green2=strtoul([green UTF8String], 0, 16);
        _blue2=strtoul([blue UTF8String], 0, 16);
        _alpha2=strtoul([alpha UTF8String], 0, 16);
        _height2=strtoul([[NSString stringWithFormat:@"%x",AckByte[7]] UTF8String], 0, 16)+strtoul([[NSString stringWithFormat:@"%x",AckByte[8]] UTF8String], 0, 16)*255;
        _width2=strtoul([[NSString stringWithFormat:@"%x",AckByte[9]] UTF8String], 0, 16)+strtoul([[NSString stringWithFormat:@"%x",AckByte[10]] UTF8String], 0, 16)*255;
        if(strtoul([[NSString stringWithFormat:@"%x",AckByte[8]] UTF8String], 0, 16)>0){
            _height2=_height2+1;
        }
        if(strtoul([[NSString stringWithFormat:@"%x",AckByte[10]] UTF8String], 0, 16)>0){
            _width2=_width2+1;
        }
//        DLog(@"获取rgba===%d,%d,%d,%d,%d,%d",_red2,_green2,_blue2,_alpha2,_height2,_width2);

        [self changeBrightnessColorButtonClick];
    }
    if(AckByte[1]==0x13){
        DLog(@"设置成功");
    }
    
    
    [_sendPlayerSocket readDataWithTimeout: -1 tag: tag];
}



- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    DLog(@"willDisconnectWithError, err = %@", err);
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    DLog(@"%s %d", __FUNCTION__, __LINE__);
    if (isSendState) {
        [self stopPublishProgress];
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }
}

/**
 *  项目发送完成的处理
 */
-(void)myFinishedPublishEvent{
    if (isSendState) {
        [mySelectedProjectArray removeAllObjects],mySelectedProjectArray = nil;

        DLog(@"发送项目成功");
        _currentDataAreaIndex = 0;
        if (_currentDataArray) {
            [_currentDataArray removeAllObjects];
            [_currentDataArray release],_currentDataArray = nil;
        }
        isSendConfig = NO;
        isSendContent = NO;
        isAllSend = NO;

        /**
         *  如果是连续播放，则提示命令发送成功
         */
        if (isContinusPlay) {
            isContinusPlay = NO;
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_playsendCompleted"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
        }else{
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_sendCompleted"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
        }
        [self stopPublishProgress];
        [myProjectCtrl reloadMyPlaylist];
    }
}

/**
 *  设置屏幕亮度
 *
 *  @param commandType   命令类型
 *  @param contentBytes  发送内容
 *  @param contentLength 内容长度
 */

-(void)commandServerWithType:(Byte)commandType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength
{
    NSInteger a=_height2%256;
    NSInteger b=_height2/256;
    NSInteger c=_width2%256;
    NSInteger d=_width2/256;
    int byteLength = 13;
    Byte outdate[byteLength];
    memset(outdate, 0x00, byteLength);
    outdate[0]=0x7D;
    outdate[1]=commandType;//命令类型
    outdate[2]=0x00; /*命令执行与状态检查2：获取服务器端的数据*/
    outdate[3]=_alpha1;
    outdate[4]=_red1;
    outdate[5]=_green1;
    outdate[6]=_blue1;
    outdate[7]=a;
    outdate[8]=b;
    outdate[9]=c;
    outdate[10]=d;
    outdate[11]=9;
    outdate[12]=0xff;
//    outdate[byteLength-3]=(Byte)byteLength;
//    outdate[byteLength-2]=(Byte)(byteLength>>11);
    //计算校验码

    int sumByte = 0;
    for (int j=0; j<(byteLength-1); j++) {
        sumByte += outdate[j];
    }
    //校验码计算（包头到校验码前所有字段求和取反+1）
    outdate[(byteLength-1)]=~(sumByte)+1;
    long tag = outdate[1];
    DLog(@"恢复默认列表 = %d",(int)commandType);
    NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:byteLength];
    DLog(@"udpPacketData=======%@",udpPacketData);
    [_sendPlayerSocket writeData:udpPacketData withTimeout:-1 tag:tag];
}
/**
 *  重置服务端
 *
 *  @param commandType   命令类型
 *  @param contentBytes  发送内容
 *  @param contentLength 内容长度
 */
-(void)commandResetServerWithType:(Byte)commandType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength
{
    int byteLength = 6;
    Byte outdate[byteLength];
    memset(outdate, 0x00, byteLength);
    outdate[0]=0x7D;
    outdate[1]=commandType;//命令类型
    outdate[2]=0x00; /*命令执行与状态检查2：获取服务器端的数据*/
    outdate[byteLength-3]=(Byte)byteLength;
    outdate[byteLength-2]=(Byte)(byteLength>>8);
    //计算校验码
    int sumByte = 0;
    for (int j=0; j<(byteLength-1); j++) {
        sumByte += outdate[j];
    }
    //校验码计算（包头到校验码前所有字段求和取反+1）
    outdate[(byteLength-1)]=~(sumByte)+1;
    long tag = outdate[1];
    DLog(@"恢复默认列表 = %d",(int)commandType);
    NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:byteLength];
    DLog(@"udpPacketData=======%@",udpPacketData);
    [_sendPlayerSocket writeData:udpPacketData withTimeout:-1 tag:tag];
}

/**
 *  使用选择区域的索引刷新播放列表
 *
 *  @param selectAreaIndex 被选择的可编辑区域的索引
 */
-(void)refreshMyPlayListWithScreenAreaIndex:(NSInteger)selectAreaIndex{
    //清空单个区域素材列表,按照区域编号到项目素材字典中查询当前编辑区域素材列表
    NSArray *myMaterialListKeyArray = [_projectMaterialDictionary allKeys];
    if (myMaterialListKeyArray) {
        if ([myMaterialListKeyArray isKindOfClass:[NSArray class]]) {
            if ([myMaterialListKeyArray indexOfObject:[NSString stringWithFormat:@"%d",selectAreaIndex]]) {
                for (NSString *sKey in myMaterialListKeyArray) {
                    NSInteger *iKey = [sKey integerValue];
                    [self refreshScelectAreaMatrialListWithTag:iKey];
                }
            }
        }
    }
}


/**
 *  使用时间字符串去更新项目名称文本框里的字符串，每一秒更新一次
 *
 *  @param myTimer 定时器
 */
-(void)updateProjectName:(NSTimer *)myTimer{
    UITextField *myTextField = (UITextField *)[self.view viewWithTag:TAG_PROJECT_NAME_TEXTFIELD];
    [myTextField setText:[self getNowdateString]];
}

/**
 *  文本滚动的速度的下拉框的回调
 *
 *  @param sender 触发对象
 */
- (void)speedButton:(BaseButton *)sender {
    if (speedIsOpend) {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"dropdown.png"];
            [speedButton setImage:closeImage forState:UIControlStateNormal];
            CGRect frame=speedTableBlock.frame;
            frame.size.height=1;
            [speedTableBlock setFrame:frame];
        } completion:^(BOOL finished){
            speedIsOpend=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"dropup.png"];
            [speedButton setImage:openImage forState:UIControlStateNormal];
            CGRect frame=speedTableBlock.frame;
            frame.size.height=[speedArray count]*30;
            [speedTableBlock setFrame:frame];
        } completion:^(BOOL finished){
            speedIsOpend=YES;
        }];
    }
}

/**
 *  画面运动方向的下拉框的回调
 *
 *  @param sender 触发者
 */
- (void)directionButtonClicked:(BaseButton *)sender {
    if (directionIsOpend) {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"dropdown.png"];
            [speedButton setImage:closeImage forState:UIControlStateNormal];
            CGRect frame=directionTableBlock.frame;
            frame.size.height=1;
            [directionTableBlock setFrame:frame];
        } completion:^(BOOL finished){
            directionIsOpend=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"dropup.png"];
            [directionButton setImage:openImage forState:UIControlStateNormal];
            CGRect frame=directionTableBlock.frame;
            frame.size.height=[directionArray count]*30;
            [directionTableBlock setFrame:frame];
        } completion:^(BOOL finished){
            directionIsOpend=YES;
        }];
    }
}

/**
 *  文本字体大小设置的下拉框的回调事件
 *
 *  @param sender 触发的按钮
 */
- (void)sizeButton:(BaseButton *)sender {
    if (sizeIsOpend) {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"dropdown.png"];
            [sizeButton setImage:closeImage forState:UIControlStateNormal];
            CGRect frame=sizeTableBlock.frame;
            frame.size.height=1;
            [sizeTableBlock setFrame:frame];
        } completion:^(BOOL finished){
            sizeIsOpend=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"dropup.png"];
            [sizeButton setImage:openImage forState:UIControlStateNormal];
            CGRect frame=sizeTableBlock.frame;
            frame.size.height=[sizeArray count]*30;
            [sizeTableBlock setFrame:frame];
        } completion:^(BOOL finished){
            sizeIsOpend=YES;
        }];
    }
}


/**
 *  点击覆盖在项目列表之上的蒙版时触发这个方法
 *
 *  @param myTouch 接受Tap事件
 */
-(void)showPromptPexitEdit:(UITapGestureRecognizer*)myTouch{
    if (isEditProject) {
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_isediting"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView setTag:TAG_IS_EDITING_PROJECT_ALERT];
        [myAlertView show];
        [myAlertView release];
    }
}

/**
 *  解析XML文件
 *
 *  @param xmppath 传入xml文件的路径
 */
-(NSDictionary*)parseXMLwithPath:(NSString*)xmppath{
    @try {
        DLog(@"开始XML解析,path = %@",xmppath);
        DLog(@"完成XML解析 = %@",[NSDictionary dictionaryWithXMLFile:xmppath]);
        return [NSDictionary dictionaryWithXMLFile:xmppath];
    }
    @catch (NSException *exception) {
        DLog(@"解析XML为字典时报错 = %@",exception);
    }
    @finally {

    }
}

/**
 *@brief 获得当前的时间，例如2013-08-11 16:05:03
 */
+(NSString*)getCurrentDateString{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH:mm:ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    return morelocationString;
}


//获取指定文件的大小的方法
+(long long)fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        DLog(@"文件的大小:%lld",[[manager attributesOfItemAtPath:filePath error:nil] fileSize]);
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


/**
 *  屏幕高度和宽度不在范围内的弹出框提示
 */
-(BOOL)screenHeightErrorAlertWithW:(NSString*)w andH:(NSString*)h{
    if (([w integerValue]<10)||([h integerValue]<10)||([w integerValue]>MAX_MASTERSCREEN_WIDTH)||([h integerValue]>MAX_MASTERSCREEN_HEIGHT)) {
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_screenheighterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
        return NO;
    }else{
        return YES;
    }
}


/**
 *  创建百叶窗动画
 *
 *  @param srcImage 通过一个UIImage对象创建一个百叶窗动画
 */
-(void)createBaiYeWith:(UIImage *)srcImage{
    @try {
        //清理资源
        UIView *myView = [self.view viewWithTag:1004];
        for (UIView *tempView in [myView subviews]) {
            [tempView removeFromSuperview];
        }
        // 调用下述函数分割图片，得到相应的dictionary，以不同的图片文件名作为key
        [self myBaiYeTimerEvent:[BaiImage SeparateImage:srcImage ByX:BAIYECHUANG_YEKUAN andY:1 cacheQuality:0.5]];
    }
    @catch (NSException *exception) {
        DLog(@"exception = %@",exception);
    }
    @finally {

    }

}

/**
 *  把一张图片分割为N份，然后存入一个字典，传入整个方法，在方法内部使用动画生成百叶窗
 *
 *  @param myBaiYeDict 百叶窗图片各个部分组成的字典
 */
-(void)myBaiYeTimerEvent:(NSDictionary *)myBaiYeDict{
    NSArray *keys = [myBaiYeDict allKeys];
    // 设置动画的各种参数
    CABasicAnimation *mrotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    mrotation.duration = 1.0;
    mrotation.fromValue=[NSNumber numberWithFloat:M_PI/1.5];
    mrotation.toValue=[NSNumber numberWithFloat:0];
    mrotation.timingFunction=[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    mrotation.autoreverses=NO;
    mrotation.repeatCount=1;


    UIView *myView = [self.view viewWithTag:1004];
    // 给所有小图片添加动画
    for (int count=0; count<BAIYECHUANG_YEKUAN; count++)
    {
        @autoreleasepool {
            NSString *key = [keys objectAtIndex:count];
            UIImageView *imageView = [myBaiYeDict objectForKey:key];
            [imageView.layer addAnimation:mrotation forKey:@"rotation"];
            [myView addSubview:imageView];
            [imageView release];
        }
    }
}


-(void)myRelease{
    RELEASE_SAFELY(myMasterCtrl);
    RELEASE_SAFELY(myPlayListCtrl);
    RELEASE_SAFELY(myProjectCtrl);
    //项目列表
    RELEASE_SAFELY(_projectArray);
    RELEASE_SAFELY(timerKillerArray);
    RELEASE_SAFELY(movewController);
    RELEASE_SAFELY(defaultImageArray);
    //使用流打开图片出错的列表
    RELEASE_SAFELY(analyzeImageDataErrorPathArray);
    //需要控制是否显示的视图集合
    RELEASE_SAFELY(myEditerCtrlViewArray);
    //需要高亮的按钮集合
    RELEASE_SAFELY(myCtrlButtonArray);
    //项目素材字典,按照区域编号去索引区域内的素材列表
    RELEASE_SAFELY(_projectMaterialDictionary);
    //字体的大小的数组
    RELEASE_SAFELY(fontSizeArray);
    //场景素材列表视图集合
    RELEASE_SAFELY(mySceneViewArray);
    //场景列表控制显示按钮的集合
    RELEASE_SAFELY(mySceneButtonArray);
    //更多设置界面中
    RELEASE_SAFELY(myMoreDict);
    RELEASE_SAFELY(directionArray);
    RELEASE_SAFELY(fontArray);
    RELEASE_SAFELY(speedArray);
    RELEASE_SAFELY(sizeArray);
    RELEASE_SAFELY(myMusicPicker);
}



#pragma mark Core Animation动画
/**
 *  在两个视图直接执行CoreAnimation
 *
 *  @param animationTag       执行动画的类型数字编号从101到112
 *  @param oldView            旧的视图
 *  @param newView            新的视图
 *  @param transitionFromType 动画从什么方向出来的编号从0到3
 */
-(void)startCoreAnimationWithAnimationTag:(NSInteger)animationTag AndtransitionFromType:(NSInteger)transitionFromType AndSuperView:(UIView*)superView{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    switch (animationTag) {
        case 101:
            animation.type = kCATransitionFade;
            break;
        case 102:
            animation.type = kCATransitionPush;
            break;
        case 103:
            animation.type = kCATransitionReveal;
            break;
        case 104:
            animation.type = kCATransitionMoveIn;
            break;
        case 105:
            DLog(@"立方体翻滚效果");
            animation.type = @"cube";
            break;
        case 106:
            DLog(@"收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)");
            animation.type = @"suckEffect";
            break;
        case 107:
            DLog(@"上下左右翻转效果");
            animation.type = @"oglFlip";
            break;
        case 108:
            DLog(@"滴水效果,(不支持过渡方向)");
            animation.type = @"rippleEffect";
            break;
        case 109:
            DLog(@"向上翻一页");
            animation.type = @"pageCurl";
            break;
        case 110:
            DLog(@"向下翻一页");
            animation.type = @"pageUnCurl";
            break;
        case 111:
            DLog(@"旋转效果");
            animation.type = @"rotate";
            break;
        case 112:
            DLog(@"立方体翻滚效果");
            animation.type = @"genieEffect";
            break;
        case 113:
            DLog(@"相机镜头打开效果(不支持过渡方向)");
            animation.type = @"cameraIrisHollowOpen";
            break;
        case 114:
            DLog(@"相机镜头关上效果(不支持过渡方向)");
            animation.type = @"cameraIrisHollowClose";
            break;
        default:
            break;
    }

    switch (transitionFromType) {
        case 0:
            animation.subtype = kCATransitionFromLeft;
            break;
        case 1:
            animation.subtype = kCATransitionFromBottom;
            break;
        case 2:
            animation.subtype = kCATransitionFromRight;
            break;
        case 3:
            animation.subtype = kCATransitionFromTop;
            break;
        default:
            break;
    }

    [[superView layer] addAnimation:animation forKey:@"animation"];
}


/**
 *  添加场景切换按钮
 *
 *  @param buttonTag 场景切换按钮的tag
 */
-(void)addSceneButtonToArrayWithTag:(NSInteger)buttonTag{
    @try {
        UIButton *myButton = ((UIButton *)[self.view viewWithTag:buttonTag]);
        if ([mySceneButtonArray indexOfObject:myButton] == NSNotFound) {
            [mySceneButtonArray addObject:myButton];
        }
    }
    @catch (NSException *exception) {
        DLog(@"addCtrlButtonToArrayWithTag方法中异常 =%@",exception);
    }
    @finally {

    }
}

/**
 *  需要高亮显示的场景列表切换按钮
 *
 *  @param buttonTag 按钮的tag
 */
-(void)highlightSceneButtonWithTag:(NSInteger)buttonTag{
    for (UIButton *myButton in mySceneButtonArray) {
        if (myButton.tag == buttonTag) {
            [myButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        }else{
            [myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

/**
 *  根据点击的功能按钮来显示场景列表区域
 *
 *  @param viewTag 要显示的功能区域的标签
 */
-(void)showOneSceneViewWithTag:(NSInteger)viewTag{
    for (UIView *myView in mySceneViewArray) {
        if (myView.tag == viewTag) {
            [myView setHidden:NO];
        }else{
            [myView setHidden:YES];
        }
    }
}

/**
 *  素材列表中的更多按钮的处理事件
 *
 *  @param assetDict     被选择的行的数据
 *  @param cellIndexPath 被选择行的索引
 */
-(void)deleteButtonClicked:(NSDictionary *)assetDict cellIndexPath:(NSIndexPath *)cellIndexPath andSwipeTableViewCell:swipeTableViewCell{
    myMoreDict = assetDict;
    DLog(@"myMoreDict = %@",myMoreDict);
    myMoreIndexPath = cellIndexPath;
    myMoreCell = swipeTableViewCell;

    _currentSelectRow = cellIndexPath.row;

    UIView *myEditCtrlView = [self.view viewWithTag:TAG_EDIT_CONTROLLER_VIEW];
    //设置区域内的素材列表上的更多按钮点击后功能区域的视图

    UIView *myMoreFuncView = [[UIView alloc]initWithFrame:CGRectMake(0+myEditCtrlView.frame.size.width, 0, myEditCtrlView.frame.size.width, myEditCtrlView.frame.size.height)];
    [myMoreFuncView setTag:TAG_MY_MORE_RUNC_VIEW];
    [myMoreFuncView setBackgroundColor:[UIColor whiteColor]];
    [myEditCtrlView addSubview:myMoreFuncView];
    [myMoreFuncView release];
    [UIView animateWithDuration:0.6 animations:^{
        [myMoreFuncView setFrame:CGRectMake(0, 0, myEditCtrlView.frame.size.width, myEditCtrlView.frame.size.height)];
    }];

    UIView *myFuncSubView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, myMoreFuncView.frame.size.width - 10, myMoreFuncView.frame.size.height - 30)];
    [myFuncSubView setTag:TAG_MY_MORE_RUNC_SUBVIEW];
    [myFuncSubView.layer setBorderColor:[UIColor blackColor].CGColor];
    [myFuncSubView.layer setBorderWidth:1];
    [myMoreFuncView addSubview:myFuncSubView];
    [myFuncSubView release];
    //设置面板的返回按钮
    CGRect buttonRect = CGRectMake(20, 20, 100, 44);
    [self creteeButtonWithFrame:buttonRect andTag:TAG_MY_MORE_RUNC_VIEW_BACKBUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_moreivew_backbutton"] superViewTag:TAG_MY_MORE_RUNC_SUBVIEW];

    //设置面板上的删除按钮
    CGRect buttonRect1 = CGRectMake(20, buttonRect.origin.y + buttonRect.size.height + 20, 100, 44);
    [self creteeButtonWithFrame:buttonRect1 andTag:TAG_MY_MORE_RUNC_VIEW_DELETE_BUTTON andAction:@selector(functionButtonClick:) andTitle:[Config DPLocalizedString:@"adedit_moreivew_deletebutton"] superViewTag:TAG_MY_MORE_RUNC_SUBVIEW];

    //动画的方向
    CGRect directionRect = CGRectMake(20, buttonRect1.origin.y + buttonRect1.size.height + 20, 200, 44);

    //后场景选择项播放时间设置文本框
    MaterialObject *myMaterialObject = (MaterialObject*)[assetDict objectForKey:@"asset"];
    NSString *durationStr = nil;
    if ([myMaterialObject material_duration]) {
        durationStr = [[NSString alloc]initWithFormat:@"%d",[myMaterialObject material_duration]];
    }
    if (durationStr==nil) {
        durationStr = [[NSString alloc]initWithFormat:@"%@",DEFAULT_TIME];
    }

    CGRect xRect = CGRectMake( 20 , directionRect.origin.y + directionRect.size.height +20, 200, 44);
    [self createRegionPropertiesViewWithFrame:xRect viewTag:9001 leftLabelText:[Config DPLocalizedString:@"adedit_Duration"] superViewTag:TAG_MY_MORE_RUNC_SUBVIEW defaultText:durationStr];

    CGRect alphaRect = CGRectMake( 20 , xRect.origin.y + xRect.size.height +20, 200, 44);
    //获取配置文件中是否透明
    [self createAlphaFieldWithFrame:alphaRect andTag:TAG_MY_MORE_ALPHA_SELECT superViewTag:TAG_MY_MORE_RUNC_SUBVIEW andAssetDict:assetDict];

    //获取配置文件中运动方向
    [self createDirectionTextFieldWithFrame:directionRect andTag:TAG_MY_MORE_DIRECTION_SELECT superViewTag:TAG_MY_MORE_RUNC_SUBVIEW andAssetDict:assetDict];
}
/**
 *  清除项目名称
 */
-(void)cleanProjectName{
    UITextField *projectNameText = (UITextField *)[self.view viewWithTag:TAG_PROJECT_NAME_TEXTFIELD];
    [projectNameText setText:@""];
}

/**
 *  显示提示退出播放的窗口
 */
-(void)showExitPromptDialog{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_quitplayafterswitch"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    [myAlertView release];
}

/**
 *  启动项目搜索进度指示
 */
-(void)startSearchActi{
    UITextField *searchTextField = (UITextField*)[self.view viewWithTag:TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD];
    UIActivityIndicatorView *myIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, searchTextField.frame.size.width, searchTextField.frame.size.height)];

    [myIndicatorView setBackgroundColor:[UIColor brownColor]];
    [myIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [myIndicatorView setTag:TAG_SEARCH_INDICATOR_VIEW];
    [searchTextField addSubview:myIndicatorView];
    [myIndicatorView startAnimating];
    [myIndicatorView release];
}
/**
 *  停止项目搜索进度指示
 */
-(void)stopSearchActi{
    UIActivityIndicatorView *myActiView = (UIActivityIndicatorView *)[self.view viewWithTag:TAG_SEARCH_INDICATOR_VIEW];
    [myActiView stopAnimating];
    [myActiView removeFromSuperview];
}


/**
 *  用户选择项目列表中的某个项目上的选择框时的回调
 *
 *  @param mySelectedProjectList 用户已经选择的项目列表
 */
-(void)selectedProjectWithObject:(NSMutableArray *)mySelectedProjectList{
    if (mySelectedProjectArray==nil) {
        mySelectedProjectArray = [[NSMutableArray alloc]initWithArray:mySelectedProjectList];
    }else{
        [mySelectedProjectArray removeAllObjects];
        [mySelectedProjectArray setArray:mySelectedProjectList];
    }

    DLog(@"mySelectedProjectList.count = %d",[mySelectedProjectList count]);
    UIButton *myButton = (UIButton*)[self.view viewWithTag:TAG_PUBLISH_PROJ_BUTTON];
    if (myButton==nil) {
        myButton = (UIButton*)[self.view viewWithTag:TAG_CREATE_GROUP_BUTTON];
    }
    if ([mySelectedProjectList count] > 0) {
        DLog(@"连续播放");
        myButton.titleLabel.text = [Config DPLocalizedString:@"adedit_continuous_play"];
        [myButton setTag:TAG_CREATE_GROUP_BUTTON];
        isContinusPlay = YES;
    }else{
        DLog(@"发布项目");
        myButton.titleLabel.text = [Config DPLocalizedString:@"adedit_PublishProj"];
        [myButton setTag:TAG_PUBLISH_PROJ_BUTTON];
        isContinusPlay = NO;
    }
    [self changeDeleteBAndEditBState];
}


/**
 *  改变删除项目和编辑项目按钮的状态
 */
-(void)changeDeleteBAndEditBState{
    UIButton *myDeleteButton = (UIButton *)[self.view viewWithTag:TAG_DELETE_PROJ_BUTTON];
    [myDeleteButton setHidden:isContinusPlay];

    UIButton *myEditButton = (UIButton *)[self.view viewWithTag:TAG_EDIT_PROJ_BUTTON];
    [myEditButton setHidden:isContinusPlay];

}

/**
 *  清除所有的复选框
 */
-(void)clearSelectBox{
    [myProjectCtrl useGroupInfoReloadProjectList];
    [self selectedProjectWithObject:nil];
}

/**
 *  创建需要传送给服务端的分组文件
 */
-(void)createGroupXMLFileWithDictionary:(NSDictionary*)myDict andSavePath:(NSString *)savePath andEdit:(BOOL)isEditXML{

    @try {
        if ((!myDict)||(![myDict isKindOfClass:[NSDictionary class]])) {
            return;
        }
        //创建根节点
        GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"playlist"];

        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithDictionary:myDict];

        //创建分组名称节点
        NSString *proejctName = [tempDictionary objectForKey:@"playlistname"];
        GDataXMLElement *projectNameElement = [GDataXMLNode elementWithName:@"playlistname" stringValue:proejctName];
        //添加子节点到根节点上
        [rootElement addChild:projectNameElement];

        //项目列表
        NSArray *playListArray = [tempDictionary objectForKey:@"playlist"];
        if (playListArray) {
            if ([playListArray isKindOfClass:[NSArray class]]) {
                for (int i=0; i<[playListArray count]; i++) {
                    ProjectListObject *oneProjectListObject = [playListArray objectAtIndex:i];
                    //创建项目节点
                    GDataXMLElement *materialListElement = [GDataXMLNode elementWithName:@"playlistElement"];

                    GDataXMLElement *selectAreaIndexElement = [GDataXMLElement elementWithName:@"playlistindex" stringValue:[NSString stringWithFormat:@"%d",i]];
                    [materialListElement addChild:selectAreaIndexElement];

                    GDataXMLElement *filepathElement = [GDataXMLElement elementWithName:@"filepath" stringValue:[NSString stringWithFormat:@"%@",[oneProjectListObject.project_filename lastPathComponent]]];
                    [materialListElement addChild:filepathElement];

                    [rootElement addChild:materialListElement];
                }
            }
        }

        //使用根节点创建xml文档
        GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
        //设置使用的xml版本号
        [rootDoc setVersion:@"1.0"];
        //设置xml文档的字符编码
        [rootDoc setCharacterEncoding:@"utf-8"];
        //获取并打印xml字符串
        NSString *XMLDocumentString = [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
        //文件字节大小
        fileSize = [rootDoc.XMLData length];
        if (isEditXML) {
            xmlfilePath = [[NSString alloc]initWithFormat:@"%@",savePath];;
        }else{
            xmlfilePath = [[NSString alloc]initWithFormat:@"%@",[[self documentGroupXMLDir]
                                                                 stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",@"playlist"]]];
        }
        DLog(@"保存分组文件XML路径 = %@",xmlfilePath);
        [[NSFileManager defaultManager] removeItemAtPath:xmlfilePath error:nil];
        NSError *error = nil;
        BOOL writeFileBool = [XMLDocumentString writeToFile:xmlfilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (writeFileBool) {
            DLog(@"保存分组文件为xml成功");
        }else{
            DLog(@"保存分组文件为xml失败；error = %@", error);
        }
        [myProjectCtrl useGroupInfoReloadProjectList];
        [mySelectedProjectArray removeAllObjects],mySelectedProjectArray = nil;
        [rootDoc release];
    }
    @catch (NSException *exception) {
        DLog(@"保存分组文件为xml出错；exception = %@", exception);
    }
    @finally {

    }
}


/**
 *  获取或者创建分组xml文件所在的路径
 *
 *  @return 分组xml文件所在的路径
 */
-(NSString*)documentGroupXMLDir{
    NSFileManager *myFileManager = [NSFileManager defaultManager];
    NSString *documentsGroupXMLDir = [[[NSString alloc]initWithFormat:@"%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/GroupXMLDir"]] autorelease];
    BOOL isDir;
    if (![myFileManager fileExistsAtPath:documentsGroupXMLDir isDirectory:&isDir]) {
        [myFileManager createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/GroupXMLDir"] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentsGroupXMLDir;
}

/**
 *  删除图片文件
 *
 *  @param myPathString 传入图片文件的路径
 */
-(void)deletePictureFileWithPath:(NSString *)myPathString{
    NSFileManager *fileMgr = [NSFileManager defaultManager];

    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/ProjectCaches"]];
    //删除文件的路径
    NSString *deleteFilePath = [[NSString alloc]initWithFormat:@"%@/%@",documentsDirectory,myPathString];

    NSError *myError = nil;
    if ([fileMgr fileExistsAtPath:deleteFilePath]) {
        [fileMgr removeItemAtPath:deleteFilePath error:&myError];
    }
    if (myError == nil) {
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_grouppicdeletesuccess"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }else{
        DLog(@"myError = %@",myError);
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_grouppicdeletefailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }
    [deleteFilePath release];
}


/**
 *  调节音量的滑块的事件
 *
 *  @param mySlider 滑块对象
 */
-(void)changeVolumeEvent:(ASValueTrackingSlider *)mySlider{
    @try {
        DLog(@"%lf",mySlider.value);
        [myMusicPicker.myMusicPlayer setVolume:mySlider.value/100];
        _musicVolume = [[NSString alloc]initWithFormat:@"%0.0lf",mySlider.value];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    @finally {

    }
}

/**
 *  选择音频的时候的回调
 *
 *  @param mySelectedMediaItem 音频的属性集
 */
-(void)selectedMuisc:(NSString *)mySelectedMediaItem andMusicName:(NSString *)sMyMusicName{
    DLog(@"mySelectedMediaItem = %@",mySelectedMediaItem);
    NSURL *url = [[NSURL alloc]initFileURLWithPath:mySelectedMediaItem];
    AVAsset *myMusicAsset  = [AVAsset assetWithURL:url];
    [url release];
    CMTime assetTime = [myMusicAsset duration];//获取视频总时长,单位秒
    Float64 assetDuration = CMTimeGetSeconds(assetTime); //返回float64格式
    _musicDuration = [[NSString alloc]initWithFormat:@"%lf",assetDuration];
    if (sMyMusicName) {
        _musicName = sMyMusicName;
    }
    if (!_musicName) {
        _musicName = [mySelectedMediaItem lastPathComponent];
    }
    [musicNameLabel setText:_musicName];
    [musicPlaytimeLabel setText:_musicDuration];
    _musicFilePath = mySelectedMediaItem;
    _musicVolume = @"50";
}

/**
 *  项目播放完毕清理所有的定时器
 *
 *  @param tsender 定时器对象
 */
-(void)stopPhotoEvent:(NSTimer *)tsender{
    if (tsender) {
        [self clearAllTimer];
    }

}

/**
 *  播放间隔时间设置到cell
 */
-(void)setTimeToCell{
    //获取时间设置文本框
    UITextField *tempFidld = (UITextField *)[self.view viewWithTag:9001];
    NSString *durationText = tempFidld.text;
    if ((durationText)&&([durationText length]>0)) {
        //间隔时间不能小于1秒
        int iDurationSecend = [durationText intValue];
        if (iDurationSecend<1) {
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_durationdonttoolittle"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            return;
        }

        //根据点击的图层或场景索引选择数据源
        [self validateCurrentScene];
        NSMutableArray *selectAreaArray = [[NSMutableArray alloc]initWithArray:[_projectMaterialDictionary objectForKey:_currentScenes]];
        NSDictionary *selectDict = [selectAreaArray objectAtIndex:_currentSelectRow];
        MaterialObject *oneMaterialObj = [selectDict objectForKey:@"asset"];
        if ([oneMaterialObj.material_type isEqual:@"Photo"]) {
            NSDictionary *assetDict = [[NSDictionary alloc]initWithObjectsAndKeys:durationText,@"duration",oneMaterialObj,@"asset",nil];
            [selectAreaArray replaceObjectAtIndex:_currentSelectRow withObject:assetDict];
            [_projectMaterialDictionary removeObjectForKey:_currentScenes];
            [_projectMaterialDictionary setObject:selectAreaArray forKey:_currentScenes];
            [myPlayListCtrl setDurationToCell:[NSIndexPath indexPathForRow:_currentSelectRow inSection:0] duration:durationText];
        }else{
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_videodontsetduration"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
        }
    }else{
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_durationnotnull"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }
}

/**
 * @brief 创建播放区域视图
 */
-(void)createPlayAreaView:(NSDictionary *)oneAreaDict andAreaKey:(NSString *)sAreaKey{
//    NSDictionary *oneMaterialDict = [oneAreaDict objectForKey:[[oneAreaDict allKeys] firstObject]];
//    NSInteger w = [[oneMaterialDict objectForKey:@"w"] integerValue];
//    NSInteger h = [[oneMaterialDict objectForKey:@"h"] integerValue];
//    NSInteger x = [[oneMaterialDict objectForKey:@"x"] integerValue];
//    NSInteger y = [[oneMaterialDict objectForKey:@"y"] integerValue];
    NSInteger w = 0;
    NSInteger h = 0;
    NSInteger x = 0;
    NSInteger y = 0;
    NSString *sMasterScreenX = @"0";
    sMasterScreenX = [oneAreaDict objectForKey:@"masterScreenX"];
    NSString *sMasterScreenY = @"0";
    sMasterScreenY = [oneAreaDict objectForKey:@"masterScreenY"];
    NSString *sMasterScreenW = @"0";
    sMasterScreenW = [oneAreaDict objectForKey:@"masterScreenW"];
    NSString *sMasterScreenH = @"0";
    sMasterScreenH = [oneAreaDict objectForKey:@"masterScreenH"];
    x = [sMasterScreenX integerValue];
    y = [sMasterScreenY integerValue];
    w = [sMasterScreenW integerValue];
    h = [sMasterScreenH integerValue];

    NSInteger iAreaKey = [sAreaKey integerValue];
    UIView *areaView = [self.view viewWithTag:iAreaKey];
    if ((!areaView)||(![areaView isKindOfClass:[UIView class]])) {
        [self createViewFactory:CGRectMake(x, y, w, h) viewTag:iAreaKey];
        areaView = [self.view viewWithTag:iAreaKey];
        if ([self.evaluateViews indexOfObject:areaView]==NSNotFound) {
            NSMutableArray *tempArray = [[NSMutableArray alloc]init];
            for (UIView *t in self.evaluateViews) {
                [tempArray addObject:t];
            }
            [tempArray addObject:areaView];
            [self setEvaluateViews:tempArray];
            [tempArray release];
        }
    }else{
        [areaView setFrame:CGRectMake(x, y, w, h)];
    }
}

/**
 *@brief 根据视图的KEY去删除视图
 */
-(void)deletViewWithKey:(NSInteger)iAreaKey{
    @try {
        UIView *areaView = [self.view viewWithTag:iAreaKey];
        if ([self.evaluateViews indexOfObject:areaView]!=NSNotFound) {
            NSMutableArray *tempArray = [[NSMutableArray alloc]init];
            for (UIView *t in self.evaluateViews) {
                if (t.tag!=iAreaKey) {
                    [tempArray addObject:t];
                }
            }
            [self setEvaluateViews:tempArray];
            [tempArray release];
        }
        [areaView removeFromSuperview];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    @finally {
        
    }
}

/**
 *@brief 切换场景按钮的事件
 */
-(void)switchSceneButtonClickEvent:(UIButton*)sender{
    if (sender) {
        if (sender.tag != NSNotFound) {
            //高亮所选场景的按钮
            [self highlightSceneButtonWithTag:sender.tag];
            //当前选择的场景
            _currentScenes = [[NSString alloc]initWithFormat:@"%d",sender.tag-5000];
            //刷新素材列表
            [self refreshScelectAreaMatrialListWithTag:[_currentScenes integerValue]];
        }
    }
}


/**
 *@brief 验证场景或图层的编号
 */
-(void)validateCurrentScene{
    if (!_currentScenes) {
        if (_currentSelectIndex!=VIEW_TAG_TEXT_AREA_1005) {
            _currentScenes = [[NSString alloc]initWithFormat:@"%d",_currentSelectIndex];
        }else{
            _currentScenes = [[NSString alloc]initWithFormat:@"%d",VIEW_TAG_EDITOR_1004];
        }
    }
}

/**
 *@brief 秒转毫秒
 */
-(NSString*)musicDurationSecondToMillisecond:(float)second{
    return [NSString stringWithFormat:@"%ld",(NSInteger)(second*1000.0f)];
}

/**
 *@brief 毫秒转秒
 */
-(float)musicDurationMillisecondToSecond:(NSInteger)millisecond{
    if (millisecond>0) {
        return millisecond/1000;
    }
    return 0;
}


/**
 *@brief 解析素材数据字典为素材对象字典
 */
-(NSDictionary*)analysisDataToMaterialObjectWith:(NSDictionary *)oneListItemDict{
    UIView *view = [self.view viewWithTag:924];
    NSInteger masterScreenHeight = self.view.frame.size.width - 46;
    if (view.frame.origin.y == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            [view setFrame:CGRectMake(view.frame.origin.x,-masterScreenHeight, view.frame.size.width, view.frame.size.height)];
        }];
    }

    NSString *materialFilePath = [[NSString alloc]initWithFormat:@"%@/%@",[_currentProjectPathRoot lastPathComponent],[oneListItemDict objectForKey:@"filename"]];
     NSString *playFilePath = [[NSString alloc]initWithFormat:@"%@/%@",[LayoutYXMViewController defaultProjectRootPath],materialFilePath];
    
    DLog(@"_waitForUploadFilesArray add %@",playFilePath);
    [_waitForUploadFilesArray addObject:playFilePath];
    MaterialObject *myMaterial = [[MaterialObject alloc]init];
    [myMaterial setMaterial_path:materialFilePath];
    [myMaterial setMaterial_type:[oneListItemDict objectForKey:@"filetype"]];
    [myMaterial setMaterial_duration:[[oneListItemDict objectForKey:@"duration"] integerValue]];
    [myMaterial setMaterial_direction:[oneListItemDict objectForKey:@"direction"]];
    //是否透明
    NSString *sAlpha = [oneListItemDict objectForKey:@"alpha"];
    if (!sAlpha) {
        sAlpha = @"0";
    }
    if (![sAlpha isKindOfClass:[NSString class]]) {
        sAlpha = @"0";
    }
    [myMaterial setMaterial_alpha:sAlpha];
    int mfangle = [[oneListItemDict objectForKey:@"fangle"] intValue];
    [myMaterial setMaterial_angle:mfangle];
    [myMaterial setMaterial_of_projectfolder:[_currentProjectPathRoot lastPathComponent]];
    [myMaterial setMaterial_x:[[oneListItemDict objectForKey:@"x"] integerValue]];
    [myMaterial setMaterial_y:[[oneListItemDict objectForKey:@"y"] integerValue]];
    [myMaterial setMaterial_w:[[oneListItemDict objectForKey:@"w"] integerValue]];
    [myMaterial setMaterial_h:[[oneListItemDict objectForKey:@"h"] integerValue]];

    NSDictionary *assetDict = [[[NSDictionary alloc]initWithObjectsAndKeys:[oneListItemDict objectForKey:@"duration"],@"duration",myMaterial,@"asset",nil] autorelease];
    [materialFilePath release];
    return assetDict;
}

/**
 *@brief 默认项目存放的根路径
 */
+(NSString *)defaultProjectRootPath{
    //项目存放的根目录
    NSString *sProjectRootPath = [[[NSString alloc]initWithFormat:@"%@",[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/ProjectCaches"]]] autorelease];
    //如果项目存放根目录不存在，则创建
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL isDir = YES;
    NSError *error = nil;
    if (![fileMgr fileExistsAtPath:sProjectRootPath isDirectory:&isDir]) {
        [fileMgr createDirectoryAtPath:sProjectRootPath withIntermediateDirectories:YES attributes:nil error:&error];
        DLog(@"项目存放根目录创建出错 = %@",error);
    }
    return sProjectRootPath;
}

/**
 *@brief 项目存放文件夹的路径
 */
-(NSString *)customeProjectDirPathWith:(NSString *)dirName{
    NSString *sProjectDirPath = [[[NSString alloc]initWithFormat:@"%@/%@",[LayoutYXMViewController defaultProjectRootPath],dirName] autorelease];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL isDir = YES;
    NSError *error = nil;
    if (![fileMgr fileExistsAtPath:sProjectDirPath isDirectory:&isDir]) {
        BOOL createResult = [fileMgr createDirectoryAtPath:sProjectDirPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!createResult) {
            DLog(@"项目存放文件夹的路径创建出错 = %@",error);
        }
    }
    return sProjectDirPath;
}

/**
 *@brief 项目的XML文件的路径
 */
-(NSString *)customeXMLFilePathWithProjectDir:(NSString *)sProjectDir{
    NSString *sXMLFilePath = [[[NSString alloc]initWithFormat:@"%@/%@/%@.xml",[LayoutYXMViewController defaultProjectRootPath],sProjectDir,sProjectDir] autorelease];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:sXMLFilePath]) {
        [fileMgr createFileAtPath:sXMLFilePath contents:nil attributes:nil];
    }
    return sXMLFilePath;
}

/**
 *@brief 移动素材到项目目录下
 */
-(void)moveMaterialToProjectDirWithFileName:(NSString *)sMaterialFileName AndProjectDirPath:(NSString *)sProjectDirPath{
    NSFileManager *fileMgr = [NSFileManager defaultManager];

    //素材的源路径
    NSString *sSourcesPath = [NSString stringWithFormat:@"%@/%@",[MaterialObject createMatrialRootPath],sMaterialFileName];
    BOOL bExistSourcesPath = [fileMgr fileExistsAtPath:sSourcesPath];

    //素材的目标路径
    NSString *sDestinationPath = [NSString stringWithFormat:@"%@/%@",sProjectDirPath,sMaterialFileName];
    if (bExistSourcesPath) {
        NSError *moveFileError = nil;
        //需要移动到文件夹里的文件
        BOOL moveResult = [fileMgr moveItemAtPath:sSourcesPath toPath:sDestinationPath error:&moveFileError];
        if (!moveResult) {
            DLog(@"错误信息 = %@",moveFileError);
        }
    }else{
        DLog(@"源文件不存在,源路径 = %@",sSourcesPath);
    }
}

/**
 *@brief 移动音频文件到项目的路径下
 */
-(void)moveMusicFileToProjectDirWithFilePath:(NSString *)sMusicFilePath AndProjectDirPath:(NSString *)sProjectDirPath{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *sMusicName = [sMusicFilePath lastPathComponent];
    NSString *sDistMusicPath = [NSString stringWithFormat:@"%@/%@",sProjectDirPath,sMusicName];
    NSError *moveFileError = nil;
    BOOL moveResult = [fileMgr copyItemAtPath:sMusicFilePath toPath:sDistMusicPath error:&moveFileError];
    DLog(@"移动结果 = %d,错误信息 = %@,%@,%@",moveResult,moveFileError,sMusicFilePath,sDistMusicPath);
}

/**
 *@brief 创建文本信息的字典
 */
-(NSDictionary *)createTextInfoDictionary{
    @try {
        //文字内容
        UITextView *myTextView = (UITextView *)[self.view viewWithTag:5001];
        NSString *textContent = @"";
        if (myTextView.text) {
            if ([myTextView.text length]>0) {
                textContent = myTextView.text;
            }
        }

        //滚动速度
        JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];
        NSString *textRollingSpeed = TXT_ROLLING_SPEED;
        textRollingSpeed = [[NSString alloc]initWithFormat:@"%d",((int)ticker.tickerSpeed)/10];
        if (!textRollingSpeed) {
            textRollingSpeed = TXT_ROLLING_SPEED;
        }
        if (![textRollingSpeed isKindOfClass:[NSString class]]) {
            textRollingSpeed = TXT_ROLLING_SPEED;
        }
        //字体大小
        UITextField *textFontField = (UITextField*)[self.view viewWithTag:TAG_FONT_SIZE_TEXT];
        NSString *textFontSize = textFontField.text;
        if (!textFontSize) {
            textFontSize = @"16";
        }
        if (![textFontSize isKindOfClass:[NSString class]]) {
            textFontSize = @"16";
        }
        //字体名称
        UITextField *textFontNameField = (UITextField *)[self.view viewWithTag:TAG_ROLLING_FONT_TEXT];
        NSString *textFontName = textFontNameField.text;
        if (!textFontName) {
            textFontName = @"Arial";
        }
        if ((![textFontName isKindOfClass:[NSString class]])||([textFontName length]<1)) {
            textFontName = @"Arial";
        }

        NSString *textRColor=@"0.9";
        NSString *textGColor=@"0.9";
        NSString *textBColor=@"0.9";

        CGColorRef textColor = ticker.tickerColor.CGColor;
        NSUInteger num = CGColorGetNumberOfComponents(textColor);
        const CGFloat *colorComponents = CGColorGetComponents(textColor);
        for (int i = 0; i < num; ++i) {
            DLog(@"color components %d: %f", i, colorComponents[i]);
            if (i==0) {
                textRColor = [[NSString alloc]initWithFormat:@"%0.4lf",colorComponents[i]];
            }
            if (i==1) {
                textGColor = [[NSString alloc]initWithFormat:@"%0.4lf",colorComponents[i]];
            }
            if (i==2) {
                textBColor = [[NSString alloc]initWithFormat:@"%0.4lf",colorComponents[i]];
            }
        }


        //播放文字的背景颜色
        NSString *textBackgroundRColor=@"0.9";
        NSString *textBackgroundGColor=@"0.9";
        NSString *textBackgroundBColor=@"0.9";
        NSString *textBackgroundAlpha=@"0.01";

        CGColorRef backgroundColor = ticker.backgroundColor.CGColor;
        NSUInteger backgroundNum = CGColorGetNumberOfComponents(backgroundColor);
        const CGFloat *backgroundColorComponents = CGColorGetComponents(backgroundColor);
        for (int i = 0; i < backgroundNum; ++i) {
            DLog(@"color components %d: %f", i, backgroundColorComponents[i]);
            if (i==0) {
                textBackgroundRColor = [[NSString alloc]initWithFormat:@"%0.4lf",backgroundColorComponents[i]];
            }
            if (i==1) {
                textBackgroundGColor = [[NSString alloc]initWithFormat:@"%0.4lf",backgroundColorComponents[i]];
            }
            if (i==2) {
                textBackgroundBColor = [[NSString alloc]initWithFormat:@"%0.4lf",backgroundColorComponents[i]];
            }
            if (i==3) {
                textBackgroundAlpha = [[NSString alloc]initWithFormat:@"%0.4lf",backgroundColorComponents[i]];
            }
        }

        UIView *textView = [self.view viewWithTag:VIEW_TAG_TEXT_AREA_1005];
        NSString *textX = [[NSString alloc]initWithFormat:@"%0.1lf",textView.frame.origin.x];
        NSString *textY = [[NSString alloc]initWithFormat:@"%0.1lf",textView.frame.origin.y];
        NSString *textW = [[NSString alloc]initWithFormat:@"%0.1lf",textView.frame.size.width];
        NSString *textH = [[NSString alloc]initWithFormat:@"%0.1lf",textView.frame.size.height];
        //yxm modify 2014年07月02日18:52:04
        NSDictionary *oneTextDict = [[[NSDictionary alloc]initWithObjectsAndKeys:textContent,@"textContent",textRollingSpeed,@"textRollingSpeed",textFontName,@"textFontName",textFontSize,@"textFontSize",textRColor,@"textRColor",textGColor,@"textGColor",textBColor,@"textBColor",textBackgroundRColor,@"textBackgroundRColor",textBackgroundGColor,@"textBackgroundGColor",textBackgroundBColor,@"textBackgroundBColor",textBackgroundAlpha,@"textBackgroundAlpha",textX,@"textX",textY,@"textY",textW,@"textW",textH,@"textH",nil] autorelease];
        
        return oneTextDict;
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
        @throw exception;
    }
    @finally {
        
    }
}

/**
 *@brief 创建素材的字典
 */
-(NSDictionary *)createMaterialInfoDictionaryWithProjectDirPath:sProjectDirPath{
    @try {
        NSMutableDictionary *materialDictionary = [[NSMutableDictionary alloc]init];

        NSArray *keysOfSelectAreaIndexArray = [_projectMaterialDictionary allKeys];
        if (keysOfSelectAreaIndexArray) {
            if ([keysOfSelectAreaIndexArray count]>0) {
                for (NSString *areaKey in keysOfSelectAreaIndexArray) {
                    NSMutableDictionary *itemListDict = [[NSMutableDictionary alloc]init];

                    NSArray *oneMaterialList = [_projectMaterialDictionary objectForKey:areaKey];
                    if (oneMaterialList) {
                        if ([oneMaterialList count]>0) {
                            //素材列表的详细信息
                            NSInteger durationIndex=0;
                            for (NSDictionary *assetDict in oneMaterialList) {
                                NSString *oneDuration = [assetDict objectForKey:@"duration"];
                                MaterialObject *oneAsset = (MaterialObject*)[assetDict objectForKey:@"asset"];
                                oneDuration = [[NSString alloc]initWithFormat:@"%ld",[oneAsset material_duration]];

                                NSString *playListKey = [[NSString alloc]initWithFormat:@"item%ld",durationIndex];
                                /*每个播放项目里面包含的元素：播放时间,文件路径,原点X,原点Y,宽度,高度,角度*/
                                NSString *playViewX = [[NSString alloc]initWithFormat:@"%ld",oneAsset.material_x];
                                NSString *playViewY = [[NSString alloc]initWithFormat:@"%ld",oneAsset.material_y];
                                NSString *playViewW = [[NSString alloc]initWithFormat:@"%ld",oneAsset.material_w];
                                NSString *playViewH = [[NSString alloc]initWithFormat:@"%ld",oneAsset.material_h];

                                NSString *playDirction = oneAsset.material_direction;
                                if (playDirction == nil) {
                                    playDirction = @"0";
                                }

                                //移动素材到项目文件夹
                                [self moveMaterialToProjectDirWithFileName:[[oneAsset material_path] lastPathComponent] AndProjectDirPath:sProjectDirPath];

                                NSString *sPlayAlpha = [oneAsset material_alpha];
                                if (sPlayAlpha == nil) {
                                    sPlayAlpha = @"0";
                                }
                                if (![sPlayAlpha isKindOfClass:[NSString class]]) {
                                    sPlayAlpha = @"0";
                                }

                                NSDictionary *oneImageDict = [[NSDictionary alloc]initWithObjectsAndKeys:oneDuration,@"duration",[oneAsset material_type],@"filetype",[oneAsset material_path],@"filepath",playViewX,@"x",playViewY,@"y",playViewW,@"w",playViewH,@"h",playDirction,@"direction",[NSString stringWithFormat:@"%d",fangle],@"angle",sPlayAlpha,@"alpha",nil];
                                [itemListDict setObject:oneImageDict forKey:playListKey];
                                
                                durationIndex ++;
                            }
                        }
                    }
                    [materialDictionary setObject:itemListDict forKey:areaKey];
                }
            }
        }
        
        return materialDictionary;
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
        @throw exception;
    }
    @finally {

    }
}

/**
 *  将主屏幕参数应用到文本框
 *
 *  @param myDict 主屏幕参数
 */
-(void)applyMasterScreenDictionaryWithDict:(NSDictionary *)myDict{
    NSString *sMasterScreenX = @"0";
    sMasterScreenX = [myDict objectForKey:@"masterScreenX"];
    NSString *sMasterScreenY = @"0";
    sMasterScreenY = [myDict objectForKey:@"masterScreenY"];
    NSString *sMasterScreenW = @"0";
    sMasterScreenW = [myDict objectForKey:@"masterScreenW"];
    NSString *sMasterScreenH = @"0";
    sMasterScreenH = [myDict objectForKey:@"masterScreenH"];

    UITextField *myTextFieldMasterScreenX = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2001];
    [myTextFieldMasterScreenX setText:sMasterScreenX];
    UITextField *myTextFieldMasterScreenY = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2002];
    [myTextFieldMasterScreenY setText:sMasterScreenY];
    UITextField *myTextFieldMasterScreenW = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2003];
    [myTextFieldMasterScreenW setText:sMasterScreenW];
    UITextField *myTextFieldMasterScreenH = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2004];
    [myTextFieldMasterScreenH setText:sMasterScreenH];
}

/**
 *  创建屏幕参数字典的创建
 *
 *  @return 返回屏幕参数字典
 */
-(NSDictionary *)createMasterScreenDictionary{
    @try {
        //主屏幕的原点和宽高参数需要获得
        UIView *myTextFieldMasterScreenX = (UIView*)[self.view viewWithTag:1004];

        NSString *sMasterScreenX = [[NSString alloc]initWithFormat:@"%d",(int)myTextFieldMasterScreenX.frame.origin.x];

        NSString *sMasterScreenY = [[NSString alloc]initWithFormat:@"%d",(int)myTextFieldMasterScreenX.frame.origin.y];

        NSString *sMasterScreenW = [[NSString alloc]initWithFormat:@"%d",(int)myTextFieldMasterScreenX.frame.size.width];

        NSString *sMasterScreenH = [[NSString alloc]initWithFormat:@"%d",(int)myTextFieldMasterScreenX.frame.size.height];

        NSDictionary *masterScreenDict = nil;
            //屏幕高度宽度验证
        if ([self screenHeightErrorAlertWithW:sMasterScreenW andH:sMasterScreenH]) {
            //LED屏幕的原点和宽高
            masterScreenDict = [[NSDictionary alloc]initWithObjectsAndKeys:sMasterScreenX,@"masterScreenX",sMasterScreenY,@"masterScreenY",sMasterScreenW,@"masterScreenW",sMasterScreenH,@"masterScreenH", nil];
        }

        return masterScreenDict;
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
        @throw exception;
    }
    @finally {

    }
}

/**
 *@brief 创建音频信息的字典
 */
-(NSDictionary *)createMusicInfoDictionary{
    //加入音频文件
    if (_musicFilePath) {
        if ([_musicFilePath length]>1) {
            //音频的名称
            NSString *sMusicName = [_musicFilePath lastPathComponent];
            //名称//音频的持续时间//音量
            NSDictionary *musicInfoDict = [[NSDictionary alloc]initWithObjectsAndKeys:sMusicName,@"musicName",[self musicDurationSecondToMillisecond:[_musicDuration floatValue]],@"musicDuration",_musicVolume,@"musicVolume", nil];
            return musicInfoDict;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

/**
 *@brief 清除当前素材列表,清除窗口内图片,刷新场景选择按钮
 */
-(void)clearImageListWithCurrentScene{
    //清理窗口内的图片
    UIView *tempView = [self.view viewWithTag:_currentSelectIndex];
    UIImageView *tempImageView = (UIImageView*)[self.view viewWithTag:(TAG_IMAGE_VIEW+tempView.tag)];
    [tempImageView setImage:nil];

    //验证如果_currentScenes为空,则进行初始化
    [self validateCurrentScene];
    //清理素材列表和刷新场景选择按钮
    if (_projectMaterialDictionary) {
        if ([_projectMaterialDictionary isKindOfClass:[NSMutableDictionary class]]) {
            NSArray *myAllKeysArray = [_projectMaterialDictionary allKeys];
            if (myAllKeysArray) {
                if ([myAllKeysArray count]>0) {
                    for (NSString *tempKey in myAllKeysArray) {
                        if ([tempKey isEqualToString:_currentScenes]) {
                            [_projectMaterialDictionary removeObjectForKey:_currentScenes];
                            [self refreshScelectAreaMatrialListWithTag:[_currentScenes integerValue]];
                        }
                    }
                }
            }
        }
    }
}

/**
 *@breif 保存项目成功后清理素材临时目录
 */
-(void)removeMaterialRootPath{
    NSString *sMatrialRootPath = [[NSString alloc]initWithFormat:@"%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ADMaterial"]];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSError *myError = nil;
    if ([fileMgr fileExistsAtPath:sMatrialRootPath]) {
        [fileMgr removeItemAtPath:sMatrialRootPath error:&myError];
        if (myError) {
            DLog(@"myError = %@",myError);
        }
    }

}

/**
 *  应用文本信息字典到文本中
 *
 *  @param textItemDict 文本信息字典
 */
-(void)applyTextInfoWithDict:(NSDictionary*)textItemDict{
    NSString *textContent = [textItemDict objectForKey:@"textContent"];
    if (!textContent) {
        textContent = @"";
    }
    UITextView *myTextView = (UITextView*)[self.view viewWithTag:5001];
    [myTextView setText:textContent];
    //文本颜色
    NSString *textRColor = [textItemDict objectForKey:@"textRColor"];
    NSString *textGColor = [textItemDict objectForKey:@"textGColor"];
    NSString *textBColor = [textItemDict objectForKey:@"textBColor"];
    //文本背景颜色
    NSString *textBackgroundRColor = [textItemDict objectForKey:@"textBackgroundRColor"];
    NSString *textBackgroundGColor = [textItemDict objectForKey:@"textBackgroundGColor"];
    NSString *textBackgroundBColor = [textItemDict objectForKey:@"textBackgroundBColor"];
    NSString *textBackgroundAlpha = [textItemDict objectForKey:@"textBackgroundAlpha"];
    //字体大小
    NSString *textFontSize = [textItemDict objectForKey:@"textFontSize"];
    //字体名称
    NSString *textFontName = [textItemDict objectForKey:@"textFontName"];
    //文字滚动速度
    NSString *textRollingSpeed = [textItemDict objectForKey:@"textRollingSpeed"];
    //文字Frame的X
    NSString *textRegionX = [textItemDict objectForKey:@"textX"];
    //文字Frame的Y
    NSString *textRegionY = [textItemDict objectForKey:@"textY"];
    //文字Frame的W
    NSString *textRegionW = [textItemDict objectForKey:@"textW"];
    //文字Frame的H
    NSString *textRegionH = [textItemDict objectForKey:@"textH"];

    JHTickerView *ticker = (JHTickerView*)[self.view viewWithTag:TAG_TEXT_AREA_LABEL];

    NSInteger iTextRegionX = [textRegionX integerValue];
    NSInteger iTextRegionY = [textRegionY integerValue];
    NSInteger iTextRegionW = [textRegionW integerValue];
    NSInteger iTextRegionH = [textRegionH integerValue];

    UIView *tempView = [self.view viewWithTag:VIEW_TAG_TEXT_AREA_1005];
    [tempView setFrame:CGRectMake(iTextRegionX, iTextRegionY,iTextRegionW, iTextRegionH)];
    [ticker setFrame:CGRectMake(0, 0, iTextRegionW, iTextRegionH)];
    [ticker setBackgroundColor:[UIColor colorWithRed:[textBackgroundRColor floatValue] green:[textBackgroundGColor floatValue] blue:[textBackgroundBColor floatValue] alpha:[textBackgroundAlpha floatValue]]];

    //修改滚动速度文本框内的值
    UITextField *mySpeedTextField = (UITextField*)[self.view viewWithTag:TAG_ROLLING_SPEED_TEXT];
    [mySpeedTextField setText:textRollingSpeed];

    //修改字体大小文本框内的值
    UITextField *myFontTextField = (UITextField*)[self.view viewWithTag:TAG_FONT_SIZE_TEXT];
    [myFontTextField setText:textFontSize];

    //修改字体名称文本框内的值
    UITextField *myTextFontNameField = (UITextField*)[self.view viewWithTag:TAG_ROLLING_FONT_TEXT];
    [myTextFontNameField setText:textFontName];

    if (textRollingSpeed) {
        int iTextRolling = [textRollingSpeed intValue]*10;
        textRollingSpeed = [[NSString alloc]initWithFormat:@"%d",iTextRolling];
    }else{
        textRollingSpeed = @"20";
    }
    if ((textContent!=nil)&&([textContent length]>0)) {
        [self createTextAreaWithMyColor:[UIColor colorWithRed:[textRColor floatValue] green:[textGColor floatValue] blue:[textBColor floatValue] alpha:1] mySpeed:[textRollingSpeed floatValue] myFont:[UIFont fontWithName:textFontName size:[textFontSize intValue]] myText:textContent];
    }else{
        //如果文字为空的情况下将文字滚动速度设置为0
        [self createTextAreaWithMyColor:[UIColor colorWithRed:[textRColor floatValue] green:[textGColor floatValue] blue:[textBColor floatValue] alpha:1] mySpeed:0.0f myFont:[UIFont fontWithName:textFontName size:[textFontSize intValue]] myText:@""];
    }
}


/**
 *  使用ftp发送项目
 */
-(void)useFTPSendProject{
    if (!_ftpMgr) {
        //连接ftp服务器
        _ftpMgr = [[YXM_FTPManager alloc]init];
        _ftpMgr.delegate = self;
    }
    NSString *sZipPath = nil;

    NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@:21/rec_bmp",ipAddressString];
    //如果是连续播放,则发送文件到分组文件夹内
    UIButton *myPublishOrContinusButton = (UIButton*)[self.view viewWithTag:TAG_CREATE_GROUP_BUTTON];
    if (myPublishOrContinusButton) {
        sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@:21/manager_xmls",ipAddressString];
    }
    DLog(@"_waitForUploadFilesArray = %@,_currentDataAreaIndex=%ld",_waitForUploadFilesArray,_currentDataAreaIndex);
    if ([_waitForUploadFilesArray count]>_currentDataAreaIndex) {
        sZipPath = [_waitForUploadFilesArray objectAtIndex:_currentDataAreaIndex];
        DLog(@"zipPath = %@,sUploadUrl = %@,_currentDataAreaIndex=%ld",sZipPath,sUploadUrl,_currentDataAreaIndex);
        [_ftpMgr startUploadFileWithAccount:@"ftpuser" andPassword:@"ftpuser" andUrl:sUploadUrl andFilePath:sZipPath];
        _currentDataAreaIndex ++;
    }
    [myProjectCtrl reloadMyPlaylist];
}

-(void)ftpuser{
    if (!_ftpMgr) {
        //连接ftp服务器
        _ftpMgr = [[YXM_FTPManager alloc]init];
        _ftpMgr.delegate = self;
    }
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* sZipPath =[NSString stringWithFormat:@"%@/image.jpg",DocumentsPath];
    NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@:21",ipAddressString];
    [_ftpMgr startUploadFileWithAccountqq:@"ftpuser" andPassword:@"ftpuser" andUrl:sUploadUrl andFilePath:sZipPath];
}



#pragma mark-ftp上传

/**
 *  反映上传进度的回调，每次写入流的数据长度
 *
 *  @param writeDataLength 数据长度
 */
-(void)uploadWriteData:(NSInteger)writeDataLength{
    _sendFileCountSize += writeDataLength;
    float progressValue = _sendFileCountSize*1.00f / _uploadFileTotalSize*1.00f;
    [myMRProgressView setProgress:progressValue animated:YES];

    [myMRProgressView setTitleLabelText:[NSString stringWithFormat:@"%@ %0.0lf％",[Config DPLocalizedString:@"adedit_publishprojecting"],progressValue*100]];
}


/**
 *  ftp上传文件的反馈结果
 *
 *  @param sInfo 反馈结果字符串
 */
-(void)uploadResultInfo:(NSString *)sInfo{
    DLog(@"sInfo = %@",sInfo);
    if ([sInfo isEqualToString:@"uploadComplete"]) {
        if (isLEDS) {
            isConnect = NO;
            ipAddressString = mianipscrenn;
            [self startSocket];
            //                }
            DLog(@"多屏同步");
            //0x18
            [self commandIPServerWithType:0x18 andContent:nil andContentLength:0];
            return;
        }
        DLog(@"_waitForUploadFilesArray = %@,_currentDataAreaIndex=%ld",_waitForUploadFilesArray,_currentDataAreaIndex);
        if ([_waitForUploadFilesArray count]>_currentDataAreaIndex) {
            [self useFTPSendProject];
        }else if(([sInfo isEqualToString:@"error_ReadFileError"])||([sInfo isEqualToString:@"error_StreamOpenError"])){
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            [self stopPublishProgress];

        }else{
            //如果是连续播放
            if (isContinusPlay) {
                    [self commandCompleteWithType:0x2C andSendType:0x04 andContent:nil andContentLength:TAG_MAX_NUMBER andPageNumber:TAG_MAX_NUMBER];
            }else{
                [self commandCompleteWithType:0x1D andSendType:0x04 andContent:nil andContentLength:TAG_MAX_NUMBER andPageNumber:TAG_MAX_NUMBER];
                _currentDataAreaIndex = 0;
            }
            isContinusPlay = NO;
            _currentDataAreaIndex = 0;
            [mySelectedProjectArray removeAllObjects],mySelectedProjectArray = nil;
        }
    }else{
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }
}


/**
 *  保存默认的宽高
 *
 *  @param sender 事件的触发者
 */
-(void)saveDefaultApplyTitle:(UIButton *)sender{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    UITextField *xField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2001];
    UITextField *yField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2002];
    UITextField *wField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2003];
    UITextField *hField = (UITextField*)[self.view viewWithTag:REGION_TAG_EDITOR_2004];
    NSInteger ix = 0;
    NSInteger iy = 0;
    NSInteger iw = 160;
    NSInteger ih = 640;
    if ([xField.text length]>0) {
        if ([self isPureInt:xField.text]) {
            ix = [xField.text integerValue];
            [ud setInteger:ix forKey:@"ix"];
        }
    }
    if ([yField.text length]>0) {
        if ([self isPureInt:yField.text]) {
            iy = [yField.text integerValue];
            [ud setInteger:iy forKey:@"iy"];
        }
    }
    if ([wField.text length]>1) {
        if ([self isPureInt:wField.text]) {
            iw = [wField.text integerValue];
            if (iw == 0) {
                iw = 160;
            }
            [ud setInteger:iw forKey:@"iw"];
        }
    }
    if ([hField.text length]>1) {
        if ([self isPureInt:hField.text]) {
            ih = [hField.text integerValue];
            if (ih == 0) {
                ih = 640;
            }
            [ud setInteger:ih forKey:@"ih"];
        }
    }

    //改变按钮上的文字
    NSString *sButtonTitle = [[NSString alloc]initWithFormat:@"%@%ldX%ld",[Config DPLocalizedString:@"adedit_setDefaultAppplyTitle"],iw,ih];
    UIButton *myApplyDefaultRegionButton = (UIButton *)[self.view viewWithTag:TAG_DEFAULT_REGION_BUTTON];
    [myApplyDefaultRegionButton setTitle:sButtonTitle forState:UIControlStateNormal];
}


//格式话小数 四舍五入类型
- (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [numberFormatter setPositiveFormat:format];
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}


-(void)createMaskViewWithShowRect:(CGRect)showRect andParentView:(UIView *)parentView{


    [self clearMaskView];
    CGRect rectPrarentView = parentView.frame;
    UIView *upMaskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rectPrarentView.size.width, showRect.origin.y)];
    [upMaskView setBackgroundColor:[UIColor blackColor]];
    [upMaskView setTag:TAG_UP_MASK_VIEW];
    UIView *leftMaskView = [[UIView alloc]initWithFrame:CGRectMake(0, showRect.origin.y, showRect.origin.x, showRect.size.height)];
    [leftMaskView setBackgroundColor:[UIColor blackColor]];
    [leftMaskView setTag:TAG_LEFT_MASK_VIEW];
    UIView *downMaskView = [[UIView alloc]initWithFrame:CGRectMake(0, showRect.origin.y + showRect.size.height, rectPrarentView.size.width, rectPrarentView.size.height - (showRect.origin.y + showRect.size.height))];
    [downMaskView setBackgroundColor:[UIColor blackColor]];
    [downMaskView setTag:TAG_DOWN_MASK_VIEW];
    UIView *rightMaskView = [[UIView alloc]initWithFrame:CGRectMake(showRect.origin.x + showRect.size.width, showRect.origin.y, parentView.frame.size.width - (showRect.origin.x + showRect.size.width), showRect.size.height)];
    [rightMaskView setBackgroundColor:[UIColor blackColor]];
    [rightMaskView setTag:TAG_RIGHT_MASK_VIEW];

    [parentView addSubview:upMaskView];
    [upMaskView release];
    [parentView addSubview:leftMaskView];
    [leftMaskView release];
    [parentView addSubview:downMaskView];
    [downMaskView release];
    [parentView addSubview:rightMaskView];
    [rightMaskView release];


//    NSInteger xOffset = showRect.origin.x ;
//    NSInteger yOffset = showRect.origin.y ;
//    DLog(@"%d,%d,%lf,%lf",xOffset,yOffset,parentView.frame.origin.x,parentView.frame.origin.y);
//    [parentView setFrame:CGRectMake(iParentX - xOffset, iParentY - yOffset, parentView.frame.size.width, parentView.frame.size.height)];
}

-(void)clearMaskView{
    UIView *u = [self.view viewWithTag:TAG_UP_MASK_VIEW];
    [u removeFromSuperview];
    UIView *d = [self.view viewWithTag:TAG_DOWN_MASK_VIEW];
    [d removeFromSuperview];
    UIView *l = [self.view viewWithTag:TAG_LEFT_MASK_VIEW];
    [l removeFromSuperview];
    UIView *r = [self.view viewWithTag:TAG_RIGHT_MASK_VIEW];
    [r removeFromSuperview];
}

-(void)addAssetButtonOpenTypeSeletor:(UIButton *)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:[Config DPLocalizedString:@"adedit_selectphotoprompt"]
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:[Config DPLocalizedString:@"adedit_selectphoto"],[Config DPLocalizedString:@"adedit_selectvideo"],nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DLog(@"%ld",buttonIndex);
    switch (buttonIndex) {
        case 0:
        {
            //选择图片
            [myMasterCtrl setSAssetType:ASSET_TYPE_PHOTO];
            [myMasterCtrl setIAssetMaxSelect:20];
            [myMasterCtrl pickAssets:nil];
            [myMasterCtrl setIslist:YES];
        }
            break;
        case 1:
        {
            //选择视频
            //清理待选素材列表
            [myMasterCtrl clearAssets:nil];
            [myMasterCtrl setSAssetType:ASSET_TYPE_VIDEO];
            [myMasterCtrl setIAssetMaxSelect:1];
            [myMasterCtrl pickAssets:nil];
            [myMasterCtrl setIslist:YES];


        }
            break;

        default:
            break;
    }

}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{

}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{

}
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}

-(void)showRestScreenSuccess{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_tryRestScreenSuccess"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView setTag:TAG_REST_SCREEN_ALERT];
    [myAlertView show];
    [myAlertView release];
    [myProjectCtrl reloadMyPlaylist];
}

-(void)showRestScreenfailed{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_tryRestScreenfailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    [myAlertView release];
    [myProjectCtrl reloadMyPlaylist];
}
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//
//}
//
//////当用户按下return键或者按回车键，keyboard消失
////-(BOOL)textFieldShouldReturn:(UITextField *)textField
////{
////    [textField resignFirstResponder];
////    return YES;
////}
//
////输入框编辑完成以后，将视图恢复到原始状态
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//
//}
-(void)dealloc{
    [self myRelease];
    [super dealloc];
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)registeredView_load
{
   
    loginPage.hidden = YES;
    
    
    __block LayoutYXMViewController *VC = self;
    
    registeredPage = [[YXM_RegisteredPage alloc]initWithFrame:CGRectMake(self.view.frame.size.width-320, 50, 320, 240)];
    
    registeredPage.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:registeredPage];

    registeredPage.userName_text = ^(NSString *userName_text){
        
        NSLog(@"%@",userName_text);
        VC.registeredUserNameString = userName_text;
        
    
    };
    registeredPage.passWord_text = ^(NSString *passWord_text){
        
        NSLog(@"%@",passWord_text);
        VC.registeredPassWordString = passWord_text;
    };
    
    registeredPage.againPassWord_text = ^(NSString *againPassWord_text){
    
        NSLog(@"%@",againPassWord_text);
        VC.registeredNextPassWordString = againPassWord_text;
        
    };
    
    registeredPage.message_text = ^(NSString *message_text){
    
        NSLog(@"%@",message_text);
        
        
        VC.messageTextString = message_text;
        NSLog(@"%@",_messageTextString);
        
       
        
    };
    
    registeredPage.determineButtonOnClick = ^(void){
    
        
        [self submit];
    
    };
    
    registeredPage.returnButtonOnClick = ^(void){
    
        [self returnButtonOnClcik];
    
    };



}


-(void)landing
{

    if (_loginUserNameString.length == 0) {
        [self showAlertView:@"用户名不能为空！"];
        return;
    }
    if (_loginPassWordString.length == 0) {
        [self showAlertView:@"密码不能为空"];
        return;
    }
    DLog(@"验证 ＝＝＝＝＝%@  和  %@",_loginMessageString,loginPage.pooCodeView.changeString)
    if ([_loginMessageString isEqualToString:loginPage.pooCodeView.changeString]) {
        
        
    }else{
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [loginPage.pooCodeView.layer addAnimation:anim forKey:nil];
        [loginPage.messageTextField.layer addAnimation:anim forKey:nil];
        
        return;
    }
    
    [self landingRequst];
    
    

}//登陆


-(void)landingRequst{


    
    NSMutableDictionary *params = [@{@"Name":self.loginUserNameString,
                                     @"Password":self.loginPassWordString}mutableCopy];
    
    
    
    
    [ForumWXDataServer requestURL:@"Ledad/LedadLogin_api.aspx"
                       httpMethod:@"POST"
                           params:params
                             file:nil
                          success:^(id data){
                              
                              DLog(@"用户登陆%@",data);
                              NSString *dict= data[@"msg"];
                              
                              
                              //                              NSDictionary *
                              NSLog(@"登陆获取的消息%@",dict);
                              if([dict isEqualToString:@"0"]){
                                  
                                  [self showAlertView:@"登陆成功！"];
                              
                                  NSString *ID = data[@"ID"];
                                  
                                  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                                  
                                  [ud setObject:ID forKey:@"userID"];
                                  
                                  [ud synchronize];
                                  
                                  
                                  
                                  if (registeredPage != NULL) {
                                      
                                      [registeredPage removeFromSuperview];
                                      
                                  }                                   
                                  if (loginPage != NULL) {
                                      
                                      [loginPage removeFromSuperview];

                                  }
                                  
                                  
                                 uploadView = [[DYT_ClouduploadViewController alloc]init];
                                  
                                  uploadView.uploadButtonOnClick = ^(void){
                                  
                                      [self upload];
                                  
                                  };
                                  
                                 
                                  uploadView.logoutButtonOnClick = ^(void){
                                  
                                      [self logout];
                                  
                                  };
                                  
                                 
                                  
                                  
                                  [self.view addSubview:uploadView.view]; 
                                  
                                  
                              }
                              
                              if ([dict isEqualToString:@"1"]){
                                  
                                  [self showAlertView:@"未激活！请联系管理员"];
                                  
//                                  [registeredPage removeFromSuperview];
//                                  [loginPage removeFromSuperview];
                                  
                              }
                              if ([dict isEqualToString:@"2"]) {
                                  [self showAlertView:@"未注册或用户名或者密码错误！"];
                                  
//                                  [registeredPage removeFromSuperview];
//                                  [loginPage removeFromSuperview];
                              }
                              
                          } fail:^(NSError *error){
                              
                              NSLog(@"%@",error);
                              [self showAlertView:@"无网络连接"];
                              
                          }];




}//提交登陆请求







-(void)submit
{
    
    [self haveNULL:self.registeredUserNameString];
    [self haveNULL:self.registeredPassWordString];
    [self haveNULL:self.registeredNextPassWordString];
    
    
    if(self.registeredUserNameString.length == 0){
    
        [self showAlertView:@"用户名不能为空"];
        
        return;
    }
    
    if(self.registeredUserNameString.length < 6){
        [self showAlertView:@"用户名不得低于6位"];
      
        return;
    }
    
    if(self.registeredUserNameString.length > 16){
    
        [self showAlertView:@"用户名不得高于16位"];
    
        return;
    }
    
    if (self.registeredPassWordString.length == 0) {
        
        [self showAlertView:@"密码不可以为空"];
        
        return;
    }
    
    if (self.registeredPassWordString.length < 6) {
        
        [self showAlertView:@"密码不得低于6位"];
        
        return;
    }
    
    
    if (self.registeredPassWordString.length > 16) {
        [self showAlertView:@"密码不得高于16位"];
        
        return;
    }
    
    if (self.registeredNextPassWordString.length == 0) {
        
        [self showAlertView:@"密码不可以为空"];
        
        return;
    }
    
    if (self.registeredNextPassWordString.length < 6) {
        
        [self showAlertView:@"密码不得低于6位"];
        
        return;
    }
    
    
    if (self.registeredNextPassWordString.length > 16) {
        [self showAlertView:@"密码不得高于16位"];
        
        return;
    }
    
    if ([self.registeredPassWordString isEqualToString: self.registeredNextPassWordString]) {
    
    }else{
    
        [self showAlertView:@"两次输入密码不一致"];
        
        return;
    
    
    }
    
    NSLog(@"提交提交提交");
    
    if ([_messageTextString isEqualToString:registeredPage.pooCodeView.changeString]) {
        
        
    }else{
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20, @20, @-20];
        [registeredPage.pooCodeView.layer addAnimation:anim forKey:nil];
        [registeredPage.messageTextField.layer addAnimation:anim forKey:nil];
        
        return;
    }

    
    [self submitRequst];
    
    

}//提交



-(void)haveNULL:(NSString *)string{

    
    NSRange _range = [string rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        [self showAlertView:@"账号或者密码不可以出现空格"];
        
    }

}


-(void)submitRequst
{

    
    
    NSMutableDictionary *params = [@{@"Name":self.registeredUserNameString,
                                     @"Password":self.registeredPassWordString}mutableCopy];
    
    
    
    
    [ForumWXDataServer requestURL:@"Ledad/LedadUserAdd_api.aspx"
                       httpMethod:@"POST"
                           params:params
                             file:nil
                          success:^(id data){
                              
                              DLog(@"%@",data);
                              NSString *dict= data[@"msg"];
//                              NSDictionary *
                              NSLog(@"%@",dict);
                              if([dict isEqualToString:@"0"]){
                              
                                  [self showAlertView:@"注册成功！请联系管理员为您激活账号"];
                                  [registeredPage removeFromSuperview];
                                  [loginPage removeFromSuperview];
                              
                              }else {
                              
                                  [self showAlertView:@"该账号已经被注册！"];
                                  
                                  [registeredPage removeFromSuperview];
                                  [loginPage removeFromSuperview];
                              
                              }
    
    } fail:^(NSError *error){
    
        NSLog(@"%@",error);
        [self showAlertView:@"无网络连接"];
    
    }];
    
    


}//提交注册请求





-(void)returnButtonOnClcik
{
    
    [registeredPage removeFromSuperview];
    
    loginPage.hidden = NO;
    
}//返回




-(void)upload{
    NSLog(@"上传按钮");


}//上传方法



-(void)logout{

    [uploadView.view removeFromSuperview ];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userID"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];

    
}//注销方法



#pragma mark - showAlertView
-(void)showAlertView:(NSString*)showString
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:showString delegate:nil  cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:2.0];
    
    
    
}//温馨提示



- (void)dimissAlert:(UIAlertView *)alert
{
    if(alert)
    {
        
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
        
    }
}//温馨提示

@end
