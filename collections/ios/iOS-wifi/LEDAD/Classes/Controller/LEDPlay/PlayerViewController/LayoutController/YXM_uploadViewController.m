//
//  YXM_uploadViewController.m
//  LEDAD
//
//  Created by 安静。 on 15/7/6.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "YXM_uploadViewController.h"
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
#import "DYT_progresstableview.h"
#import "NSString+MD5.h"
#import "Config.h"
 #define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@interface YXM_uploadViewController ()<HeadViewDelegate,NSXMLParserDelegate,ASIHTTPRequestDelegate>
{
    NSArray *_groupData;
    
    UILabel *_locallabtabel;
    //当前播放项目名字
    NSString *_currentPlayProjectName;
    NSString *_currentPlayProjectFilename;
    NSString *_currentProjectPathRoot;
    NSArray *filenameArray;
    
    NSMutableArray *_waitForUploadFilesArray;
    
    DYT_progresstableview *dyt_tablewview;
    
    //上传成功后需要给服务器提交的参数
    NSString *_videoName;
    
    NSString *_xmlName;

    NSString *_Material_Name;
    
    NSString *_Video_url;
    
    NSString *_Xml_url;
    
    
    //    删除按钮
    UIButton *deleGroupButton;
    NSInteger _number;
    NSMutableArray *dytarray;

    //    分组id
    NSString *mygroupid;

    
}

@property (nonatomic,strong) NSMutableArray *assets;
@property (nonatomic,strong) NSMutableArray *xmlArr;
@end

@implementation YXM_uploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initButton];
    
    dytarray = [[NSMutableArray alloc]init];
    
    _assets = [[NSMutableArray alloc]init];
    
    _waitForUploadFilesArray = [[NSMutableArray alloc]init];
    
    UILabel *_datalabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 110, 100, 30)];
    
    _datalabel.text = @"云端项目:";
    
    _dataTableview = [[UITableView alloc]initWithFrame:CGRectMake(40, 160, 320, 400) style:UITableViewStylePlain];
    _dataTableview.tableFooterView = [[UIView alloc]init];
    
    _dataTableview.tag = 1;
    
    _dataTableview.sectionHeaderHeight = 40;
    
    _dataTableview.dataSource = self;
    _dataTableview.delegate = self;
    
    [self.view addSubview:_datalabel];
    [self.view addSubview:_dataTableview];
    
    _locallabtabel = [[UILabel alloc]initWithFrame:CGRectMake(500, 110, 100, 30)
                      ];
    
    _locallabtabel.text = @"本地项目:";
    
    _localTableview = [[UITableView alloc]initWithFrame:CGRectMake(500, 160, 320, 400)];
    _localTableview.tag = 2;
    _localTableview.tableFooterView = [[UIView alloc]init];

    _locallabtabel.hidden = YES;
    _localTableview.delegate = self;
    _localTableview.dataSource = self;
    
    _localTableview.hidden = YES;
    [self.view addSubview:_locallabtabel];
    [self.view addSubview:_localTableview];
    [self loadData];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
}

#pragma mark 加载数据
- (void)loadData
{
    
    __block  NSArray *tempArray = [[NSArray alloc]init];
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *userID = [ud objectForKey:@"userID"];
    
    [ud synchronize];
    
    NSMutableDictionary *params = [@{@"UserID": userID}mutableCopy];
    
    [ForumWXDataServer requestURL:@"Ledad/Ledad_GroupingList_api.aspx"
                  httpMethod:@"GET"
                      params:params
                        file:nil
                     success:^(id data){
                         
                         
                         
                         tempArray = data[@"Groupings"];
                         
                         
                         NSLog(@"%@",data);
                         
                         NSMutableArray *fgArray = [NSMutableArray array];
                         for (NSDictionary *dict in tempArray) {
                             Group *group = [Group projectGroupWithDict:dict];
                             [fgArray addObject:group];
                         }
                         
                         _groupData = fgArray;
                         
                         [self.dataTableview reloadData];
                     } fail:^(NSError *error){
                         
                         
                         NSLog(@"%@",error);
                         
                         
                     }];
    
    
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"friends.plist" withExtension:nil];
    //    NSArray *tempArray = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *fgArray = [NSMutableArray array];
    for (NSDictionary *dict in tempArray) {
        Group *group = [Group projectGroupWithDict:dict];
        [fgArray addObject:group];
    }
    
    _groupData = fgArray;
}



