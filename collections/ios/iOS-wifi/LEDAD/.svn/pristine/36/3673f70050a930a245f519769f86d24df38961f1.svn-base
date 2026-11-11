//
//  UpgradeViewController.m
//  XCloudsManager
//
//  Created by yixingman on 14-7-14.
//
//

//是否打印播放的日志
#define PLAY_LOG 1
#define CURRENT_LOG 1
//每个区域上表示范围的label
#define TEST_MODE 1
#define CURRENT_MODE 1
//是否打印发布日志
#define PRINT_LOG 1
#define CURRENT_PRIENT_LOG 1

//可编辑区的选择索引的非选择时的默认值,一个无法命中的值
#define TAG_NO_SELECT_AREA 1000000000

#define TAG_REGION_LABEL 83500
//设置区域的根视图
#define TAG_EDIT_CONTROLLER_VIEW 100500
//设置区域
#define TAG_REGION_SETTINGS_VIEW 100501

//设置Region
#define TAG_REGION_TAG_LABEL 100502
//图片视图的tag
#define TAG_IMAGE_VIEW 200502


//控制按钮容器
#define TAG_CONTROL_BUTTON_VIEW 300100
//region设置功能按钮
#define TAG_SETTIONG_REGION_BUTTON 300502
//保存项目按钮
#define TAG_SAVE_PROJECT_BUTTON 300602
//文字编辑按钮
#define TAG_TEXT_EDIT_BUTTON 300702
//item设置按钮
#define TAG_ITEM_SETTING_BUTTON 300802

//资源列表
#define TAG_SUBITEM_LIST_VIEW 400502

//文字编辑区域
#define TAG_TEXT_REGION_SETTING_VIEW 500502

//项目设置
#define TAG_PROJECT_SETTING_VIEW 600502

//编辑图片
#define TAG_PLAY_LIST_VIEW 600802

//设置图片播放间隔时间
#define TAG_PLAY_ONE_DURATION_BUTTON 700802

//项目名称
#define TAG_PROJECT_NAME_TEXTFIELD 800802

//项目列表
#define TAG_PROJECT_LIST_VIEW 1010100

//文字编辑区域
#define TAG_TEXT_AREA_LABEL 2010100

//保存文字按钮
#define TAG_SAVE_TEXT_BUTTON 2010101

/*屏幕的宽度和高度*/
#define SCREEN_CGSIZE_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_CGSIZE_HEIGHT [[UIScreen mainScreen]bounds].size.height

//保存项目
#define TAG_SAVE_AS_BUTTON 701000

//退出播放模式
#define TAG_QUIT_PLAY_BUTTON 702000

//删除项目
#define TAG_DELETE_PROJ_BUTTON 2020101

//播放的速度
#define TAG_ROLLING_SPEED_TEXT 2030101

//改变文字颜色按钮
#define TAG_CHANGE_COLOR_BUTTON 2040101

//改变文字背景颜色按钮
#define TAG_CHANGE_TEXT_BACK_GROUND_COLOR_BUTTON 2040201

//颜色的标签值 ：红、绿、蓝、透明值
#define TAG_RED_COLOR_LABEL 2040206
#define TAG_GREEN_COLOR_LABEL 2040207
#define TAG_BLUE_COLOR_LABEL 2040208
#define TAG_ALPHA_COLOR_LABEL 2040209

//字体大小
#define TAG_FONT_SIZE_TEXT 2040310

//发布项目
#define TAG_PUBLISH_PROJ_BUTTON 2060310

//重新连接网络
#define TAG_RECONNECT_ALERTVIEW 2060410

//编辑项目按钮
#define TAG_EDIT_PROJ_BUTTON 2060510

//是否重复加载素材的弹出框
#define TAG_IS_REPATED_LOAD 2060511

//主屏幕的现实范围的设定
#define TAG_MASTER_REGION_SETTINGS_VIEW 2060610

//主屏幕的区域
#define TAG_MASTER_SCREEN_VIEW 2070100

//正在加载的标记
#define IS_LOADED_MATRIAL @"IS_LOADED_MATRIAL"

//已经加载的标记
#define IS_ALREADY_LOAD_MATRIAL @"IS_ALREADY_LOAD_MATRIAL"

//加载默认素材的按钮
#define TAG_LOAD_DEFAULT_IMAGE_BUTTON 2070200

//添加选择字体的下拉框
#define TAG_ROLLING_FONT_TEXT 2070300

