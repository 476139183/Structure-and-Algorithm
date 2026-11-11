//
//  DYT_ScreenupgradeViewController.m
//  LEDAD
//
//  Created by laidiya on 15/7/22.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_ScreenupgradeViewController.h"
#import "DYT_Hardwaredetectionview.h"

//程序版本号的最大值
#define PROGRAM_VERSION_NO_MAX 100000000
static NSString *myCollectionViewCellIdentifier = @"myCollectionCell";

@implementation DYT_ScreenupgradeViewController
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setbaseview];
    }
    return self;

}

-(void)setbaseview
{

    self.backgroundColor = [UIColor whiteColor];
    
    AddressArr = [[NSMutableArray alloc]init];
    NameArr = [[NSMutableArray alloc]init];
    myselect = [[NSMutableArray alloc]init];
    
    mymodel = [[DYT_AsyModel alloc]init];
    
    mymodel.mydelegate = self;
    
    [self setcollview];
    
    [self setbutton];
    
    [self initBrodcast];
    
    myURLArray = [[NSMutableArray alloc]initWithObjects:@"libv8.so", @"ledcontrollerforlinux704.jar",nil];
    myURLArrayV3 = [[NSMutableArray alloc]initWithObjects:@"led_net.zip",nil];

    
    



}

-(void)setbutton
{
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [back setBackgroundImage: [UIImage imageNamed:@"dyt_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(upgback:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:back];

    
    UIButton *reflsh = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-35, 5, 30, 30)];
    [reflsh setBackgroundImage: [UIImage imageNamed:@"dyt_refresh"] forState:UIControlStateNormal];
    [reflsh addTarget:self action:@selector(reflsh:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reflsh];
    
    
    
    BFPaperButton *upbut ;
    BFPaperButton *shengji ;
    BFPaperButton *chongzhi ;
    BFPaperButton *jiance ;


    if (DEVICE_IS_IPAD) {
        upbut = [[BFPaperButton alloc]initWithFrame:CGRectMake(10, mycollectCV.frame.size.height+mycollectCV.frame.origin.y+10, 100, 44)];
        shengji = [[BFPaperButton alloc]initWithFrame:CGRectMake(upbut.frame.origin.x + upbut.frame.size.width + 10, upbut.frame.origin.y, 100, 40)];
        chongzhi = [[BFPaperButton alloc]initWithFrame:CGRectMake(shengji.frame.origin.x + shengji.frame.size.width +10, shengji.frame.origin.y, 100, 40)];
        jiance = [[BFPaperButton alloc]initWithFrame:CGRectMake(chongzhi.frame.origin.x+chongzhi.frame.size.width + 10, chongzhi.frame.origin.y, 100, 40)];
    }else{
        upbut = [[BFPaperButton alloc]initWithFrame:CGRectMake(10, mycollectCV.frame.size.height+mycollectCV.frame.origin.y+10, 70, 40)];
        shengji = [[BFPaperButton alloc]initWithFrame:CGRectMake(90, upbut.frame.origin.y, 70, 40)];
        chongzhi = [[BFPaperButton alloc]initWithFrame:CGRectMake(shengji.frame.origin.x+80, shengji.frame.origin.y, 70, 40)];
        jiance = [[BFPaperButton alloc]initWithFrame:CGRectMake(chongzhi.frame.origin.x+80, chongzhi.frame.origin.y, 70, 40)];
        upbut.titleLabel.font = [UIFont systemFontOfSize:10];
        shengji.titleLabel.font = [UIFont systemFontOfSize:10];
        chongzhi.titleLabel.font = [UIFont systemFontOfSize:10];
        jiance.titleLabel.font = [UIFont systemFontOfSize:10];
    }

    [upbut setTitle:[Config DPLocalizedString:@"adedit_yjxz"]  forState:UIControlStateNormal];

    [upbut addTarget:self action:@selector(dytloadview:) forControlEvents:UIControlEventTouchUpInside];
    
    //        upbut.backgroundColor = [UIColor redColor];
    [self addSubview:upbut];
    
    
    

    [shengji setTitle:[Config DPLocalizedString:@"adedit_yjsj"]  forState:UIControlStateNormal];

    [shengji addTarget:self action:@selector(yunshenji:) forControlEvents:UIControlEventTouchUpInside];
    
    //        shengji.backgroundColor = [UIColor redColor];
    [self addSubview:shengji];
    
    

    
    
    [chongzhi setTitle:[Config DPLocalizedString:@"adedit_ypcz"]  forState:UIControlStateNormal];

    [chongzhi addTarget:self action:@selector(upchongzhiyunping:) forControlEvents:UIControlEventTouchUpInside];
    
    //    chongzhi.backgroundColor = [UIColor redColor];
    [self addSubview:chongzhi];

    [jiance setTitle:[Config DPLocalizedString:@"adedit_Hardware"]  forState:UIControlStateNormal];

    [jiance addTarget:self action:@selector(jiancebtn:) forControlEvents:UIControlEventTouchUpInside];

    //    chongzhi.backgroundColor = [UIColor redColor];
    [self addSubview:jiance];

    
    
}

-(void)jiancebtn:(UIButton*)sender{
    if (myselect.count == 0) {
        [self showone];
        return;
    }
    DYT_Hardwaredetectionview *cxjc = [[DYT_Hardwaredetectionview alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andname:nil];
    [self addSubview:cxjc];
}

-(void)setcollview
{
    NSInteger mywid;
    if (DEVICE_IS_IPAD) {
       mywid = (self.frame.size.width-30)/6;
    }else{
       mywid = (self.frame.size.width-30)/3;
    }

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //每个格子的大小
    layout.itemSize = CGSizeMake(mywid, mywid+20);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    mycollectCV = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 60, self.frame.size.width  - 30, self.frame.size.height-160) collectionViewLayout:layout];
    //    mycollectCV.backgroundColor = [UIColor whiteColor];
    
    [mycollectCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:myCollectionViewCellIdentifier];
    mycollectCV.delegate = self;
    mycollectCV.dataSource = self;
    mycollectCV.backgroundColor = [UIColor whiteColor];
    [self addSubview:mycollectCV];
    
    
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [AddressArr count];
    //       return 15;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:myCollectionViewCellIdentifier forIndexPath:indexPath];
    [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除子视图防止重叠
    
    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 20)];
    
    NSString *strip = AddressArr[indexPath.row];
     namelabel.text = @"";
    
    for (int i=0; i<ipNameArr.count; i++) {
        if ([strip isEqualToString:ipAddressArr[i]])
        {
            namelabel.text = ipNameArr[i];
        }
    }
    
    
    
    
    //    //    创建一个imageview
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, cell.frame.size.width-20, cell.frame.size.height-40)];
    [button setBackgroundImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"LEDYES"] forState:UIControlStateSelected];
    //    button.myname.text = ipNameArr[indexPath.row];
    button.tag = 5000+indexPath.row;
    [button addTarget:self action:@selector(upmysele:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    　接收ip
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-20, cell.frame.size.width, 20)];
    
    label.text = strip;
    
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    
   
    [cell.contentView addSubview:namelabel];
    [cell.contentView addSubview:button];
    [cell.contentView addSubview:label];
    return cell;
    
    
}
-(void)upmysele:(UIButton *)sender
{
    [myselect removeAllObjects];
    sender.selected = !sender.selected;
    jianceip = AddressArr[sender.tag - 5000];
    for (UICollectionViewCell  *one in [mycollectCV subviews]) {
        NSLog(@"=====%@",NSStringFromClass([one class]));
        
        if ([one isKindOfClass:[UICollectionViewCell class]]) {
            
            for (UIButton *two in [one.contentView subviews]) {
                if ([two isKindOfClass:[UIButton class]]&&two.selected == YES) {
                    [myselect addObject: AddressArr[two.tag-5000]];
                }
                
                
            }
        }
        
    }
    
    
//    myselect = nil;
//    
//    
//    for (int i=0; i<AddressArr.count; i++) {
//        
//        UIButton *button = (UIButton *)[self viewWithTag:AddressArr.count+5000];
//        
//        NSLog(@"fasfa=====%ld",(long)button.tag);
//        button.selected = NO;
//    }
//    
//    sender.selected = !sender.selected;
//    
//    
//    
//    if (sender.selected==YES) {
//        
//        //        [ selectIpArr addObject:ipAddressArr[sender.tag-5000]];
//        //        [selectNameArr addObject:ipNameArr[sender.tag-5000]];
//        myselect = AddressArr[sender.tag-5000];
//    }
    
}