-(void)initButton{
    
    //上传
    UIButton *uploadButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 60, 90, 40)];
    uploadButton.backgroundColor = [UIColor grayColor];
    [uploadButton setTitle:[Config DPLocalizedString:@"adedit_uploadproject"] forState:0];
    [uploadButton addTarget:self action:@selector(uploadButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uploadButton];

    
    
    //注销
    UIButton *logOutButton = [[UIButton alloc]initWithFrame:CGRectMake(uploadButton.right + 60, 60, 90, 40)];
    logOutButton.backgroundColor = [UIColor grayColor];
    [logOutButton setTitle:@"注销" forState:0];
    [logOutButton addTarget:self action:@selector(logoutButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logOutButton];
    
//    新建分组
    UIButton *newGroupButton = [[UIButton alloc]initWithFrame:CGRectMake(logOutButton.right + 60, 60, 90, 40)];
    newGroupButton.backgroundColor = [UIColor grayColor];
    [newGroupButton setTitle:[Config DPLocalizedString:@"newgroup"] forState:0];
    [newGroupButton addTarget:self action:@selector(newGroupButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newGroupButton];
    
//
    deleGroupButton = [[UIButton alloc]initWithFrame:CGRectMake(newGroupButton.frame.size.width+newGroupButton.frame.origin.x, newGroupButton.frame.origin.y, newGroupButton.frame.size.width, newGroupButton.frame.size.height)];
    deleGroupButton.backgroundColor = [UIColor grayColor];
    [deleGroupButton setTitle:@"删除组" forState:0];
    [deleGroupButton addTarget:self action:@selector(deleGroupButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleGroupButton];
    deleGroupButton.hidden = YES;

    
    
    
    
}

//点击上传实现方法
-(void)uploadButtonOnClick{
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
        
        _xmlArr=[[NSMutableArray alloc]init];
        for (int i = 0; i<count; i++) {
            [_xmlArr addObject:[NSString stringWithFormat:@"%@",[[filenameArray objectAtIndex:i] lastPathComponent]]];
            
            if ([filenameArray objectAtIndex:i]) {
                if ([[[filenameArray objectAtIndex:i] lastPathComponent] isEqualToString:@"playlist.xml"]) {
                    continue;
                }
                
                
                ProjectListObject *myPro = [[ProjectListObject alloc]init];
                [self getProjectNameWithFileName:[filenameArray objectAtIndex:i] andProjectObj:myPro];
                [_assets addObject:myPro];
            }
        }
        
        NSLog(@"%@",_assets);
        
        [_localTableview reloadData];
        DLog(@"本地的xml========>%@",_xmlArr);
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
                DLog(@"****________________****%@",projectName);
                
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

    
    self.stAlertView = [[STAlertView alloc] initWithTitle:@"新建组"
                                                  message:@"请您新建一个组."
                                            textFieldHint:@"请输入新建组的名字"
                                           textFieldValue:nil
                                        cancelButtonTitle:@"关闭"
                                        otherButtonTitles:@"提交"
                        
                                        cancelButtonBlock:^{

                                        
                                        } otherButtonBlock:^(NSString * result){

                                            [self newGroupRequst:result];
                                            
                                        
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



#pragma table delegate 单元格

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 1) {
        return _groupData.count;

    }else{
        
     return dytarray.count;
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        
        Group *group = _groupData[section];
        NSInteger count = group.isOpened ? group.Materials.count : 0;
        return count;
    }else{
        
        Group *group = dytarray[section];
        NSInteger count = group.isOpened ? group.Materials.count : 0;
        return count;
        
        
        
    }
    
        
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView.tag == 1) {
        
        
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
        
        
    }else{
        
        
        
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
    }else
    {
        
        HeadView *headView = [HeadView headViewWithTableView:tableView];
        Group *gg = dytarray[section];
        headView.delegate = self;
        headView.mytag = 2000+section;
        headView.qchek = gg.qcheck;
        headView.group = gg;
        
        return headView;
        
        
    }
    
    
    
}



#pragma mark-段头的代理
- (void)clickHeadView:(NSInteger)tag
{
    
    if (tag<2000) {
        [_dataTableview reloadData];
    }else
    {
        [_localTableview reloadData];
        
    }
    
    
    
}

//多穿
-(void)upmoreobc:(NSInteger )tag
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网速不好，请依次上传" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    
    //    DLog(@"===%ld",tag-2000);
    //    Group *grop = _groupData[tag-2000];
    //
    //    NSMutableArray *array = [[NSMutableArray alloc]init];
    //    for (int i=0; i<grop.Materials.count; i++) {
    //         Project *project = grop.Materials[i];
    //        [array addObject:project.Material_Name];
    //    }
    //    upnumber = array.count;
    //    dyt_tablewview  = [[DYT_progresstableview alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 300)];
    //
    //    dyt_tablewview.data = array;
    //    [self.view addSubview:dyt_tablewview];
    
    
    
    
    
    
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

    

}
//上传  界面  多传
-(void)uploadview:(NSInteger)tag
{
    //  点击上传  加载上传界面
    if (tag<2000) {
        Group *gg = _groupData[tag-1000];
//        [self setlocaldata];
//        cloudview.hidden = YES;
        //        加载本地的项目列表
//        [self  setLocaltableview];
//        backbutton.hidden = NO;
        
        mygroupid = gg.ID;
        DLog(@"====%@",mygroupid);
        
    }else
    {
        //        进行 多个上传
        
        
        [self upmoreobc:tag];
        
        
    }
    
}

#pragma mark-

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



//点击云素材 下载 到本地  单个上传
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
    _number = 1;
    dyt_tablewview  = [[DYT_progresstableview alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 300)];
    
    dyt_tablewview.data = [[NSArray alloc]initWithObjects:project.Material_Name, nil];
    [self.view addSubview:dyt_tablewview];
    
    
    
    
    [self downRequestMovPath:project.Video_url movName:project.VideoName xmlPath:project.Xml_url xmlName:project.XmlName andcount:100];
    
    
    
    
    
    
    
}



//下载云端到本地素材
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
    
    
    
    DLog(@" %d,第一次我想要的视频size== %@",[fileManager fileExistsAtPath:sProjectVideoFilePath],dict1);
    
    
    
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
                
                
                DLog(@"写入成功！xml");
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
           [self stopaf:count];
        [self showAlertView:@"网络出错！"];
    }];
    
    [operation start];
    
    
    
    
    
}//下载路径







- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1) {

//    Group *group = _groupData[indexPath.section];
//    Project *project = group.Materials[indexPath.row];
//    
//    NSLog(@"video路径：%@ , XML路径：%@",project.Video_url,project.Xml_url);
//        
//        [self downRequestMovPath:project.Video_url movName:project.VideoName xmlPath:project.Xml_url xmlName:project.XmlName];
//        
        
        
        
        
        
    }else{
    
        [_waitForUploadFilesArray removeAllObjects];
        
       ProjectListObject *myPro  = [_assets objectAtIndex:indexPath.row];
        _currentPlayProjectFilename = myPro.project_filename;
        _currentPlayProjectName = myPro.project_name;
        _Material_Name = myPro.project_name;
        NSString *projectFileLastString =  [_currentPlayProjectFilename lastPathComponent];
        _currentProjectPathRoot = [[NSString alloc]initWithFormat:@"%@",[_currentPlayProjectFilename stringByReplacingOccurrencesOfString:projectFileLastString withString:@""]];
        
        //缓存文件夹的路径
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithXMLFile:myPro.project_filename]];
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithDictionary:dataDictionary];
        [tempDictionary removeObjectForKey:@"projectName"];
        
        NSArray *materiallistArray = [tempDictionary objectForKey:@"materialListElement"];
        
        NSLog(@"11111111 %@",materiallistArray);
        
