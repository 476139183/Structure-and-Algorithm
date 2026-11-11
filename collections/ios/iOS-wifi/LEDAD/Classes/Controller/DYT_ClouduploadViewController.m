//
//  DYT_ClouduploadViewController.m
//  LEDAD
//
//  Created by laidiya on 15/7/22.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_ClouduploadViewController.h"
#import "UIViewExt.h"
#import "HeadView.h"
#import "Group.h"
#import "Project.h"
#import "ForumWXDataServer.h"
#import "LayoutYXMViewController.h"
#import "XMLDictionary.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AFHTTPRequestOperation.h"
#import "AGAlertViewWithProgressbar.h"
#import "MRProgressOverlayView.h"
#import "DYT_cloudcheckTableViewCell.h"
#import "dyt_projectgroup.h"
#import "ForumWXDataServer.h"
#import "Config.h"
#import "Common.h"
#import "NSString+MD5.h"
#import "DYT_asimodel.h"
#import "DYT_FTPmodel.h"
#import "NSString+SBJSON.h"

#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]


@interface DYT_ClouduploadViewController ()<HeadViewDelegate,NSXMLParserDelegate,ASIHTTPRequestDelegate,ASIProgressDelegate,ftpprogressdelegate>
{
    NSMutableArray *_groupData;
    
    
    UIView *mengbanview;
    
    
    UILabel *_locallabtabel;
    //当前播放项目名字
//    NSString *_currentPlayProjectName;
//    NSString *_currentPlayProjectFilename;
//    NSString *_currentProjectPathRoot;
    NSArray *filenameArray;
    
//    NSMutableArray *_waitForUploadFilesArray;
    
    
//   本地的view
    UIView *Localview;
    
//  云端的view
    UIView *cloudview;
    
//    本地view
    
//    删除按钮
    UIButton *deleGroupButton;
    
    
    NSInteger _number;
    
    
    UIButton *backbutton;
    
    NSMutableArray *dytarray;
    
    
//    分组id
    NSString *mygroupid;
    
    
    UIProgressView *progressview;
    
    
    NSMutableArray *xmlarray;
    NSMutableArray *loacxmlarr;
    UIButton *savexmlbut;
    
}
@property (nonatomic,strong) NSMutableArray *assets;
@property (nonatomic,strong) NSMutableArray *xmlArr;

@end

@implementation DYT_ClouduploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _groupData = [[NSMutableArray alloc]init];
    
    
    dytarray = [[NSMutableArray alloc]init];
    xmlarray = [[NSMutableArray alloc]init];
    loacxmlarr = [[NSMutableArray alloc]init];
    [self initButton];
    
    
    _assets = [[NSMutableArray alloc]init];
    
//    _waitForUploadFilesArray = [[NSMutableArray alloc]init];
    [self settitleview];
    
    [self setcloudtableview];
    
    
    

    
//    xmltaleview
    [self setxmlview];
    
    
    [self lookxml];
    
    // Do any additional setup after loading the view.
}

-(void)settitleview
{

    
    
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    title.text = [NSString stringWithFormat:@"\t\t%@,%@",[Config DPLocalizedString:@"adedit_zc26"],self.usename];
    title.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:title];

    //注销
    UIButton *logOutButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 0, 50, 40)];
//    logOutButton.backgroundColor = [UIColor blueColor];
    
//    [logOutButton setTitle:@"注销" forState:0];
    [logOutButton setBackgroundImage:[UIImage imageNamed:@"注销"] forState:UIControlStateNormal];
    [logOutButton addTarget:self action:@selector(logoutButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logOutButton];
    
    backbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [backbutton setBackgroundImage: [UIImage imageNamed:@"dyt_back"] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(backview:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    backbutton.hidden = YES;
    
    
    

}


//上传xml方案
-(void)savexml:(NSString *)path andname:(NSString *)title;
{
    DLog(@"我的----%@   %@",path,title);
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *userID = [ud objectForKey:@"userID"];

    NSString *xmlPath = @"";
    
    NSFileManager *myFileManager = [NSFileManager defaultManager];
   
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    
    
//    NSString *xmlfilePath = [[NSString alloc]initWithFormat:@"%@/%@.xml",documentsDirectoryPath,[self getNowdateString]];

    
    NSArray *a = [LayoutYXMViewController getFilenamelistOfType:@"xml" fromDirPath:documentsDirectoryPath AndIsGroupDir:YES];
   
    DLog(@"--%@",a);
    
    xmlPath  = [a[0] lastPathComponent];
    
//    [myFileManager copyItemAtPath:a[0] toPath:[NSString stringWithFormat:@"%@/ExceptionReport.txt",documentsDirectoryPath] error:nil];
    
//    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/warty-final-ubuntu.png"] contents:data attributes:nil];

    
//    [fileMgr contentsOfDirectoryAtPath:documentsDirectoryerror:&error]);
        NSError *Error;
    
        NSString *Data = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[Config DPLocalizedString:@"adedit_syjc1"] ofType:@"txt"]encoding:4 error:& Error];
    
    
    
   NSLog(@"fasfasfa===%@",Data);
   NSString*filePath=[[NSBundle mainBundle] pathForResource:[Config DPLocalizedString:@"adedit_syjc1"] ofType:@"txt"];
    
 DLog(@"=====%@",xmlPath);
    //    上传文件 路径 和素材
    ASIFormDataRequest *request_xml=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://www.ledmediasz.com/Ledad/Handler/UploadFilesXML.ashx"]];
    
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithXMLFile:a[1]]];
    
    DLog(@"--%@",dataDictionary);

    
    [request_xml setRequestMethod:@"POST"];
    [request_xml setTimeOutSeconds:60];
    [request_xml setPostValue:userID forKey:@"userId"];
    [request_xml setPostValue:title forKey:@"name"];

    [request_xml setFile:path forKey:@"Filedata"];
    
    request_xml.tag = 2;
    [request_xml setDelegate:self];
    [request_xml buildRequestHeaders];

    [request_xml startAsynchronous];
    
    [request_xml setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
        
//        zsize += size;
        DLog(@"shangc=====%lld    %lld",size,total);
    }];

    
    

}

//查看云端xml
-(void)lookxml
{

    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *userID = [ud objectForKey:@"userID"];

    NSMutableDictionary *params = [@{@"userId": userID}mutableCopy];
    
    [ForumWXDataServer requestURL:@"Ledad/Handler/SelectFilesXML.ashx"
                       httpMethod:@"GET"
                           params:params
                             file:nil
                          success:^(id data){
                              
                              NSLog(@"=====%@",data);
                              NSArray *arr = data[@"FileList"];
                              
                              [self _setXmlArr:arr];
                              
                          } fail:^(NSError *error){
                              
                              
                              NSLog(@"失败%@",error);
                              
                              
                          }];
    
    
}


//查看本地xml 方案
-(void)lookloacxml
{
    
    [loacxmlarr removeAllObjects];
  NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSArray *a = [LayoutYXMViewController getFilenamelistOfType:@"xml" fromDirPath:documentsDirectoryPath AndIsGroupDir:YES];

//
    DLog(@"==%@",a);
    for (int i=0; i<a.count; i++) {
          NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithXMLFile:a[i]]];
        DLog(@"----%@",dataDictionary);
        Project *pro = [[Project alloc]init];
        pro.Material_Name = dataDictionary[@"numberip"][@"name"];
        pro.Xml_url = a[i];
        [loacxmlarr addObject:pro];
    }
    
    [locaxmltable reloadData];

}


//得到云端 反馈
-(void)_setXmlArr:(NSArray *)arr
{

    
    DLog(@"arr===%@",arr);
    
    [xmlarray removeAllObjects];
    
    for (int i=0; i<arr.count; i++) {
        Project *myproject = [[Project alloc]init];
        
        myproject.Material_Name = arr[i][@"name"];
        myproject.XmlName = arr[i][@"filename"];
        myproject.Xml_url = arr[i][@"fileUrl"];
        myproject.ID = arr[i][@"userID"];
        [xmlarray addObject:myproject];
                                      
    }
    
    DLog(@"刷新列表====");
    [xmltabview reloadData];
    

}