-(void)initBrodcast{
    
    @try {
        //      __block UpgradeViewController *weekSelf = self;
        _playerBroadcast = [[AsyncUdpSocketReceivePlayerBroadcastIp alloc] initReceivePlayerBroadcastIp:^(NSString *ledPlayerName,NSString *ledPlayerIP){
            
                DLog(@"=====%@  和 %@",ledPlayerName, ledPlayerIP);
            
            if (ledPlayerIP != nil) {
                
                NSString *myipstr = [[NSString alloc]initWithFormat:@"%@",[ledPlayerIP stringByReplacingOccurrencesOfString:@"::ffff:" withString:@""]];
                
                if (![AddressArr containsObject:myipstr]) {
                    
                    [AddressArr addObject:myipstr];
                    if (ledPlayerName!=nil) {
                        
                        NSString  *_playerNameString = [[NSString alloc]initWithFormat:@"%@",ledPlayerName];
                        [NameArr addObject:_playerNameString];
                        
                    }
                    
                    [mycollectCV reloadData];
                    
                    
                    
                }
                
//                NSString *ssssssss = [[NSString alloc]initWithFormat:@"%@",[ledPlayerIP stringByReplacingOccurrencesOfString:@"::ffff:" withString:@""]];
                
                
            }
            else{
                
            }
            
        }];
        
        
    }
    
    @catch (NSException *exception) {
        DLog(@"升级时广播异常 = %@",exception);
    }
    @finally {
        
    }
    
    
}