//是否提示应该退出编辑
#define TAG_IS_EDITING_PROJECT_ALERT 2070400

//项目列表中放置误操作的蒙版
#define TAG_MAKE_OPACITY_MASK 2070500

//程序版本号的最大值
#define PROGRAM_VERSION_NO_MAX 100000000

//发送数据类型
#define SEND_DATA_TYPE @"program"

#import "UpgradeViewController.h"
#import "Config.h"



//点击了升级按钮
#define TAG_UPGRADE_BUTTON 2070500
//点击了升级按钮2
#define TAG_UPGRADE_BUTTON2 3070500
#define TAG_UPGRADE_BUTTON3 3070501
#define TAG_UPGRADE_BUTTON11 3070511


@interface UpgradeViewController ()

@end

@implementation UpgradeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)initBrodcast{
    @try {
        __block UpgradeViewController *weekSelf = self;
        _upgradeBroadcast = [[AsyncUdpSocketReceiveUpgradeBroadcastIp alloc] initReceivePlayerBroadcastIp:^(NSString *ledPlayerName,NSString *ledPlayerIP){

            if (ledPlayerIP!=nil) {
                ipAddressString = [[NSString alloc]initWithFormat:@"%@",[ledPlayerIP stringByReplacingOccurrencesOfString:@"::ffff:" withString:@""]];
            }

            DLog(@"ledPlayerIP");
            DLog(@"%@",ledPlayerIP);
            if (weekSelf) {
                if (weekSelf->myUpgradePromptLabel) {
                    if (ledPlayerIP) {
                        weekSelf->myUpgradePromptLabel.text = [[NSString alloc]initWithFormat:@"已经连接到%@",ledPlayerIP];
                    }else{
                        weekSelf->myUpgradePromptLabel.text = [[NSString alloc]initWithFormat:@""];
                    }
                }
            }
        }];

        _transcationBroadcast = [[AsyncUdpSocketReceiveUpgradeTranscationBroadcastIp alloc] initReceivePlayerBroadcastIp:^(NSString *ledPlayerName,NSString *ledPlayerIP){

            if (ledPlayerIP!=nil) {
                ipAddressString = [[NSString alloc]initWithFormat:@"%@",[ledPlayerIP stringByReplacingOccurrencesOfString:@"::ffff:" withString:@""]];
            }
            DNetLog(@"ledPlayerIP");
            DNetLog(@"%@",ledPlayerIP);
            if (weekSelf) {
                if (weekSelf->myUpgradePromptLabel) {
                    if (ledPlayerIP) {
                        weekSelf->myUpgradePromptLabel.text = [[NSString alloc]initWithFormat:@"已经连接到%@",ledPlayerIP];
                    }else{
                        weekSelf->myUpgradePromptLabel.text = [[NSString alloc]initWithFormat:@""];
                    }
                }
            }
        }];

        [_upgradeBroadcast release];
        [_transcationBroadcast release];
    }
    @catch (NSException *exception) {
        DLog(@"升级时广播异常 = %@",exception);
    }
    @finally {

    }
}


- (void)viewDidLoad
{

    [super viewDidLoad];

    
    CGRect rectContainerView = CGRectMake(0, 0, self.view.frame.size.height - 320,self.view.frame.size.width);
    if (OS_VERSION_FLOAT>7.9) {
        rectContainerView = CGRectMake(0, 0, self.view.frame.size.width - 320,self.view.frame.size.height);
    }
    _currentDataArray = [[NSMutableArray alloc]init];
    myURLArray = [[NSMutableArray alloc]initWithObjects:@"libv8.so", @"ledcontrollerforlinux704.jar",nil];
    //xcloudemanagermvup/led_net.zip
    myURLArrayV3 = [[NSMutableArray alloc]initWithObjects:@"led_net.zip",nil];
    [self createMenuViewWithRect:rectContainerView];

    progressIndicator = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, rectContainerView.size.width, 1)];
    [progressIndicator setAlpha:0];
    [self.view addSubview:progressIndicator];


    [self initBrodcast];
    [self startSocket];
}


