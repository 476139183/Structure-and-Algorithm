//
//  DYT_projectViewController.m
//  LEDAD
//
//  Created by laidiya on 15/9/10.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_projectViewController.h"
#import "DYT_screenTableViewCell.h"
#import "DYT_Transversetableview.h"
#import "DYT_rightbaseview.h"
#import "DYT_leftbaseview.h"
#import "CX_SaveViewController.h"
#import "ChenXuNeedDemos.h"
#import "DYT_Hardwaredetectionview.h"
#import "DYT_uploadMaterial.h"
#import "DYT_SourcematerialUploadview.h"
#import "DYT_colorTestview.h"

#import "DYT_Sliderview.h"

#import "CX_MODEL.h"

#import "DYT_SourcematerialUploadviewcontroller.h"
#import "CX_LEDControlViewController.h"
#import "CX_iPhoneWifiViewController.h"
#import "CX_ProgramViewController.h"
#import "DYT_AstepUploadViewController.h"
@interface DYT_projectViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ftpprogressdelegate,UIAlertViewDelegate>
{
    
    UIView *basetableview;
    DYT_Transversetableview *tableviewTransverse;
    
    
    UIView *Fieldview;
    
    UITextField *Fieldfoot;
    
    UIButton *buttonSearch;
    UIButton *buttonadd;
    
    DYT_leftbaseview *leftbaseview;
    DYT_rightbaseview *rightbaseview;
    
    
    UITableView *gouptableview;
    
    
    UIScrollView *midview;
    
    
    //监听广播
    AsyncUdpSocketReceiveUpgradeTranscationBroadcastIp *_playerBroadcast;
    
    
    
    UIView *addprojectview;
    
}

@end

@implementation DYT_projectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 构建视图
    [self setloadview];
    // 广播
    [self initBrodcast];

    // Do any additional setup after loading the view.
}

-(void)setloadview
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    selectNameArr = [[NSMutableArray alloc]init];
    selectIpArr = [[NSMutableArray alloc]init];
    ipAddressArr = [[NSMutableArray alloc]init];
    ipNameArr = [[NSMutableArray alloc]init];
    _waitForUploadFilesArray = [[NSMutableArray alloc]init];
    
    showscreentableview = NO;
    showtableview = NO;
    //    广播
    
    //    加载头部视图
    [self setheadview];
    
    //    加载横向tableview
    [self settableview];
    
    [self setmidview];
    
    //    加载分组列表
    [self setgouptableview];
    
    //    加载底视图
    [self setfootview];
    
    [self setaddview];
    
    //    加载左右弹框
    [self addleftandrightview];
    
    
    //    [self registerForKeyboardNotifications];
    
    
}
//加载初始化界面
-(void)setheadview
{
    
    //    头部
    headlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    headlabel.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *head = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    head.image = [UIImage imageNamed:@"置顶横条"];
    [self.view addSubview:head];
    
    NSString *string = [[NSString alloc]initWithFormat:@"%@: %d",[Config DPLocalizedString:@"current_screen_number"],0];
    headlabel.text = string;
    headlabel.textAlignment = NSTextAlignmentCenter;
    //    [headbutton setTitle:string forState:UIControlStateNormal];
    
    [self.view addSubview:headlabel];
    
    
    
    
    
    UIButton *leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(10, 2, 35, 35)];
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"素材组图标"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(leftviewshow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftbutton];
    
    UIButton *rigthbutton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-45, 2, 35, 35)];
    [rigthbutton setBackgroundImage:[UIImage imageNamed:@"屏控制图标"] forState:UIControlStateNormal];
    [rigthbutton addTarget:self action:@selector(rightviewshou:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rigthbutton];
    
    
    
    
    //    近期连屏
    UIButton *Buttonlname = [[UIButton alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width/2, 44)];
    //    [Buttonlname setTitle:@"近期连屏" forState:UIControlStateNormal];
    [Buttonlname setBackgroundImage:[UIImage imageNamed:@"单屏素材上传"] forState:UIControlStateNormal];
    [Buttonlname addTarget:self action:@selector(sendproject:) forControlEvents:UIControlEventTouchUpInside];
    Buttonlname.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:Buttonlname];
    
    
    
    
    
    
    //    素材  上传
    UIButton *buttonsetproject = [[UIButton alloc]initWithFrame:CGRectMake(Buttonlname.frame.origin.x+Buttonlname.frame.size.width+1, Buttonlname.frame.origin.y, self.view.frame.size.width/2-1, 44)];
    //    [buttonsetproject setTitle:@"上传" forState:UIControlStateNormal];
    //    多联屏素材上传
    //    jinqilianping
    [buttonsetproject setBackgroundImage:[UIImage imageNamed:@"多联屏素材上传"] forState:UIControlStateNormal];
    [buttonsetproject addTarget:self action:@selector(jinqilianping:) forControlEvents:UIControlEventTouchUpInside];
    buttonsetproject.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:buttonsetproject];
    
    
    
}
//上传  素材上传
-(void)sendproject:(UIButton *)sender
{
    
    
    
    
    
    
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i=0; i<ipAddressArr.count; i++) {
        CX_MODEL *dyt = [[CX_MODEL alloc]init];
        dyt.name = ipNameArr[i];
        dyt.ipname = ipAddressArr[i];
        [arr addObject:dyt];
    }
    
    DYT_AstepUploadViewController *vc = [[DYT_AstepUploadViewController alloc]init];
    vc.mydata = arr;
    [self presentViewController:vc animated:YES completion:^{
        
    }];

    
    
