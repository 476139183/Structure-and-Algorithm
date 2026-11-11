//
//  ScreenOptionsViewController.m
//  屏体选项的类文件
//
//  Created by LDY on 13-11-26.
//
//

#import "ScreenOptionsViewController.h"
#import "Config.h"
#import "BaseButton.h"
#import "YXM_PlayerListTableViewCell.h"
#import "YXM_WiFiManagerViewController.h"
#import "MyProjectListViewController.h"
#import "LayoutYXMViewController.h"
#import "YXM_SettingViewController.h"
#import "SliderViewController.h"
#import "screendata_TableViewController.h"
#import "dyt_projectgroup.h"
#import "CX_ProgramViewController.h"
#import "CX_LEDControlViewController.h"
#import "DYT_TheNearFutureViewController.h"
#import "DYT_rightbaseview.h"
#import "CX_ErrorViewController.h"
#define firsttag 4004
#define nexttag  4005
@interface ScreenOptionsViewController ()<UIPopoverControllerDelegate,UIAlertViewDelegate>
{
    NSMutableArray *ipArray;
    BOOL isupdate;
    UITextField *updatefield;
    UIButton *LEDNum;
    
    LayoutYXMViewController *lay;
    
    YXM_SettingViewController * cx;
    
    SliderViewController *CX;
    
    UIView * viewlist;
    UIView *shangci1;
    UIButton *bencibtn;
    UIButton *shangcibtn;
    
    
    //接受多屏的  数组
    NSMutableArray *_MYIPArray;
    CTMasterViewController *myMasterCtrl;
    
    
//
    
    
    // 气泡
    UIPopoverController *_popCtl;
    

    
    
    
    
//    screendata_TableViewController
    
    
}
@end

@implementation ScreenOptionsViewController