//下载xml 方案
-(void)startfa:(NSString *)string andname:(NSString *)name;
{

    DLog(@"===%@",name);
    NSArray *arr = [name componentsSeparatedByString:@"."];
    
    
    
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    NSLog(@"--%@",[formatter stringFromDate:[NSDate date]]);

    
    NSString *myname = [self getNowdateString];
    myname = [myname md5Encrypt];

    DLog(@"%@",myname);
    
//    保存的路径
        NSString *xmlfilePath = [[NSString alloc]initWithFormat:@"%@/%@.xml",documentsDirectoryPath,myname];

    
    NSURL *url=[NSURL URLWithString:string];
    
    //创建请求
    NSMutableURLRequest  *request=[NSMutableURLRequest requestWithURL:url];//默认为get请求
    //设置最大的网络等待时间
    request.timeoutInterval=20.0;
    
    //获取主队列
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    //发起请求
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //隐藏HUD
        if (data) {//如果请求成功，拿到服务器返回的数据
            
            //        [self parseXMLData:data];
            NSString *xmlStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            
            NSError *error;
            BOOL writeFileBool  =  [xmlStr writeToFile:xmlfilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
            DLog(@"=====%d",writeFileBool);
            
            if(error){
                
                DLog(@"写入xml出错");
                
                [self showAlertView:[Config DPLocalizedString:@"adedit_zc27"]];
                return ;
                
            }else{
                
                [self showAlertView:[Config DPLocalizedString:@"adedit_zc28"]];
                DLog(@"写入成功！====%@",myname);
                
                NSArray *a = [LayoutYXMViewController getFilenamelistOfType:@"xml" fromDirPath:documentsDirectoryPath AndIsGroupDir:YES];
                
                DLog(@"--%@",a);
                
            }
            
        }else {
            
            DLog(@"＝＝＝＝＝%@",connectionError);
            
        }
        
        
    }];
    

    


}


//本地返回到云
-(void)backview:(UIButton *)sender
{
    backbutton.hidden = YES;
    cloudview.hidden = NO;
    [savexmlbut setTitle:@"云端xml" forState:UIControlStateNormal];
    [self loadData];
    xmltabview.hidden = NO;
    locaxmltable.hidden = YES;
    [self lookxml];
    [Localview removeFromSuperview];
}

//云列表
-(void)setcloudtableview
{
    
    cloudview = [[UIView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-360)];
    [self.view addSubview:cloudview];
    
    UILabel *_datalabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
    
    _datalabel.text = [Config DPLocalizedString:@"adedit_zc29"];
    _datalabel.font = [UIFont systemFontOfSize:12];
    
    _dataTableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 50, cloudview.frame.size.width-20, cloudview.frame.size.height-50) style:UITableViewStylePlain];
    _dataTableview.tableFooterView = [[UIView alloc]init];
//    _dataTableview.backgroundColor = [UIColor redColor];
    _dataTableview.tag = 1;
    
    _dataTableview.sectionHeaderHeight = 40;
    
    _dataTableview.dataSource = self;
    _dataTableview.delegate = self;
    
    [cloudview addSubview:_datalabel];
    [cloudview addSubview:_dataTableview];

    
    
    
    
//    新建分组
        UIButton *newGroupButton = [[UIButton alloc]initWithFrame:CGRectMake(cloudview.frame.size.width/2-20, 0, 35, 30)];
//        newGroupButton.backgroundColor = [UIColor grayColor];
    
//        [newGroupButton setTitle:@"新建组" forState:0];
    [newGroupButton setBackgroundImage:[UIImage imageNamed:@"新建组"] forState:UIControlStateNormal];
        [newGroupButton addTarget:self action:@selector(newGroupButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cloudview addSubview:newGroupButton];

    
//    删除分组
    deleGroupButton = [[UIButton alloc]initWithFrame:CGRectMake(newGroupButton.frame.origin.x + newGroupButton.frame.size.width+5, 0, newGroupButton.frame.size.width, 30)];
//    deleGroupButton.backgroundColor = [UIColor grayColor];
    [deleGroupButton setBackgroundImage:[UIImage imageNamed:@"删除组"] forState:UIControlStateNormal];
    
//    [deleGroupButton setTitle:@"删除组" forState:0];
    
    [deleGroupButton addTarget:self action:@selector(deleGroupButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cloudview addSubview:deleGroupButton];
    deleGroupButton.hidden = YES;
    
    
    
    
    
   
    

}

//加载xml列表

-(void)setxmlview
{
    
    
    
    
    NSInteger wid = cloudview.frame.origin.y+cloudview.frame.size.height+10;
    UIView *xmlview = [[UIView alloc]initWithFrame:CGRectMake(0, wid, cloudview.frame.size.width, self.view.frame.size.height-wid-80)];
//    xmlview.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:xmlview];
    
    
    xmltabview = [[UITableView alloc]initWithFrame:CGRectMake(10, 35, xmlview.frame.size.width-20, xmlview.frame.size.height-35)];
//    xmltabview.backgroundColor = [UIColor orangeColor];
    xmltabview.dataSource = self;
    xmltabview.delegate = self;
    xmltabview.tag = 3;
    [xmlview addSubview:xmltabview];
    
//
    
    savexmlbut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    savexmlbut.backgroundColor = [UIColor cyanColor];
    
    
    [savexmlbut setTitle:[Config DPLocalizedString:@"adedit_zc30"] forState:UIControlStateNormal];
    
    savexmlbut.titleLabel.font = [UIFont systemFontOfSize:12];
//    [savexmlbut addTarget:self action:@selector(savexml) forControlEvents:UIControlEventTouchUpInside];
    [xmlview addSubview:savexmlbut];
    
    
    
    
    
    
    locaxmltable = [[UITableView alloc]initWithFrame:CGRectMake(10, 35, xmltabview.frame.size.width, xmltabview.frame.size.height)];
    
//    locaxmltable.backgroundColor = [UIColor orangeColor];
    locaxmltable.dataSource = self;
    locaxmltable.delegate = self;
    locaxmltable.tag = 4;
    [xmlview addSubview:locaxmltable];

    locaxmltable.hidden = YES;
    
//    UIButton *looksxml = [[UIButton alloc]initWithFrame:CGRectMake(60, savexmlbut.frame.origin.y, 50, 30)];
//    looksxml.backgroundColor = [UIColor redColor];
//    [looksxml addTarget:self action:@selector(lookxml) forControlEvents:UIControlEventTouchUpInside];
//    [xmlview addSubview:looksxml];
//    

    
    
    

}


//本地列表
-(void)setLocaltableview
{
    
    
    Localview = [[UIView alloc]initWithFrame:CGRectMake(0, 60, cloudview.frame.size.width, cloudview.frame.size.height)];
    [self.view addSubview:Localview];
    
        _locallabtabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Localview.frame.size.width, 30)
                          ];
    
        _locallabtabel.text = [Config DPLocalizedString:@"Button_project"];
    
        _localTableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 50, Localview.frame.size.width-20, Localview.frame.size.height-50)];
        _localTableview.tag = 2;
        _localTableview.tableFooterView = [[UIView alloc]init];
    _localTableview.sectionHeaderHeight = 40;

        _localTableview.delegate = self;
        _localTableview.dataSource = self;
    
        [Localview addSubview:_locallabtabel];
        [Localview addSubview:_localTableview];
    


}
-(void)setlocaldata
{
    
    //保存到数据里面
    NSUserDefaults *mysqlarray = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *array = [mysqlarray objectForKey:@"mysqlprojects"];

    [dytarray removeAllObjects];
    for (int i=0; i<array.count; i++) {
        NSMutableDictionary *dic = array[i];
        
        Group   *my_friendsData = [[Group alloc]init];
        
        my_friendsData.Grouping_Name = [dic objectForKey:@"name"];
        
        NSMutableArray *mypro =[dic objectForKey:@"myproject"];
        NSLog(@"段雨田 ＝＝＝＝＝%@",mypro);
        my_friendsData.Materials = [dic objectForKey:@"myproject"];
        [dytarray addObject:my_friendsData];
        
    }
    
    

    


}

//解析数据
-(void)duanyutianAnalytical
{
    
//    //保存到数据里面
//    NSUserDefaults *mysqlarray = [NSUserDefaults standardUserDefaults];
//    
//    NSMutableArray *dataarray = [[NSMutableArray alloc]init];
//    
//    for (int i=0; i<dytarray.count; i++) {
//        
//        NSMutableDictionary *mydic = [[NSMutableDictionary alloc]init];
//        
//        dyt_projectgroup   *my_friendsData = dytarray[i];
//        
//        NSString *str = my_friendsData.name;
//        
//        NSMutableArray *mypro = my_friendsData.myprjectarray;
//        
//        [mydic setObject:mypro forKey:@"myproject"];
//        [mydic setObject:str forKey:@"name"];
//        
//        [dataarray addObject:mydic];
//        
//    }
//    
//    [mysqlarray removeObjectForKey:@"mysqlprojects"];
//    
//    [mysqlarray setObject:dataarray forKey:@"mysqlprojects"];
    
    
}


