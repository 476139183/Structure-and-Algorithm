//
//  DYT_FTPmodel.m
//  LEDAD
//
//  Created by laidiya on 15/7/14.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_FTPmodel.h"
#import "ProjectListObject.h"
#import "XMLDictionary.h"
#import "LayoutYXMViewController.h"

#import "GDataXMLNode.h"
#import "ForumWXDataServer.h"
//程序版本号的最大值
#define PROGRAM_VERSION_NO_MAX 100000000


@implementation DYT_FTPmodel
-(id)init
{
    self = [super init];
    if (self) {
        
        myasy = [[DYT_AsyModel alloc]init];
        myasy.mydelegate = self;
        
        [self _setdata];
    }
    return self;

}
-(void)_setdata
{

    _waitForUploadFilesArray = [[NSMutableArray alloc]init];
    xmldataarray = [[NSMutableArray alloc]init];
    _currentDataAreaIndex = 0;
    canle = NO;
    
    mySelectedProjectArray = [[NSMutableArray alloc]init];
    stringip = nil;
    
    _currentProjectPathRoot = nil;
    
    _myFileListArray = [[NSMutableArray alloc]init];
    
    _uploadFileTotalSize = 0;
    _sendFileCountSize = 0;

    

}

//取消
-(void)cancle
{
    [self _setdata];

    canle = YES;
    
    
    
    [_ftpMgr dytstop:@"0"];
    

}


//先发项目
-(void)ftp:(NSString *)ipstr and:(NSMutableArray *)xmlarray;
{
    tago = 1;
//    非连续播放
    isContinusPlay = NO;

    unknow = YES;
    
    [_waitForUploadFilesArray removeAllObjects];
    [xmldataarray removeAllObjects];
//    
    mySelectedProjectArray = [[NSMutableArray alloc]init];
    
   
    
    
    
    
    stringip = ipstr;
    
    for (int i=0; i<xmlarray.count; i++) {
        
        ProjectListObject *projectObj = [self findmyproject:[xmlarray objectAtIndex:i]];
        
        [mySelectedProjectArray addObject:projectObj];
        
        
        
        [_waitForUploadFilesArray addObject:projectObj.project_filename];
        
        //获得项目的根目录
        NSString *projectFileLastString =  [projectObj.project_filename lastPathComponent];
        
        _currentProjectPathRoot = [[NSString alloc]initWithFormat:@"%@",[projectObj.project_filename stringByReplacingOccurrencesOfString:projectFileLastString withString:@""]];
        DLog(@"失败的路径＝＝＝%@",_currentProjectPathRoot);
        //缓存文件夹的路径
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithXMLFile:projectObj.project_filename]];
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithDictionary:dataDictionary];
        
        
        NSDictionary *oneMaterialListElement = [tempDictionary objectForKey:@"materialListElement"];
        [self analysisDataToMaterialObjectWith:[oneMaterialListElement objectForKey:@"listItemElement"]];
        //
        
    }
    
    
    
    DLog(@"我要的＝＝＝＝＝%@",_waitForUploadFilesArray);
    
    
    
[self startupPublish];
    
//    [self useFTPSendProject];
    
    

}


//云屏升级
-(void)yunftp:(NSString *)ipisarrat;
{
    isContinusPlay = YES;
    
    stringip = ipisarrat;
    
    _currentDataAreaIndex = 0;
    [self useFTPSendFile];
    unknow = NO;
    
    
    
    
    

}

-(void)yunftpshangchuang:(NSMutableArray *)Project
{

    DLog(@"=====%@",Project);
    
    
    

}


-(void)uploadRequstMovPath:(NSString *)movPath movName:(NSString *)movName xmlPath:(NSString *)xmlPath xmlName:(NSString *)xmlName Material:(NSString *)materialName andgourpid:(NSString *)mygroupid
{

    
    DLog(@"\n%@\n %@\n %@\n %@\n %@\n %@\n ",movPath,movName,xmlPath,xmlName,materialName,mygroupid);
    
    DLog(@"====%@",xmlPath);
    DLog(@"======%@",movPath);
    
    yunduan = YES;
    NSString *str1 = [NSString stringWithFormat:@"http://www.ledmediasz.com/Ledad/FTP/%@",[movPath lastPathComponent]];
    NSString *str2 = [NSString stringWithFormat:@"http://www.ledmediasz.com/Ledad/FTP/%@",[xmlPath lastPathComponent]];
    

    
    parm = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                         mygroupid,@"GroupingID",
                         materialName,@"Material_Name",
                         str1,@"Video_url",
                         str2,@"Xml_url",
                         movName,@"VideoName",
                         xmlName,@"XmlName",
                         @"",@"Note",
                         nil];

    
    
    [_waitForUploadFilesArray addObject:xmlPath];
    [_waitForUploadFilesArray addObject:movPath];
    
    [self startyunduanupPublish];
    
    
}