//    [self.mydelegate showAstepUpload:arr];
    
    
    //    DLog(@"====%@",_waitForUploadFilesArray);
    //    if (_waitForUploadFilesArray.count==0) {
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"为点击项目" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [alert show];
    //        return;
    //    }
    //
    //    if (ipAddressString==nil||selectIpArr.count>1) {
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择一个屏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [alert show];
    //        return;
    //    }
    
    
    
    
    //    _alertViewWithProgressbar = [[AGAlertViewWithProgressbar alloc] initWithTitle:nil message:@"请稍等..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    //    [_alertViewWithProgressbar show];
    //
    //    ftpmodel = [[DYT_FTPmodel alloc]init];
    //    ftpmodel.mytag = 11000;
    //     ftpmodel.mydelegate = self;
    //     [ftpmodel ftp:ipAddressString and:_waitForUploadFilesArray];
    //
    
    
}
#pragma mark-ftp上传
//反馈 进度条消失
-(void)returemytag:(NSInteger )tag;
{
    [_alertViewWithProgressbar hide];
    
}


-(void)returegress:(float)flo andtag:(NSInteger)tag andstr:(NSString *)str;
{
    
    
    
}

//加载左侧
-(void)addleftandrightview
{
    
    __block DYT_projectViewController *weakf = self;
    
    leftbaseview = [[DYT_leftbaseview alloc]initWithFrame:CGRectMake(0, 42, self.view.frame.size.width, 140)];
    
    
    leftbaseview.leftblock = ^(NSInteger buttontag)
    {
    
        [weakf retureleftview:buttontag];
        
    };
    
     [self.view addSubview:leftbaseview];
    
    
    rightbaseview = [[DYT_rightbaseview alloc]initWithFrame:CGRectMake(0, 42, leftbaseview.frame.size.width, 140)];
    
    
    rightbaseview.rightblock = ^(NSInteger buttontag)
    {
        
        [weakf returerightview:buttontag];
        
    };
//    rightbaseview.delegate = self;
    
    
   
    
    [self.view addSubview:rightbaseview];
    
    leftbaseview.hidden = YES;
    rightbaseview.hidden = YES;
    
}


-(void)settableview
{
    
    
    
    basetableview = [[UIView alloc]initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 100)];
    //    basetableview.backgroundColor = [UIColor redColor];
    [self.view addSubview:basetableview];
    
    
    
    
    tableviewTransverse = [[DYT_Transversetableview alloc]initWithFrame:CGRectMake(10, 10, 100,basetableview.frame.size.width-60)];
    [basetableview addSubview:tableviewTransverse];
    
    tableviewTransverse.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    tableviewTransverse.center = CGPointMake(self.view.frame.size.width/2-22, 50);
    
    //    刷新
    UIButton *buttonreplay = [[UIButton alloc]initWithFrame:CGRectMake(basetableview.frame.size.width-35, 5, 25, 25)];
    //    buttonreplay.backgroundColor = [UIColor orangeColor];
    [buttonreplay setBackgroundImage:[UIImage imageNamed:@"dyt_refresh"] forState:UIControlStateNormal];
    [buttonreplay addTarget:self action:@selector(replaytableview:) forControlEvents:UIControlEventTouchUpInside];
    [basetableview addSubview:buttonreplay];
    
    
}

//  警告框 代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //  关机
    if (alertView.tag==2002) {
        if (buttonIndex==0) {
            //确定
            
            for (int i=0; i<selectIpArr.count; i++) {
                DLog(@"关机次数");
                
                DYT_AsyModel *masay = [[DYT_AsyModel alloc]init];
//                masay.mydelegate = self;
                
                [masay SafetySignout:selectIpArr[i]];
                
            }

            
        }
    }
    
//        重启云屏
        if (alertView.tag==2003) {
            if (buttonIndex==0) {
    
                for (int i=0; i<selectIpArr.count; i++) {
    
                    DYT_AsyModel *myasy = [[DYT_AsyModel alloc]init];
    
                    [myasy RestartScreen:selectIpArr[i]];
                }
    
            
        }
        }

    //修改终端名称
        if (alertView.tag == 2005) {
            DLog(@"bu==%ld",buttonIndex);
            if (buttonIndex==0) {
                
                    UITextField *mytextfild = [alertView textFieldAtIndex:0];
                if (mytextfild.text.length!=0&&![mytextfild.text isEqualToString:@""]) {
    
                     [self writeFile:@"vlc.txt" Data:mytextfild.text];
    
                    [self ftpuser1];
                }}}

    
    //   重置素材
    if (alertView.tag==2003) {
        if (buttonIndex==0) {
            for (int i=0; i<selectIpArr.count; i++) {
                DYT_AsyModel *myasy = [[DYT_AsyModel alloc]init];
//                myasy.mydelegate = self;
                [myasy ResetScreen:selectIpArr[i]];
            }
        }
        
        
    }

    
    
    
    
    
    
    
    
    if (alertView.tag == 2015) {
        if (buttonIndex == 1) {
            myMasterCtrl = [[CTMasterViewController alloc]init];
            myMasterCtrl.view.backgroundColor = [UIColor cyanColor];
            myMasterCtrl.delegate = self;
            myMasterCtrl.tableView.hidden = YES;
            [self.view addSubview:myMasterCtrl.view];
            [myMasterCtrl setSAssetType:ASSET_TYPE_VIDEO];
            //    [myMasterCtrl setSAssetType:ASSET_TYPE_PHOTO];
            [myMasterCtrl setIAssetMaxSelect:1];
            [myMasterCtrl pickAssets:nil];
            [myMasterCtrl setIslist:NO];
        }else
            if (buttonIndex == 2) {
                myMasterCtrl = [[CTMasterViewController alloc]init];
                myMasterCtrl.view.backgroundColor = [UIColor cyanColor];
                myMasterCtrl.delegate = self;
                myMasterCtrl.tableView.hidden = YES;
                [self.view addSubview:myMasterCtrl.view];
                
                //        [self ftpuser]
                [myMasterCtrl setSAssetType:ASSET_TYPE_PHOTO];
                [myMasterCtrl setIAssetMaxSelect:1];
                [myMasterCtrl pickAssets:nil];
                [myMasterCtrl setIslist:NO];
            }else
                if (buttonIndex == 0) {
                    
                }
    }
}