#pragma mark 加载数据
- (void)loadData
{
    
    __block  NSArray *tempArray = [[NSArray alloc]init];
    [_groupData removeAllObjects];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *userID = [ud objectForKey:@"userID"];
    
    [ud synchronize];
    
    NSMutableDictionary *params = [@{@"UserID": userID}mutableCopy];
    
    [ForumWXDataServer requestURL:@"Ledad/Ledad_GroupingList_api.aspx"
                       httpMethod:@"GET"
                           params:params
                             file:nil
                          success:^(id data){
                              
                              NSLog(@"=====%@",data);
                              
                              tempArray = data[@"Groupings"];
                              
                              
                              NSLog(@"成功---------%@",tempArray);
                              
                              NSMutableArray *fgArray = [NSMutableArray array];
                              for (NSDictionary *dict in tempArray) {
                                  Group *group = [Group projectGroupWithDict:dict];
                                  group.qcheck = NO;
                                  [fgArray addObject:group];
                              }
                              [_groupData addObjectsFromArray:fgArray];
//                              _groupData = fgArray;
                              DLog(@"成功=======%ld",_groupData.count);
                              [self.dataTableview reloadData];
                          } fail:^(NSError *error){
                              
                              
                              NSLog(@"失败%@",error);
                              
                              
                          }];
    
    

    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self loadData];

    


}

-(void)initButton{
    
    
    
//    //上传
//    UIButton *uploadButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 60, 90, 40)];
//    uploadButton.backgroundColor = [UIColor grayColor];
//    [uploadButton setTitle:@"上传" forState:0];
//    [uploadButton addTarget:self action:@selector(myuploadButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:uploadButton];
//    
//    
}

//点击上传实现方法


-(void)myuploadButtonOnClick
{
    _localTableview.hidden = NO;
    _locallabtabel.hidden = NO;
    //    _uploadButtonOnClick();
    
    @try {
        [_assets removeAllObjects];
        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/"];
        filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                           fromDirPath:documentsDirectory AndIsGroupDir:NO];
        NSInteger count = filenameArray.count;
        
        
        DLog(@"I have %ld XMLfile in DocumentsDir,filenameArray =%@",(long)count,filenameArray);
        ProjectListObject *myPro = [[ProjectListObject alloc]init];
        [self getProjectNameWithFileName:[filenameArray objectAtIndex:0] andProjectObj:myPro];
        
        DLog(@"获取名字=====%@",myPro.project_name);
        
//        _xmlArr=[[NSMutableArray alloc]init];
//        for (int i = 0; i<count; i++) {
//            [_xmlArr addObject:[NSString stringWithFormat:@"%@",[[filenameArray objectAtIndex:i] lastPathComponent]]];
//            
//            if ([filenameArray objectAtIndex:i]) {
//                if ([[[filenameArray objectAtIndex:i] lastPathComponent] isEqualToString:@"playlist.xml"]) {
//                    continue;
//                }
//                
//                
//                ProjectListObject *myPro = [[ProjectListObject alloc]init];
//                [self getProjectNameWithFileName:[filenameArray objectAtIndex:i] andProjectObj:myPro];
//                [_assets addObject:myPro];
//            }
//        }
//        
//        NSLog(@"%@",_assets);
//        
//        [_localTableview reloadData];
//        DLog(@"本地的xml========>%@",_xmlArr);
    }
    @catch (NSException *exception) {
        DLog(@"读取项目列表异常loadProject2List = %@",exception);
    }
    @finally {
    }
    
    
    
}

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
                DLog(@"获取名字****________________****%@",projectName);
                
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
//点击新建组button实现发方法
-(void)newGroupButtonOnClick:(id)sender{
    
    
    self.stAlertView = [[STAlertView alloc] initWithTitle:[Config DPLocalizedString:@"adedit_zc31"]
                                                  message:[Config DPLocalizedString:@"adedit_zc32"]
                                            textFieldHint:[Config DPLocalizedString:@"adedit_zc33"]
                                           textFieldValue:nil
                                        cancelButtonTitle:[Config DPLocalizedString:@"adedit_Close"]
                                        otherButtonTitles:[Config DPLocalizedString:@"adedit_zc2"]
                        
                                        cancelButtonBlock:^{
                                            
                                            
                                        } otherButtonBlock:^(NSString * result){
                                            
                                            [self newGroupRequst:result];
                                            
                                            
                                        }];
    
    
}

//删除分组
-(void)deleGroupButtonOnClick:(UIButton *)sender
{
    
    for (int i=0; i<_groupData.count; i++) {
        Group *grop = _groupData[i];
        if (grop.qcheck==YES) {
            
            [self selfdeleGroupcloud:grop.ID];
            
        }
    }

    
    
    
}

-(void)selfdeleGroupcloud:(NSString *)stringid
{

    
    NSMutableDictionary *params = [@{@"ID":stringid}mutableCopy];
    
    [ForumWXDataServer requestURL:@"Ledad/Ledad_GroupingIsShowUP_api.aspx"
                       httpMethod:@"GET"
                           params:params
                             file:nil
                          success:^(id data){
                              
                              NSLog(@"%@",data);
                              
                              
                              [self loadData];
                          } fail:^(NSError *error){
                              
                              
                              NSLog(@"%@",error);
                              
                              
                          }];
    

    
    

}



//点击注销实现方法
-(void)logoutButtonOnClick:(id)sender{
    
    
    _logoutButtonOnClick();
    
    
}


-(void)newGroupRequst:(NSString *)string{
    
    NSLog(@"%@",string);
    NSString *str = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *userID = [ud objectForKey:@"userID"];
    
    [ud synchronize];
    
    NSMutableDictionary *params = [@{@"UserID":userID,
                                     @"Grouping_Name":str}mutableCopy];
    
    [ForumWXDataServer requestURL:@"Ledad/Ledad_GroupingAdd_api.aspx"
                       httpMethod:@"GET"
                           params:params
                             file:nil
                          success:^(id data){
                              
                              NSLog(@"%@",data);
                              
                              
                              [self loadData];
                          } fail:^(NSError *error){
                              
                              
                              NSLog(@"%@",error);
                              
                              
                          }];
    
    
    
}



////点击删除实现方法
//-(void)deleteButtonOnClick:(id)sender{
//
//    _deleteButtonOnClick();
//
//}


#pragma mark- table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 1) {
        
        return _groupData.count;
        
    }else if(tableView.tag==2){
        
        return dytarray.count;
        
    }else
    {
    
        return 1;
    
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        
        Group *group = _groupData[section];
        NSInteger count = group.isOpened ? group.Materials.count : 0;
        return count;
    }else if(tableView.tag==2){
        
        Group *group = dytarray[section];
        NSInteger count = group.isOpened ? group.Materials.count : 0;
        return count;

        
        
    }else if(tableView.tag==3)
    {
        return xmlarray.count;
    }else
    {
    
        return loacxmlarr.count;
    
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (tableView.tag == 1) {
//       云项目
        
            static NSString *cellIdentifier = @"cell";
            
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
           UITableViewCell     *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            

        Group *group = _groupData[indexPath.section];
        
        Project *project = group.Materials[indexPath.row];
            
            cell.textLabel.text = project.Material_Name;
        
            UIButton *downbutton = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-50, 2, 30, 30)];
            [downbutton setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
            [downbutton addTarget:self action:@selector(celldwonbutton:) forControlEvents:UIControlEventTouchUpInside];
            downbutton.tag = 10000*indexPath.section+indexPath.row+1;
            [cell.contentView addSubview:downbutton];
            
        
        return cell;
        
        
    }else if(tableView.tag==2){
        
        
//        本地项目
        static NSString *cellIdentifier = @"cell000000";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除子视图防止重叠

        Group *group = dytarray[indexPath.section];
        
        
        Project *project = group.Materials[indexPath.row];
        
        
        DLog(@"===%@",project);

        
        
        ProjectListObject *myPro = [self findmyproject:(NSString *)project];
        
        
        NSLog(@"%@",myPro.project_name);
        UIButton *upbutton = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-50, 2, 30, 30)];
        [upbutton setImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];
        [upbutton addTarget:self action:@selector(cellupbutton:) forControlEvents:UIControlEventTouchUpInside];
        upbutton.tag = 20000*indexPath.section+indexPath.row+1;
        [cell.contentView addSubview:upbutton];
        

        
        
        cell.textLabel.text = myPro.project_name;
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
        
    }else if(tableView.tag==3)
    {
//        xml 云端
       static NSString *mycell = @"xmlcell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除子视图防止重叠

//        cell.backgroundColor = [UIColor redColor];
        
        UIButton *downbutton = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-50, 10, 30, 30)];
        [downbutton setBackgroundImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
        [downbutton addTarget:self action:@selector(set_xml:) forControlEvents:UIControlEventTouchUpInside];
        downbutton.tag = 50000+indexPath.row;
        Project *pro = xmlarray[indexPath.row];
        cell.textLabel.text = pro.Material_Name;
        
        [cell.contentView addSubview:downbutton];
        return cell;
    
    }else
    {
//        xml  本地
        static NSString *mycell = @"xmlcell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
        }
        [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除子视图防止重叠

//        cell.backgroundColor = [UIColor redColor];
        UIButton *upbutton = [[UIButton alloc]initWithFrame:CGRectMake(cell.frame.size.width-50, 10, 30, 30)];
        [upbutton setBackgroundImage:[UIImage imageNamed:@"upload"] forState:UIControlStateNormal];
        upbutton.tag = 60000+indexPath.row;
        [upbutton addTarget:self action:@selector(up_xml:) forControlEvents:UIControlEventTouchUpInside];
        Project *pro = loacxmlarr[indexPath.row];
        cell.textLabel.text = pro.Material_Name;
        [cell.contentView addSubview:upbutton];
        return cell;

        
    
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
//    这是 云素材
    if (tableView.tag==1) {
        HeadView *headView = [HeadView headViewWithTableView:tableView];
        
        
        Group *gg = _groupData[section];
        
        headView.delegate = self;
        headView.mytag = 1000+section;
        headView.qchek = gg.qcheck;
        headView.group = gg;
        
        return headView;
    }else if(tableView.tag==2)
    {
    
        HeadView *headView = [HeadView headViewWithTableView:tableView];
        Group *gg = dytarray[section];
        headView.delegate = self;
        headView.mytag = 2000+section;
        headView.qchek = gg.qcheck;
        headView.group = gg;
        
        return headView;

    
    }else
    {
    
    
        return nil;
    }
    
    
    
}