-(void)createProgressView:(float)myProgressView andFrame:(CGRect)myFrame andSuperView:(UIView *)superView{
    UIColor *backColor = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
    UIColor *progressColor = [UIColor colorWithRed:82.0/255.0 green:135.0/255.0 blue:237.0/255.0 alpha:1.0];
    
    //alloc CircularProgressView instance
    myCircularProgressView = [[CircularProgressView alloc] initWithFrame:myFrame
                                                               backColor:backColor
                                                           progressColor:progressColor
                                                               lineWidth:30];
    
    
    //add CircularProgressView
    [superView addSubview:myCircularProgressView];
    
    //set initial timeLabel
    promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(myCircularProgressView.center.x-50, myCircularProgressView.center.y-50, 100, 100)];
    [promptLabel setFont:[UIFont fontWithName:@"Arial" size:28]];
    [promptLabel setTextAlignment:NSTextAlignmentCenter];
    
    [superView addSubview:promptLabel];
}


-(void)buttonEvent:(UIButton *)sender{
    if (TAG_UPGRADE_BUTTON == sender.tag) {
        DLog(@"点击了下载");
        version = [[NSString alloc]initWithFormat:@"2"];
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"version"];
        [myTimer setFireDate:[NSDate date]];
        [self checkUpgradeVersionTxt];
        [myUpgradeButton setEnabled:NO];
        [myUpgradeButton1 setEnabled:NO];
    }
    if (TAG_UPGRADE_BUTTON11 == sender.tag) {
        DLog(@"点击了下载11");
        version = [[NSString alloc]initWithFormat:@"3"];
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"version"];
        [myTimer setFireDate:[NSDate date]];
        [self checkUpgradeVersionTxt];
        [myUpgradeButton setEnabled:NO];
        [myUpgradeButton1 setEnabled:NO];
    }
    if (TAG_UPGRADE_BUTTON2 == sender.tag) {
        DLog(@"点击了上传");
        if (!isConnect) {
            [self startSocket];
        }
        if([ipAddressString isEqualToString:@""]){
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_Nonetwork"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
        }else{
            //使用ftp传输文件
            _currentDataAreaIndex = 0;
            [self useFTPSendFile];
        }
    }
    if (TAG_UPGRADE_BUTTON3 == sender.tag) {
        if (!isConnect) {
            [self startSocket];
        }
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_resetScreenMachine"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptno"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptyes"], nil];
        [myAlertView setTag:1002888];
        myAlertView.delegate = self;
        [myAlertView show];
        [myAlertView release];
    }
}

/**
 *  使用ftp来发送文件
 */
-(void)useFTPSendFile{
    if (!_myFtpMgr) {
        //连接ftp服务器
        _myFtpMgr = [[YXM_FTPManager alloc]init];
        _myFtpMgr.delegate = self;


        _myFileListArray = [[NSMutableArray alloc]init];
        [_myFileListArray removeAllObjects];
        _currentDataAreaIndex = 0;
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Upgrade"];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"version"]==nil) {
            version = @"3";
        }else{
            version = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
        }

        if ([version isEqualToString:@"3"]) {
            NSString *sV8Path = [[NSString alloc]initWithFormat:@"%@/%@",documentsDirectory,@"led_net.zip"];
            [_myFileListArray addObject:sV8Path];
            DLog(@"%@",_myFileListArray);
        }
        if ([version isEqualToString:@"2"]) {
            NSString *sV8Path = [[NSString alloc]initWithFormat:@"%@/%@",documentsDirectory,@"libv8.so"];
            [_myFileListArray addObject:sV8Path];
            NSString *sCtrlPath = [[NSString alloc]initWithFormat:@"%@/%@",documentsDirectory,@"ledcontrollerforlinux704.jar"];
            [_myFileListArray addObject:sCtrlPath];
            DLog(@"%@",_myFileListArray);
        }

        //计算文件总大小
        for (NSString *sFielPath in _myFileListArray) {
            _uploadFileTotalSize += [LayoutYXMViewController fileSizeAtPath:sFielPath];
        }
    }
    NSString *zipPath = nil;
    if ([_myFileListArray count]>_currentDataAreaIndex) {
        zipPath = [_myFileListArray objectAtIndex:_currentDataAreaIndex];
        NSLog(@"zipPath = %@",zipPath);
        NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@/version",ipAddressString];
        DLog(@"%@",sUploadUrl);
        [_myFtpMgr startUploadFileWithAccount:@"ftpuser" andPassword:@"ftpuser" andUrl:sUploadUrl andFilePath:zipPath];
        _currentDataAreaIndex ++;
        [myUpgradeButton2 setEnabled:NO];
    }
}