//上传ftp 成功后
-(void)staraf
{

    
    //请求参数
    [ForumWXDataServer POSTrequestURL:@"Ledad/Ledad_MaterialAdd_api.aspx" params:parm success:^(id data) {
        
        
        
        
        DLog(@"===data＝＝＝%@",data);
        if ([data[@"msg"] isEqualToString:@"0"]) {
            
            [self.mydelegate showAlertView:[Config DPLocalizedString:@"adedit_zc21"] andtag:self.mytag];
            
        }else if([data[@"msg"] isEqualToString:@"2"])
        {
            
            [self.mydelegate showAlertView:[Config DPLocalizedString:@"adedit_zc22"] andtag:self.mytag];
            
        }
        
        
    } fail:^(NSError *error) {
        DLog(@"===%@",error);
        
        //                [_alertViewWithProgressbar hide];
        
    }];



}

/**
 *  使用ftp来发送文件  云屏升级
 */
-(void)useFTPSendFile{
    
    
    
    
    //连接ftp服务器
    _ftpMgr = [[YXM_FTPManager alloc]init];
    _ftpMgr.delegate = self;
    tago = 100;
    
   
    
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
        NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@/version",stringip];
        
        DLog(@"00000上传地址%@",sUploadUrl);
        [_ftpMgr startUploadFileWithAccount:@"ftpuser" andPassword:@"ftpuser" andUrl:sUploadUrl andFilePath:zipPath];
        _currentDataAreaIndex ++;
        
    }
    
    
}



-(void)lianxu
{
    DLog(@"连续播放");
    tago = 1;
   [_waitForUploadFilesArray removeAllObjects];
    NSString *groupNameString = @"连续播放";
    //开始创建分组文件
    NSDictionary *myGroupDict = [[NSDictionary alloc]initWithObjectsAndKeys:groupNameString,@"playlistname",mySelectedProjectArray,@"playlist" ,nil];
    
    [self createGroupXMLFileWithDictionary:myGroupDict andSavePath:nil andEdit:NO];
    
    
    [_waitForUploadFilesArray addObject:xmlfilePath];
    
    isContinusPlay = YES;
    
    [self startupPublish];

}



/**
 *  //在确认连接成功之后开始发布 发布项目
 */
-(void)startupPublish{
    
    
    //    if (!isConnect) {
    //        [self startSocket];
    //    }
    
    if (stringip == nil) {
        UIAlertView *alerviewnext = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_NoipError"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles: nil];
        [alerviewnext show];
        return;
        
    }
    
    
    DLog(@"传输项目");
    _currentDataAreaIndex = 0;
    //启动发布的进度条
//    [self startPuslisProgress];
    //计算文件总大小
    for (NSString *sFielPath in _waitForUploadFilesArray) {
        _uploadFileTotalSize += [LayoutYXMViewController fileSizeAtPath:sFielPath];
    }
    
DLog(@"=====大小＝＝＝＝＝%lld   ==%lf m",_uploadFileTotalSize,(float)_uploadFileTotalSize/(1024.0*1024.0))
    //开始发送文件，使用ftp的方式
    [self useFTPSendProject];
}