//多个 上传  本地项目  多传
-(void)upmoreobc:(NSInteger )tag
{
    
    
     Group *group = dytarray[tag-2000];
    

    upnumber = group.Materials.count;
    
    [self setmengban];
    
    
     dyt_tablewview  = [[DYT_progresstableview alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 300)];
     [mengbanview addSubview:dyt_tablewview];
    NSMutableArray *namearray = [[NSMutableArray alloc]init];
    
    for (int k=0; k<group.Materials.count; k++) {
        
        NSMutableArray *_waitForUploadFilesArray = [[NSMutableArray alloc]init];
        
            ProjectListObject *myPro = [self findmyproject:group.Materials[k]];
        
            NSString  *_currentPlayProjectFilename = myPro.project_filename;
        
        
            NSString *projectFileLastString =  [_currentPlayProjectFilename lastPathComponent];
            NSString *_currentProjectPathRoot = [[NSString alloc]initWithFormat:@"%@",[_currentPlayProjectFilename stringByReplacingOccurrencesOfString:projectFileLastString withString:@""]];
        
            DLog(@"=====%@",myPro);
        
            //缓存文件夹的路径
            NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithXMLFile:myPro.project_filename]];
        
            NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithDictionary:dataDictionary];
            [tempDictionary removeObjectForKey:@"projectName"];
        
            NSArray *materiallistArray = [tempDictionary objectForKey:@"materialListElement"];
        
        
            if (materiallistArray) {
                if ([materiallistArray isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *oneMaterialListElement in materiallistArray) {
                        NSArray *listItemArray = [oneMaterialListElement objectForKey:@"listItemElement"];
                        if (listItemArray) {
                            if ([listItemArray isKindOfClass:[NSArray class]]) {
                                for (NSDictionary *oneListItemDict in listItemArray) {
                                    [self analysisDataToMaterialObjectWith:oneListItemDict androotpath:_currentProjectPathRoot andwaitarray:_waitForUploadFilesArray];
                                }
                            }else{
                                [self analysisDataToMaterialObjectWith:[oneMaterialListElement objectForKey:@"listItemElement"] androotpath:_currentProjectPathRoot andwaitarray:_waitForUploadFilesArray];
                            }
                        }
                    }
                }else{
                    NSDictionary *oneMaterialListElement = [tempDictionary objectForKey:@"materialListElement"];
                    NSArray *listItemArray = [oneMaterialListElement objectForKey:@"listItemElement"];
                    if (listItemArray) {
                        if ([listItemArray isKindOfClass:[NSArray class]]) {
                            for (NSDictionary *oneListItemDict in listItemArray) {
                                [self analysisDataToMaterialObjectWith:oneListItemDict androotpath:_currentProjectPathRoot andwaitarray:_waitForUploadFilesArray];
                            }
                        }else{
                            [self analysisDataToMaterialObjectWith:[oneMaterialListElement objectForKey:@"listItemElement"] androotpath:_currentProjectPathRoot andwaitarray:_waitForUploadFilesArray];
                        }
                    }
                }
            }
        
        
        
        
            NSString *movPath = [_waitForUploadFilesArray firstObject];
            NSString *movName = [_waitForUploadFilesArray lastObject];
        
        
        
            //    xml的地址
            NSString *xmlPath = myPro.project_filename ;
        
//            for (int i=0; i<filenameArray.count; i++) {
//                NSString *path = [NSString stringWithFormat:@"%@",[[filenameArray objectAtIndex:i] lastPathComponent]];
//                if ([group.Materials[k] isEqualToString:path]) {
//                    xmlPath = filenameArray[i];
//                }
//            }
        
            DLog(@"====%@",xmlPath);
        
            NSString *xmlName = [group.Materials objectAtIndex:k];
        
        
            //    NSLog(@"电影路径：%@,XML路径：%@,电影名字：%@,XML名字%@",movPath,xmlPath,movName,xmlName);
            //    开始  上传
        
        [namearray addObject:myPro.project_name];
        
        
        
        
            
            DYT_FTPmodel *ftpmodel = [[DYT_FTPmodel alloc]init];
            ftpmodel.mytag = 100+k;
            ftpmodel.mydelegate = self;
            [ftpmodel uploadRequstMovPath:movPath movName:movName xmlPath:xmlPath xmlName:xmlName Material:myPro.project_name andgourpid:mygroupid];
            
        

        
        
    }
    
      dyt_tablewview.data = namearray;
    
    
    
    
    
    
    
    
    

}



//点击云 下载 到本地  单个下载
-(void)celldwonbutton:(UIButton *)sender
{
    NSInteger section = sender.tag/10000;
    NSInteger row = sender.tag%10000-1;
    DLog(@"====%d",section);
    //        点击上传  单个项目
    Group *group = _groupData[section];
    Project *project = group.Materials[row];
    
    DLog(@"video路径：%@ , XML路径：%@",project.Video_url,project.Xml_url);
    
//    _alertViewWithProgressbar = [[AGAlertViewWithProgressbar alloc] initWithTitle:nil message:@"请稍等..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    [_alertViewWithProgressbar show];
    
    [self setmengban];
    
    
    
    _number = 1;
    dyt_tablewview  = [[DYT_progresstableview alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 300)];
    
    dyt_tablewview.data = [[NSArray alloc]initWithObjects:project.Material_Name, nil];
    [mengbanview addSubview:dyt_tablewview];

    
   
    
    
    
//    ftpmodel yunftpshangchuang:<#(Project *)#>
    
    
    
    
    [self downRequestMovPath:project.Video_url movName:project.VideoName xmlPath:project.Xml_url xmlName:project.XmlName andcount:100];
    
    
    
    

    

}