-(void)upchongzhiyunping:(BFPaperButton *)sender
{
    
    
    if (myselect.count==0) {
        [self showone];
        return;
    }
    
    //    [mymodel startSocket];
    
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_resetScreenMachine"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptno"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptyes"], nil];
    [myAlertView setTag:1002888];
    myAlertView.delegate = self;
    [myAlertView show];
    
    
}



-(void)dytloadview:(BFPaperButton *)sender
{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_checkupdatepakcage"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptno"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptyes"], nil];
    [myAlertView setTag:1002889];
    myAlertView.delegate = self;
    [myAlertView show];
    
    //    [myUpgradeButton setEnabled:NO];
    //    [myUpgradeButton1 setEnabled:NO];
    
    
//    _alertViewWithProgressbar = [[AGAlertViewWithProgressbar alloc] initWithTitle:nil message:@"请稍等..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    [_alertViewWithProgressbar show];
//    UIAlertView


    
    
    
    //    [myUpgradeButton1 setEnabled:NO];
    
    
    
}

/**
 *  检查升级版本号
 */
-(void)checkUpgradeVersionTxt{
    
    _currentDataAreaIndex = 0;
    
    
    NSString *myURLString = @"http://www.ledmediasz.com/z_andro_brank/v_xcloudmanagerupgrade.txt";
    NSURL *myUrl = [NSURL URLWithString:myURLString];
    ASIHTTPRequest *myRqeust = [[ASIHTTPRequest alloc]initWithURL:myUrl];
    firstview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    firstview.alpha = 0.8;
    firstview.backgroundColor = [UIColor whiteColor];
    progressview = [[UIProgressView alloc]initWithFrame:CGRectMake(10, 100, self.frame.size.width-100, 100)];
    [firstview addSubview:progressview];
    [self addSubview:firstview];
    
    [myRqeust setDownloadProgressDelegate:progressview];
    
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
                            //                            成功升级中
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
            
            //            [myUpgradeButton setEnabled:YES];
            //            [myUpgradeButton1 setEnabled:YES];
            
            [myTimer setFireDate:[NSDate distantFuture]];
            
            [progressview removeFromSuperview];
            [firstview removeFromSuperview];
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_internetconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myTimer setFireDate:[NSDate distantFuture]];
        }
    }];
    
    [myRqeust setFailedBlock:^{
//        [_alertViewWithProgressbar hide];
        //        [myUpgradeButton setEnabled:YES];
        //        [myUpgradeButton1 setEnabled:YES];
        [myTimer setFireDate:[NSDate distantFuture]];
        
        
        UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alet show];
        DLog(@"检查升级版本号失败");
        
        [progressview removeFromSuperview];
        [firstview removeFromSuperview];
        
        
        
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
        //        [myUpgradeButton setEnabled:YES];
        //        [myUpgradeButton1 setEnabled:YES];
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
    
    //    [networkQueue setDownloadProgressDelegate:_downloadProgress];
    
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
                //                [myUpgradeButton setEnabled:YES];
                //                [myUpgradeButton1 setEnabled:YES];
                isDownloadingError = YES;
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
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
                //                [myUpgradeButton setEnabled:YES];
                //                [myUpgradeButton1 setEnabled:YES];
                isDownloadingError = YES;
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
                [myTimer setFireDate:[NSDate distantFuture]];
            }];
            [networkQueue addOperation:request];
            
        }
    }
    
    filemanager=nil;
    [networkQueue go];
    
    
}