-(void)initBrodcast
{
    @try {
        
//       DLog(@"收到广播");
        _playerBroadcast = [[AsyncUdpSocketReceiveUpgradeTranscationBroadcastIp alloc] initReceivePlayerBroadcastIp:^(NSString *ledPlayerName,NSString *ledPlayerIP){
            if (ledPlayerIP!=nil) {
//                DLog(@"有广播====%@",ipAddressArr);
                NSString *ip = [[NSString alloc]initWithFormat:@"%@",[ledPlayerIP stringByReplacingOccurrencesOfString:@"::ffff:" withString:@""]];
                
                if (![ipAddressArr containsObject:ip]) {
                    [ipAddressArr addObject:ip];
//                    DLog(@"广播新增 =====%@",ipAddressArr);
                    if (ledPlayerName!=nil) {
                        playerNameString = [[NSString alloc]initWithFormat:@"%@",ledPlayerName];
//                        if (![ipNameArr containsObject:playerNameString]) {
                            [ipNameArr addObject:playerNameString];
//                        }
                        
                    }
                }
            }
//            DLog(@"====%@",ipAddressArr);
            DNetLog(@"----升级时广播不异常------ledPlayerIP=%@,ledPlayerName=%@,50000",ipAddressString,playerNameString);
        }];

    }
    @catch (NSException *exception) {
        DLog(@"升级时广播异常 = %@",exception);
    }
    @finally {

    }
}
- (void)intDataSoure
{
    _MYIPArray = [[NSMutableArray alloc]init];
    //数据源
    selectIpArr = [[NSMutableArray alloc]init];
    selectNameArr = [[NSMutableArray alloc]init];
    
    ipAddressArr = [[NSMutableArray alloc]init];
    ipNameArr = [[NSMutableArray alloc]init];
    
    isupdate = NO;
}
- (void)viewDidLoad
{

    _tableOfRow = 0;
    
    [super viewDidLoad];
    
  
    
    //初始化ip名字和地址数组
    [self intDataSoure];
    
    //广播 接收ip
    [self initBrodcast];
    
    lay = [[LayoutYXMViewController alloc]init];
    cx = [[YXM_SettingViewController alloc]init];


  //=======================云屏界面修改=============================
//    NSString *topnavistr=[[NSString alloc]initWithFormat:@"置顶横条"];
//    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:topnavistr]];
//    titleImageView.frame = CGRectMake(0, 0, containerView.frame.size.width, 44);
//    //导航栏上的标题
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, 44)];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.text = [Config DPLocalizedString:@"Root_ScreenOptions"];
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [titleImageView addSubview:titleLabel];
//    [titleLabel release];
//    [containerView addSubview:titleImageView];
//    [titleImageView release];
//
//    //屏体选项的背景视图
//    backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 100, 500, 400)];
//    UIImage *image = [UIImage imageNamed:@"CustomBoxBig.png"];
//    
//    CGFloat top = 25; // 顶端盖高度
//    CGFloat bottom = 25 ; // 底端盖高度
//    CGFloat left = 10; // 左端盖宽度
//    CGFloat right = 10; // 右端盖宽度
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//    // 指定为拉伸模式，伸缩后重新赋值
//    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//    backgroundView.image = image;
//
//    //终端名称
//    terminalNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500/2, 40)];
//    terminalNameLabel.text = [Config  DPLocalizedString:@"ScreenOptions_TerminalName"];
//    terminalNameLabel.textAlignment = NSTextAlignmentCenter;
//    [backgroundView addSubview:terminalNameLabel];
//    
//    
//    
//    //地址
//    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(500/2, 0, 500/2, 40)];
//    addressLabel.text = [Config  DPLocalizedString:@"ScreenOptions_address"];
//    addressLabel.textAlignment = NSTextAlignmentCenter;
//    [backgroundView addSubview:addressLabel];
//
//    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(80, 140, backgroundView.frame.size.width, 320) style:UITableViewStylePlain];
//    _myTableView.backgroundColor = [UIColor clearColor];
//    _myTableView.dataSource = self;
//    _myTableView.delegate = self;
//    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    _myTableView.showsHorizontalScrollIndicator=NO;
//    _myTableView.showsVerticalScrollIndicator=NO;
//
//    
//    [containerView addSubview:backgroundView];
//    [containerView addSubview:_myTableView];
//    
//    //刷新按钮
//
////    confirmButton = [[BFPaperButton alloc] initWithFrame:CGRectMake(90, 550, 120, 44)];
////    [confirmButton setTitle:[Config DPLocalizedString:@"User_OK"] forState:UIControlStateNormal];
////    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
////    [confirmButton addTarget:self action:@selector(refreshIPButton:) forControlEvents:UIControlEventTouchUpInside];
////    [containerView addSubview:confirmButton];
//
//
//    
//
////    wifiPasswordMangerButton = [[BFPaperButton alloc] initWithFrame:CGRectMake(110, 550, 200, 44)];
////    [wifiPasswordMangerButton setTitle:[Config DPLocalizedString:@"adedit_wifipasswordbutton"] forState:UIControlStateNormal];
////    [wifiPasswordMangerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
////    [wifiPasswordMangerButton addTarget:self action:@selector(wifiPasswordMangerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
////    [containerView addSubview:wifiPasswordMangerButton];
//=============================================
    
//    //修改终端名称
//    updateNameButton = [[BFPaperButton alloc] initWithFrame:CGRectMake(200,550, 200, 44)];
//    [updateNameButton setTitle:[Config DPLocalizedString:@"ScreenOptions_updateName"] forState:UIControlStateNormal];
//    [updateNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [updateNameButton addTarget:self action:@selector(updateButton:) forControlEvents:UIControlEventTouchUpInside];
//    [containerView addSubview:updateNameButton];
//    
//    saveNameButton = [[BFPaperButton alloc] initWithFrame:CGRectMake(200, 550, 200, 44)];
//    [saveNameButton setTitle:[Config DPLocalizedString:@"ScreenOptions_saveName"] forState:UIControlStateNormal];
//    [saveNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [saveNameButton addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
//    saveNameButton.hidden=YES;
//    [containerView addSubview:saveNameButton];
//    if (_istrue) {
//        updateNameButton.hidden = YES;
//        saveNameButton.hidden = YES;
//    }

    [self initloadview];
    
    //定时器刷新列表
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(reloadMyTable) userInfo:nil repeats:YES];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 7003) {
        UITextField *mytextfild = [alertView textFieldAtIndex:0];
        if (mytextfild.text.length!=0&&![mytextfild.text isEqualToString:@""]) {
            [self writeFile:@"vlc.txt" Data:mytextfild.text];
            DYT_rightbaseview *dyt = [[DYT_rightbaseview alloc]init];
            [dyt ftpuser1];
        }
    }
    if (alertView.tag == 7002) {
        DLog(@"bu==%ld",buttonIndex);
        if (buttonIndex==0) {
            
            UITextField *mytextfild = [alertView textFieldAtIndex:0];
            if([mytextfild.text isEqual:@"zdec"]){
                back=YES;

                myMasterCtrl = [[CTMasterViewController alloc]init];
                [myMasterCtrl.view setFrame:CGRectMake(0, 0, 1, 1)];
                myMasterCtrl.view.backgroundColor = [UIColor cyanColor];
                myMasterCtrl.delegate = self;
                myMasterCtrl.tableView.hidden = YES;
                [self.view addSubview:myMasterCtrl.view];
                
                //        [self ftpuser]
                [myMasterCtrl setSAssetType:ASSET_TYPE_PHOTO];
                [myMasterCtrl setIAssetMaxSelect:1];
                [myMasterCtrl pickAssets:nil];
                [myMasterCtrl setIslist:NO];            }
        }
    }
}