// 点击本地单云格  上传 单个上传  单传
-(void)cellupbutton:(UIButton *)sender
{
    
    

    
    
    NSInteger section = sender.tag/20000;
    NSInteger row = sender.tag%20000-1;
    
    
    Group *group = dytarray[section];
    
    
    
    NSMutableArray *_waitForUploadFilesArray = [[NSMutableArray alloc]init];
    
    
    ProjectListObject *myPro = [self findmyproject:group.Materials[row]];
          
    NSString  *_currentPlayProjectFilename = myPro.project_filename;

    
    NSString *projectFileLastString =  [_currentPlayProjectFilename lastPathComponent];
   NSString *_currentProjectPathRoot = [[NSString alloc]initWithFormat:@"%@",[_currentPlayProjectFilename stringByReplacingOccurrencesOfString:projectFileLastString withString:@""]];
    
    DLog(@"=====%@",_currentProjectPathRoot);
    
    //缓存文件夹的路径
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithXMLFile:myPro.project_filename]];
    
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithDictionary:dataDictionary];
    [tempDictionary removeObjectForKey:@"projectName"];
    
    NSArray *materiallistArray = [tempDictionary objectForKey:@"materialListElement"];
    
    NSLog(@"11111111 %@",materiallistArray);
    
  
    
    if (materiallistArray) {
        if ([materiallistArray isKindOfClass:[NSArray class]]) {
            for (NSDictionary *oneMaterialListElement in materiallistArray) {
                NSArray *listItemArray = [oneMaterialListElement objectForKey:@"listItemElement"];
                if (listItemArray) {
                    if ([listItemArray isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *oneListItemDict in listItemArray) {
                            [self analysisDataToMaterialObjectWith:oneListItemDict androotpath:_currentProjectPathRoot andwaitarray:_waitForUploadFilesArray];
                        }
                    }else{
                        [self analysisDataToMaterialObjectWith:[oneMaterialListElement objectForKey:@"listItemElement"] androotpath:_currentProjectPathRoot andwaitarray:_waitForUploadFilesArray];
                    }
                }
            }
        }else{
            NSDictionary *oneMaterialListElement = [tempDictionary objectForKey:@"materialListElement"];
            NSArray *listItemArray = [oneMaterialListElement objectForKey:@"listItemElement"];
            if (listItemArray) {
                if ([listItemArray isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *oneListItemDict in listItemArray) {
                        [self analysisDataToMaterialObjectWith:oneListItemDict androotpath:_currentProjectPathRoot andwaitarray:_waitForUploadFilesArray];
                    }
                }else{
                    [self analysisDataToMaterialObjectWith:[oneMaterialListElement objectForKey:@"listItemElement"] androotpath:_currentProjectPathRoot andwaitarray:_waitForUploadFilesArray];
                }
            }
        }
    }
    
    
    
    
    NSString *movPath = [_waitForUploadFilesArray firstObject];
    NSString *movName = [_waitForUploadFilesArray lastObject];
    
//    xml的地址
    NSString *xmlPath = [filenameArray objectAtIndex:row];
    
    for (int i=0; i<filenameArray.count; i++) {
         NSString *path = [NSString stringWithFormat:@"%@",[[filenameArray objectAtIndex:i] lastPathComponent]];
        if ([group.Materials[row] isEqualToString:path]) {
            xmlPath = filenameArray[i];
        }
    }
    
    DLog(@"====%@",xmlPath);
    NSString *xmlName = [group.Materials objectAtIndex:row];
    
    
//    NSLog(@"电影路径：%@,XML路径：%@,电影名字：%@,XML名字%@",movPath,xmlPath,movName,xmlName);
//    开始  上传
    [self setmengban];
    
    dyt_tablewview  = [[DYT_progresstableview alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 300)];
    NSArray *array = [[NSArray alloc]initWithObjects:myPro.project_name, nil];
    dyt_tablewview.data = array;
    [mengbanview addSubview:dyt_tablewview];
    
    
    
    
    
    
    upnumber = 1;
    
    
     DYT_FTPmodel *ftpmodel = [[DYT_FTPmodel alloc]init];
    ftpmodel.mytag = 100;
    ftpmodel.mydelegate = self;
    [ftpmodel uploadRequstMovPath:movPath movName:movName xmlPath:xmlPath xmlName:xmlName Material:myPro.project_name andgourpid:mygroupid];
    
    
    
    
    
//    DYT_asimodel *asy = [[DYT_asimodel alloc]initwith:self];
//    
//    asy.mytag = 100;
//    
//    
//    
//    [asy uploadRequstMovPath:movPath movName:movName xmlPath:xmlPath xmlName:xmlName Material:myPro.project_name andgourpid:mygroupid];


}



//-(void)returemytag:(NSInteger )tag;
//{
//    upnumber--;
//    
////    if ([string isEqualToString:@"上传云备份成功"]) {
////        
////        
////        if (upnumber==0) {
////            
////            [dyt_tablewview removeFromSuperview];
////            
////            [self showAlertView:string];
////        }
////    }else
////    {
////        if (upnumber==0) {
////            [self showAlertView:string];
////            [dyt_tablewview removeFromSuperview];
////        }
////        DLog(@"失败");
////        //     [self showAlertView:string];
////        
////    }
//
//    
//    
//}

-(void)returegress:(float)flo andtag:(NSInteger)tag andstr:(NSString *)str;

{

     [dyt_tablewview changeview:tag-99 andtext:str andgress:flo];
    
    
    
}




-(void)showAlertView:(NSString *)string andtag:(NSInteger )tag;
{
    DLog(@"服务器反馈====%@",string);
     upnumber--;
   
    if ([string isEqualToString:[Config DPLocalizedString:@"adedit_zc21"]]) {
        
       
        if (upnumber==0) {
            
            
            
            [dyt_tablewview removeFromSuperview];
            [mengbanview removeFromSuperview];
             [self showAlertView:string];
        }
    }else
    {
        if (upnumber==0) {
             [self showAlertView:string];
             [dyt_tablewview removeFromSuperview];
            [mengbanview removeFromSuperview];
        }
        DLog(@"失败");
//     [self showAlertView:string];
        
    }
    
    
}

-(void)returegress:(long long)siez andtotal:(long long)total andtext:(NSString *)string andtag:(NSInteger)tag
{
    
    
    float next = siez*1.00f/(1024.0*1024.0);
    float one = total*1.00f/(1024.0*1024.0);
     CGFloat flo = siez*1.00f / total*1.00f;
    
    NSString *tetx = [NSString stringWithFormat:@"%.2lfM/%.2lfM",next,one];
    
    [dyt_tablewview changeview:tag-99 andtext:tetx andgress:flo];

    
//    DLog(@"jindu====%lld   %lld",siez,total);
    
}


//  下载云端xml
-(void)set_xml:(UIButton *)sender
{


    Project *pro = xmlarray[sender.tag-50000];
    DLog(@"pr===%@",pro.Xml_url);
    [self startfa:pro.Xml_url andname:pro.XmlName];

    
}


//上传方案 当云端
-(void)up_xml:(UIButton *)sender
{

    
    Project *pro = loacxmlarr[sender.tag-60000];
    DLog(@"pr===%@",pro.Xml_url);
    
    [self savexml:pro.Xml_url andname:pro.Material_Name];


}

//单元格点击

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return;
    if (tableView.tag == 1) {
        
        
        
    }else if(tableView.tag==2){
        
//        [_waitForUploadFilesArray removeAllObjects];
//        
//        ProjectListObject *myPro  = [_assets objectAtIndex:indexPath.row];
//        _currentPlayProjectFilename = myPro.project_filename;
//        _currentPlayProjectName = myPro.project_name;
        
        
           }else if(tableView.tag==3)
           {
           
               
               Project *pro = xmlarray[indexPath.row];
               DLog(@"pr===%@",pro.Xml_url);
               [self startfa:pro.Xml_url andname:pro.XmlName];
           
           }else
           {
           
               Project *pro = loacxmlarr[indexPath.row];
               DLog(@"pr===%@",pro.Xml_url);
               
               [self savexml:pro.Xml_url andname:pro.Material_Name];

           
           }
    
    //点击下载项目从云到本地
    
}