//手动刷新
-(void)replaytableview:(UIButton *)sender
{
    
    [selectNameArr removeAllObjects];
    [selectIpArr removeAllObjects];
    [ipAddressArr removeAllObjects];
    [ipNameArr removeAllObjects];
    ipAddressString = nil;
    
    
    
    [tableviewTransverse replayname:ipNameArr andip:ipAddressArr];
    
    
}

-(void)setmidview
{
    
    midview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, basetableview.frame.size.height+basetableview.frame.origin.y, self.view.frame.size.width, 800)];
    //    midview.directionalLockEnabled = YES;//定向锁定
    //    midview.backgroundColor = [UIColor redColor];
    midview.scrollEnabled = NO;
    [self.view addSubview:midview];
    //    midview.hidden = YES;
    
}

-(void)setgouptableview
{
    
    
    //项目列表
    _myProjectCtrl = [[MyProjectListViewController alloc]init];
    [_myProjectCtrl.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, 270)];
    _myProjectCtrl.tableView.tag = 9009;
    _myProjectCtrl.delegate = self;
    
    
    [midview addSubview:_myProjectCtrl.view];
    
    
    
    
}




-(void)setfootview
{
    
    DLog(@"======%@",NSStringFromCGRect(self.view.frame));
    
    //    浮动框的载视图
    Fieldview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-110, self.view.frame.size.width, 50)];
    Fieldview.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:Fieldview];
    
    UIView *viewfoot = [[UIView alloc]initWithFrame:CGRectMake(5, 5, Fieldview.frame.size.width-40, 40)];
    viewfoot.backgroundColor = [UIColor whiteColor];
    [Fieldview addSubview:viewfoot];
    //    搜索
    Fieldfoot = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, viewfoot.frame.size.width-40, 40)];
    Fieldfoot.backgroundColor = [UIColor whiteColor];
    Fieldfoot.delegate = self;
    [Fieldview addSubview:Fieldfoot];
    
    
    //    搜索按钮
    buttonSearch = [[UIButton alloc]initWithFrame:CGRectMake(Fieldfoot.frame.size.width+5, 5, 35, 35)];
    [buttonSearch setBackgroundImage:[UIImage imageNamed:@"fdj"] forState:UIControlStateNormal];
    [buttonSearch addTarget:self action:@selector(searchbutton:) forControlEvents:UIControlEventTouchUpInside];
    [Fieldview addSubview:buttonSearch];
    
    //    添加项目按钮
    buttonadd = [[UIButton alloc]initWithFrame:CGRectMake(viewfoot.frame.size.width+5, 5, 35, 35)];
    [buttonadd setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [buttonadd addTarget:self action:@selector(addproject:) forControlEvents:UIControlEventTouchUpInside];
    [Fieldview addSubview:buttonadd];
    
    
}

-(void)setaddview
{
    
    if (addprojectview) {
        [addprojectview removeFromSuperview];
    }
    
    addprojectview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, Fieldview.frame.origin.y-80, 80, 80)];
    buttonaddproject = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    [buttonaddproject setTitle:[Config DPLocalizedString:@"adedit_Item"] forState:UIControlStateNormal];
    [buttonaddproject addTarget:self action:@selector(butttonaddproject:) forControlEvents:UIControlEventTouchUpInside];
    addprojectview.backgroundColor = [UIColor lightGrayColor];
    buttonaddgoup = [[UIButton alloc]initWithFrame:CGRectMake(0, buttonaddproject.frame.size.height+buttonaddproject.frame.origin.y, 80, 40)];
    [buttonaddgoup setTitle:[Config DPLocalizedString:@"adedit_addgroup"] forState:UIControlStateNormal];
    [buttonaddgoup addTarget:self action:@selector(butttonaddproject:) forControlEvents:UIControlEventTouchUpInside];
    [addprojectview addSubview:buttonaddproject];
    [addprojectview addSubview:buttonaddgoup];
    [self.view addSubview:addprojectview];
    addprojectview.hidden = YES;
    
    
    
    
    
}

#pragma mark-单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (tableView==gouptableview) {
        return 10;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (tableView==gouptableview) {
        static NSString *string = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
        }
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
    
    return nil;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView==gouptableview) {
        return 30;
    }
    return 0;
    
}