//                    NSString *oneMaterialListElementOfKey = [oneMaterialListElement objectForKey:@"key"];
//                    NSMutableArray *tempObjectArray =  [[NSMutableArray alloc]init];
//                    NSDictionary *listItemArray = [materiallistArray objectAtIndex:1];
//                    if (listItemArray) {
////                        if ([listItemArray isKindOfClass:[NSArray class]]) {
//                            for (NSDictionary *oneListItemDict in listItemArray) {
//                                [tempObjectArray addObject:[self analysisDataToMaterialObjectWith:oneListItemDict]];
//                            }
//                        
//                        }
        
        if (materiallistArray) {
            if ([materiallistArray isKindOfClass:[NSArray class]]) {
                for (NSDictionary *oneMaterialListElement in materiallistArray) {
                    NSArray *listItemArray = [oneMaterialListElement objectForKey:@"listItemElement"];
                    if (listItemArray) {
                        if ([listItemArray isKindOfClass:[NSArray class]]) {
                            for (NSDictionary *oneListItemDict in listItemArray) {
                                [self analysisDataToMaterialObjectWith:oneListItemDict];
                            }
                        }else{
                            [self analysisDataToMaterialObjectWith:[oneMaterialListElement objectForKey:@"listItemElement"]];
                        }
                    }
                }
            }else{
                NSDictionary *oneMaterialListElement = [tempDictionary objectForKey:@"materialListElement"];
                NSArray *listItemArray = [oneMaterialListElement objectForKey:@"listItemElement"];
                if (listItemArray) {
                    if ([listItemArray isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *oneListItemDict in listItemArray) {
                            [self analysisDataToMaterialObjectWith:oneListItemDict];
                        }
                    }else{
                      [self analysisDataToMaterialObjectWith:[oneMaterialListElement objectForKey:@"listItemElement"]];
                    }
                }
            }
        }
        

        
        NSString *movPath = [_waitForUploadFilesArray firstObject];
        NSString *movName = [_waitForUploadFilesArray lastObject];
        NSString *xmlPath = [filenameArray objectAtIndex:indexPath.row];
        NSString *xmlName = [_xmlArr objectAtIndex:indexPath.row];
        NSLog(@"电影路径：%@,XML路径：%@,电影名字：%@,XML名字%@",movPath,xmlPath,movName,xmlName);

        [self uploadRequstMovPath:movPath movName:movName xmlPath:xmlPath xmlName:xmlName];
    }
    //点击下载项目从云到本地
    
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









-(NSString *)_jiequzifu:(NSString *)string{
    NSArray *strArray = [string componentsSeparatedByString:@"."];
    NSString *str = [strArray firstObject];

    return str;
}










/**
 *@brief 项目的XML文件的路径
 */
-(NSString *)customeXMLFilePathWithProjectDir:(NSString *)sProjectDir{
   
    NSString *str = [self _jiequzifu:sProjectDir];
    
    NSString *sXMLFilePath = [[NSString alloc]initWithFormat:@"%@/%@/%@",[LayoutYXMViewController defaultProjectRootPath],str,sProjectDir];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:sXMLFilePath]) {
        [fileMgr createFileAtPath:sXMLFilePath contents:nil attributes:nil];
    }
    return sXMLFilePath;
}






/**
 *@brief 项目的video文件的路径
 */