//下载云端到本地
-(void)downRequestMovPath:(NSString *)movPath movName:(NSString *)movName xmlPath:(NSString *)xmlPath xmlName:(NSString *)xmlName andcount:(NSInteger)count;
{
    
    
     NSFileManager * fileManager = [NSFileManager defaultManager];
    
    //项目文件夹的名称
    //    NSString *sProjectDir = nil;
    
//    IMG_6646.mp4
    //    NSArray *array_movName = [movName componentsSeparatedByString:@"."];
    
    //    sProjectDir = [array_movName firstObject];
    
    
   
        
        DLog(@"视频名字===%@",movName);
        NSArray *b = [movName componentsSeparatedByString:@"."];
        
        NSString *str = [NSString stringWithFormat:@"%@%@",b[0],[self getNowdateString]];

  NSString  *nametime = [NSString stringWithFormat:@"%@",[str md5Encrypt]];

  NSString  *stringpath = [self documentGroupXMLDir:nametime];
        
    
    DLog(@"===%@",stringpath);
    
    
    
    
    
    //项目存放根目录
    NSString *sProjectRootPath = nil;
    //项目文件夹的路径
    NSString *sProjectDirPath = nil;
    //项目的XML文件的路径
    NSString *sProjectXmlFilePath = nil;
    //项目的video文件路径
    NSString *sProjectVideoFilePath = nil;
    
    //项目存放根目录
    sProjectRootPath = [LayoutYXMViewController defaultProjectRootPath];
    
    //项目文件夹的路径
    sProjectDirPath = [self customeProjectDirPathWith:xmlName];
    
    
    sProjectVideoFilePath = [self customeVideoFilePathWithProjectDir:xmlName videoType:movName andpath:stringpath];
    
    //项目的XML文件的路径
    sProjectXmlFilePath = [self customeXMLFilePathWithProjectDir:xmlName];
    
    DLog(@" 写入xml======%@",sProjectXmlFilePath);
    
    //    sProjectVideoFilePath = [self customeVideoFilePathWithProjectDir:xmlName videoType:movName];
    NSDictionary * dict1 = [fileManager attributesOfItemAtPath:stringpath error:nil];

    
    
      DLog(@" %d,第一次我想要的视频size== %d",[fileManager fileExistsAtPath:sProjectVideoFilePath],dict1);
    
    
    
    NSURL *url=[NSURL URLWithString:xmlPath];
    
    //创建请求
    NSMutableURLRequest  *request=[NSMutableURLRequest requestWithURL:url];//默认为get请求
    //设置最大的网络等待时间
    request.timeoutInterval=20.0;
    
    //获取主队列
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    //发起请求
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //隐藏HUD
        if (data) {//如果请求成功，拿到服务器返回的数据
            
            //        [self parseXMLData:data];
            NSString *xmlStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            
            DLog(@"%@=====%@",stringpath,sProjectXmlFilePath);
            
        NSString    *xmlfilePath = [NSString stringWithFormat:@"%@/%@.xml",stringpath,nametime];
            DLog(@"写入路径===%@",xmlfilePath);
            
            NSError *error;
        BOOL writeFileBool  =  [xmlStr writeToFile:xmlfilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
            DLog(@"=====%d",writeFileBool);
            
            if(error){
                
                DLog(@"写入xml出错");
                
                [self showAlertView:@"写入文件出错！"];
                return ;
                
            }else{
                
                
                DLog(@"写入成功！");
                [self adduser:xmlfilePath];
            }
            
        }else {
            
            DLog(@"＝＝＝＝＝%@",connectionError);
            
        }
        
        
    }];
    
    
    /*
     //1.创建请求对象
     
     /var/mobile/Containers/Data/Application/F77A99DD-5632-4DEB-BC9C-08EF177E1132/Documents/ProjectCaches/b06c37f098d294286f36816b9c08ea121435831820952.xml/b06c37f098d294286f36816b9c08ea121435831820952.xml
     
     
     /var/mobile/Containers/Data/Application/F77A99DD-5632-4DEB-BC9C-08EF177E1132/Documents/ProjectCaches/7441d705c1ac031f2b21250f8b4cdddb/7441d705c1ac031f2b21250f8b4cdddb.xml
     
     
     NSURL *url=[NSURL URLWithString:xmlPath];
     ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
     request.downloadDestinationPath=sProjectXmlFilePath;
     
     //    3.设置下载进度的代理
     //         request.downloadProgressDelegate=self.progress;
     
     //4.发送网络请求（异步）
     [request startAsynchronous];
     
     //5.下载完毕后通知
     [request setCompletionBlock:^{
     
     
     NSLog(@"%@",request.error);
     
     NSLog(@"完成xml下载");
     
     
     }];
     
     
     //2.添加请求参数（请求体中的参数）
     [request setDataReceivedBlock:^(NSData *data) {
     NSLog(@"xmlxmlxmlxmlxmlxmlxmlxmlxmlxmlxmlxmlxmlxml%ld",data.length);
     }];
     
     */
    
    //1.创建请求对象
    //    NSURL *urlVideo=[NSURL URLWithString:movPath];
    //    ASIHTTPRequest *requestVideo=[ASIHTTPRequest requestWithURL:urlVideo];
    //    requestVideo.downloadDestinationPath=sProjectVideoFilePath;
    //
    //    //    3.设置下载进度的代理
    //    //         request.downloadProgressDelegate=self.progress;
    //
    //    //4.发送网络请求（异步）
    //    [requestVideo startAsynchronous];
    //
    //    //5.下载完毕后通知
    //    [requestVideo setCompletionBlock:^{
    //        NSLog(@"视频文件已经下载完毕");
    //    }];
    //    //2.添加请求参数（请求体中的参数）
    //    [requestVideo setDataReceivedBlock:^(NSData *data) {
    ////        NSLog(@"%ld\n",data.length);
    //    }];
  
    
    //   __block int i = 0;
    //    [self performBlock:^{
    //        if (++i%2==1) {
    //            progressView.mode = MRProgressOverlayViewModeCheckmark;
    //            progressView.titleLabelText = @"Succeed";
    //        } else {
    //            progressView.mode = MRProgressOverlayViewModeCross;
    //            progressView.titleLabelText = @"Failed";
    //        }
    //    } afterDelay:1.0];
    
    
    
    //    [progressView show:YES];
    
//    UIProgressView *progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(400, 300, 220, 30)];
//    
//    progressView.backgroundColor = [UIColor blueColor];
//    
//    [self.view addSubview:progressView];
    
    
    NSURL *urlVideo=[NSURL URLWithString:movPath];
    NSURLRequest *requestVideo=[NSURLRequest requestWithURL:urlVideo];
    
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:requestVideo];
    operation.mytag = count;
    operation.inputStream = [NSInputStream inputStreamWithURL:url];
    
    
    
  

    NSLog(@"移动路径----%@\n",sProjectVideoFilePath);
    
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:sProjectVideoFilePath append:NO];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //        NSLog(@"is download：％%f", (float)totalBytesRead/totalBytesExpectedToRead);
        
        float floatInt = (float)totalBytesRead/totalBytesExpectedToRead;
        
//        DLog(@"下载进度========%f/%f",totalBytesRead/(1064*1064),totalBytesExpectedToRead/(1064*1064));
        NSString *str = [NSString stringWithFormat:@"%.2lfM/%.2lfM",totalBytesRead/(1024.0*1024.0),totalBytesExpectedToRead/(1024.0*1024.0)];
//        int i = floatInt*100;
        [self settxt:str andtag:count andpress:floatInt];
        
//        NSLog(@"下载进度====%d",i);
//        progressView.progress = floatInt;
        
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      
       
            [self stopaf:count];
        
        
        
        
        
        
//        [progressView removeFromSuperview];
        
       
        
        if(![fileManager fileExistsAtPath:sProjectVideoFilePath])
        {
            DLog(@"不存在这个地址");
//            [fileManager createDirectoryAtPath:FilePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        if ([fileManager fileExistsAtPath:sProjectVideoFilePath]) {
            DLog(@"有文件");
            NSDictionary * dict1 = [fileManager attributesOfItemAtPath:sProjectVideoFilePath error:nil];
            //方法一:
            
//            [fileManager removeItemAtPath:sProjectVideoFilePath error:nil];
            
            DLog(@" %d,第2次我想要的视频size = %lld",[fileManager fileExistsAtPath:sProjectVideoFilePath],[dict1 fileSize]/(1024*1024));
            
        }
        
//        if ([fileManager fileExistsAtPath:stringpath]) {
//           
//            
//            
//            
//            DLog(@"存在＝＝＝");
//            
//            
//        }
        
        
        
       [self myuploadButtonOnClick];
        //设置下载数据到res字典对象中并用代理返回下载数据NSData
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [_alertViewWithProgressbar hide];
        
//        [progressView removeFromSuperview];
        DLog(@"视频下载失败");
        [self showAlertView:@"网络出错！"];
    }];
    
    [operation start];
    
    
    
    
    
}//下载路径


-(void)settxt:(NSString *)str andtag:(NSInteger )tag andpress:(float)flo
{
    
    
      [dyt_tablewview changeview:tag-99 andtext:str andgress:flo];

    

}


-(void)stopaf:(NSInteger)tag
{
    
  _number--;
    if (_number==0) {
        dyt_tablewview.data  = nil;
        [dyt_tablewview removeFromSuperview];
        [mengbanview removeFromSuperview];
    }
    
}

-(void)adduser:(NSString *)xmlfilePath
{

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
    
    DLog(@"本地数组=====%@",_yunsi);
    //
    NSDictionary *dic = _yunsi[0];
    
    NSArray *arr = dic[@"myproject"];
    
    
    NSMutableArray *nextarr = [NSMutableArray arrayWithArray:arr];
    
    
    
    DLog(@"文件======%@",[xmlfilePath lastPathComponent]);
    NSString *onestr = [xmlfilePath lastPathComponent];
    //        新数组
    [nextarr addObject:onestr];
    
    NSMutableDictionary *mydic = [[NSMutableDictionary alloc]init];
    [mydic setObject:[Config DPLocalizedString:@"adedit_Notgrouped"] forKey:@"name"];
    [mydic setObject:nextarr forKey:@"myproject"];
    
    [_yunsi replaceObjectAtIndex:0 withObject:mydic];
    
    [mysqlarray removeObjectForKey:@"mysqlprojects"];
    
    [mysqlarray setObject:_yunsi forKey:@"mysqlprojects"];
    
    DLog(@"最新本地woyaode======%@",_yunsi);
    
    

    
    

}