-(void)jinqilianping:(UIButton *)sender
{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [ud objectForKey:@"Recent"];
    DLog(@"%@",dic);
    DLog(@"%@",[[dic objectForKey:@"numberip"] objectForKey:@"name"]);
    
    
    
    if (!dic) {
        
        [self showalertview:[Config DPLocalizedString:@"adedit_zc16"]];
        return;
    }
    
    NSMutableArray *iparr = [[NSMutableArray alloc]init];
    NSMutableArray *namearr = [[NSMutableArray alloc]init];
    
    for (int i=0; i<[dic[@"play"] count]; i++) {
        [iparr addObject:[[dic[@"play"] objectAtIndex:i] objectForKey:@"dataledip"]];
        [namearr addObject:[[dic[@"play"] objectAtIndex:i] objectForKey:@"dataname"]];
        
    }
    DLog(@"====%@   %@",iparr,namearr);
    if (self.mydelegate&&[self.mydelegate respondsToSelector:@selector(shownearfutureview:andname:)]) {
        [self.mydelegate shownearfutureview:iparr andname:namearr];
    }
    
    
}
#pragma mark-textfile 键盘的高度
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    textField
    //     CGSize kbSize = [[textField objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    //
    
    [UIView  animateWithDuration:0.5 animations:^{
        CGRect rect = Fieldview.frame;
        rect.origin.y -= 220;
        Fieldview.frame = rect;
    }];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    DLog(@"======%@",NSStringFromCGRect(Fieldview.frame));
    if (theTextField == Fieldfoot&&Fieldview.frame.origin.y!=self.view.frame.size.height-110) {
        [Fieldfoot resignFirstResponder];
        [UIView  animateWithDuration:0.5 animations:^{
            CGRect rect = Fieldview.frame;
            rect.origin.y += 220;
            Fieldview.frame = rect;
        }];
    }
    return YES;
}



- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    
    
}

//显示左侧
-(void)leftviewshow:(UIButton *)sender
{
    
    rightbaseview.hidden = YES;
    
    leftbaseview.hidden = !leftbaseview.hidden;
    
    
    if (leftbaseview.hidden==YES) {
        
        
        [self uptableview:leftbaseview];
        
        
    }else
    {
        
        [self downtableview:leftbaseview];
        
        
    }
    
    
    
    
}
//显示右
-(void)rightviewshou:(UIButton *)sender
{
    leftbaseview.hidden = YES;
    rightbaseview.hidden = !rightbaseview.hidden;
    
    if (rightbaseview.hidden==YES) {
        
        
        DLog(@"影城");
        [self uptableview:rightbaseview];
        
        
    }else
    {
        
        for (UIView *view in [midview subviews]) {
            if (view) {
                [view removeFromSuperview];
            }
        }
        
        
        
        //        显示出来
        DLog(@"显示");
        [self downtableview:rightbaseview];
        
        
    }
    
    
    
    
    
}

-(void)searchbutton:(UIButton *)sender
{
    DLog(@"搜索已经编辑好的项目");
    [self clearSelectBox];
    [self textFieldShouldReturn: Fieldfoot];
    NSString *stringname = Fieldfoot.text;
    if ((stringname)&&([stringname length]>0)) {
        [self performSelectorInBackground:@selector(dyt_startSearchActi1) withObject:nil];
        
        [_myProjectCtrl searchProjectListWithProjectName:stringname];
        
        [self dyt_stopSearchActi1];
        
        
    }else
    {
        
        [_myProjectCtrl loadfirstview];
    }
    
    
}
/**
 *  启动项目搜索进度指示
 */
-(void)dyt_startSearchActi1
{
    
    UIActivityIndicatorView *myIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, Fieldfoot.frame.size.width, Fieldfoot.frame.size.height)];
    
    [myIndicatorView setBackgroundColor:[UIColor brownColor]];
    [myIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [myIndicatorView setTag:TAG_SEARCH_INDICATOR_VIEW];
    [Fieldfoot addSubview:myIndicatorView];
    [myIndicatorView startAnimating];
    
    
    
    
}

/**
 *  停止项目搜索进度指示
 */
-(void)dyt_stopSearchActi1{
    [NSThread sleepForTimeInterval:0.3];
    UIActivityIndicatorView *myActiView = (UIActivityIndicatorView *)[self viewWithTag:TAG_SEARCH_INDICATOR_VIEW];
    [myActiView stopAnimating];
    [myActiView removeFromSuperview];
}


//添加项目 或者分组
-(void)addproject:(UIButton *)sender
{
    
    
    
    if (!addprojectview) {
        addprojectview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, Fieldview.frame.origin.y-80, 80, 80)];
        buttonaddproject = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
        [buttonaddproject setTitle:[Config DPLocalizedString:@"adedit_Item"] forState:UIControlStateNormal];
        [buttonaddproject addTarget:self action:@selector(butttonaddproject:) forControlEvents:UIControlEventTouchUpInside];
        addprojectview.backgroundColor = [UIColor lightGrayColor];
        buttonaddgoup = [[UIButton alloc]initWithFrame:CGRectMake(0, buttonaddproject.frame.size.height+buttonaddproject.frame.origin.y, 80, 40)];
        [buttonaddgoup setTitle:[Config DPLocalizedString:@"adedit_addgroup"] forState:UIControlStateNormal];
        [buttonaddgoup addTarget:self action:@selector(butttonaddproject:) forControlEvents:UIControlEventTouchUpInside];
        [addprojectview addSubview:buttonaddproject];
        [addprojectview addSubview:buttonaddgoup];
        [self.view addSubview:addprojectview];
        addprojectview.hidden = YES;
        
    }
    
    addprojectview.hidden = !addprojectview.hidden;
    
    
    
    
    
    
}
-(void)butttonaddproject:(UIButton *)sender
{
    if (sender==buttonaddproject) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[Config DPLocalizedString:@"User_Prompt"]message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:[Config DPLocalizedString:@"adedit_add2"],[Config DPLocalizedString:@"adedit_add1"], nil];
        alertView.tag = 2015;
        [alertView show];
        
    }
    
    if (sender==buttonaddgoup) {
        
        [_myProjectCtrl  addgroup];
    }
    addprojectview.hidden = YES;
    
    
}