//云屏选项界面
-(void)initloadview{
    
    CGRect rectContainerView = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-20);
    
    if (OS_VERSION_FLOAT>7.9) {
        rectContainerView = CGRectMake(0, 0, self.view.frame.size.width-320,self.view.frame.size.height-20);
    }
    
    
    
    containerView = [[UIView alloc]initWithFrame:rectContainerView];
    [self.view addSubview:containerView];
    
    LEDNum = [[UIButton alloc]initWithFrame:CGRectMake(10, 15, 100, 40)];
    [LEDNum setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    
//    云屏数量
    [LEDNum setTitle:[NSString stringWithFormat:@"%@:0",[Config DPLocalizedString:@"LED_Number"]] forState:UIControlStateNormal];
    [containerView addSubview:LEDNum];
    
//    刷新
    UIButton *restbtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-320-60, 15, 50, 40)];
    [restbtn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [restbtn addTarget:self action:@selector(rest) forControlEvents:UIControlEventTouchUpInside];
    [restbtn.titleLabel setFont:[UIFont systemFontOfSize:12]];

    [restbtn setTitle:[Config DPLocalizedString:@"User_OK"] forState:UIControlStateNormal];
    [containerView addSubview:restbtn];
 
    
    
    
    
    
    
//    上次设置与本次设置 近期连屏设置
    
    
    shangcibtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-320-60-120, 15, 100, 40)];
    [shangcibtn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
    [shangcibtn addTarget:self action:@selector(shangcibtn) forControlEvents:UIControlEventTouchUpInside];
    [shangcibtn setTitle:[Config DPLocalizedString:[Config DPLocalizedString:@"adedit_jqlp"]] forState:UIControlStateNormal];
    [shangcibtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    shangcibtn.tag = firsttag;
    [containerView addSubview:shangcibtn];
//    
//    bencibtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-320-60-120, 15, 100, 40)];
//    [bencibtn setBackgroundImage:[UIImage imageNamed:@"btn"] forState:UIControlStateNormal];
//    [bencibtn addTarget:self action:@selector(bencibtn) forControlEvents:UIControlEventTouchUpInside];
//    [bencibtn setTitle:[Config DPLocalizedString:@"adedit_benci"] forState:UIControlStateNormal];
//    bencibtn.hidden = YES;
//    [containerView addSubview:bencibtn];
    
    NSInteger wid = self.view.frame.size.height-200;
    NSArray *title = [[NSArray alloc]initWithObjects:[Config DPLocalizedString:@"adedit_brightness"],[Config DPLocalizedString:@"ScreenOptions_updateName"],[Config DPLocalizedString:@"adedit_ledbak"],[Config DPLocalizedString:@"adedit_ypfa1"],[Config DPLocalizedString:@"adedit_guanji"],[Config DPLocalizedString:@"adedit_chongqi"],[Config DPLocalizedString:@"adedit_zc17"],[Config DPLocalizedString:@"adedit_dlpkz"],nil];
    
    for (int k=0; k<title.count; k++) {
        
        BFPaperButton *button = [[BFPaperButton alloc]initWithFrame:CGRectMake(30+170*(k%4), wid+50*(k/4), 150, 40)];
        button.tag = 1102+k;
        [button setTitle:title[k] forState:UIControlStateNormal];
        button.titleFont = [UIFont systemFontOfSize:12];
        [button addTarget:self action:@selector(mybtnonclick:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:button];
        
    }
    
//    取消同步播放
    BFPaperButton *Cancelbutton = [[BFPaperButton alloc]initWithFrame:CGRectMake(30, wid, 100, 40)];
    Cancelbutton.tag = 1058;
    [Cancelbutton setTitle:@"取消同步播放" forState:UIControlStateNormal];
    [Cancelbutton addTarget:self action:@selector(cancelbutton:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:Cancelbutton];
    Cancelbutton.hidden = YES;
//  完成连平设置
    
    BFPaperButton *savebutton = [[BFPaperButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-320-150, wid, 100, 40)];
    savebutton.tag = 1059;
    
    [savebutton setTitle:@"完成" forState:UIControlStateNormal];
    
    [containerView addSubview:savebutton];
    savebutton.hidden = YES;

    
    
    
////多屏同步
//    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height-200, 100, 40)];
//    
//    [btn1 setTitle:[Config DPLocalizedString:@"adedit_tongbu"] forState:UIControlStateNormal];
//    [btn1 setBackgroundImage:[UIImage imageNamed:@"btnselected"] forState:UIControlStateNormal];
//    btn1.tag = 1058;
//    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
//    [containerView addSubview:btn1];
//
////屏幕亮度
//    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.frame.origin.x + btn1.frame.size.width + 20, self.view.frame.size.height-200, 100, 40)];
//    [btn2 setBackgroundImage:[UIImage imageNamed:@"btnselected"] forState:UIControlStateNormal];
//    [btn2 setTitle:[Config DPLocalizedString:@"adedit_brightness"] forState:UIControlStateNormal];
//    btn2.tag = 1059;
//    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    [btn2 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
//    [containerView addSubview:btn2];
//
////关机
//    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(btn2.frame.origin.x + btn2.frame.size.width + 20, self.view.frame.size.height-200, 100, 40)];
//    [btn3 setBackgroundImage:[UIImage imageNamed:@"btnselected"] forState:UIControlStateNormal];
//    [btn3 setTitle:[Config DPLocalizedString:@"adedit_guanji"] forState:UIControlStateNormal];
//    btn3.tag = 1060;
//    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    [btn3 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
//    [containerView addSubview:btn3];
//
////重启
//    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(btn3.frame.origin.x + btn3.frame.size.width + 20, self.view.frame.size.height-200, 100, 40)];
//    [btn4 setBackgroundImage:[UIImage imageNamed:@"btnselected"] forState:UIControlStateNormal];
//    [btn4 setTitle:[Config DPLocalizedString:@"adedit_chongqi"] forState:UIControlStateNormal];
//    btn4.tag = 1061;
//    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    [btn4 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
//    [containerView addSubview:btn4];
//    
////    修改终端名字
//    updateNameButton = [[BFPaperButton alloc] initWithFrame:CGRectMake(btn4.frame.origin.x + btn4.frame.size.width + 20, self.view.frame.size.height-200, 100, 40)];
//    [updateNameButton setTitle:[Config DPLocalizedString:@"ScreenOptions_updateName"] forState:UIControlStateNormal];
//    [updateNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [updateNameButton addTarget:self action:@selector(updateButton:) forControlEvents:UIControlEventTouchUpInside];
//    [containerView addSubview:updateNameButton];
//
////    保存终端名字
//    saveNameButton = [[BFPaperButton alloc] initWithFrame:CGRectMake(btn4.frame.origin.x + btn4.frame.size.width + 20, self.view.frame.size.height-200, 100, 40)];
//    [saveNameButton setTitle:[Config DPLocalizedString:@"ScreenOptions_saveName"] forState:UIControlStateNormal];
//    [saveNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [saveNameButton addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
//    saveNameButton.hidden=YES;
//    [containerView addSubview:saveNameButton];
//    
    
    
    
    
    
//    加载泡泡
    
    //下拉表格
    screendata_TableViewController *sendview = [[screendata_TableViewController alloc]init];
//    sendview.delege=self;
    //气泡
    _popCtl=[[UIPopoverController alloc]initWithContentViewController:sendview];
    _popCtl.delegate = self;
    _popCtl.popoverContentSize = CGSizeMake(500, 500);

    
    
    
    
    
    
}

-(void)rest{
    [selectIpArr removeAllObjects];
    [selectNameArr removeAllObjects];
    [ipAddressArr removeAllObjects];
    [self reloadMyTable];
}
-(void)bencibtn{
    
    
    shangcibtn.hidden = NO;
    bencibtn.hidden = YES;
    UIView *shangci = [containerView viewWithTag:20150511];
    shangci.hidden = NO;
    UIView *benci = [containerView viewWithTag:20150510];
    benci.hidden = YES;
}
-(void)shangcibtn{
    DYT_TheNearFutureViewController *dyt = [[DYT_TheNearFutureViewController alloc]init];
    [self presentViewController:dyt animated:YES completion:nil];
}







-(void)mybtnonclick:(BFPaperButton *)sender{
    
    
    
//     if (ipAddressString==NULL) {
//     
//     //如没有联网
//     UIAlertView *mynextalertview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_NoipError"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles: nil];
//     [mynextalertview show];
//     return;
//     }
//     
    
//     硬件检测
    if (sender.tag == 1100) {
        DLog(@"硬件检测");
        //隐藏其他的button
        for (int k=0; k<8; k++) {
            BFPaperButton *button  = (BFPaperButton *)[self.view viewWithTag:1100+k];
            button.hidden = !button.hidden;
        }
        sender.hidden = NO;
        
        [_popCtl presentPopoverFromRect:CGRectMake(100, 0, 5, 5) inView:sender permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        
        
    }

    
    
//    多屏同步
    if (sender.tag == 1101)
    {
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        [ud setObject:selectIpArr forKey:@"selectIPArr"];
        [ud setObject:selectNameArr forKey:@"selectNameArr"];
//        [lay tongBu_buttonOnClick];
    }
    
//    屏幕亮度
    
     if (sender.tag == 1102){
         
         if (selectIpArr.count == 0) {
             CX_ErrorViewController *err = [[CX_ErrorViewController alloc]init];
             [err NOipError];
         }else{
        CX = [[SliderViewController alloc]init];
        [self.view addSubview:CX.view];
         }
    }
    
//    修改终端名称
    if (sender.tag ==1103) {
        if (selectIpArr.count == 0) {
            CX_ErrorViewController *err = [[CX_ErrorViewController alloc]init];
            [err NOipError];
        }else{
        UIAlertView *myalert = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_ledname"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles:[Config DPLocalizedString:@"NSStringNO"], nil];
        myalert.tag = 7003;
        myalert.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        [myalert show];
        }
    }
    
//    修改云端背景
    if (sender.tag ==1104) {
        if (selectIpArr.count == 0) {
            CX_ErrorViewController *err = [[CX_ErrorViewController alloc]init];
            [err NOipError];
        }else{
        UIAlertView *aletview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_ledbak"] message:[Config DPLocalizedString:@"adedit_ledkl"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_Done"] otherButtonTitles: nil];
        aletview.tag = 7002;
        aletview.alertViewStyle = UIAlertViewStylePlainTextInput;
        [aletview show];
        }
    }
    
//    查看方案
    if (sender.tag ==1105) {
        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
        NSArray *filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                                    fromDirPath:documentsDirectory AndIsGroupDir:YES];
        DLog(@"%@",filenameArray);
        if (filenameArray.count == 0) {
            UIAlertView *alerview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_zc16"] delegate:nil cancelButtonTitle:[Config DPLocalizedString: @"NSStringYes"] otherButtonTitles: nil];
            [alerview show];
        }else{
        CX_ProgramViewController *cxpro = [[CX_ProgramViewController alloc]init];
//        [cxpro.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
        [self presentViewController:cxpro animated:YES completion:nil];
        }
//        [self.view addSubview:cxpro.view];
    }
    
    
//    关机
     if (sender.tag == 1106){
         if (selectIpArr.count == 0) {
             CX_ErrorViewController *err = [[CX_ErrorViewController alloc]init];
             [err NOipError];
         }else{
        [cx resetguanji];
         }
    }
//    重启
    if (sender.tag == 1107){
        if (selectIpArr.count == 0) {
            CX_ErrorViewController *err = [[CX_ErrorViewController alloc]init];
            [err NOipError];
        }else{
        [cx resetchongqi];
        }
    }
    if (sender.tag == 1109){
        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
        NSArray *filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                                    fromDirPath:documentsDirectory AndIsGroupDir:YES];
        DLog(@"%@",filenameArray);
        if (filenameArray.count == 0) {
            UIAlertView *alerview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_zc16"] delegate:nil cancelButtonTitle:[Config DPLocalizedString: @"NSStringYes"] otherButtonTitles: nil];
            [alerview show];
        }else{
        CX_LEDControlViewController *cxled = [[CX_LEDControlViewController alloc]init];
        [self presentViewController:cxled animated:YES completion:nil];
        }
    }

    DLog(@"---%d",sender.tag);
    if (sender.tag == 1108) {
        
//        单屏快传
//        if (selectIpArr.count==1) {
        if (selectIpArr.count == 0) {
            CX_ErrorViewController *err = [[CX_ErrorViewController alloc]init];
            [err NOipError];
        }else{
            dyt_OnefastViewController *viewcontroller = [[dyt_OnefastViewController alloc]init];
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (int i=0; i<selectIpArr.count; i++) {
            dyt_projectgroup *pro = [[dyt_projectgroup alloc]init];
            pro.name = selectNameArr[i];
            pro.ipname = selectIpArr[i];
            [arr addObject:pro];
            
        }
        viewcontroller.number = arr;
        
        UINavigationController *testNav = [[UINavigationController alloc] initWithRootViewController:viewcontroller];
        
        
        
             [self presentViewController:testNav animated:YES completion:nil];
            
//        }else
//        {
//        
//            [self showalertview:@"请选择一个屏"];
//        }
//        
        }
        
    }
    
    
}