/**
 *@brief 项目存放文件夹的路径
 */
-(NSString *)customeProjectDirPathWith:(NSString *)dirName{
    NSString *sProjectDirPath = [[NSString alloc]initWithFormat:@"%@/%@",[LayoutYXMViewController defaultProjectRootPath],dirName];
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
    
//    NSString *sXMLFilePath = [[NSString alloc]initWithFormat:@"%@/%@/%@.xml",[LayoutYXMViewController defaultProjectRootPath],sProjectDir,sProjectDir];
    
    NSArray *array = [sProjectDir componentsSeparatedByString:@"."];
    
    
    NSString *string = array[0];
    
    
    NSString *sXMLFilePath = [[NSString alloc]initWithFormat:@"%@/%@/%@.xml",[LayoutYXMViewController defaultProjectRootPath],string,string];
    NSString *file = [[NSString alloc]initWithFormat:@"%@/%@/",[LayoutYXMViewController defaultProjectRootPath],string];
    
    DLog(@"xml 路径=====%@",sXMLFilePath);
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:file]) {
        
        [fileMgr createFileAtPath:file contents:nil attributes:nil];
    }
    return sXMLFilePath;
}

/**
 *@brief 项目的video文件的路径
 */
-(NSString *)customeVideoFilePathWithProjectDir:(NSString *)sProjectDir videoType:(NSString *)string  andpath:(NSString *)stringpath {
  
    DLog(@"=====%@   %@",stringpath,string);
    //    NSString *str = [string lastPathComponent];
    
    
    NSString *sVideoFilePath = [[NSString alloc]initWithFormat:@"%@/%@",stringpath,string];
    
    DLog(@"反馈路径----====%@",sVideoFilePath);
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:stringpath]) {
        [fileMgr createFileAtPath:stringpath contents:nil attributes:nil];
    }
    return sVideoFilePath;
}



#pragma mark-段头的所有代理
//展开
- (void)clickHeadView:(NSInteger)tag
{
    
//    deleGroupButton.hidden = NO;
    
    if (tag<2000) {
        [_dataTableview reloadData];
    }else
    {
        [_localTableview reloadData];
    
    }
    
}

// 选择框
-(void)chooseview:(NSInteger)tag andchoose:(BOOL)chex
{
    
    if (tag<2000) {
        //    HeadView *head = (HeadView *)[self.view viewWithTag:tag];
        Group *gg = _groupData[tag-1000];
        gg.qcheck = chex;
        
        for (int i=0; i<_groupData.count; i++) {
            Group *grop = _groupData[i];
             deleGroupButton.hidden = YES;
            if (grop.qcheck==YES) {
                deleGroupButton.hidden = NO;
                return;
            }
            
            
        }

    }
    else
    {
    
        

        
        
        
        
        
        
        
    
    }
    
    
    
    
    
    
}



//多个下载  段头的点击事件
-(void)downloadview:(NSInteger)tag
{
    
    
    Group *goup = _groupData[tag-1000];

    
//    _alertViewWithProgressbar = [[AGAlertViewWithProgressbar alloc] initWithTitle:nil message:@"请稍等..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    [_alertViewWithProgressbar show];
    
    
    [self setmengban];
    
    _number = goup.Materials.count;
    
    
    NSMutableArray *title = [[NSMutableArray alloc]init];
    for (int i=0; i<goup.Materials.count; i++) {
        Project *project = goup.Materials[i];
        
        [title addObject:project.Material_Name];
    }
    DLog(@"====%@",title);
    dyt_tablewview  = [[DYT_progresstableview alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 300)];
    
    dyt_tablewview.data = title;
    [mengbanview addSubview:dyt_tablewview];
    
//    多下载
    for (int i=0; i<goup.Materials.count; i++) {
        Project *project = goup.Materials[i];
        
        [self downRequestMovPath:project.Video_url movName:project.VideoName xmlPath:project.Xml_url xmlName:project.XmlName andcount:100+i];
        
    }
    
    
    

}


//上传  界面  多传
-(void)uploadview:(NSInteger)tag
{
//  点击上传  加载上传界面
    if (tag<2000) {
        
             Group *gg = _groupData[tag-1000];
        [self setlocaldata];
        cloudview.hidden = YES;
        
        xmltabview.hidden = YES;
        locaxmltable.hidden = NO;
        [self lookloacxml];
        
//        加载本地的项目列表
        [self  setLocaltableview];
        backbutton.hidden = NO;
        [savexmlbut setTitle:@"本地xml" forState:UIControlStateNormal];
        mygroupid = gg.ID;
        DLog(@"====%@",mygroupid);

    }else
    {
    //        进行 多个上传
        
        
        [self upmoreobc:tag];
        
    
    }
    
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {
        
        
        if (editingStyle==UITableViewCellEditingStyleDelete) {
            //        获取选中删除行索引值
            
            NSLog(@"已经删除");
            Group *group = _groupData[indexPath.section];
            Project *project = group.Materials[indexPath.row];
            
            NSLog(@"%@",project.ID);
            
            NSMutableDictionary *params = [@{@"ID":project.ID}mutableCopy];
            
            [ForumWXDataServer requestURL:@"Ledad/Ledad_MaterialIsShowUP_api.aspx"
                               httpMethod:@"GET"
                                   params:params
                                     file:nil
                                  success:^(id data){
                                      
                                      NSLog(@"%@",data);
                                      NSString *mes = data[@"msg"];
                                      
                                      if ([mes isEqualToString:@"0"]) {
                                          
                                          [self loadData];
                                          
                                          [self showAlertView:@"删除成功！"];
                                          
                                          
                                      }else{
                                          
                                          [self showAlertView:@"删除失败"];
                                          [_dataTableview reloadData];
                                          
                                      }
                                      
                                  } fail:^(NSError *error){
                                      
                                      NSLog(@"%@",error);
                                      
                                      [self showAlertView:@"网络错误"];
                                      
                                  }];
            
            
            //        [_dataTableview reloadData];
        }
        
        
    }else{
        
        [self showAlertView:@"本地项目不可删除！"];
        
    }
    
}



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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *@brief 解析素材数据字典为素材对象字典
 */
-(void)analysisDataToMaterialObjectWith:(NSDictionary *)oneListItemDict androotpath:(NSString *)_currentProjectPathRoot andwaitarray:(NSMutableArray *)_waitForUploadFilesArray{
    
    NSString *materialFilePath = [[NSString alloc]initWithFormat:@"%@/%@",[_currentProjectPathRoot lastPathComponent],[oneListItemDict objectForKey:@"filename"]];
    NSString *playFilePath = [[NSString alloc]initWithFormat:@"%@/%@",[LayoutYXMViewController defaultProjectRootPath],materialFilePath];
    
    DLog(@"_waitForUploadFilesArray add %@",playFilePath);
    
    NSString *filename = [oneListItemDict objectForKey:@"filename"];
    [_waitForUploadFilesArray addObject:playFilePath];
    [_waitForUploadFilesArray addObject:filename];
}


/**
 *  获取或者创建分组xml文件所在的路径
 *
 *  @return 分组xml文件所在的路径
 */