//选择了 素材后 跳 界面
-(void)selectPhotoToLayerWithALAsset:(ALAsset *)asset cellIndexPath:(NSIndexPath *)cellIndexPath{
    
    if (self.mydelegate&&[self.mydelegate respondsToSelector:@selector(showpicview:)]) {
        [self.mydelegate showpicview:asset];
    }
    
}
-(void)selfreloadview
{
    DLog(@"添加项目完毕ff");
    
    [_waitForUploadFilesArray removeAllObjects];
    
    [_myProjectCtrl addreloadview];
    
}



//tableview 动画效果
-(void)uptableview:(UIView *)view
{
    [UIView animateWithDuration:0.5 animations:^{
        basetableview.frame = CGRectMake(basetableview.frame.origin.x, 95, basetableview.frame.size.width, basetableview.frame.size.height);
        
        midview.frame = CGRectMake(midview.frame.origin.x, basetableview.frame.size.height+basetableview.frame.origin.y, midview.frame.size.width, midview.frame.size.height);
        
    }];
    //    midview.hidden = YES;
    
    
    
}


// 下来框出来
-(void)downtableview:(UIView *)view
{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        basetableview.frame = CGRectMake(basetableview.frame.origin.x, view.frame.size.height+view.frame.origin.y, basetableview.frame.size.width, basetableview.frame.size.height);
        
        
        midview.frame = CGRectMake(midview.frame.origin.x, basetableview.frame.size.height+basetableview.frame.origin.y, midview.frame.size.width, midview.frame.size.height);
        _myProjectCtrl.view.frame = CGRectMake(0, 0, _myProjectCtrl.view.frame.size.width, 270);
        [midview addSubview:_myProjectCtrl.view];
        
        
        
    }];
    midview.scrollEnabled = NO;
    
    //    midview.hidden = YES;
    
}

//展示minview
-(void)upscreentablew:(UIView *)view
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        //        横向tableview 上移
        basetableview.frame = CGRectMake(basetableview.frame.origin.x, 95, basetableview.frame.size.width, basetableview.frame.size.height);
        
        //      滚动一样上移
        midview.frame = CGRectMake(midview.frame.origin.x, basetableview.frame.size.height+basetableview.frame.origin.y, midview.frame.size.width, midview.frame.size.height);
        
        //        项目组下移动
        _myProjectCtrl.view.frame = CGRectMake(_myProjectCtrl.view.frame.origin.x, 0+200, _myProjectCtrl.view.frame.size.width, _myProjectCtrl.view.frame.size.height);
        
        [midview addSubview:_myProjectCtrl.view];
    }];
    
    midview.hidden = NO;
    midview.scrollEnabled = YES;
    [midview setContentSize:CGSizeMake(self.view.frame.size.width, 1100)];
    
    
    //    CGRect rect = midview.frame;
    //    rect.origin.y = basetableview.frame.size.height+basetableview.frame.origin.y;
    ////    rect.size.height = _myProjectCtrl.view.frame.origin.y-rect.origin.y;
    //    midview.frame = rect;
    
    DLog(@"======%@",NSStringFromCGRect(midview.frame));
    
}