//http
-(void)myFetchFailed:(ASIHTTPRequest*)myRquest{
    
    DLog(@"下载出错 = %@",myRquest);
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_downloadupgradefileerror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    
     [progressview removeFromSuperview];
    [firstview removeFromSuperview];
}




-(void)myFetchComplete:(ASIHTTPRequest*)myRquest{
    [progressview removeFromSuperview];
    [firstview removeFromSuperview];
    if (isDownloadingError) {
        //网络连接出现错误
        DLog(@"网络连接出现错误");
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
    }else{
        
        DLog(@"下载完成 = %@",myRquest);
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_downloadupgradefilefinish"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        
        [myAlertView show];
        
        
        
        
        
    }
    
   
}









#pragma mark-FTP

#pragma mark-硬件升级

-(void)yunshenji:(BFPaperButton *)sender
{
    
    
    NSLog(@"升级");
    if (myselect.count == 0) {
        
        
        
        [self showone];
        return;
    }
    
//    _alertViewWithProgressbar = [[AGAlertViewWithProgressbar alloc] initWithTitle:nil message:@"请稍等..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    
//    [_alertViewWithProgressbar show];
//
    
    
    
    
    //使用ftp传输文件
    numberl = myselect.count;
    for (int i=0; i<myselect.count; i++) {
        
        
        DYT_FTPmodel *mode = [[DYT_FTPmodel alloc]init];
        mode.mydelegate = self;
        mode.mytag = i+10000;
        
        [mode yunftp:myselect[i]];
        
        
    }
//    
//    _currentDataAreaIndex = 0;
//    [self useFTPSendFile];
    
    
    
    
    
    
    
    
}
//完成
-(void)returemytag:(NSInteger )tag;
{
    
    numberl--;
    
    if (numberl==0) {
        
       
        [_alertViewWithProgressbar hide];

        [self showUploadUpgradeFileSuccess];
        
        [self reflsh:nil];
        
         DLog(@"发送硬件升级数据成功");
        
    }
    
   
    

}
-(void)returegress:(float)flo andtag:(NSInteger)tag andstr:(NSString *)str;
{
    DLog(@"fanku");
 
    
}

/**
 *  使用ftp来发送文件
 */
-(void)useFTPSendFile{
    
    
    
    
        //连接ftp服务器
        _ftpMgr = [[YXM_FTPManager alloc]init];
        _ftpMgr.delegate = self;
       tago = 100;
        
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
            DLog(@"段雨田确定进入－－－－－－");
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
    
    
    
    NSString *zipPath = nil;
    if ([_myFileListArray count]>_currentDataAreaIndex) {
        zipPath = [_myFileListArray objectAtIndex:_currentDataAreaIndex];
        NSLog(@"zipPath = %@",zipPath);
        
        //        上传地址
        NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@/version",ipAddressString];
        
        DLog(@"上传地址%@",sUploadUrl);
        [_ftpMgr startUploadFileWithAccount:@"ftpuser" andPassword:@"ftpuser" andUrl:sUploadUrl andFilePath:zipPath];
        _currentDataAreaIndex ++;
        
    }
    
    
}

-(void)uploadWriteData:(NSInteger)writeDataLength{
    _sendFileCountSize += writeDataLength;
    float progressValue = _sendFileCountSize*1.0f / _uploadFileTotalSize*1.0f;
    DLog(@"progressValue = %lf",progressValue);
    //    [_upgradeProgress setProgress:progressValue];
    //    promptLabel.text = [NSString stringWithFormat:@"%0.0lf％",progressValue*100];
}



-(void)uploadResultInfo:(NSString *)sInfo
{
    if (tago==100) {
        
        DLog(@"返回的参数sInfo = %@",sInfo);
        if ([sInfo isEqualToString:@"uploadComplete"]) {
            if ([_myFileListArray count]>_currentDataAreaIndex) {
                
                [self useFTPSendFile];
                
            }else{
                
                DLog(@"发送完成");
                //发送完成
                [self upgradeSuccess];
                unftp = NO;
                //升级文件发送完成
                
                
//                
                [mymodel startSocket:ipAddressString];
//                
                
                [mymodel commandCompleteWithType:0x1D andSendType:0x04 andContent:nil andContentLength:100000000 andPageNumber:100000000];
                
                
                [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(feedbackTimeout:) userInfo:nil repeats:NO];
            }
        }else{
            
            [self upgradeFaild];
//            [self upgradeFaild];
            
        }
        
        
        
    }
    
    
}