/**
 *  检查升级版本号
 */
-(void)checkUpgradeVersionTxt{
    _currentDataAreaIndex = 0;
    NSString *myURLString = @"http://www.ledmediasz.com/z_andro_brank/v_xcloudmanagerupgrade.txt";
    NSURL *myUrl = [NSURL URLWithString:myURLString];
    ASIHTTPRequest *myRqeust = [[ASIHTTPRequest alloc]initWithURL:myUrl];
    [myRqeust setCompletionBlock:^{
        NSString *myString = [myRqeust responseString];
        DLog(@"升级版本号 = %@",myString);
        if (myString) {
            
            if ([myString isKindOfClass:[NSString class]]) {
                if ([myString length]>0) {
                    if ([myString length]<9) {
                        int iMyString = [myString intValue];
                        DLog(@"iMyString = %d",iMyString);
                        if ((0<iMyString) && (iMyString<PROGRAM_VERSION_NO_MAX)) {
                            myUpgradePackageVersion = myString;
                            [self startDownloadUpgradePackage];
                        }else{
                            isCheckVersionNoError = YES;
                        }
                    }else{
                        isCheckVersionNoError = YES;
                    }
                }else{
                    isCheckVersionNoError = YES;
                }
            }else{
                isCheckVersionNoError = YES;
            }
        }else{
            isCheckVersionNoError = YES;
        }
        
        if (isCheckVersionNoError) {
            [myUpgradeButton setEnabled:YES];
            [myUpgradeButton1 setEnabled:YES];
            [myTimer setFireDate:[NSDate distantFuture]];
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_internetconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            [myTimer setFireDate:[NSDate distantFuture]];
        }
    }];
    [myRqeust setFailedBlock:^{
        [myUpgradeButton setEnabled:YES];
        [myUpgradeButton1 setEnabled:YES];
        [myTimer setFireDate:[NSDate distantFuture]];
        DLog(@"检查升级版本号失败");
    }];
    [myRqeust startAsynchronous];
}

/**
 *  到服务器下载更新程序
 *
 *  @param fileName 传入需要下载的文件名
 */