//广播
-(void)initBrodcast
{
    
    
    
    @try {
        
        //                DLog(@"收到");// 端口变了
        _playerBroadcast = [[AsyncUdpSocketReceiveUpgradeTranscationBroadcastIp alloc] initReceivePlayerBroadcastIp:^(NSString *ledPlayerName,NSString *ledPlayerIP){
            if (ledPlayerIP!=nil) {
                
                NSString *ip = [[NSString alloc]initWithFormat:@"%@",[ledPlayerIP stringByReplacingOccurrencesOfString:@"::ffff:" withString:@""]];
                
                //               DLog(@"发送广播===%d=%@",ipAddressArr.count,ip);
                if (![ipAddressArr containsObject:ip])
                {
                    [ipAddressArr addObject:ip];
                    
                    if (ledPlayerName!=nil) {
                        
                        NSString  *_playerNameString = [[NSString alloc]initWithFormat:@"%@",ledPlayerName];
                        [ipNameArr addObject:_playerNameString];
                        
                    }
                    
                    [self reloadtableview];
                    
                }
            }else
            {
                
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

//广播刷新
-(void)reloadtableview
{
    NSString *string = [[NSString alloc]initWithFormat:@"%@: %ld",[Config DPLocalizedString:@"current_screen_number"],(unsigned long)ipAddressArr.count];
    headlabel.text = string;
    
    [tableviewTransverse replayname:ipNameArr andip:ipAddressArr];
    
    
}

#pragma mark-bofang
/**
 *  用户选择项目列表中的某个项目上的选择框时的回调
 *
 *  @param mySelectedProjectList 用户已经选择的项目列表
 */
-(void)selectedProjectWithObject:(NSMutableArray *)mySelectedProjectList{
    //    @try {
    //        if (mySelectedProjectArray==nil) {
    //            mySelectedProjectArray = [[NSMutableArray alloc]initWithArray:mySelectedProjectList];
    //        }else{
    //            [mySelectedProjectArray removeAllObjects];
    //            [mySelectedProjectArray setArray:mySelectedProjectList];
    //        }
    //
    //        DLog(@"mySelectedProjectList.count = %d",[mySelectedProjectList count]);
    //        UIButton *myButton = (UIButton*)[self.view viewWithTag:TAG_PUBLISH_PROJ_BUTTON];
    //        if (myButton==nil) {
    //            myButton = (UIButton*)[self.view viewWithTag:TAG_CREATE_GROUP_BUTTON];
    //        }
    //        if ([mySelectedProjectList count] > 0) {
    //            DLog(@"连续播放");
    //            myButton.titleLabel.text = [Config DPLocalizedString:@"adedit_continuous_play"];
    //            [myButton setTag:TAG_CREATE_GROUP_BUTTON];
    //            isContinusPlay = YES;
    //        }else{
    //            //
    //            DLog(@"发布项目");
    //            myButton.titleLabel.text = [Config DPLocalizedString:@"adedit_PublishProj"];
    //            [myButton setTag:TAG_PUBLISH_PROJ_BUTTON];
    //            isContinusPlay = NO;
    //        }
    //
    //    }
    //    @catch (NSException *exception) {
    //        DLog(@"%@",exception);
    //    }
    //    @finally {
    //
    //    }
}
/**
 *  项目列表点击的回调，开始模拟播放已经编辑好的项目  点击项目
 *
 *  @param asset 输入播放对象
 *  @param cellIndexPath 以及项目的索引
 */
-(void)playOneWithProjectObj:(ProjectListObject *)asset cellIndexPath:(NSIndexPath *)cellIndexPath{
    
    if (isPlay) {
        
        [_waitForUploadFilesArray removeAllObjects];
        
        
    }
    
    
    
    currentPlayProObject = asset;
    
    DLog(@"播放的项目名称 = %@",asset.project_name);
    
    _currentPlayProjectFilename = asset.project_filename;
    
    DLog(@"播放的项目配置文件路径 = %@",asset.project_filename);
    [_waitForUploadFilesArray addObject:asset.project_filename];
    _currentPlayProjectName = asset.project_name;
    /**
     *  当前播放的项目索引
     */
    _currentPlayProjIndex = cellIndexPath;
    @try {
        
        
        //获得项目的根目录
        NSString *projectFileLastString =  [_currentPlayProjectFilename lastPathComponent];
        _currentProjectPathRoot = [[NSString alloc]initWithFormat:@"%@",[_currentPlayProjectFilename stringByReplacingOccurrencesOfString:projectFileLastString withString:@""]];
        DLog(@"失败的路径＝＝＝%@",_currentProjectPathRoot);
        
        //缓存文件夹的路径
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithXMLFile:asset.project_filename]];
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithDictionary:dataDictionary];
        [tempDictionary removeObjectForKey:@"projectName"];
        
        
        //设置屏端宽高
        //        NSDictionary *masterScreenDict = [tempDictionary objectForKey:@"masterScreenFrame"];
        //        [self applyMasterScreenDictionaryWithDict:masterScreenDict];
        //删除屏端宽高
        [tempDictionary removeObjectForKey:@"masterScreenFrame"];
        
        //播放音频
        NSDictionary *musicDict = [tempDictionary objectForKey:@"projectMusicElement"];
        if (musicDict) {
            if ([musicDict isKindOfClass:[NSDictionary class]]) {
                NSString *musicNameString = [musicDict objectForKey:@"musicName"];
                _musicFilePath = [[NSString alloc]initWithFormat:@"%@%@",_currentProjectPathRoot,musicNameString];
                [_waitForUploadFilesArray addObject:_musicFilePath];
                //                [myMusicPicker playMusicWithPath:_musicFilePath];
                _musicVolume = [musicDict objectForKey:@"musicVolume"];
                DLog(@"vString floatValue = %lf",[_musicVolume floatValue]);
                //                [myMusicPicker.myMusicPlayer setVolume:([_musicVolume floatValue]/100)];
                [tempDictionary removeObjectForKey:@"projectMusicElement"];
            }
        }
        
        //文本
        //        NSDictionary *textItemDict = [[NSDictionary alloc]initWithDictionary:[tempDictionary objectForKey:@"text"]];
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
        
        //        if (self.mydelegate) {
        [self.mydelegate showmovview:_waitForUploadFilesArray];
        //        }
        
        //        [self presentViewController:cx animated:YES completion:nil];
        isPlay = YES;
        
    }
    @catch (NSException *exception) {
        DLog(@"exception = %@",exception);
    }
    @finally {
        
    }
    
}
/**
 *@brief 解析素材数据字典为素材对象字典
 */
-(NSDictionary*)analysisDataToMaterialObjectWith:(NSDictionary *)oneListItemDict{
    
    NSString *materialFilePath = [[NSString alloc]initWithFormat:@"%@/%@",[_currentProjectPathRoot lastPathComponent],[oneListItemDict objectForKey:@"filename"]];
    DLog(@"地址＝＝＝%@",materialFilePath);
    
    
    
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
    
    NSDictionary *assetDict = [[NSDictionary alloc]initWithObjectsAndKeys:[oneListItemDict objectForKey:@"duration"],@"duration",myMaterial,@"asset",nil];
    return assetDict;
}


//左侧 代理
-(void)retureleftview:(NSInteger)mytag
{
    
    if (mytag==1000) {
        // 上传素材
        
        DYT_SourcematerialUploadviewcontroller *dyt_sourupvc = [[DYT_SourcematerialUploadviewcontroller alloc]init];
        
        dyt_sourupvc.myiparray = selectIpArr;
        dyt_sourupvc.myipnamearray = selectNameArr;
        
        [self presentViewController:dyt_sourupvc animated:YES completion:^{
            
        }];
        return;
    }
    
    
    leftbaseview.hidden = YES;
    [self upscreentablew:leftbaseview];
    

    if (mytag==1001) {
        //调节亮度
        
        
                DLog(@"调节亮度");
                DYT_Sliderview *vc = [[DYT_Sliderview alloc]initWithFrame:CGRectMake(0, 0, midview.frame.size.width, 200)];
        
                vc.canlerblock = ^(void)
                {
                    [vc removeFromSuperview];
                    [self uptableview:rightbaseview];
        
                };
        
        
                [midview addSubview:vc];
                
                
                return;
        

        
    }
    if (mytag==1002) {
        //关机
        
        
//                if (selectIpArr.count ==0) {
//                    UIAlertView *aletview= [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_shoose"] delegate:nil cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles: nil];
//                    [aletview show];
//                    return;
//                }
//        
//                //关机
//                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_guanji"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptno"], nil];
//        
//                [myAlertView setTag:2002];
//                myAlertView.delegate = self;
//                [myAlertView show];

        
        
        
    }
    if (mytag==1003) {
        //重启
        
        
//        
//                //重启动
//                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_chongqi"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptno"], nil];
//                [myAlertView setTag:2003];
//                myAlertView.delegate = self;
//                [myAlertView show];
        

        
    }
    if (mytag==1004) {
        //重置
//                //重zhi
//                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_resetscreenbutton"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptno"], nil];
//                [myAlertView setTag:2004];
//                myAlertView.delegate = self;
//                [myAlertView show];

        
        
    }
    if (mytag==1005) {
//        //修改终端名称
//                UIAlertView *myalert = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_ledname"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles:[Config DPLocalizedString:@"NSStringNO"], nil];
//                myalert.tag = 2005;
//                myalert.alertViewStyle = UIAlertViewStylePlainTextInput;
//        
//                [myalert show];
//                return;
//
        
    }
    
//    if (mytag==1005) {
//        [_mydelegate showProgram];
//        return;
//    }
//    //多连屏控制
//    if (mytag == 1000) {
//        
//        [self.mydelegate showLED];
//        
//        return;
//    }
//    
//    
//    //    设置选屏的
//    if (selectIpArr.count==0) {
//        [self showalertview:[Config DPLocalizedString:@"adedit_shoose"]];
//        return;
//    }
//    
//    //    素材上传
//    if (mytag == 1004) {
//        
//        
//        if (_mydelegate&&[_mydelegate respondsToSelector:@selector(showuploadprojectview)]) {
//            [_mydelegate showuploadprojectview];
//        }
//        
//        
//        return;
//    }
//    
//    
//    
//    
//    
//    DLog(@"===%d",mytag);
//    
//    
//    
//    //    关机云屏
//    if (mytag==1001) {
//        
//        return;
//    }
//    
//    
//    //    重置素材  重置 云屏
//    if (mytag==1003) {
//        
//        
//        return;
//    }
//    
//    
//    //    需要加载view 时  先清空
//    for (UIView *view in [midview subviews]) {
//        if (view) {
//            [view removeFromSuperview];
//        }
//    }
//    
//    leftbaseview.hidden = YES;
//    [self upscreentablew:leftbaseview];
//    
//    
//    //    调节亮度
//    if (mytag==1002) {
//        
//        DLog(@"ffff");
//        DYT_Sliderview *vc = [[DYT_Sliderview alloc]initWithFrame:CGRectMake(0, 0, midview.frame.size.width, 200)];
//        
//        vc.canlerblock = ^(void)
//        {
//            [vc removeFromSuperview];
//            [self uptableview:rightbaseview];
//            
//        };
//        
//        
//        [midview addSubview:vc];
//        
//        
//        return;
//    }
//    
//    
//    
//    
//    if (mytag==1005) {
//        return;
//    }
//    
//    
//    
    
}
//右侧 代理
-(void)returerightview:(NSInteger)mytag
{
    
    
    if (mytag==2000) {
        //多联屏控制
        
        CX_LEDControlViewController *cxled = [[CX_LEDControlViewController alloc]init];
        [self presentViewController:cxled animated:YES completion:nil];

        
    }
    if (mytag==2001) {
        // 激活云屏
        
        CX_iPhoneWifiViewController *cxwifi = [[CX_iPhoneWifiViewController alloc]init];
        [self presentViewController:cxwifi animated:YES completion:nil];
        
    }
    if (mytag==2002) {
        //查看云屏方案
        
        CX_ProgramViewController *cxpro = [[CX_ProgramViewController alloc]init];
        [self presentViewController:cxpro animated:YES completion:nil];
        
    }
    
    if (mytag==2003) {
        // 设置背景图片
        
        
                myMasterCtrl = [[CTMasterViewController alloc]init];
                myMasterCtrl.view.backgroundColor = [UIColor cyanColor];
                myMasterCtrl.delegate = self;
                myMasterCtrl.tableView.hidden = YES;
                [self.view addSubview:myMasterCtrl.view];
        
                //        [self ftpuser]
                [myMasterCtrl setSAssetType:ASSET_TYPE_PHOTO];
                [myMasterCtrl setIAssetMaxSelect:1];
                [myMasterCtrl pickAssets:nil];
                [myMasterCtrl setIslist:NO];
                
                
                return;

        
        
        
    }
    
    rightbaseview.hidden = YES;
        midview.hidden = YES;
    //
    [self upscreentablew:rightbaseview];

    
    if (mytag==2004) {
//         调节红绿蓝白
        
                DYT_colorTestview *view = [[DYT_colorTestview alloc]initWithFrame:CGRectMake(0, 0, midview.frame.size.width, 200)];
                view.canlerblock = ^(void)
                {
                    [view removeFromSuperview];
                    [self uptableview:rightbaseview];
        
                };
                [midview addSubview:view];
                
                return;

    }
    if (mytag==2005) {
        // 设置
    }
    
    
    
//    if (mytag==2003) {
//        
//        [self.mydelegate showwifl];
//        return;
//    }
//    if (mytag==2000) {
//        
//        [self.mydelegate showsj];
//        return;
//        
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    //    修改云屏背景
//    if (mytag==2001) {
//        
//        
//        
//        myMasterCtrl = [[CTMasterViewController alloc]init];
//        myMasterCtrl.view.backgroundColor = [UIColor cyanColor];
//        myMasterCtrl.delegate = self;
//        myMasterCtrl.tableView.hidden = YES;
//        [self.view addSubview:myMasterCtrl.view];
//        
//        //        [self ftpuser]
//        [myMasterCtrl setSAssetType:ASSET_TYPE_PHOTO];
//        [myMasterCtrl setIAssetMaxSelect:1];
//        [myMasterCtrl pickAssets:nil];
//        [myMasterCtrl setIslist:NO];
//        
//        
//        return;
//    }
//    
//    
//    for (UIView *view in [midview subviews]) {
//        if (view) {
//            [view removeFromSuperview];
//        }
//    }
//    
//    rightbaseview.hidden = YES;
//    //    midview.hidden = YES;
//    
//    [self upscreentablew:rightbaseview];
//    
//    //    硬件检测
//    
//    
//    if (mytag==2002) {
//        
//        
//        
//        
//    }
//    if (mytag==2004) {
//        
//    }
//    
//    //    测试红绿蓝
//    if (mytag==2005) {
//        
//        DYT_colorTestview *view = [[DYT_colorTestview alloc]initWithFrame:CGRectMake(0, 0, midview.frame.size.width, 200)];
//        view.canlerblock = ^(void)
//        {
//            [view removeFromSuperview];
//            [self uptableview:rightbaseview];
//            
//        };
//        [midview addSubview:view];
//        
//        return;
//    }
//    
    
    
}







/**
 *  清除所有的复选框
 */
-(void)clearSelectBox{
    [_myProjectCtrl useGroupInfoReloadProjectList];
    [self selectedProjectWithObject:nil];
}

-(void)loadingmidview:(UIView *)midview
{
    
    
    
    
    
}


-(void)showalertview:(NSString *)messge
{
    UIAlertView *alerview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:messge delegate:nil cancelButtonTitle:[Config DPLocalizedString: @"NSStringYes"] otherButtonTitles: nil];
    [alerview show];
    
    
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
    DLog(@"修改终端%@",files);

}

-(void)ftpuser1{
    isgaiming = YES;

    //    if (!_ftpMgr) {
    //连接ftp服务器
    _ftpMgr = [[YXM_FTPManager alloc]init];
    _ftpMgr.delegate = self;
    //    }
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* sZipPath =[NSString stringWithFormat:@"%@/vlc.txt",DocumentsPath];
    NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@:21/config",ipAddressString];
    [_ftpMgr startUploadFileWithAccount:@"ftpuser" andPassword:@"ftpuser" andUrl:sUploadUrl andFilePath:sZipPath];
    NSFileManager * fm = [NSFileManager defaultManager];
    NSDictionary * dict = [fm attributesOfItemAtPath:sZipPath error:nil];
    //方法一:
    NSLog(@"size = %lld",[dict fileSize]);

}

// *  ftp上传文件的反馈结果
// *
// *  @param sInfo 反馈结果字符串
// */
-(void)uploadResultInfo:(NSString *)sInfo{
    DLog(@"sInfo = %@",sInfo);

    if ([sInfo isEqualToString:@"uploadComplete"]) {
                if (isgaiming) {
                    DYT_AsyModel *myasy = [[DYT_AsyModel alloc]init];

                    [myasy changeTerminalname];
            return;
            //            [self commandCompleteWithType:0x19 andContent:nil andContentLength:0];
        }


            }else{
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