-(NSString *)customeVideoFilePathWithProjectDir:(NSString *)sProjectDir videoType:(NSString *)string{
    
//    NSString *str = [string lastPathComponent];
    NSString *str = [self _jiequzifu:sProjectDir];

    NSString *sVideoFilePath = [[NSString alloc]initWithFormat:@"%@/%@/%@",[LayoutYXMViewController defaultProjectRootPath],str,string];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:sVideoFilePath]) {
        [fileMgr createFileAtPath:sVideoFilePath contents:nil attributes:nil];
    }
    return sVideoFilePath;
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
-(void)analysisDataToMaterialObjectWith:(NSDictionary *)oneListItemDict{
    
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
-(NSString*)documentGroupXMLDir{
    NSFileManager *myFileManager = [NSFileManager defaultManager];
    NSString *documentsGroupXMLDir = [[NSString alloc]initWithFormat:@"%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/GroupXMLDir"]];
    BOOL isDir;
    if (![myFileManager fileExistsAtPath:documentsGroupXMLDir isDirectory:&isDir]) {
        [myFileManager createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/GroupXMLDir"] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentsGroupXMLDir;
}

-(void)uploadRequstMovPath:(NSString *)movPath movName:(NSString *)movName xmlPath:(NSString *)xmlPath xmlName:(NSString *)xmlName
{
    _Video_url = nil;
    
    _Xml_url = nil;
    
    _Video_url = [NSString stringWithFormat:@"http://www.ledmediasz.com/Ledad/FileUpload/%@",movName];
    
    _Xml_url = [NSString stringWithFormat:@"http://www.ledmediasz.com/Ledad/FileUpload/%@",xmlName];
    
    
//    NSData *data = [NSData dataWithContentsOfFile:movPath];
    
    _alertViewWithProgressbar = [[AGAlertViewWithProgressbar alloc] initWithTitle:nil message:@"正在上传,请稍等..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];

    [_alertViewWithProgressbar show];
    
    //上传文件
    ASIFormDataRequest *request_xml=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://www.ledmediasz.com/Ledad/Handler/UploadFiles.ashx"]];
    
    [request_xml setRequestMethod:@"POST"];
    [request_xml setTimeOutSeconds:60];
    [request_xml setFile:xmlPath forKey:@"Filedata"];
    request_xml.tag = 2;
    [request_xml setDelegate:self];
    [request_xml startAsynchronous];
 
    
    
    //上传文件
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://www.ledmediasz.com/Ledad/Handler/UploadFiles.ashx"]];
//    UIProgressView *pro = [[UIProgressView alloc]init];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:60];

    
    [request setFile:movPath forKey:@"Filedata"];
    request.tag = 1;
    [request setDelegate:self];
    [request startAsynchronous];
//    NSLog(@"max: %f ",[pro progress]);
    
    
    _videoName =  movName;
    
    _xmlName = xmlName;
    
    
    
}//上传路径






- (void)requestFinished:(ASIHTTPRequest *)request{
    
    if (request.tag == 1) {
    
    
//        NSDictionary *dict = request.responseString;
        //        NSLog(@"%@",data);
//    NSString *mes = [dict objectForKey:@"msg"];
    
        if ([request.responseString isEqualToString:@"0"]) {
            
            [_alertViewWithProgressbar hide];
//            [self showAlertView:@"上传video成功"];
            
            
            NSString *video_name = [self _jiequzifu:_videoName];
            
            NSString *xml_name = [self _jiequzifu:_xmlName];
            
            NSMutableDictionary *params = [@{@"GroupingID":@"1",
                                             @"Material_Name":_Material_Name,
                                             @"Video_url":_Video_url,
                                             @"Xml_url":_Xml_url,
                                             @"VideoName":video_name,
                                             @"XmlName":xml_name}mutableCopy];
            
            
            [ForumWXDataServer requestURL:@"Ledad/Ledad_MaterialAdd_api.aspx"
                               httpMethod:@"GET"
                                   params:params
                                     file:nil
                                  success:^(id data){
                                  
                                      NSLog(@"%@",data);
                                  
                                      [self showAlertView:@"上传video成功"];

                                  
                                  } fail:^(NSError *error){
                                  
                                  
                                      [self showAlertView:@"网络错误！"];
                                  
                                  
                                  }];
            
            
            
            
        }else {
            
            [self showAlertView:@"上传video失败，请重新上传"];
            
        }
    
    }else {
//        id data = request.responseString;
//        NSDictionary *dict =   [self dictionaryWithJsonString: request.responseString];
        
        if ([request.responseString isEqualToString:@"0"]) {
            
            [self showAlertView:@"上传xml成功"];
            
            
            
            
        }else {
            
            [self showAlertView:@"上传xml失败，请重新上传"];
            
        }
    
    }
    
}



- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"%@",request.error);
    
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
    }
    
}


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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