-(void)startDownloadUpgradePackage{
    /*
     http://www.ledmediasz.com/xcloudmanagerupgrade/libv8.so
     http://www.ledmediasz.com/xcloudmanagerupgrade/ledcontrollerforlinux704.jar
     */
    
    
    
    if (!myURLArray) {
        [myUpgradeButton setEnabled:YES];
        [myUpgradeButton1 setEnabled:YES];
        [myTimer setFireDate:[NSDate distantFuture]];
        return;
    }
    
    
    //下载进度条时不用delegate代理
    if (!networkQueue) {
        networkQueue = [[ASINetworkQueue alloc] init];
    }
    [networkQueue reset];
    
    [networkQueue setQueueDidFinishSelector:@selector(myFetchFailed:)];
    [networkQueue setQueueDidFinishSelector:@selector(myFetchComplete:)];
    [networkQueue setDownloadProgressDelegate:_downloadProgress];
    [networkQueue setShowAccurateProgress:YES];
    [networkQueue setDelegate:self];
    
    ASIHTTPRequest *request;
    
    NSFileManager *filemanager=[[NSFileManager alloc] init];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Upgrade"];
    [filemanager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    if ([version isEqualToString:@"2"]) {
        for (int i=0; i<[myURLArray count]; i++) {
            NSString *fileName = [myURLArray objectAtIndex:i];
            DLog(@"fileName = %@",fileName);
            NSString *myURLString = [[NSString alloc]initWithFormat:@"http://www.ledmediasz.com/xcloudmanagerupgrade/%@",fileName];
            DLog(@"服务器的文件保存的路径myURLString = %@",myURLString);
            request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:myURLString]];

            NSString *mySavePath = [[NSString alloc]initWithFormat:@"%@/%@",documentsDirectory,fileName];
            BOOL deleteFileResult = [filemanager removeItemAtPath:mySavePath error:nil];
            if (deleteFileResult) {
                DLog(@"成功删除文件 = %@",mySavePath);
            }
            //        NSString *tempPath = [[NSString alloc]initWithFormat:@"%@/%@.temp",documentsDirectory,fileName];
            DLog(@"下载的文件保存的路径mySavePath = %@",mySavePath);


            [request setDownloadDestinationPath:mySavePath];
            //        [request setTemporaryFileDownloadPath:tempPath];

            //        [request setDownloadProgressDelegate:videodownprogressview];
            //区分标示身份的
            [request setUserInfo:[NSDictionary dictionaryWithObject:myURLString forKey:@"name"]];
            [request setFailedBlock:^{
                DLog(@"下载数据出错");
                [myUpgradeButton setEnabled:YES];
                [myUpgradeButton1 setEnabled:YES];
                isDownloadingError = YES;
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
                [myAlertView release];
                [myTimer setFireDate:[NSDate distantFuture]];
            }];
            [networkQueue addOperation:request];
            
        }
    }
    if ([version isEqualToString:@"3"]) {
        for (int i=0; i<[myURLArrayV3 count]; i++) {
            NSString *fileName = [myURLArrayV3 objectAtIndex:i];
            DLog(@"fileName = %@",fileName);
            NSString *myURLString = [[NSString alloc]initWithFormat:@"http://www.ledmediasz.com/xcloudemanagermvup/%@",fileName];
            DLog(@"服务器的文件保存的路径myURLString = %@",myURLString);
            request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:myURLString]];

            NSString *mySavePath = [[NSString alloc]initWithFormat:@"%@/%@",documentsDirectory,fileName];
            BOOL deleteFileResult = [filemanager removeItemAtPath:mySavePath error:nil];
            if (deleteFileResult) {
                DLog(@"成功删除文件 = %@",mySavePath);
            }
            //        NSString *tempPath = [[NSString alloc]initWithFormat:@"%@/%@.temp",documentsDirectory,fileName];
            DLog(@"下载的文件保存的路径mySavePath = %@",mySavePath);


            [request setDownloadDestinationPath:mySavePath];
            //        [request setTemporaryFileDownloadPath:tempPath];

            //        [request setDownloadProgressDelegate:videodownprogressview];
            //区分标示身份的
            [request setUserInfo:[NSDictionary dictionaryWithObject:myURLString forKey:@"name"]];
            [request setFailedBlock:^{
                DLog(@"下载数据出错");
                [myUpgradeButton setEnabled:YES];
                [myUpgradeButton1 setEnabled:YES];
                isDownloadingError = YES;
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
                [myAlertView release];
                [myTimer setFireDate:[NSDate distantFuture]];
            }];
            [networkQueue addOperation:request];
            
        }
    }

    [filemanager release];
    filemanager=nil;
    [networkQueue go];
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/**
 *  启动网络连接
 */
-(void)startSocket{
    if (!_sendPlayerSocket) {
        _sendPlayerSocket = [[AsyncSocket alloc] initWithDelegate:self];
    }

    if (ipAddressString) {
        DNetLog(@"ipaddress = %@",ipAddressString);
        isConnect = [_sendPlayerSocket connectToHost:ipAddressString onPort:PORT_OF_UPGRADE_SERVICE_IP error:nil];
        [_sendPlayerSocket setDelegate:self];
        [_sendPlayerSocket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
        DLog(@"建立连接");
    }
}


#pragma mark - tcp
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
    
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    DNetLog(@"%s %d", __FUNCTION__, __LINE__);
    
    [_sendPlayerSocket readDataWithTimeout: -1 tag: 0];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    DNetLog(@"%s %d, tag = %ld", __FUNCTION__, __LINE__, tag);
    
    DNetLog(@"写数据完成");
    
    [_sendPlayerSocket readDataWithTimeout: -1 tag: tag];
}