//修改终端名字按钮
-(void)updateButton:(UIButton*)sender{
    
    DLog(@"修改终端名字");
    if (selectIpArr.count>0) {
//        for (int i=0; i<_tableOfRow; i++) {
//            YXM_PlayerListTableViewCell *cell = (YXM_PlayerListTableViewCell*)[_myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//            if (cell._select.tag == 11) {
//                updatefield = [[UITextField alloc]initWithFrame:CGRectMake(_myTableView.frame.origin.x, _myTableView.frame.origin.y+cell.frame.size.height*i, cell.frame.size.width/2, cell.frame.size.height)];
//                [updatefield setText:cell.myObj.player_name];
//                updatefield.backgroundColor = [UIColor brownColor];
//                [self.view addSubview:updatefield];
//            }
//        }
        for (int i = 0; i<ipAddressArr.count; i ++) {
            UIButton *btn =(UIButton*)[self.view viewWithTag:i+1];
            if (btn.selected == YES) {
                UILabel *lab = (UILabel*)[self.view viewWithTag:10+i];
                updatefield = [[UITextField alloc]initWithFrame:lab.frame];
                [updatefield setText:lab.text];
                updatefield.backgroundColor = [UIColor brownColor];
                [viewlist addSubview:updatefield];
            }
        }
        saveNameButton.hidden = NO;
        updateNameButton.hidden = YES;
    }else{
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_tishiupdate"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }

}


//保存终端名字
-(void)saveButton:(UIButton*)sender{

//存在中文
    if ([updatefield.text isEqualToString:@""]) {
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:@"不能为空" delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }else{
        saveNameButton.hidden = YES;
        updateNameButton.hidden = NO;
        
        [self writeFile:@"vlc.txt" Data:updatefield.text];

        [lay ftpuser1];
        updatefield.hidden=YES;
        [updatefield release];
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_tishi1"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }
}


//写文件
-(void)writeFile:(NSString*)filename Data:(NSString*)data

{
    //获得应用程序沙盒的Documents目录，官方推荐数据文件保存在此
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* doc_path = [path objectAtIndex:0];
    
    DLog(@"Documents Directory:%@",doc_path);
    
    //创建文件管理器对象
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString* _filename = [doc_path stringByAppendingPathComponent:filename];
    //NSString* new_folder = [doc_path stringByAppendingPathComponent:@"test"];
    //创建目录
    //[fm createDirectoryAtPath:new_folder withIntermediateDirectories:YES attributes:nil error:nil];
    [fm createFileAtPath:_filename contents:[data dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    NSArray *files = [fm subpathsAtPath: doc_path];
    DLog(@"%@",files);
    
}


/*
 这是什么鬼啊！！！！！！
 
 
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
 *  启动网络连接
 */
-(void)startSocket
{
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
}



- (void)refreshIPButton:(BaseButton *)sender
{
    if (!buttonIsClicked) {
        buttonIsClicked = YES;
        [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(setButtonBool) userInfo:nil repeats:NO];
        [_playerBroadcast closeUDPSocket];
        [_playerBroadcast startUDPSocket];
    }

}

-(void)setButtonBool
{
    buttonIsClicked = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    DLog(@"------------%@**************%@...........%@",NameArray,IPArray,playerNameString);
    [self reloadMyTable];
}

#pragma mark-定时器
-(void)reloadMyTable
{
//    DLog(@"小问题----%@",ipNameArr);
    [self initBrodcast];
//    DLog(@"====%d",ipAddressArr.count);

//        if (_myTableView) {
//        [_myTableView reloadData];
    /*
    if (([ipAddressString length]>1)&&([playerNameString length]>1)) {
        _tableOfRow = 1;
    }else{
        ipAddressString=@"";
        _tableOfRow = 0;
    }
    if (_myTableView) {
        [_myTableView reloadData];
    }
     */

    if (_tableOfRow == ipAddressArr.count) {
//        DLog(@"如果没有收到广播或者广播没有更新  就不进行操作");
    }else{
        DLog(@"初始化");
    _tableOfRow = ipAddressArr.count;
    [LEDNum setTitle:[NSString stringWithFormat:@"%@:%ld",[Config DPLocalizedString:@"LED_Number"],(long)ipAddressArr.count] forState:UIControlStateNormal];
    if (viewlist) {
        [viewlist.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }else{
//        承载屏端的东西
        viewlist = [[UIView alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, self.view.frame.size.height-500)];

        
        viewlist.tag = 20150511;
        [containerView addSubview:viewlist];
        shangci1 = [[UIView alloc]initWithFrame:viewlist.frame];
        shangci1.tag = 20150510;
        shangci1.hidden = YES;
        [containerView addSubview:shangci1];


    }
//    viewlist.backgroundColor = [UIColor redColor];
        //*********
        //待解决bug
        int a = (int)_tableOfRow/5;
        int b = (int)_tableOfRow%5;
        int c = 5;
        int d = 0;
        if (b>0) {
            a++;
        }
        for (int i=0; i<a; i++) {
            if (i+1 == a) {
                if (b>0) {
                    c = b;
                }
            }else{
                c = 5;
            }
            
            for (int j=0; j<c; j++) {
//                选择屏体的but
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10+(100+20)*j, 10+(100+20+40)*i, 100 , 100)];
                [btn setImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
                if ([selectIpArr containsObject:ipAddressArr[d]]) {
                    btn.selected = YES;
                }else{
                    btn.selected = NO;
                }
                btn.tag = d+1;
                [btn addTarget:self action:@selector(MYonclick:) forControlEvents:UIControlEventTouchUpInside];
                [viewlist addSubview:btn];
                UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y+btn.frame.size.height+10, btn.frame.size.width, 40)];
                [lab setText:[NSString stringWithFormat:@"%@",ipNameArr[d]]];
                lab.textAlignment = NSTextAlignmentCenter;
                lab.tag = 10+d;
                //            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(lab.frame.origin.x, lab.frame.origin.y+lab.frame.size.height+10, btn.frame.size.width, 40)];
                //            [lab1 setText:[NSString stringWithFormat:@"%@",ipAddressArr[d]]];
                //            [lab1 setFont:[UIFont systemFontOfSize:12]];
                //            lab1.textAlignment = NSTextAlignmentCenter;
                d++;
                [viewlist addSubview:lab];
                //            [viewlist addSubview:lab1];
            }
        }
        //******
    }
}

-(void)MYonclick:(UIButton *)sender{
    
    DLog(@"点击了选屏%d",sender.selected);
    if (!sender.selected) {
//
        sender.selected = YES;;
        [sender setImage:[UIImage imageNamed:@"LEDYES"] forState:UIControlStateSelected];
        ipAddressString = ipAddressArr[sender.tag-1];
        [selectNameArr addObject:ipNameArr[sender.tag-1]];
        [selectIpArr addObject:ipAddressArr[sender.tag-1]];
        isConnect = NO;
//        查看    联网
        [self startSocket];
    }else{
        
        sender.selected = NO;
        [sender setImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
        
        [selectIpArr removeObject:ipAddressArr[sender.tag-1]];
    }

}



#pragma mark-表格   段雨田表示目前弃用

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    YXM_PlayerListTableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (myCell==nil) {
        myCell = [[YXM_PlayerListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
//    if (isupdate) {
//        if (myCell._select.tag == 11) {
//            myCell.serverNameFile.hidden = NO;
//            myCell.serverNameLabel.hidden = YES;
//        }
//    }

    YXM_PlayerListObject *myObj = [[YXM_PlayerListObject alloc]init];
//    DLog(@"IP    是    %@",playerNameString);
    [myObj setPlayer_name:ipNameArr[indexPath.row]];
    [myObj setPlayer_ip:ipAddressArr[indexPath.row ]];
//    [myObj setPlayer_ip:ipAddressString];


//    [userdefauls setObject:myCell forKey:[NSString stringWithFormat:@"%@",playerNameString]];
//    YXM_PlayerListObject *myobjc = (YXM_PlayerListObject *)[userdefauls objectForKey:[NSString stringWithFormat:@"%@",playerNameString]];
//    DLog(@"------****-%@",myobjc.player_name);

   // DLog(@"数据   %@    %ld",playerNameString,NameArray.count);
    
    
    
    [myCell setMyObj:myObj];
    return myCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableOfRow;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXM_PlayerListTableViewCell *myCell = (YXM_PlayerListTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (myCell._select.tag==10) {
        myCell._select.tag=11;
        [selectIpArr addObject:myCell.myObj.player_ip];
        [selectNameArr addObject:myCell.myObj.player_name];
        ipAddressString = ipAddressArr[indexPath.row];
        myCell._select.image=[UIImage imageNamed:@"select_Yes"];
    }else if(myCell._select.tag==11){
        myCell._select.tag=10;
        [selectIpArr removeObject:myCell.myObj.player_ip];
        [selectNameArr removeObject:myCell.myObj.player_name];
        myCell._select.image=[UIImage imageNamed:@"select_No"];
    }
    DLog(@"qqqq===%@",selectIpArr);
    DLog(@"aaaa===%@",ipAddressString);
}



//取消多屏同步
-(void)cancelbutton:(BFPaperButton *)sender
{

    DLog(@"点击l 近期连平设置");
    shangcibtn.hidden = NO;
    //隐藏其他的button
    for (int k=0; k<8; k++) {
        BFPaperButton *button  = (BFPaperButton *)[self.view viewWithTag:1100+k];
        button.hidden = NO;
    }
    for (int k=0; k<2; k++) {
        BFPaperButton *button  = (BFPaperButton *)[self.view viewWithTag:1058+k];
        button.hidden = YES;
    }



}

//用来决定用户点击了蒙版后，popoverController是否可以dismiss,返回YES代表可以，返回NO代表不可以
-(BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
        return NO;
}
//- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController;
//{
////    if (popoverController==_popCtl) {
////        return YES;
////    }
//    return NO;
//    
//}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController;
{
    if (popoverController == _popCtl) {
        
    }
    
}


-(void)wifiPasswordMangerButtonClicked:(UIButton *)sender
{
    [self loadRooterInfo];
}//密码管理


-(void)loadRooterInfo
{
//    NSString *rootLoginString = @"http://192.168.0.1";
//    NSURL *url = [NSURL URLWithString:rootLoginString];
//    ASIHTTPRequest *getRootInfo = [[ASIHTTPRequest alloc]initWithURL:url];
//    [getRootInfo setCompletionBlock:^{
//        DLog(@"%@",[getRootInfo responseString]);
        YXM_WiFiManagerViewController *detailViewController = [[YXM_WiFiManagerViewController alloc]init];
        [self.view addSubview:detailViewController.view];
//    }];
//    [getRootInfo setFailedBlock:^{
//        DLog(@"%@",[getRootInfo responseString]);
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查设置-无线局域网,确定已经连接到LED屏的wifi之后再试！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//    }];
//    [getRootInfo startAsynchronous];
}//修改密码页面
-(void)showalertview:(NSString *)messge
{
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提示" message:messge delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [aler show];
    
    

}

@end