//云端ftp
-(void)startyunduanupPublish
{

    
    //    if (!isConnect) {
    //        [self startSocket];
    //    }
    
//    if (ipAddressString == nil) {
//        UIAlertView *alerviewnext = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_NoipError"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles: nil];
//        [alerviewnext show];
//        return;
//        
//    }
//    
    
    DLog(@"传输项目");
    _currentDataAreaIndex = 0;
    //启动发布的进度条
    //    [self startPuslisProgress];
    //计算文件总大小
    for (NSString *sFielPath in _waitForUploadFilesArray) {
        _uploadFileTotalSize += [LayoutYXMViewController fileSizeAtPath:sFielPath];
    }
    
    DLog(@"=====大小＝＝＝＝＝%lld   ==%lf m",_uploadFileTotalSize,(float)_uploadFileTotalSize/(1024.0*1024.0))
    //开始发送文件，使用ftp的方式
    
    
    
    
    
   
    [self useFTPyunSendProject];


    


}
-(void)useFTPyunSendProject
{

    //连接ftp服务器
    _ftpMgr = [[YXM_FTPManager alloc]init];
    _ftpMgr.delegate = self;
    
    
    NSString *sZipPath = nil;
    
    NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@:10021/",@"112.91.118.173"];
    
    
    DLog(@"上传钱_waitForUploadFilesArray = %@,_currentDataAreaIndex=%ld",_waitForUploadFilesArray,(long)_currentDataAreaIndex);
    if ([_waitForUploadFilesArray count]>_currentDataAreaIndex) {
        sZipPath = [_waitForUploadFilesArray objectAtIndex:_currentDataAreaIndex];
        DLog(@"zipPath = %@,sUploadUrl = %@,_currentDataAreaIndex=%ld",sZipPath,sUploadUrl,(long)_currentDataAreaIndex);
        [_ftpMgr startUploadFileWithAccount:@"ledmedia" andPassword:@"Q123456az" andUrl:sUploadUrl andFilePath:sZipPath];
        _currentDataAreaIndex ++;
    }
    DLog(@"是否相等＝＝＝＝%lu  %ld",(unsigned long)_waitForUploadFilesArray.count,(long)_currentDataAreaIndex);


}

/**
 *  使用ftp发送项目
 */

-(void)useFTPSendProject{
//       if (!_ftpMgr) {
    //连接ftp服务器
    _ftpMgr = [[YXM_FTPManager alloc]init];
    _ftpMgr.delegate = self;
//        }
    NSString *sZipPath = nil;
//    ipAddressString = stringip;
    NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@:21/rec_bmp",stringip];
    
    //如果是连续播放,则发送文件到分组文件夹内
    if (isContinusPlay) {
//        发送plist 文件
        sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@:21/manager_xmls",stringip];
    }
    
    DLog(@"上传钱_waitForUploadFilesArray = %@,_currentDataAreaIndex=%ld",_waitForUploadFilesArray,_currentDataAreaIndex);
    if ([_waitForUploadFilesArray count]>_currentDataAreaIndex) {
        sZipPath = [_waitForUploadFilesArray objectAtIndex:_currentDataAreaIndex];
        DLog(@"zipPath = %@,sUploadUrl = %@,_currentDataAreaIndex=%ld",sZipPath,sUploadUrl,_currentDataAreaIndex);
        [_ftpMgr startUploadFileWithAccount:@"ftpuser" andPassword:@"ftpuser" andUrl:sUploadUrl andFilePath:sZipPath];
        _currentDataAreaIndex ++;
    }
    DLog(@"是否相等＝＝＝＝%lu  %ld",(unsigned long)_waitForUploadFilesArray.count,(long)_currentDataAreaIndex);
    
    
}

/**
 *  反映上传进度的回调，每次写入流的数据长度
 *
 *  @param writeDataLength 数据长度
 */
-(void)uploadWriteData:(NSInteger)writeDataLength{
    
    
    
    DLog(@"上传中");
    if (yunduan==YES) {
        
        _sendFileCountSize += writeDataLength;
        CGFloat progressValue = _sendFileCountSize*1.00f / _uploadFileTotalSize*1.00f;
        
        float next = _sendFileCountSize*1.00f/(1024.0*1024.0);
        float one = _uploadFileTotalSize*1.00f/(1024.0*1024.0);
        NSString *string = [[NSString alloc]initWithFormat:@"%.2lfM/%.2lfM",next,one];
        DLog(@"======%@",string);

         [_mydelegate returegress:progressValue andtag:self.mytag andstr:string];
        return;
    }
//    
//    if (self.mytag>10000) {
//        
//        _sendFileCountSize += writeDataLength;
//        float progressValue = _sendFileCountSize*1.0f / _uploadFileTotalSize*1.0f;
//        DLog(@"progressValue = %lf",progressValue);
//        //    [_upgradeProgress setProgress:progressValue];
//        return;
//    }
//    
    
    
//    只计算项目的
    if (!isContinusPlay&&_mydelegate) {
        _sendFileCountSize += writeDataLength;
        CGFloat progressValue = _sendFileCountSize*1.00f / _uploadFileTotalSize*1.00f;
        
        float next = _sendFileCountSize*1.00f/(1024.0*1024.0);
        float one = _uploadFileTotalSize*1.00f/(1024.0*1024.0);
        NSString *string = [[NSString alloc]initWithFormat:@"%.2lfM/%.2lfM",next,one];
        DLog(@"======%@",string);
        [_mydelegate returegress:progressValue andtag:self.mytag andstr:string];
    }
    
    
    
//    [myMRProgressView setProgress:progressValue animated:YES];
//    
//    [myMRProgressView setTitleLabelText:[NSString stringWithFormat:@"%@ %0.0lf％",[Config DPLocalizedString:@"adedit_publishprojecting"],progressValue*100]];
}
/**
 *  ftp上传文件的反馈结果
 *
 *  @param sInfo 反馈结果字符串
 */