// 这里必须要使用流式数据
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    Byte *AckByte = (Byte *)[data bytes];
    
    DLog(@"发送命令的反馈");
    DLog(@"ack[0]=%x",AckByte[0]);
    DLog(@"ack[1]=%x",AckByte[1]);
    DLog(@"ack[2]=%x",AckByte[2]);
    DLog(@"ack[3]=%x",AckByte[3]);
    DLog(@"ack[4]=%x",AckByte[4]);
    DLog(@"ack[5]=%x",AckByte[5]);

    if (AckByte[1] == 0x1D) {
        DLog(@"发送图数据成功");
        [self showUploadUpgradeFileSuccess];
    }
    if (AckByte[1] == 0xD1) {
        DLog(@"发送重置命令成功");

        if (AckByte[3]==0x00) {
            [self showRestScreenSuccess];
        }else{
            [self showRestScreenfailed];
        }
    }

    [_sendPlayerSocket readDataWithTimeout: -1 tag: tag];
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
    outdate[2]=0x03; /*命令执行与状态检查
                      2：获取服务器端的数据*/
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
        
        DLog(@"pageNumber = %d",pageNumber);
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
    
    
    DLog(@"pageNumber = %d",pageNumber);
    if (pageNumber==100000000) {
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
    DNetLog(@"byteLength = %d",byteLength);
    Byte outdate[byteLength];
    memset(outdate, 0x00, byteLength);
    outdate[0]=0x7D;
    outdate[1]=commandType;//命令类型
    outdate[2]=0x03; //传输数据到客户端
    outdate[3]=sendType;
    
    if (sendType == 0x01) {
        
        DLog(@"pageNumber = %d",pageNumber);
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
    DNetLog(@"tag = %ld",tag);
    NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:byteLength];
    
    
    DNetLog(@"pageNumber = %d",pageNumber);
    if (pageNumber==100000000) {
        DLog(@"发送文件数据传输完成命令");
    }
    
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
    outdate[2]=0x00; /*命令执行与状态检查
                      2：获取服务器端的数据*/
    
    
    
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

    NSData *udpPacketData = [[NSData alloc] initWithBytes:outdate length:byteLength];
    DLog(@"恢复默认列表 = %ld,PacketData=%@",tag,udpPacketData);
    [_sendPlayerSocket writeData:udpPacketData withTimeout:-1 tag:tag];
    
}




-(void)myFetchFailed:(ASIHTTPRequest*)myRquest{
    
    DLog(@"下载出错 = %@",myRquest);
    [myUpgradeButton setEnabled:YES];
    [myUpgradeButton1 setEnabled:YES];
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_downloadupgradefileerror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    [myAlertView release];
}
-(void)myFetchComplete:(ASIHTTPRequest*)myRquest{
    if (isDownloadingError) {
        //网络连接出现错误
        DLog(@"网络连接出现错误");
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }else{
        DLog(@"下载完成 = %@",myRquest);
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_downloadupgradefilefinish"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }
    [myUpgradeButton setEnabled:YES];
    [myUpgradeButton1 setEnabled:YES];
}


//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1002888) {
        if (buttonIndex==1) {
            //重置屏幕
            [self commandResetServerWithType:0xD1 andContent:nil andContentLength:0];
            [myUpgradeButton3 setEnabled:NO];
            [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(feedbackTimeout2:) userInfo:nil repeats:NO];
        }
    }
}

/**
 *  ftp上传文件的结果
 *
 *  @param sInfo 结果信息字符串
 */
-(void)uploadResultInfo:(NSString *)sInfo{
    DLog(@"sInfo = %@",sInfo);
    if ([sInfo isEqualToString:@"uploadComplete"]) {
        if ([_myFileListArray count]>_currentDataAreaIndex) {
            [self useFTPSendFile];
        }else{
            [self upgradeSuccess];
            //升级文件发送完成
            [self commandCompleteWithType:0x1D andSendType:0x04 andContent:nil andContentLength:100000000 andPageNumber:100000000];
            [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(feedbackTimeout:) userInfo:nil repeats:NO];
        }
    }else{
        [myUpgradeButton2 setEnabled:YES];
        [self upgradeFaild];
    }
}

-(void)feedbackTimeout:(NSTimer *)myTimer{
    [myUpgradeButton2 setEnabled:YES];
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_upgradetimeout"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    [myAlertView release];
}

-(void)feedbackTimeout2:(NSTimer *)myTimer{
    [myUpgradeButton3 setEnabled:YES];
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_resettimeout"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    [myAlertView release];
}

-(void)upgradeFaild{
    [self upgradeSuccess];
    [self showUploadUpgradeFileError];
}

-(void)upgradeSuccess{
    _sendFileCountSize = 0;
    _currentDataAreaIndex = 0;
    promptLabel.text = @"";
}

/**
 *  ftp上传文件写入的数据长度
 *
 *  @param writeDataLength 数据长度
 */
-(void)uploadWriteData:(NSInteger)writeDataLength{
    _sendFileCountSize += writeDataLength;
    float progressValue = _sendFileCountSize*1.0f / _uploadFileTotalSize*1.0f;
    DLog(@"progressValue = %lf",progressValue);
    [_upgradeProgress setProgress:progressValue];
    promptLabel.text = [NSString stringWithFormat:@"%0.0lf％",progressValue*100];
}


