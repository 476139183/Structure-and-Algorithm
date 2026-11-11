//
//  YXM_SettingViewController.m
//  LEDAD
//
//  Created by chengxu on 15/3/26.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "YXM_SettingViewController.h"
#import "Config.h"
#import "UpgradeViewController.h"
#import "RGBColorSlider.h"
#import "LanguageSettingViewController.h"
#import "RGBColorSliderDelegate.h"
#import "KWPopoverView.h"
#import "LayoutYXMViewController.h"
#import "SliderViewController.h"
#import "CX_ErrorViewController.h"
#import "DYT_ScreenupgradeViewController.h"
#import "VideosCenterCollectionPullViewController.h"

@interface YXM_SettingViewController ()<UITableViewDelegate,UITableViewDataSource,AsyncSocketDelegate>{

    UITableView *containerView;

    //soket连接
    AsyncSocket *_sendPlayerSocket;

    //当前数据仓库
    NSMutableArray *_currentDataArray;

    VideosCenterCollectionPullViewController *useview;

    //是否连接中
    BOOL isConnect;

    //当前数据区域的索引
    NSInteger _currentDataAreaIndex;


    //发送中
    BOOL isSendState;


    //发布进度
//    UIProgressView *myProgressView;

    //当前调整颜色的对象编号
    NSInteger _currentChangeColorViewTag;



    //当前选择区域的索引
    NSInteger _currentSelectIndex;
    LayoutYXMViewController *lay ;
    UIView *v;
    UITextField *textfid;
    SliderViewController *sliderview;
    CX_ErrorViewController *CXError;
    NSInteger Number;
    
}


//显示区域对象数组
@property (strong, nonatomic) NSArray *evaluateViews;
@property (nonatomic, strong) RGBColorSliderDelegate *delegate;

@end




@implementation YXM_SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Number = 0;
//    self.title = @"云屏设置";
    // Do any additional setup after loading the view.
    CXError = [[CX_ErrorViewController alloc]init];
    CGRect rectContainerView = CGRectMake(0, 0, self.view.frame.size.height - 320,self.view.frame.size.width);
    if (OS_VERSION_FLOAT>7.9) {
        rectContainerView = CGRectMake(0, 0, self.view.frame.size.width - 320,self.view.frame.size.height);
    }

    containerView = [[UITableView alloc]initWithFrame:rectContainerView];

    containerView.delegate = self;
    containerView.dataSource = self;
    lay = [[LayoutYXMViewController alloc]init];
    sliderview = [[SliderViewController alloc]init];

    [self.view addSubview:containerView];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//  去掉了屏幕亮度  以及以下的东西
    return 3;

}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//        云屏升级
    if(indexPath.row == 0){

        cell.textLabel.text = [Config DPLocalizedString:@"Root_upgrade"];

//        语言设置
    }
    else if(indexPath.row == 1){

        cell.textLabel.text = [Config DPLocalizedString:@"Root_LanguageSettings"];

//        使用教程
    }
    else if(indexPath.row == 2){

        cell.textLabel.text = [Config DPLocalizedString:@"Button_syproject1"];

//        云屏背景
    }
    else if(indexPath.row == 3){

        cell.textLabel.text =[Config DPLocalizedString:@"adedit_background"];

//        安全退出
    }
    else if(indexPath.row == 4){

        cell.textLabel.text = [Config DPLocalizedString:@"adedit_guanji"];

    }
    else if(indexPath.row == 5){
        
        cell.textLabel.text = [Config DPLocalizedString:@"adedit_chongqi"];
        
    }

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100.0;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    if (indexPath.row == 0) {
//        if (selectIpArr.count==0) {
//            [CXError NOipError];
//        }else{
        DYT_ScreenupgradeViewController *vc = [[DYT_ScreenupgradeViewController alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//            UpgradeViewController *vc = [[UpgradeViewController alloc]init];
            [self.view addSubview:vc];
//        }
    }
   else if (indexPath.row == 1) {
       LanguageSettingViewController *vc = [[LanguageSettingViewController alloc]init];
       [self.view addSubview:vc.view];
   }else if (indexPath.row == 2){
       if (useview) {
           [useview.view removeFromSuperview];
       }
       useview = [[VideosCenterCollectionPullViewController alloc]init];
       [useview.view setFrame:CGRectMake(0, 0, self.view.frame.size.width - 330, self.view.frame.size.height-60)];
       [self.view addSubview:useview.view];


   }else if(indexPath.row == 3){
       

   }else if (indexPath.row == 4){
       if (selectIpArr.count==0) {
           [CXError NOipError];
       }else{
           [self resetguanji];
       }

   }else if(indexPath.row == 5){
       if (selectIpArr.count==0) {
           [CXError NOipError];
       }else{
           [self resetchongqi];
       }
   }
}

/**
 *  云屏背景设置
 */
-(void)background{
    //    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_tishi"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    //    [myAlertView show];
    //    [myAlertView release];
    //    [self startSocket];
    [self alertload];
    back = YES;
    //    //    [self ftpuser];
}
-(void)alertload{
    v=[[UIView alloc]initWithFrame:CGRectMake(300,300, 400, 60)];
    v.backgroundColor=[UIColor cyanColor];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 50)];
    lab.text=[Config DPLocalizedString:@""];
    textfid=[[UITextField alloc]initWithFrame:CGRectMake(120, 5, 200, 50)];
    textfid.backgroundColor=[UIColor whiteColor];
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(330, 5, 60, 50)];
    [btn setTitle:[Config DPLocalizedString:@"adedit_Done"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(onclick) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:btn];
    [v addSubview:textfid];
    [v addSubview:lab];
    [self.view addSubview:v];
}
-(void)onclick{
    if([textfid.text isEqual:@"zdec"]){
        v.hidden=YES;
        back=YES;
        //        [self ftpuser]
        myMasterCtrl = [[CTMasterViewController alloc]init];
        [myMasterCtrl.view setFrame:CGRectMake(0, 50, 1, 1)];

        [self.view addSubview:myMasterCtrl.view];
        [myMasterCtrl setSAssetType:ASSET_TYPE_PHOTO];
        [myMasterCtrl setIAssetMaxSelect:1];
        [myMasterCtrl pickAssets:nil];
        [myMasterCtrl setIslist:NO];
    }else{
        v.hidden=YES;
    }
}


//关机
-(void)resetguanji{
//    if (!isConnect) {
    ipAddressString = selectIpArr[Number];
    isConnect = NO;
    [self startSocket];
//    }
    DLog(@"关机");
    //0x16
    [self commandResetServerWithType:0x16 andContent:nil andContentLength:0];

}

//重启
-(void)resetchongqi{
    //    if (!isConnect) {
    ipAddressString = selectIpArr[Number];
    isConnect = NO;
    [self startSocket];
    //    }
    DLog(@"重启");
    //0x20
    [self commandResetServerWithType:0x20 andContent:nil andContentLength:0];

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

/**resetBrightness
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
    DLog(@"返回的数据");
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

    if(AckByte[1]==0x16){
        Number++;
        if (Number<selectIpArr.count) {
            [self resetguanji];
        }else{
        Number = 0;
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_tuichu"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
        }
    }else if(AckByte[1]==0x20){
        Number++;
        if (Number<selectIpArr.count) {
            [self resetchongqi];
        }else{
            Number = 0;
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_chongqi1"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
        }
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}//设置状态栏风格



-  (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;//NO不清除
}




- (BOOL)isPureInt:(NSString*)string{
    if ([string length]==0) {
        return YES;
    }
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}






/*
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