-(void)uploadResultInfo:(NSString *)sInfo{
    
    
//     云屏升级
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
                
                show = NO;
                
                [myasy startSockettow:stringip];
                
                [myasy commandCompleteWithType:0x1D andSendType:0x04 andContent:nil andContentLength:100000000 andPageNumber:100000000];
                
                
                [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(feedbackTimeout2:) userInfo:nil repeats:NO];
            }
        }else{
            
            [self upgradeFaild];
        }
        
        return;
        
    }
    
//云端  上传
    if (yunduan==YES) {
         if ([sInfo isEqualToString:@"uploadComplete"]) {
        if ([_waitForUploadFilesArray count]>_currentDataAreaIndex){
        [self useFTPyunSendProject];
        }else
        {
        
            [self staraf];
        
        }
         
         
         }else
         {
             DLog(@"失败");
         }
        
        
        
        
        
    }
    
    
    
    if (canle==YES) {
        return;
    }
    //    段雨田  tfp结果
    DLog(@"云屏sInfo = %@",sInfo);
    if ([sInfo isEqualToString:@"uploadComplete"]) {
        DLog(@"上传时_waitForUploadFilesArray = %@,_currentDataAreaIndex=%ld",_waitForUploadFilesArray,(long)_currentDataAreaIndex);
        if ([_waitForUploadFilesArray count]>_currentDataAreaIndex) {
            DLog(@"继续发");
            [self useFTPSendProject];
        }else if(([sInfo isEqualToString:@"error_ReadFileError"])||([sInfo isEqualToString:@"error_StreamOpenError"])){
//            [self stopPublishProgress];
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
        }else{
//            [self startSocket];
            //如果是连续播放
            if (isContinusPlay) {
                DLog(@"走了第一个方法");
                [myasy lianxu:stringip];
                 isContinusPlay = NO;
                _currentDataAreaIndex = 0;

                return;
               
            }else{
                DLog(@"走了第二个方法");
                [myasy fasong:stringip];
                return;
                
            }
            
            //上传成功
            
            
//            [mySelectedProjectArray removeAllObjects];
            
            //          段雨田   还是要刷新一下界面
            
            
        }
    }else{
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
    }
}







/**
 *@brief
 */
-(void)analysisDataToMaterialObjectWith:(NSDictionary *)oneListItemDict{
    
    NSString *materialFilePath = [[NSString alloc]initWithFormat:@"%@/%@",[_currentProjectPathRoot lastPathComponent],[oneListItemDict objectForKey:@"filename"]];
    DLog(@"一碟＝＝＝%@",materialFilePath);
    NSString *playFilePath = [[NSString alloc]initWithFormat:@"%@/%@",[LayoutYXMViewController defaultProjectRootPath],materialFilePath];
    DLog(@"一碟＝＝＝%@",playFilePath);

    DLog(@"_waitForUploadFilesArray add %@",playFilePath);
    [_waitForUploadFilesArray addObject:playFilePath];
    
}



////判断我要的东西 获取素材
//
-(ProjectListObject *)findmyproject:(NSString *)mypath
{
    
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/"];
    NSArray *filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                                fromDirPath:documentsDirectory AndIsGroupDir:NO];
    NSInteger count = filenameArray.count;
    
    for (int i=0; i<count; i++) {
        NSString *path = [NSString stringWithFormat:@"%@",[[filenameArray objectAtIndex:i] lastPathComponent]];
        if ([path isEqualToString:mypath]) {
            
            ProjectListObject *myPro = [[ProjectListObject alloc]init];
            [self getProjectNameWithFileName:[filenameArray objectAtIndex:i] andProjectObj:myPro];
            return myPro;
        }
    }
    
    return nil;
}