-(void)showRestScreenSuccess{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_tryRestScreenSuccess"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    [myAlertView release];
}
-(void)showRestScreenfailed{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_tryRestScreenfailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    [myAlertView release];
}

-(void)showUploadUpgradeFileSuccess{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_upgradefinish"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    [myAlertView release];
}


-(void)showUploadUpgradeFileError{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_upgradeerror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    [myAlertView release];
}


/**
 *  创建折叠菜单
 */
-(void)createMenuViewWithRect:(CGRect)rect{
    UIView *containerView = [[UIView alloc]initWithFrame:rect];
    [containerView setBackgroundColor:[UIColor lightGrayColor]];
    UIView *menuView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, containerView.frame.size.width-40, containerView.frame.size.height - 40)];
    [menuView setBackgroundColor:[UIColor grayColor]];
    [containerView addSubview:menuView];

    //下载升级包
    _downloadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, menuView.frame.size.width, 200)];
    UILabel *downloadLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, _downloadView.frame.size.width-20, 100)];
    [downloadLabel setText:[Config DPLocalizedString:@"adedit_resetscreenprompt"]];
    [downloadLabel setNumberOfLines:4];
    [downloadLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [_downloadView addSubview:downloadLabel];
    _downloadProgress = [[UIProgressView alloc]initWithFrame:CGRectMake(10, downloadLabel.frame.size.height + downloadLabel.frame.origin.y, downloadLabel.frame.size.width-20, 2)];
    [_downloadView addSubview:_downloadProgress];

//    CGRect myUpgradeButtonRect = CGRectMake(_downloadView.frame.size.width-240, _downloadView.frame.size.height - 60, 100, 33);
//    myUpgradeButton = [BFPaperButton buttonWithType:UIButtonTypeCustom];
//    [myUpgradeButton setFrame:myUpgradeButtonRect];
//    [myUpgradeButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [myUpgradeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [myUpgradeButton setTag:TAG_UPGRADE_BUTTON];
//    [myUpgradeButton setTitle:[Config DPLocalizedString:@"adedit_downloadbuttontitle"] forState:UIControlStateNormal];
//    [myUpgradeButton setBackgroundImage:[UIImage imageNamed:@"置顶横条"] forState:UIControlStateDisabled];
//    myUpgradeButton.titleLabel.textColor = [UIColor whiteColor];
//    [_downloadView addSubview:myUpgradeButton];

    CGRect myUpgradeButtonRect1 = CGRectMake(_downloadView.frame.size.width-120, _downloadView.frame.size.height - 60, 100, 33);
    myUpgradeButton1 = [BFPaperButton buttonWithType:UIButtonTypeCustom];
    [myUpgradeButton1 setFrame:myUpgradeButtonRect1];
    [myUpgradeButton1 addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [myUpgradeButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myUpgradeButton1 setTag:TAG_UPGRADE_BUTTON11];
    [myUpgradeButton1 setTitle:[Config DPLocalizedString:@"adedit_downloadbuttontitle11"] forState:UIControlStateNormal];
    [myUpgradeButton1 setBackgroundImage:[UIImage imageNamed:@"置顶横条"] forState:UIControlStateDisabled];
    myUpgradeButton1.titleLabel.textColor = [UIColor whiteColor];
    [_downloadView addSubview:myUpgradeButton1];

    //上传升级包
    _upgradeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, menuView.frame.size.width, 200)];
    UILabel *upgradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, _downloadView.frame.size.width-20, 100)];
    [upgradeLabel setText:[Config DPLocalizedString:@"adedit_uploadupgradepackage"]];
    [upgradeLabel setNumberOfLines:4];
    [upgradeLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [_upgradeView addSubview:upgradeLabel];
    _upgradeProgress = [[UIProgressView alloc]initWithFrame:CGRectMake(10, upgradeLabel.frame.size.height + upgradeLabel.frame.origin.y, upgradeLabel.frame.size.width-20, 2)];
    [_upgradeView addSubview:_upgradeProgress];
    CGRect myUpgradeButtonRect2 = CGRectMake(_upgradeView.frame.size.width-100, _upgradeView.frame.size.height - 60, 60, 33);
    myUpgradeButton2 = [BFPaperButton buttonWithType:UIButtonTypeCustom];
    [myUpgradeButton2 setFrame:myUpgradeButtonRect2];
    [myUpgradeButton2 addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [myUpgradeButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myUpgradeButton2 setTag:TAG_UPGRADE_BUTTON2];
    [myUpgradeButton2 setTitle:[Config DPLocalizedString:@"adedit_upgradebuttontitle"] forState:UIControlStateNormal];
    [myUpgradeButton2 setBackgroundImage:[UIImage imageNamed:@"置顶横条"] forState:UIControlStateDisabled];
    myUpgradeButton2.titleLabel.textColor = [UIColor whiteColor];
    [_upgradeView addSubview:myUpgradeButton2];
    myUpgradePromptLabel = [[UILabel alloc]initWithFrame:CGRectMake(upgradeLabel.frame.origin.x, upgradeLabel.frame.origin.y+upgradeLabel.frame.size.height-40, upgradeLabel.frame.size.width, 30)];
    [_upgradeView addSubview:myUpgradePromptLabel];

    //重置
    _resetView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, menuView.frame.size.width, 200)];
    UILabel *resetLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, _downloadView.frame.size.width-20, 100)];
    [resetLabel setText:[Config DPLocalizedString:@"adedit_resetscreenprompt"]];
    [resetLabel setNumberOfLines:4];
    [resetLabel setLineBreakMode:NSLineBreakByWordWrapping];

    [_resetView addSubview:resetLabel];
    _resetProgress = [[UIProgressView alloc]initWithFrame:CGRectMake(10, resetLabel.frame.size.height + resetLabel.frame.origin.y, resetLabel.frame.size.width-20, 2)];
    [_resetView addSubview:_resetProgress];
    CGRect myUpgradeButtonRect3 = CGRectMake(_resetView.frame.size.width-100, _resetView.frame.size.height - 60, 60, 33);
    myUpgradeButton3 = [BFPaperButton buttonWithType:UIButtonTypeCustom];
    [myUpgradeButton3 setFrame:myUpgradeButtonRect3];
    [myUpgradeButton3 addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [myUpgradeButton3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myUpgradeButton3 setTag:TAG_UPGRADE_BUTTON3];
    [myUpgradeButton3 setTitle:[Config DPLocalizedString:@"adedit_RestDataProject"] forState:UIControlStateNormal];
    myUpgradeButton3.titleLabel.textColor = [UIColor whiteColor];
    [myUpgradeButton3 setBackgroundImage:[UIImage imageNamed:@"置顶横条"] forState:UIControlStateDisabled];
    [_resetView addSubview:myUpgradeButton3];


    myCollapseClick = [[CollapseClick alloc]initWithFrame:CGRectMake(0, 0, menuView.frame.size.width, menuView.frame.size.height)];
    myCollapseClick.CollapseClickDelegate = self;
    [myCollapseClick reloadCollapseClick];
    // If you want a cell open on load, run this method:
    [myCollapseClick openCollapseClickCellAtIndex:0 animated:NO];
    [menuView addSubview:myCollapseClick];

    [self.view addSubview:containerView];
}