-(NSString*)documentGroupXMLDir:(NSString *)nametime
{
    
    
//    NSFileManager *myFileManager = [NSFileManager defaultManager];
//    NSString *documentsGroupXMLDir = [[NSString alloc]initWithFormat:@"%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/GroupXMLDir"]];
//    BOOL isDir;
//    if (![myFileManager fileExistsAtPath:documentsGroupXMLDir isDirectory:&isDir]) {
//        [myFileManager createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/GroupXMLDir"] withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    return documentsGroupXMLDir;
    
    NSFileManager *myFileManager = [NSFileManager defaultManager];
    //   NSString *documentsGroupXMLDir = [[[[[[NSString stringWithFormat:@"%@",[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/ProjectCaches/%@",nametime]]]];
    
    NSString *documentsGroupXMLDir = [NSString stringWithFormat:@"%@",[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/ProjectCaches/%@",nametime]]];
    
    BOOL isDir;
    if (![myFileManager fileExistsAtPath:documentsGroupXMLDir isDirectory:&isDir]) {
        [myFileManager createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/ProjectCaches/%@",nametime]] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentsGroupXMLDir;

    
    
    
    
}


//上传文件
-(void)uploadRequstMovPath:(NSString *)movPath movName:(NSString *)movName xmlPath:(NSString *)xmlPath xmlName:(NSString *)xmlName Material:(NSString *)materialName
{
    
    
   __block long long zsize = 0;
    
    //    NSData *data = [NSData dataWithContentsOfFile:movPath];
    
    
    
    NSArray *array = [[NSArray alloc]initWithObjects:xmlPath, movPath,nil];
    
    NSString *str1 = [NSString stringWithFormat:@"http://www.ledmediasz.com/Ledad/FileUpload/%@",[movPath lastPathComponent]];
    NSString *str2 = [NSString stringWithFormat:@"http://www.ledmediasz.com/Ledad/FileUpload/%@",[xmlPath lastPathComponent]];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         mygroupid,@"GroupingID",
                         materialName,@"Material_Name",
                         str1,@"Video_url",
                         str2,@"Xml_url",
                         movName,@"VideoName",
                         xmlName,@"XmlName",
                         @"",@"Note",
                         nil];

//    _alertViewWithProgressbar = [[AGAlertViewWithProgressbar alloc] initWithTitle:nil message:@"请稍等..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    [_alertViewWithProgressbar show];

    
    
//    上传文件 路径 和素材
    ASIFormDataRequest *request_xml=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://www.ledmediasz.com/Ledad/Handler/UploadFiles.ashx"]];
    
    [request_xml setRequestMethod:@"POST"];
    [request_xml setTimeOutSeconds:60];
    [request_xml setFile:xmlPath forKey:@"Filedata"];
    request_xml.tag = 2;
    [request_xml setDelegate:self];
    [request_xml startAsynchronous];
    
//    [request_xml setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
//       
//          DLog(@"第一个=====%lld    %lld",size,total);
//        
//    }];
    
//
    
    
    //上传文件 素材
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://www.ledmediasz.com/Ledad/Handler/UploadFiles.ashx"]];
    //    UIProgressView *pro = [[UIProgressView alloc]init];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:60];
    request.mydic = dic;
//    [request addFilearray:array forKey:@"Filedata"];
    [request setFile:movPath forKey:@"Filedata"];
    request.tag = 1;

   [request setUploadProgressDelegate:self];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    [request setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
        
        zsize += size;
        DLog(@"????=====%lld    %lld",zsize,total);
    }];
    
    
}//上传路径

- (void)setProgress:(float)newProgress;
{
    
 
    
    
}

//- (void)setProgress:(float)newProgress;
//{
//
//    DLog(@"=====%d",newProgress);
//    
//}


#pragma mark-asi
- (void)request:(ASIHTTPRequest *)request didSendBytes:(long long)bytes;
{
//    if (request.tag==1) {
//        
//        DLog(@"这======%lld",bytes);
//    }

}

// Called when we get a content-length header and shouldResetDownloadProgress is true
- (void)incrementDownloadSizeBy:(long long)length;
{
    
    
//    DLog(@"这======%lld",length);
}

    


// Called when a request starts and shouldResetUploadProgress is true
// Also called (with a negative length) to remove the size of the underlying buffer used for uploading


-(void)request:(ASIHTTPRequest *)request incrementUploadSizeBy:(long long)newLength
{
//    if (request.tag==1) {
//        DLog(@"长度＝＝%d＝＝＝%lld",request.tag,newLength);
//    }


}

//上传到云端
- (void)requestFinished:(ASIHTTPRequest *)request{
    DLog(@"requesttag====%ld",request.tag);
    if (request.tag == 1) {
        

        //        NSDictionary *dict = request.responseString;
        //        NSLog(@"%@",data);
        //    NSString *mes = [dict objectForKey:@"msg"];
        
        if ([request.responseString isEqualToString:@"0"]) {
            [_alertViewWithProgressbar hide];
            
            
            [NSThread sleepForTimeInterval:1];
            
            [self showAlertView:@"上传视频成功"];

            
            DLog("??????????......==%@",request.mydic);
            
            //请求参数
            NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:request.mydic];
            
            [progressview removeFromSuperview];
            
            [ForumWXDataServer POSTrequestURL:@"Ledad/Ledad_MaterialAdd_api.aspx" params:params success:^(id data) {
                
                
              

                DLog(@"===data＝＝＝%@",data);
                if ([data[@"msg"] isEqualToString:@"0"]) {
                    
                    [self showAlertView:[Config DPLocalizedString:@"adedit_zc21"]];
                    
                }else if([data[@"msg"] isEqualToString:@"2"])
                {
                    
                 [self showAlertView:data[[Config DPLocalizedString:@"adedit_zc22"]]];
                    
                }
                

            } fail:^(NSError *error) {
                DLog(@"===%@",error);
                
                [_alertViewWithProgressbar hide];

            }];
            
//            ASIFormDataRequest *requestnext = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://www.ledmediasz.com/Ledad/Ledad_MaterialAdd_api.aspx"]];
//            //构造请求头
//            [requestnext addRequestHeader:@"Content-Type" value:@"Application/Json"];
//            [requestnext addRequestHeader:@"charset" value:@"utf-8"];
//            requestnext.delegate = self;
//            requestnext.tag = 3;
//            [requestnext setRequestMethod:@"POST"];
//
//            DLog(@"======%@",request.mydic);
//            
//            if ([NSJSONSerialization isValidJSONObject:request.mydic])
//            {
//                
//                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:request.mydic options:NSJSONWritingPrettyPrinted error: nil];
//                
//                NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
//                
//                [requestnext setPostBody:tempJsonData];
//                [requestnext startAsynchronous];
//                
//            }

            
            
        }else {
            
            [self showAlertView:[Config DPLocalizedString:@"adedit_zc23"]];
            
        }
        
    }else if(request.tag==2)
        
    {
        
        DLog(@"fankuishuju===%@",request.responseString);
        
        NSString *jsonString = [request responseString];
        
     NSDictionary  * itemsDataDictionary = [jsonString JSONValue];

        DLog(@"解析的网络数据====%@",itemsDataDictionary);
        
        
        if ([itemsDataDictionary[@"msg"] isEqualToString:@"0"]) {
            
            [self showAlertView:[Config DPLocalizedString:@"adedit_zc34"]];
            
        }else {
            
            [self showAlertView:[Config DPLocalizedString:@"adedit_zc24"]];
            
        }
        
    }else if(request.tag==3)
    {
    
        
        DLog(@"=====%@",request.responseString);
        
    
    }
    
    
}



- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"%@   ====%ld",request.error,request.tag);
    
     [_alertViewWithProgressbar hide];
    [progressview removeFromSuperview];
    [self showAlertView:[Config DPLocalizedString:@"NSString25"]];
    
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
//- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
//    if (jsonString == nil) {
//        return nil;
//    }
//
//    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
//    if(err) {
//        NSLog(@"json解析失败：%@",err);
//        return nil;
//    }
//    return dic;
//}




//上传到云端

- (void)upload:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType data:(NSData *)data parmas:(NSDictionary *)params
{
    // 文件上传
    NSURL *url = [NSURL URLWithString:@"http://www.ledmediasz.com/Ledad/FileUpload"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 设置请求体
    NSMutableData *body = [NSMutableData data];
    
    /***************文件参数***************/
    // 参数开始的标志
    [body appendData:YYEncode(@"--YY\r\n")];
    // name : 指定参数名(必须跟服务器端保持一致)
    // filename : 文件名
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filename];
    [body appendData:YYEncode(disposition)];
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType];
    [body appendData:YYEncode(type)];
    
    [body appendData:YYEncode(@"\r\n")];
    [body appendData:data];
    [body appendData:YYEncode(@"\r\n")];
    
    /***************普通参数***************/
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 参数开始的标志
        [body appendData:YYEncode(@"--YY\r\n")];
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
        [body appendData:YYEncode(disposition)];
        
        [body appendData:YYEncode(@"\r\n")];
        [body appendData:YYEncode(obj)];
        [body appendData:YYEncode(@"\r\n")];
    }];
    
    /***************参数结束***************/
    // YY--\r\n
    [body appendData:YYEncode(@"--YY--\r\n")];
    request.HTTPBody = body;
    
    // 设置请求头
    // 请求体的长度
    [request setValue:[NSString stringWithFormat:@"%zd", body.length] forHTTPHeaderField:@"Content-Length"];
    // 声明这个POST请求是个文件上传
    [request setValue:@"multipart/form-data; boundary=YY" forHTTPHeaderField:@"Content-Type"];
    
    // 发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@", dict);
        } else {
            NSLog(@"上传失败");
            
            NSLog(@"%@",connectionError);
            
        }
    }];
}



//判断我要的东西 获取素材

-(ProjectListObject *)findmyproject:(NSString *)mypath
{
    
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/"];
    filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
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

//当前时间字符串
-(NSString *)getNowdateString{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    return [formatter stringFromDate:[NSDate date]];
}

-(void)setmengban
{

    mengbanview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mengbanview.alpha = 0.8;
    mengbanview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mengbanview];
    

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