/**
 *  根据传入的文件对象，解析文件中的项目名称返回
 *
 *  @param asset 文件对象
 *
 *  @return 项目名称
 */
-(void)getProjectNameWithFileName:(NSString *)myFilePath andProjectObj:(ProjectListObject*)myProjectObj{
    @try {
        DLog(@"dataDictionary.filePath = %@",myFilePath);
        NSDictionary *dataDictionary = [NSDictionary dictionaryWithXMLFile:myFilePath];
        DLog(@"dataDictionary 字典-----------------= %@",dataDictionary);
        NSString *projectName = nil;
        BOOL includeMusic = NO;
        
        //        BOOL isExsit=NO;//默认不存在
        
        if (dataDictionary) {
            if ([dataDictionary objectForKey:@"projectName"]) {
                projectName = [[NSString alloc]initWithString:[dataDictionary objectForKey:@"projectName"]];
                DLog(@"根据传入的文件对象%@",projectName);
                
                //                if ([projectName rangeOfString:@"h"].location !=NSNotFound) {
                //                    isExsit=YES;
                //                }
                
            }
            if ([[dataDictionary objectForKey:@"projectMusicElement"] isKindOfClass:[NSDictionary class]]) {
                includeMusic = YES;
            }
            //判断是否存在这标识符
            
            
        }
        
        
        [myProjectObj setProject_filename:myFilePath];
        [myProjectObj setProject_name:projectName];
        [myProjectObj setProject_list_type:IS_PROJECT_XML];
        [myProjectObj setIsIncludeMusic:includeMusic];
        
        //存在
        //       [myProjectObj setIsExist:isExsit];
        
        [myProjectObj setIsSelected:NO];
    }
    @catch (NSException *exception) {
        DLog(@"解析项目名称异常 = %@",exception);
    }
    @finally {
    }
}


#pragma mark-
-(void)returemydata:(NSData *)mydata
{
    DLog(@"多连屏发送项目======%@",mydata);
    
    Byte *AckByte = (Byte *)[mydata bytes];
    
    
    
    if (AckByte[1] == 0x1D&&tago!=100) {
        DLog(@"连续播放项目命令发送成功");
        
//        连续播放
      [self lianxu];
        return;
    }
    
    
    if (AckByte[1] == 0x2C) {
        DLog(@"发送连续播放数据成功");
        
        if (_mydelegate&&[_mydelegate respondsToSelector:@selector(returemytag:)]) {
            [_mydelegate returemytag:self.mytag];

        }
//        [self myFinishedPublishEvent];
    }

    if (AckByte[1] == 0x1D&&tago ==100) {
        
        DLog(@"发送硬件升级数据成功");
        
        unftp = YES;
//        [self showUploadUpgradeFileSuccess];
        if (_mydelegate&&[_mydelegate respondsToSelector:@selector(returemytag:)]) {
            [_mydelegate returemytag:self.mytag];
        }
        
        
    }
    


    
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
        
//        [_myProjectCtrl useGroupInfoReloadProjectList];
        
        [mySelectedProjectArray removeAllObjects];
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
    NSString *documentsGroupXMLDir = [[NSString alloc]initWithFormat:@"%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/GroupXMLDir"]];
    BOOL isDir;
    if (![myFileManager fileExistsAtPath:documentsGroupXMLDir isDirectory:&isDir]) {
        [myFileManager createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/GroupXMLDir"] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentsGroupXMLDir;
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


-(void)upgradeSuccess{
    _sendFileCountSize = 0;
    _currentDataAreaIndex = 0;
}

-(void)feedbackTimeout2:(NSTimer *)myTimer{
//    DLog(@"走你");
//    //    [myUpgradeButton3 setEnabled:YES];
//    
//    if (show==YES) {
//        
//        return;
//    }
//    //    重置失败
//    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_resettimeout"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
//    [myAlertView show];
//    [myAlertView release];
}
//升级成功
-(void)showUploadUpgradeFileSuccess{
    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_upgradefinish"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
    [myAlertView show];
    
}


@end