#pragma mark - Collapse Click Delegate

// Required Methods
-(int)numberOfCellsForCollapseClick {
    return 3;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index {
    switch (index) {
        case 0:
            return [Config DPLocalizedString:@"adedit_checkupdatepakcage"];
            break;
        case 1:
            return [Config DPLocalizedString:@"adedit_upgradeprogram"];
            break;
        case 2:
            return [Config DPLocalizedString:@"adedit_resetscreenbutton"];
            break;

        default:
            return @"";
            break;
    }
}

-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index {
    switch (index) {
        case 0:
            return _downloadView;
            break;
        case 1:
            return _upgradeView;
            break;
        case 2:
            return _resetView;
            break;

        default:
            return _downloadView;
            break;
    }
}


// Optional Methods

-(UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index {
    return [UIColor whiteColor];
}


-(UIColor *)colorForTitleLabelAtIndex:(int)index {
    return [UIColor colorWithWhite:0.5 alpha:0.85];
}

-(UIColor *)colorForTitleArrowAtIndex:(int)index {
    return [UIColor colorWithWhite:0.0 alpha:0.25];
}

-(void)didClickCollapseClickCellAtIndex:(int)index isNowOpen:(BOOL)open {
    DLog(@"%d and it's open:%@", index, (open ? @"YES" : @"NO"));
    for (int i=0; i<3; i++) {
        if (i!=index) {
            [myCollapseClick closeCollapseClickCellAtIndex:i animated:YES];
        }
    }
    
}

@end