//升级包发送成功 但未收到反馈
-(void)feedbackTimeout:(NSTimer *)myTimer{
    
    
    if (unftp==YES) {
        return;
    }
    
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_upgradetimeout"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
}



-(void)upgradeSuccess{
    _sendFileCountSize = 0;
    _currentDataAreaIndex = 0;
}
//上传失败
-(void)upgradeFaild{
    [self upgradeSuccess];
    [self showUploadUpgradeFileError];
}



-(void)showUploadUpgradeFileError{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_upgradeerror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
}



-(void)returemydata:(NSData *)mydata
{
    
    Byte *AckByte = (Byte *)[mydata bytes];
    
    DLog(@"发送命令的反馈");
    DLog(@"ack[0]=%x",AckByte[0]);
    DLog(@"ack[1]=%x",AckByte[1]);
    DLog(@"ack[2]=%x",AckByte[2]);
    DLog(@"ack[3]=%x",AckByte[3]);
    DLog(@"ack[4]=%x",AckByte[4]);
    DLog(@"ack[5]=%x",AckByte[5]);
    
    if (AckByte[1] == 0x1D) {
        DLog(@"发送硬件升级数据成功");
        unftp = YES;
        [self showUploadUpgradeFileSuccess];
        [self reflsh:nil];
        
    }
    
    
    if (AckByte[1] == 0xD1) {
        numberl++;
        if (numberl == myselect.count) {
            
            show = YES;
            
            
        }
        DLog(@"发送重置命令成功==%d",show);
        
        if (AckByte[3]==0x06) {
            
            [self showRestScreenSuccess];
            //            [self contreloaddata];
        }else{
            [self showRestScreenfailed];
        }
    }
    
    //    [_sendPlayerSocket readDataWithTimeout: -1 tag: tag];
    
    
    
}

-(void)upgback:(UIButton *)sender
{
    
    self.hidden = YES;
    
    
}
-(void)reflsh:(id)sender
{
    DLog(@"刷新   ");
    
    
    [AddressArr removeAllObjects];
    
    [NameArr removeAllObjects];
    
    ipAddressString = nil;
    
    [myselect removeAllObjects];
    
    for (UICollectionViewCell *cell in [mycollectCV subviews]) {
        if ([cell isKindOfClass:[UICollectionViewCell class]]) {
            [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除子视图防止重叠
            
        }
    }
    
    
    [mycollectCV reloadData];
    
    
    
    
    
    
    
    
    
}

//升级成功
-(void)showUploadUpgradeFileSuccess{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_upgradefinish"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    
}

-(void)showone
{
    
    UIAlertView *mynextalertview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_NoipError"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles: nil];
    [mynextalertview show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1002889) {
        if (buttonIndex == 1) {
            version = [[NSString alloc]initWithFormat:@"3"];
            [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"version"];
            [myTimer setFireDate:[NSDate date]];
            [self checkUpgradeVersionTxt];
        }
    }
    
    
    
    if (alertView.tag == 1002888) {
        
        
        if (buttonIndex==1) {
            show = NO;
            
            numberl = 0;
            //重置屏幕
            
            for (int i=0; i<myselect.count; i++) {
                DYT_AsyModel *model = [[DYT_AsyModel alloc]init];
                model.mydelegate = self;
                [model startSockettow:myselect[i]];
                [model commandResetServerWithType:0xd1 andContent:nil andContentLength:0];
            }
            
            
            
            [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(feedbackTimeout2:) userInfo:nil repeats:NO];
        }
    }
}


-(void)feedbackTimeout2:(NSTimer *)myTimer{
    DLog(@"走你");
    //    [myUpgradeButton3 setEnabled:YES];
    
    if (show==YES) {
        
        return;
    }
    //    重置失败
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_resettimeout"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
}
-(void)showRestScreenSuccess{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_tryRestScreenSuccess"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
}
//重置失败
-(void)showRestScreenfailed{
    
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_tryRestScreenfailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
}
-(void)contreloaddata
{
    //    [duanyutianiparray removeAllObjects];
    //
    //    [duanyutianipnamearray removeAllObjects];
    [myselect removeAllObjects];
    NSMutableArray *one = [[NSMutableArray alloc]init];
    NSMutableArray *two = [[NSMutableArray alloc]init];
    for (int i=0; i<AddressArr.count; i++) {
        [one addObject:AddressArr[i]];
        [two addObject:NameArr[i]];
        
    }
    
    [AddressArr removeAllObjects];
    [NameArr removeAllObjects];
    [AddressArr addObjectsFromArray:one];
    [NameArr addObjectsFromArray:two];
    [mycollectCV reloadData];
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
