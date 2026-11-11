


#define TAG_DURATION_CELL 210010
#define TAG_MUSIC_CELL 810990
#define TAG_BUTTON_OFFSET 1000
/*
 
 段雨田
 
 */
#import "CTAssetsPickerController.h"
#import "MyProjectListViewController.h"
#import "MyPlayListViewController.h"
#import "LayoutYXMViewController.h"
#import "XMLDictionary.h"
#import "Config.h"
#import "GRRequestsManager.h"

#import "dyt_projectgroup.h"
#import "dyt_headview.h"

#define HEADER_HEIGHT 35


@interface MyProjectListViewController () <UINavigationControllerDelegate,GRRequestsManagerDelegate,UIActionSheetDelegate,HeadViewDelegate>
{
    
    
    
    NSInteger num;
    UIAlertView *alert;
    NSInteger NUM;
    NSInteger index;
    BOOL isdown;
    
    dyt_projectgroup *_friendsData;
    
    
    //   总的数组
    NSMutableArray *dytarray;
    
    
    ProjectListObject *duanyutianprojectObj;
    
    BOOL editState;//  能移动就不能删除
    
    
    //    删除的index
    NSIndexPath *deletate;
    
    
    
    // 存储需要删除的组
    
    NSMutableArray *headarray;
    
}

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) GRRequestsManager *requestsManager1;
@property (nonatomic, strong) NSMutableArray *xmlArr;
@property (nonatomic, strong) NSMutableArray *ftpxmlArr;
@property (nonatomic, strong) NSMutableArray *xml_id;
@property (nonatomic, strong) NSMutableArray *jiancefile;
@property (nonatomic, strong) NSMutableArray *ftpProject;



@end



@implementation MyProjectListViewController
@synthesize delegate;
@synthesize itemDurationArray = _itemDurationArray;
@synthesize assets = _assets;
@synthesize isMulitSelected = _isMulitSelected;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isdown = NO;
    
    headarray = [[NSMutableArray alloc]init];
    
    [self startSocket];

    [self _setupManager];

    [self ftpstart];

    _assets = [[NSMutableArray alloc]init];

    _ftpxmlArr = [[NSMutableArray alloc]init];
    
    dytarray = [[NSMutableArray alloc]init];

//首个  分组
    [self setfirstgroup];
    
    //    首次加载view
    [self loadfirstview];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    //    self.editButtonItem.title = @"编辑";
    
    
    eventView = [[UIView alloc]initWithFrame:self.tableView.frame];
    [self.tableView addSubview:eventView];
    //    self.tableView.backgroundColor = [UIColor whiteColor];
    
    //    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [eventView setHidden:YES];
    
    

    
    
}

-(void)setfirstgroup
{

    
    
    
    //保存到数据里面
    NSUserDefaults *mysqlarray = [NSUserDefaults standardUserDefaults];
    
    //只加载一次
    if ([mysqlarray objectForKey:@"first"]) {
        return;
    }
    
    
    NSArray *_numarray = [mysqlarray objectForKey:@"mysqlprojects"];

    NSMutableArray *_yunsi = [[NSMutableArray alloc]initWithArray:_numarray];

    if (_yunsi.count == 0) {

        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:[Config DPLocalizedString:@"adedit_Notgrouped"] forKey:@"name"];
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        [dic setObject:arr forKey:@"myproject"];
        [_yunsi addObject:dic];
        
        
        
        

        NSLog(@"=====%@",_yunsi);
        //
        NSDictionary *dic2 = _yunsi[0];

        NSArray *arr2 = dic2[@"myproject"];


        
        
        
        NSMutableArray *nextarr = [NSMutableArray arrayWithArray:arr2];


        
        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/"];
        NSArray *filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                                    fromDirPath:documentsDirectory AndIsGroupDir:NO];
        
        
        
        
        for (int k=0; k<filenameArray.count; k++) {
            
            NSString *string = [filenameArray[k] lastPathComponent];
            
            [nextarr addObject:string];
        }
        NSInteger count = nextarr.count;
        DLog(@"---%d",count);

//            NSLog(@"woyaode======%@",[xmlfilePath lastPathComponent]);
//            NSString *onestr = [xmlfilePath lastPathComponent];
//                新数组
        

        NSMutableDictionary *mydic = [[NSMutableDictionary alloc]init];
        [mydic setObject:[Config DPLocalizedString:@"adedit_Notgrouped"] forKey:@"name"];
        [mydic setObject:nextarr forKey:@"myproject"];

        [_yunsi replaceObjectAtIndex:0 withObject:mydic];

        
        
        
        NSMutableDictionary *mynextdic = [[NSMutableDictionary alloc]init];
        
        [mynextdic setObject:@"经典分组" forKey:@"name"];
        
        [mynextdic setObject:[[NSArray alloc]init] forKey:@"myproject"];
        
        [_yunsi addObject:mynextdic];
//        [_yunsi replaceObjectAtIndex:1 withObject:mynextdic];
        

        
        
        [mysqlarray removeObjectForKey:@"mysqlprojects"];
        
        
        
        
        
        
        [mysqlarray setObject:_yunsi forKey:@"mysqlprojects"];
        
        NSLog(@"woyaode======%@",_yunsi);
    }
    
    
    [mysqlarray setObject:@"1" forKey:@"first"];
    
    
//       DLog(@"----%@",filenameArray);

    
}




/**
 *   启动ftp服务器获取文件列表
 */
-(void)ftpstart{
    [self.requestsManager1 addRequestForListDirectoryAtPath:@"/"];
    [self.requestsManager1 startProcessingRequests];
}
/**
 *  启动网络连接
 */
-(void)startSocket{
    if (!_sendPlayerSocket) {
        _sendPlayerSocket = [[AsyncSocket alloc] initWithDelegate:self];
    }
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


//得到反馈的xml
-(void)xmlid{
    
    DLog(@"得到xml");
    
    if(_xml_id){
        [_xml_id release];
    }
    
    NSString* a=@"playlist.xml";
    
    _xml_id=[[NSMutableArray alloc]init];
    
    
    
    for (int i=0; i<_xmlArr.count; i++) {
        if ([a isEqualToString:_xmlArr[i]]) {
            [_xmlArr removeObject:a];
        }
    }
    for (NSString *str in _ftpxmlArr) {
        for (int j=0; j<_xmlArr.count; j++) {
            if([str isEqualToString:_xmlArr[j]]){
                [_xml_id addObject:[NSString stringWithFormat:@"%d",j]];
                DLog(@"%@",_xml_id);
            }
            
        }
    }
    
    DLog(@"加入了、、、、、、==%@",_xml_id);
    
    
    
    if (!DEVICE_IS_IPAD) {
        [self clickHeadView];
    }
}
-(void)initdate{
    _jiancefile = [[NSMutableArray alloc]init];
    [_jiancefile addObject:@"cloudtest.txt"];
    [_jiancefile addObject:@"time.txt"];
}

-(void)downjiance{
    num = 0;
    NUM = 0;
    [self showAlertView:@"正在检测"];
    [self jiance];
}


-(void)jiance{
    isdown = NO;
    if (_jiancefile == nil) {
        [self initdate];
    }
    [self _setupManager1];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *FilePath = [documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",_jiancefile[num]]];
    //    [fileManager removeItemAtPath:FilePath error:nil];
    
    [self.requestsManager1 addRequestForDownloadFileAtRemotePath:[NSString stringWithFormat:@"%@",_jiancefile[num]] toLocalPath:FilePath];
    [self.requestsManager1 startProcessingRequests];
    NSLog(@"下载路径===%@",FilePath);
    
    NSArray *files = [fileManager subpathsAtPath: documentsDirectoryPath];
    NSLog(@"111111%@",files);
    //通过文件管理器获取文件属性然后通过字典获取文件长度
    NSFileManager * fm = [NSFileManager defaultManager];
    NSDictionary * dict = [fm attributesOfItemAtPath:FilePath error:nil];
    //方法一:
    
    NSLog(@"22222222size = %lld",[dict fileSize]);
}
-(void)downxiazai{
    
    isdown = YES;
    index = 0;
    [self showAlertView:@"正在扫面云屏上的项目，请稍等"];
    //    [self startSocket];
    [self _setupManager];
    [self ftpstart];
}


//云屏项目
-(void)xiazai{
    
    DLog(@"得到服务器的项目");
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSArray *files1 = [fileManager subpathsAtPath:[NSString stringWithFormat:@"%@/LedProject",documentsDirectoryPath]];
    NSLog(@"%@",files1);
    for (int i = 0; i < files1.count ; i++) {
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/LedProject/%@",documentsDirectoryPath,files1[i]] error:nil];
    }
    NSArray *files2 = [fileManager subpathsAtPath:[NSString stringWithFormat:@"%@/LedProject",documentsDirectoryPath]];
    NSLog(@"%@",files2);
    
    [self LEDproject];
    if (_ftpProject == nil) {
        _ftpProject = [[NSMutableArray alloc]init];
        for (NSString *str in _ftpxmlArr) {
            [_ftpProject addObject:str];
        }
    }
    [self _setupManager];
    
    NSString *FilePath = [documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"LedProject/%@",_ftpProject[index]]];
    //    [fileManager removeItemAtPath:FilePath error:nil];
    [self.requestsManager1 addRequestForDownloadFileAtRemotePath:[NSString stringWithFormat:@"%@",_ftpProject[index]] toLocalPath:FilePath];
    [self.requestsManager1 startProcessingRequests];
    NSLog(@"下载路径===%@",FilePath);
    
    NSArray *files = [fileManager subpathsAtPath: documentsDirectoryPath];
    NSLog(@"%@",files);
    //通过文件管理器获取文件属性然后通过字典获取文件长度
    NSFileManager * fm = [NSFileManager defaultManager];
    NSDictionary * dict = [fm attributesOfItemAtPath:FilePath error:nil];
    //方法一:
    
    NSLog(@"22222222size = %lld",[dict fileSize]);
    
}


//云端ftp文件夹创建
-(void)createfile{
    [self _setupManager];
    [self.requestsManager1 addRequestForDeleteDirectoryAtPath:@"dir/"];
    [self.requestsManager1 startProcessingRequests];
}

//ftp上传
-(void)useFTPSendProject{
    if (!_ftpMgr) {
        //连接ftp服务器
        _ftpMgr = [[YXM_FTPManager alloc]init];
        _ftpMgr.delegate = self;
    }
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* sZipPath =[NSString stringWithFormat:@"%@/%@",DocumentsPath,_jiancefile[NUM]];
    NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://www.ledmediasz.com:10021"];
    [_ftpMgr startUploadFileWithAccount:@"ledmedia" andPassword:@"Q123456az" andUrl:sUploadUrl andFilePath:sZipPath];
    
}


#pragma mark - UploadResultDelegate的代理
-(void)uploadResultInfo:(NSString *)sInfo{
    if ([sInfo isEqualToString:@"uploadComplete"]) {
        NUM++;
        if (NUM<2) {
            [self useFTPSendProject];
        }else{
            DLog(@"222");
            [self dimissAlert:alert];
        }
        
    }
}
-(void)uploadWriteData:(NSInteger)writeDataLength
{
    
}




#pragma mark - ftp
- (void)_setupManager
{
    if ([ipAddressString length]>0)
    {
        self.requestsManager1 = [[GRRequestsManager alloc] initWithHostname:[[NSString alloc]initWithFormat:@"%@/rec_bmp",ipAddressString]
                                                                       user:@"ftpuser"
                                                                   password:@"ftpuser"];
        self.requestsManager1.delegate = self;
        
    }
    
}


- (void)_setupManager1
{
    if ([ipAddressString length]>0) {
        self.requestsManager1 = [[GRRequestsManager alloc] initWithHostname:[[NSString alloc]initWithFormat:@"%@/config",ipAddressString]
                                                                       user:@"ftpuser"
                                                                   password:@"ftpuser"];
        self.requestsManager1.delegate = self;
        
    }
    
}


- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didStartRequest:(id<GRRequestProtocol>)request
{
    NSLog(@"requestsManager:didStartRequest:");
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteListingRequest:(id<GRRequestProtocol>)request listing:(NSArray *)listing
{
    
    
    
    if (isdown) {
        
        
        
        [self xiazai];
        
    }else{
        
        
        //        上传文件成功后
        
        if (_ftpxmlArr.count!= 0) {
            [_ftpxmlArr removeAllObjects];
            
        }
        
        for (NSString *str in listing) {
            [_ftpxmlArr addObject:str];
        }
        
        DLog(@"得到服务器的xml ======ftpxml===>%@",_ftpxmlArr);
        DLog(@"requestsManager:didCompleteListingRequest:listing: \n%@", listing);
        
        [self xmlid];
    }
}
- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteCreateDirectoryRequest:(id<GRRequestProtocol>)request
{
    NSLog(@"requestsManager:didCompleteCreateDirectoryRequest:");
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteDeleteRequest:(id<GRRequestProtocol>)request
{
    NSLog(@"requestsManager:didCompleteDeleteRequest:");
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompletePercent:(float)percent forRequest:(id<GRRequestProtocol>)request
{
    NSLog(@"requestsManager:didCompletePercent:forRequest: %f", percent);
    
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteUploadRequest:(id<GRDataExchangeRequestProtocol>)request
{
    NSLog(@"requestsManager:didCompleteUploadRequest:");
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteDownloadRequest:(id<GRDataExchangeRequestProtocol>)request
{
    NSLog(@"requestsManager:didCompleteDownloadRequest:");
    if (isdown) {
        index++;
        if (index<_ftpProject.count) {
            [self xiazai];
        }else{
            isdown = NO;
            [self dimissAlert:alert];
        }
    }else{
        num++;
        if (num<_jiancefile.count) {
            [self jiance];
        }else{
            
            [self useFTPSendProject];
        }
    }
    
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didFailWritingFileAtPath:(NSString *)path forRequest:(id<GRDataExchangeRequestProtocol>)request error:(NSError *)error
{
    NSLog(@"requestsManager:didFailWritingFileAtPath:forRequest:error: \n %@", error);
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didFailRequest:(id<GRRequestProtocol>)request withError:(NSError *)error
{
    NSLog(@"requestsManager:didFailRequest:withError: \n %@", error);
}




/**
 *  加载项目列表  刷新  第多次加载
 */
-(void)loadProjectList{
    @try {
        
        [_assets removeAllObjects];
        
        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/"];
        NSArray *filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                                    fromDirPath:documentsDirectory AndIsGroupDir:NO];
        NSInteger count = filenameArray.count;
        DLog(@"I have %ld XMLfile in DocumentsDir,filenameArray =%@",(long)count,filenameArray);
        
        
        if(_xmlArr){
            [_xmlArr release];
        }
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
        
        DLog(@"第er次加载本地的xml========>%@",_xmlArr);
        
        
        
        
        
        
    }
    
    
    
    
    @catch (NSException *exception) {
        DLog(@"读取项目列表异常loadProject2List = %@",exception);
    }
    @finally {
    }
}

//首次加载 view  第一次


-(void)loadfirstview
{
    
    @try {
        
        [_assets removeAllObjects];
        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/"];
        NSArray *filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                                    fromDirPath:documentsDirectory AndIsGroupDir:NO];
        NSInteger count = filenameArray.count;
        DLog(@"I have %ld XMLfile in DocumentsDir,filenameArray =%@",(long)count,filenameArray);
        
        
        if(_xmlArr){
            [_xmlArr release];
        }
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
        
        DLog(@"第一次加载本地的xml========>%@",_xmlArr);
        
        
        
        
        //        //保存到数据里面
        //        NSUserDefaults *mysqlarray = [NSUserDefaults standardUserDefaults];
        //
        //        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        //        [dic setObject:@"未分组" forKey:@"name"];
        //        [dic setObject:_xmlArr forKey:@"myproject"];
        //
        //        NSMutableArray *_numarray = [[NSMutableArray alloc]init];
        //
        //        [_numarray addObject:dic];
        //
        //        [mysqlarray setObject:_numarray forKey:@"mysqlprojects"];
        //
        
        
        [self dytloadview];
        
        
    }
    
    
    
    
    @catch (NSException *exception) {
        DLog(@"读取项目列表异常loadProject2List = %@",exception);
    }
    @finally {
    }
    
    
    
    
    
}


//判断我要的东西 获取素材

-(ProjectListObject *)findmyproject:(NSString *)mypath
{
    
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/"];
    NSArray *filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                                fromDirPath:documentsDirectory AndIsGroupDir:NO];
    
    
    
    DLog(@"shuzu =====%@",filenameArray);
    DLog(@"xml路径====%@   不等于＝＝＝%@",filenameArray[0],mypath);
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






#pragma mark - Table View  单元格
//设置段头长
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView.tag==9009) {
        
        return HEADER_HEIGHT;
    }
    return HEADER_HEIGHT;
}


//返回多少段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    if (tableView.tag==9009) {
        return dytarray.count;
    }
    return dytarray.count;
}

//设置段头
-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    
    //    if (tableView.tag==9009) {
    
    dyt_headview *headView = [dyt_headview headViewWithTableView:tableView];
    headView.delegate = self;
    headView.userInteractionEnabled = YES;
    headView.tag = section+100;
    
    
    UILongPressGestureRecognizer *longPressGR =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress2:)];
    
    longPressGR.allowableMovement = NO;
    longPressGR.minimumPressDuration = 0.5;
    [headView addGestureRecognizer:longPressGR];
    [longPressGR release];
    
    dyt_projectgroup * grop = dytarray[section];
    headView.prjectgroup = grop;
    
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeGestureRight setDirection:UISwipeGestureRecognizerDirectionLeft];

    [headView addGestureRecognizer:swipeGestureRight];

    
    
    return headView;
    
    //    }
    
    
    //    return nil;
    
}


- (void)clickHeadView
{
    
    NSLog(@"点击了按钮 刷新");
    
    [headarray removeAllObjects];
    
    [self.tableView reloadData];
}

//确定之后
-(void)makesure:(NSString *)text andtag:(NSInteger)tag
{
       
    
    dyt_projectgroup *dyt = dytarray[tag-100];
    
    dyt.name = text;
    
    [self  duanyutianAnalytical];
    
    [self clickHeadView];
    
//    if (self.delegate&&[self.delegate respondsToSelector:@selector(changedeleta:)]) {
//        [self.delegate changedeleta:2];
//    }
    
    [headarray removeAllObjects];
    
}




-(void)handleLongPress2:(UILongPressGestureRecognizer *)gestureRecognizer
{
    
    dyt_headview *dyt = (dyt_headview *)gestureRecognizer.view;
    if (dyt.tag==100) {
        return;
    }
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        
        DLog(@"ssseeeeee长按前,%ld",(long)dyt.tag);
        [dyt showtext:dyt.tag];
        
        [headarray addObject:dyt];
        
//        if (self.delegate&&[self.delegate respondsToSelector:@selector(changedeleta:)]) {
//            [self.delegate changedeleta:1];
//        }
        
        
    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        DLog(@"mimimimimimi长安后");
    }
    
    
    
}

-(void) swipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer {

    CALayer *layer = [swipeGestureRecognizer.view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 20.0;
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
     
        dyt_headview *dyt = (dyt_headview *)swipeGestureRecognizer.view;
        if (dyt.tag==100) {
            return;
        }
            [headarray addObject:dyt];
            
        for (UIView *view in [dyt subviews]) {
            view.frame = CGRectMake(view.frame.origin.x-50, 0, view.frame.size.width, view.frame.size.height);
        }
        UIButton *buttoncanle = [[UIButton alloc]initWithFrame:CGRectMake(dyt.frame.size.width-30, 0, 30, 30)];
        buttoncanle.backgroundColor = [UIColor redColor];
        [buttoncanle addTarget:self action:@selector(deletegroup) forControlEvents:UIControlEventTouchUpInside];
        [dyt addSubview:buttoncanle];
        
        
        

        
    }


}

//设置 多少cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (tableView.tag==9009) {
    
    dyt_projectgroup *grop = dytarray[section];
    
    NSInteger count = grop.opened?grop.myprjectarray.count : 0;
    return count;
    //    }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ProjectItemCell projectItemCellHeight];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellReuseIdentifierString = @"myProjectItemCell";
    ProjectItemCell *projectItemCell =[[ProjectItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifierString];
    
    dyt_projectgroup *grop = dytarray[indexPath.section];
    
    
    ProjectListObject *projectObj = [self findmyproject:[grop.myprjectarray objectAtIndex:indexPath.row]];
    
    projectObj.isExist = NO;
    
    DLog(@"我的shuzu===%@",_xml_id);
    
    if (_xml_id.count!=0) {
        
        projectObj.isExist = [self lookyunping:projectObj.project_filename];
        
        //        if ([_xml_id containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
        //            projectObj.isExist=YES;
        //
        //        }
    }
    
//    手机版 项目列表
    if (tableView.tag == 9009) {
        
        UILongPressGestureRecognizer *longPressGR =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handmove:)];
        
        longPressGR.allowableMovement = NO;
        longPressGR.minimumPressDuration = 0.5;
        [projectItemCell addGestureRecognizer:longPressGR];
        [longPressGR release];
        
        projectObj.isp=YES;
        
    }
    
    if(tableView.tag == 9999){
        
        UILongPressGestureRecognizer *longPressGR =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handmove:)];
        
        longPressGR.allowableMovement = NO;
        longPressGR.minimumPressDuration = 0.5;
        [projectItemCell addGestureRecognizer:longPressGR];
        [longPressGR release];
        
        
        
        
        projectObj.isp=YES;
    }
    if(tableView.tag==9998){
        projectObj.isp=NO;
    }
    
    
    DLog(@"上传成功  刷新===%d   %@",projectObj.isExist,projectObj.project_name);
    
    [projectItemCell setMyCheckBoxOfIndexPath:indexPath];
    
    [projectItemCell setProjectObject:projectObj];
    
    [projectItemCell setDelegate:self];
    
    //    projectItemCell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    
    
    return projectItemCell;
}


//-(void)swipeShowDelButton:(UISwipeGestureRecognizer *)myGesture{
//    UIButton *delButton = [[UIButton alloc]init];
//    [delButton setTitle:[Config DPLocalizedString:@"adedit_musicdelbutton"] forState:UIControlStateNormal];
//    [delButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [delButton setBackgroundImage:[UIImage imageNamed:@"redbutton_background"] forState:UIControlStateNormal];
//    NSInteger iDelButton = 80;
//    [delButton setFrame:CGRectMake(myGesture.view.frame.size.width - iDelButton, 0, iDelButton, myGesture.view.frame.size.height)];
//    [delButton setTag:(myGesture.view.tag-TAG_BUTTON_OFFSET)];
//    [delButton addTarget:self action:@selector(delButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [myGesture.view addSubview:delButton];
//    [delButton release];
//    NSLog(@"%@",myGesture.view);
//}


//-(void)delButtonClicked:(UIButton *)sender{
//
//    NSInteger indexOfMusicItems = (sender.tag - (TAG_MUSIC_CELL-TAG_BUTTON_OFFSET));
//    DLog(@"indexOfMusicItems = %ld",(long)indexOfMusicItems);
//
//    //删除项目
//    [self deletePlayProject:projectObj];
//}


/**
 *  删除播放项目
 */
-(void)deletePlayProject:(ProjectListObject *)projects{
    
    
    
    
    @try {
        
        DLog(@"删除项目 ");
        
        
        
        
        
        NSString *myProjectFileName = projects.project_filename;
        if ((!myProjectFileName)||([myProjectFileName length]<1)) {
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_Pleaseselectanitem"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            return;
        }
        
        
        
        //通过项目的文件名找到项目的配置文件，先删除配置文件下管理的资源，最后删除配置文件
        NSString *sXmlFileName =  [myProjectFileName lastPathComponent];
        NSString *sProjectDirPath = [[NSString alloc] initWithString:myProjectFileName];
        NSString *sProjectDir = [sProjectDirPath stringByReplacingOccurrencesOfString:sXmlFileName withString:@""];
        
                DLog(@"伤处文件＝＝＝＝＝%@",sXmlFileName);
                 DLog(@"伤处文件＝＝＝＝＝%@",sProjectDirPath);
                 DLog(@"伤处文件＝＝＝＝＝%@",sProjectDir);
        
        
        
        NSFileManager *myFileManager = [NSFileManager defaultManager];
        [myFileManager removeItemAtPath:sProjectDirPath error:nil];
        BOOL deleteFileResult = [myFileManager removeItemAtPath:sProjectDir error:nil];
        if (deleteFileResult) {
            
            
            [self shangchu:sProjectDirPath];
            //                删除成功
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_deleteprojectsuccess"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
        }else{
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_deleteprojectfailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
        }
        
        
        //重新加载视频播放列表
        [self addreloadview];
        
    }
    @catch (NSException *exception) {
        DLog(@"删除播放项目数据异常 = %@",exception);
    }
    @finally {
    }
}


//删除项目
-(void)shangchu:(NSString *)str
{
    NSString *mystr = [str lastPathComponent];
    
    for (int k=0; k<dytarray.count; k++) {
        
        //        NSMutableDictionary *dic = array[i];
        
//        获取分组 信息
        dyt_projectgroup   *my_friendsData = dytarray[k];
        
        
        for (int i=0; i<my_friendsData.myprjectarray.count; i++) {
            
            if ([mystr isEqualToString:my_friendsData.myprjectarray[i]]) {
                NSLog(@"找到要删除的东西fsafsa===%d",i);

                NSMutableArray *myarr1 = my_friendsData.myprjectarray;
                
                NSMutableArray *myarr = [[NSMutableArray alloc]initWithArray:myarr1];
                NSLog(@"fadsfasfa===%lu",(unsigned long)myarr.count);

                
                if (my_friendsData.myprjectarray.count == 1)
                {
                    myarr = [[NSMutableArray alloc]init];
                }else{
                    
                    DLog(@"=====%@",myarr);
                    [myarr removeObjectAtIndex:i];
                }
                
                my_friendsData.myprjectarray = myarr;
                //                [my_friendsData.myprjectarray removeObjectAtIndex:i];
                if (my_friendsData.myprjectarray.count==0) {
                    
                }
                
            }
        }
        
    }
    
    [self duanyutianAnalytical];
    
    [self clickHeadView];
    
}



//选择素材
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    dyt_projectgroup *dyt = dytarray[indexPath.section];
    
    
    for (int i=0; i<dytarray.count; i++)
    {
        dyt_projectgroup *dytone = dytarray[i];
        for (int k=0; k<dytone.myprjectarray.count; k++) {
            ProjectItemCell *projectItemCell00 = (ProjectItemCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:k inSection:i]];
            projectItemCell00.backgroundColor = [UIColor whiteColor];
            
        }
        
        
        
    }
    
    
    
    ProjectItemCell *projectItemCell1 = (ProjectItemCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    DLog(@"变成了红色");
    
    
    
    projectItemCell1.backgroundColor = [UIColor lightGrayColor];
    
    
    
    //    ProjectListObject *projectObj = [dyt.myprjectarray objectAtIndex:indexPath.row];
    
    ProjectListObject *projectObj = [self findmyproject:[dyt.myprjectarray objectAtIndex:indexPath.row]];
    
    if (delegate &&[delegate respondsToSelector:@selector(playOneWithProjectObj:cellIndexPath:)]) {
        [self.delegate playOneWithProjectObj:projectObj cellIndexPath:indexPath];
    }
    
}


#pragma mark-移动

-(void)handmove:(UILongPressGestureRecognizer *)gestureRecognizer
{
    
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        
        if (editState==NO) {
            
            DLog(@"keyi");
            editState = YES;
            [self.tableView setEditing:!self.tableView.editing animated:YES];
        }else
        {
            DLog(@"可以取消移动编辑");
            
        }
        
        
        
    }
    
    
    
    
}


-(void)noteMove
{
    DLog(@"取消移动");
    editState = NO;
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    
}
//指定该行能够移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editState)
        return YES;
    else
        return NO;  //如果点了删除行不能移动
}
//移动方法
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    
    NSUInteger fromRow = [sourceIndexPath row];    //要移动的位置
    NSInteger fromsection = [sourceIndexPath section];
    
    
    NSUInteger toRow = [destinationIndexPath row]; //移动的目的位置
    NSInteger tosection = [destinationIndexPath section];
    
    DLog(@"移动＝＝＝＝＝%lu     %lu",(unsigned long)fromRow,(unsigned long)toRow);
    
    
    
    
    if (fromsection != tosection) {
        dyt_projectgroup *formdyt = [dytarray objectAtIndex:fromsection];
        
        
        id object = [formdyt.myprjectarray objectAtIndex:fromRow];
        
        NSMutableArray *nextarray = [[NSMutableArray alloc]initWithArray:formdyt.myprjectarray];
        
        
        
        dyt_projectgroup *todyt = [dytarray objectAtIndex:tosection];
        
        
        NSMutableArray *toarray = [[NSMutableArray alloc]initWithArray:todyt.myprjectarray];
        
        
        [nextarray removeObjectAtIndex:fromRow];       //将对象从原位置移除
        [toarray insertObject:object atIndex:toRow]; //将对象插入到新位置
        
        formdyt.myprjectarray = nextarray;
        todyt.myprjectarray = toarray;
        
        
    }else
    {
        dyt_projectgroup *mydyt = [dytarray objectAtIndex:fromsection];
        
        id object = [mydyt.myprjectarray objectAtIndex:fromRow]; //存储将要被移动的位置的对象
        NSMutableArray *_noteList = [[NSMutableArray alloc]initWithArray:mydyt.myprjectarray];
        
        [_noteList removeObjectAtIndex:fromRow];
        //将对象从原位置移除
        [_noteList insertObject:object atIndex:toRow]; //将对象插入到新位置
        mydyt.myprjectarray = _noteList;
        
    }
    
    [self noteMove];
    
    [self duanyutianAnalytical];
    
    [self clickHeadView];
    
    
}





#pragma mark-返回编辑模式'
//返回编辑状态的style
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!DEVICE_IS_IPAD&&!editState) {
        
        return UITableViewCellEditingStyleDelete;
        
    }else{
        
        return UITableViewCellEditingStyleNone;
    }
}








//完成编辑的触发事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //        //        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
        //        //                         withRowAnimation:UITableViewRowAnimationFade];
        //        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
        //                         withRowAnimation:UITableViewRowAnimationFade];
        
        
        
        NSInteger indexOfMusicItems = indexPath.row;
        
        
        dyt_projectgroup *dyt = [dytarray objectAtIndex:indexPath.section];
        
        duanyutianprojectObj =  [self findmyproject:[dyt.myprjectarray objectAtIndex:indexOfMusicItems]];
        
        //        duanyutianprojectObj =    dyt.myprjectarray objectAtIndex:indexOfMusicItems];
        
        deletate = indexPath;
        DLog(@"上传成功===%d   %@",duanyutianprojectObj.isExist,duanyutianprojectObj.project_name);
        
        DLog(@"完成删除====%@",duanyutianprojectObj.project_filename);
        
        DLog(@"======%@",[duanyutianprojectObj description]);
        
        
        if ([self lookyunping:duanyutianprojectObj.project_filename]) {
            
            UIActionSheet *actionview = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除本地项目" otherButtonTitles:@"删除云屏项目", nil];
            actionview.tag = 10000;
            [actionview showInView:self.view];
            
            
        }else
        {
            
            UIActionSheet *actionview = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除本地项目" otherButtonTitles: nil];
            actionview.tag = 10001;
            [actionview showInView:self.view];
            
            
            
            
            
        }
        
        
        
        
    }
}



//修改文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [Config DPLocalizedString:@"adedit_musicdelbutton"];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag==10000) {
        DLog(@"------%ld",(long)buttonIndex);
        if (buttonIndex==0) {
            NSLog(@"删除本地   ");
            //删除项目
            [self deletePlayProject:duanyutianprojectObj];
            
            
        }
        if (buttonIndex==1) {
            DLog(@"删除云屏项目 ");
            [self delete:duanyutianprojectObj.project_filename];
            
            
        }
        
        
        
    }
    
    //    如果不存在云端
    if (actionSheet.tag==10001) {
        if (buttonIndex==0) {
            NSLog(@"删除本地");
            [self deletePlayProject:duanyutianprojectObj];
        }
    }
    
    duanyutianprojectObj = nil;
    
}
//删除云项目
-(void)delete:(NSString*)path{
    
    
    [self _setupManager];
    [self.requestsManager1 addRequestForDeleteFileAtPath:path];
    [self.requestsManager1 startProcessingRequests];
    
}

#pragma mark - Assets Picker Delegate
- (NSArray *)indexPathOfNewlyAddedAssets:(NSArray *)assets
{
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (NSInteger i = _assets.count; i < self.assets.count + assets.count ; i++)
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    return indexPaths;
}



//解析数据
-(void)dytloadview
{
    
    //保存到数据里面
    NSUserDefaults *mysqlarray = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *array = [mysqlarray objectForKey:@"mysqlprojects"];
    
    DLog(@"-------%lu",(unsigned long)array.count);
    [dytarray removeAllObjects];
    
    for (int i=0; i<array.count; i++) {
        NSMutableDictionary *dic = array[i];
        
        dyt_projectgroup   *my_friendsData = [[dyt_projectgroup alloc]init];
        
        my_friendsData.name = [dic objectForKey:@"name"];
        
        NSMutableArray *mypro =[dic objectForKey:@"myproject"];
        NSLog(@"段雨田 ＝＝＝＝＝%@",mypro);
        my_friendsData.myprjectarray = [dic objectForKey:@"myproject"];
        [dytarray addObject:my_friendsData];
        
    }
    
    [self clickHeadView];
    
}


//添加项目
-(void)addreloadview
{
    [self _setupManager];
    
    [self ftpstart];
    
    
    
    [self loadfirstview];
    
    
    
    
    
    
}

//添加分组
-(void)addgroup
{
    
    
    
    
    dyt_projectgroup   *my_friendsData = [[dyt_projectgroup alloc]init];
    
    NSInteger count = [self looknewgoup];
    
    if (count==0) {
        my_friendsData.name = [NSString stringWithFormat:@"%@",[Config DPLocalizedString:@"newgroup"]];
    }else
    {
        my_friendsData.name = [NSString stringWithFormat:@"%@%ld",[Config DPLocalizedString:@"newgroup"],(long)count];
    }
    
    
    NSMutableArray *mypro =[[NSMutableArray alloc]init];
    
    my_friendsData.myprjectarray = mypro;
    [dytarray addObject:my_friendsData];
    
    [self addsql:[Config DPLocalizedString:@"newgroup"] :mypro];
    
    [self clickHeadView];
    
    
}

//查看分组
-(NSInteger)looknewgoup
{
    NSInteger k = 0;
    NSInteger count = 0;
    NSMutableArray *name = [[NSMutableArray alloc]init];
    
    return 0;
    
    
    for (int i=0; i<dytarray.count; i++) {
        dyt_projectgroup *dyt = dytarray[i];
        if ([dyt.name rangeOfString:[Config DPLocalizedString:@"newgroup"]].location != NSNotFound) {
            [name addObject:dyt];
            k++;
        }
    }
    if (k==0) {
        return 0;
    }
    
    if (k==1) {
        return k;
    }
    
    for (int i=0; i<name.count; i++) {
        dyt_projectgroup *dyt = name[i];
        
        if ([dyt.name rangeOfString:[Config DPLocalizedString:@"newgroup"]].location == NSNotFound) {
            return 0;
        }
        
        for (int j=0; j<k; j++) {
            
            NSString *str = [[NSString alloc]initWithFormat:@"%@%d",[Config DPLocalizedString:@"newgroup"],j+1 ];
            
            if ([dyt.name rangeOfString:str].location == NSNotFound) {
                return 0;
            }
        }
        
        
    }
    
    
    return count;
    
}





//删除分组
-(void)deletegroup
{
    
    NSFileManager *myFileManager = [NSFileManager defaultManager];
    
    for (int i=0; i<headarray.count; i++) {
        
        
        dyt_headview *dyt = (dyt_headview *)headarray[i];
        dyt_projectgroup *data = dyt.prjectgroup;
        //        删除项目
        
        for (int i=0; i<data.myprjectarray.count; i++) {
            
            ProjectListObject  *projects  = [self findmyproject:[data.myprjectarray objectAtIndex:i]];
            
            
            NSString *myProjectFileName = projects.project_filename;
            
            if ((!myProjectFileName)||([myProjectFileName length]<1)) {
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_Pleaseselectanitem"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
                [myAlertView release];
                return;
            }
            
            
            //通过项目的文件名找到项目的配置文件，先删除配置文件下管理的资源，最后删除配置文件
            NSString *sXmlFileName =  [myProjectFileName lastPathComponent];
            NSString *sProjectDirPath = [[NSString alloc] initWithString:myProjectFileName];
            NSString *sProjectDir = [sProjectDirPath stringByReplacingOccurrencesOfString:sXmlFileName withString:@""];
            
            DLog(@"伤处文件＝＝＝＝＝%@",sProjectDirPath);
            
            
            
            
            [myFileManager removeItemAtPath:sProjectDirPath error:nil];
            BOOL deleteFileResult = [myFileManager removeItemAtPath:sProjectDir error:nil];
            if (deleteFileResult) {
                
                [self shangchu:sProjectDirPath];
                //                删除成功
                
            }
            
            
            
            
            
            
            DLog(@"我要删除的＝＝＝%lu",(unsigned long)dyt.tag);
            
            
            
        }
        
        [dytarray removeObject:data];
    }
    
    
    [self duanyutianAnalytical];
    
//    if (delegate&&[delegate respondsToSelector:@selector(changedeleta:)]) {
//        [delegate changedeleta:2];
//    }
    
    [self clickHeadView];
    
}



//添加 分组 到 数据
-(void)addsql:(NSString *)mystr :(NSArray *)array
{
    
    if (array.count==0) {
        
        
        //保存到数据里面
        NSUserDefaults *mysqlarray = [NSUserDefaults standardUserDefaults];
        
        NSArray *arrayproject = [mysqlarray objectForKey:@"mysqlprojects"];
        
        NSMutableArray *_numarray = [[NSMutableArray alloc]initWithArray:arrayproject];
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        
        [dic setObject:mystr forKey:@"name"];
        
        [dic setObject:array forKey:@"myproject"];
        
        
        [_numarray addObject:dic];
        
        [mysqlarray setObject:_numarray forKey:@"mysqlprojects"];
        
    }
    else
    {
        //               解析当前的dataarray
        
        //        //保存到数据里面
        //        NSUserDefaults *mysqlarray = [NSUserDefaults standardUserDefaults];
        //
        //        NSMutableArray *array = [mysqlarray objectForKey:@"mysqlprojects"];
        //        DLog(@"-------%d",array.count);
        //        [dytarray removeAllObjects];
        
        //        for (int i=0; i<array.count; i++) {
        //            NSMutableDictionary *dic = array[i];
        //
        //            dyt_projectgroup   *my_friendsData = [[dyt_projectgroup alloc]init];
        //
        //            my_friendsData.name = [dic objectForKey:@"name"];
        //
        //            NSMutableArray *mypro =[dic objectForKey:@"myproject"];
        //            NSLog(@"段雨田 ＝＝＝＝＝%@",mypro);
        //            my_friendsData.myprjectarray = [dic objectForKey:@"myproject"];
        //            [dytarray addObject:my_friendsData];
        
        
        
        
        
    }
    
    
}



-(BOOL)lookyunping:(NSString *)str
{
    NSString *file = [str lastPathComponent];
    
    DLog(@"我丫的=====%@========%@",_ftpxmlArr,file);
    
    
    
    
    for (NSString *string in _ftpxmlArr) {
        if ([string isEqualToString:file]) {
            return true;
        }
    }
    
    return false;
}


//解析数据
-(void)duanyutianAnalytical
{
    
    //保存到数据里面
    NSUserDefaults *mysqlarray = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *dataarray = [[NSMutableArray alloc]init];
    
    for (int i=0; i<dytarray.count; i++) {
        
        NSMutableDictionary *mydic = [[NSMutableDictionary alloc]init];
        
        dyt_projectgroup   *my_friendsData = dytarray[i];
        
        NSString *str = my_friendsData.name;
        
        NSMutableArray *mypro = my_friendsData.myprjectarray;
        
        [mydic setObject:mypro forKey:@"myproject"];
        [mydic setObject:str forKey:@"name"];
        
        [dataarray addObject:mydic];
        
    }
    
    [mysqlarray removeObjectForKey:@"mysqlprojects"];
    
    [mysqlarray setObject:dataarray forKey:@"mysqlprojects"];
    
    
}


-(void)review;
{
    //    [self  duanyutianAnalytical];
    
    DLog(@"调用了 连续播放");
    
    [self addreloadview];
    
    //    [self.tableView reloadData];
    
}


//上传后刷新
-(void)reloadMyPlaylist{
    
    DLog(@"传输");
    [self _setupManager];
    
    
    [self ftpstart];
    
    
    [self loadProjectList];
    
    
    [self clickHeadView];
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
        DLog(@"====%@",projectName);
        
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
-(void)startPuslisProgress{
    //发送状态设置为发送中
    //    isSendState = YES;
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.height, self.view.frame.size.width)];
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
    
}


/**
 * 获取或者创建云屏项目所在的路径
 *
 * @return 云屏项目所在路径
 */
-(NSString*)LEDproject{
    NSFileManager *myFileManager = [NSFileManager defaultManager];
    NSString *documentsGroupXMLDir = [[[NSString alloc]initWithFormat:@"%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedProject"]] autorelease];
    BOOL isDir;
    if (![myFileManager fileExistsAtPath:documentsGroupXMLDir isDirectory:&isDir]) {
        [myFileManager createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedProject"] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentsGroupXMLDir;
    
}

/**
 *  根据传入的文件对象，解析文件中的项目的播放时间返回
 *
 *  @param asset 文件对象
 *
 *  @return 指定项目的播放时间
 */
-(int)getProjectDurationWithFileName:(NSString *)myFilePath{
    @try {
        DLog(@"dataDictionary.filePath = %@",myFilePath);
        NSDictionary *dataDictionary = [NSDictionary dictionaryWithXMLFile:myFilePath];
        DLog(@"dataDictionary = %@",dataDictionary);
        int totalSchedule = 0;
        NSArray *tempArray = [dataDictionary objectForKey:@"materialListElement"];
        for (NSDictionary *tempDictionary in tempArray) {
            DLog(@"tempDictionary = %@",tempDictionary);
            if ([[tempDictionary objectForKey:@"key"] isEqualToString:@"1004"]) {
                NSArray *oneListArray = [tempDictionary objectForKey:@"listItemElement"];
                for (NSDictionary *oneItemDict in oneListArray) {
                    NSString *durationString = [oneItemDict objectForKey:@"duration"];
                    int sleepSecond = [durationString intValue];
                    totalSchedule +=sleepSecond;
                }
            }
        }
        return totalSchedule;
    }
    @catch (NSException *exception) {
        DLog(@"解析项目名称异常 = %@",exception);
    }
    @finally {
        
    }
}

/**
 *  通过项目名称搜索项目列表
 */
-(BOOL)searchProjectListWithProjectName:(NSString *)projectName{
    
    @try {
        
        //        [self  dytloadview];
        
        
        [self duanyutiansearch:projectName];
        
        
        //        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/"];
        //        NSArray *filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
        //                                                                    fromDirPath:documentsDirectory AndIsGroupDir:NO];
        //        NSInteger count = filenameArray.count;
        //        DLog(@"I have %lud XMLfile in DocumentsDir,filenameArray =%@",count,filenameArray);
        //        if (count<1) {
        //            return NO;
        //        }
        //        for (int i = 0; i<count; i++) {
        //
        //            DLog(@"NO.%d is %@",i+1,[filenameArray objectAtIndex:i]);
        //
        //            if ([filenameArray objectAtIndex:i]) {
        //
        //                //项目名称
        //                ProjectListObject *myPro = [[ProjectListObject alloc]init];
        //
        //                [self getProjectNameWithFileName:[filenameArray objectAtIndex:i] andProjectObj:myPro];
        //
        //                NSString *projectNameString = myPro.project_name;
        //
        //                NSRange range = [projectNameString rangeOfString:projectName];
        //                NSInteger sublocation = range.location;
        //                NSInteger sublength = range.length;
        //                if ((sublocation != NSNotFound)&&(sublength>0)) {
        //
        //
        //                }
        //            }
        //        }
        //            return YES;
        //        }else{
        //            return NO;
        //        }
    }
    @catch (NSException *exception) {
        DLog(@"读取项目列表异常loadProject1List = %@",exception);
    }
    @finally {
        [self clickHeadView];
    }
}

-(void)duanyutiansearch:(NSString *)namestr
{
    
    
    NSLog(@"搜索的内容===%@",namestr);
    
    //    存储的数组
    NSMutableArray *myarray = [[NSMutableArray alloc]init];
    
    
    
    
    
    //    先查看组
    for (int i=0; i<dytarray.count; i++) {
        
        
        //        获取组
        dyt_projectgroup *mygroup = dytarray[i];
        dyt_projectgroup *mynewgroup = [[dyt_projectgroup alloc]init];
        
        //        得到组名
        
        mynewgroup.name = mygroup.name;
        
        
        
        DLog(@"我的s数组名字＝＝＝%@    %lu",mygroup.name,(unsigned long)mygroup.myprjectarray.count);
        
        //        存分组内部项目
        NSMutableArray *projectarray = [[NSMutableArray alloc]init];
        
        //        查看分组 的     元素
        for (int k=0; k<mygroup.myprjectarray.count; k++) {
            
            
            ProjectListObject *projectObj = [self findmyproject:[mygroup.myprjectarray objectAtIndex:k]];
            
            NSString *projectNameString = projectObj.project_name;
            DLog(@"项目名ongxi====%@",projectNameString);
            //            获取搜索的长度
            NSRange range = [projectNameString rangeOfString:namestr];
            
            NSInteger sublocation = range.location;
            NSInteger sublength = range.length;
            
            DLog(@"我靠  %@ %ld   %ld",projectNameString,(long)sublocation,(long)sublength);
            if ((sublocation != NSNotFound)&&(sublength>0)) {
                
                [projectarray addObject:mygroup.myprjectarray[k]];
                NSLog(@"我的＝＝＝＝%@",projectObj.project_name);
            }
            
            
            mynewgroup.myprjectarray = projectarray;
            
        }
        
        
        
        
        [myarray addObject:mynewgroup];
        
    }
    
    
    
    
    dytarray = myarray;
    
    [self clickHeadView];
    
    
}



/**
 *  列表中的复选框被选择或被反选的之后的表格的索引传给代理处理者
 *
 *  @param cellIndexPath 列表的索引  段雨田
 *  @param checked       是否被选中
 */
-(void)didSelectedCheckBoxWithIndexPath:(NSIndexPath *)cellIndexPath checked:(BOOL)checked{
    if (_isMulitSelected) {
        [self reloadMyPlaylist];
    }
    
    DLog(@"段雨田==========%d",checked);
    dyt_projectgroup *dyt = dytarray[cellIndexPath.section];
    //    ProjectListObject *projectObj = [self findmyproject:[grop.myprjectarray objectAtIndex:indexPath.row]];
    
    ProjectListObject *tempProjectListObject = [self findmyproject:[dyt.myprjectarray objectAtIndex:cellIndexPath.row]];
    tempProjectListObject.isSelected = checked;
    NSMutableArray *next = [[NSMutableArray alloc]initWithArray:dyt.myprjectarray];
    
    [next replaceObjectAtIndex:cellIndexPath.row withObject:tempProjectListObject];
    
    //    [dyt.myprjectarray replaceObjectAtIndex:cellIndexPath.row withObject:tempProjectListObject];
    
    dyt.myprjectarray = next;
    //初始化被选择的项目容器
    if (_selectedProjectArray == nil) {
        _selectedProjectArray = [[NSMutableArray alloc]init];
    }
    
    if (_isMulitSelected) {
        
        if (checked) {
            [_selectedProjectArray removeAllObjects];
            
            DLog(@"被选择的项目 = %@",tempProjectListObject);
            [_selectedProjectArray addObject:tempProjectListObject];
            
            [delegate selectedProjectWithObject:_selectedProjectArray];
        }else{
            DLog(@"被反选的项目 = %@",tempProjectListObject);
            [_selectedProjectArray removeObject:tempProjectListObject];
        }
    }else{
        DLog(@"可多选");
        [tempProjectListObject setIsSelected:checked];
        
        NSMutableArray *next1 = [[NSMutableArray alloc]initWithArray:dyt.myprjectarray];
        
        [next1 replaceObjectAtIndex:cellIndexPath.row withObject:tempProjectListObject];
        
        //    [dyt.myprjectarray replaceObjectAtIndex:cellIndexPath.row withObject:tempProjectListObject];
        
        dyt.myprjectarray = next1;
        
        
        //        [dyt.myprjectarray replaceObjectAtIndex:cellIndexPath.row withObject:tempProjectListObject];
        if (checked) {
            DLog(@"被选择的项目 = %@",tempProjectListObject);
            [_selectedProjectArray addObject:tempProjectListObject];
        }else{
            DLog(@"被反选的项目 = %@",tempProjectListObject);
            [_selectedProjectArray removeObject:tempProjectListObject];
        }
        [delegate selectedProjectWithObject:_selectedProjectArray];
    }
    
    
    
    
}

/**
 *  读取分组文件列表来重新加载项目列表
 */
-(void)useGroupInfoReloadProjectList{
    if (_selectedProjectArray) {
        [_selectedProjectArray removeAllObjects];
        
        
    }
}

/**
 *  查询分组文件列表
 *
 *  @return 分组文件列表
 */
-(NSArray*)searchGroupXMLFileList{
    //group XML 文件的路径
    NSMutableArray *groupArray = [[[NSMutableArray alloc]init] autorelease];
    @try {
        
        NSString *documentsDirectory = [self documentGroupXMLDir];
        DLog(@"searchGroupXMLFileLis.documentsDirectory = %@",documentsDirectory);
        NSArray *filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                                    fromDirPath:documentsDirectory AndIsGroupDir:YES];
        NSInteger count = filenameArray.count;
        
        
        
        
        DLog(@"I have %ld XMLfile in DocumentsDir,filenameArray =%@",(long)count,filenameArray);
        for (int i = 0; i<count; i++) {
            DLog(@"NO.%d is %@",i+1,[filenameArray objectAtIndex:i]);
            if ([filenameArray objectAtIndex:i]) {
                
                //项目名称
                NSString *projectNameString = [self getGroupNameWithFileName:[filenameArray objectAtIndex:i]];
                
                ProjectListObject *myPro = [[ProjectListObject alloc]init];
                
                [myPro setProject_name:projectNameString];
                [myPro setProject_filename:[filenameArray objectAtIndex:i]];
                [myPro setProject_list_type:IS_GROUP_XML];
                [groupArray addObject:myPro];
            }
        }
    }
    
    
    
    @catch (NSException *exception) {
        DLog(@"读取项目列表异常loadProject1List = %@",exception);
    }
    @finally {
    }
    
    return groupArray;
}


/**
 *  根据传入的文件对象，解析文件中的分组名称返回
 *
 *  @param asset 文件对象
 *
 *  @return 分组名称
 */
-(NSString*)getGroupNameWithFileName:(NSString *)myFilePath{
    @try {
        DLog(@"dataDictionary.filePath = %@",myFilePath);
        NSDictionary *dataDictionary = [NSDictionary dictionaryWithXMLFile:myFilePath];
        DLog(@"dataDictionary = %@",dataDictionary);
        
        NSString *projectName = nil;
        if (dataDictionary) {
            if ([dataDictionary objectForKey:@"playlistname"]) {
                projectName = [[NSString alloc]initWithString:[dataDictionary objectForKey:@"playlistname"]];
            }
        }
        return projectName;
    }
    @catch (NSException *exception) {
        DLog(@"解析分组名称异常 = %@",exception);
    }
    @finally {
        
    }
}


-(NSString*)documentGroupXMLDir{
    NSFileManager *myFileManager = [NSFileManager defaultManager];
    NSString *documentsGroupXMLDir = [[NSString alloc]initWithFormat:@"%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/GroupXMLDir"]];
    BOOL isDir;
    if (![myFileManager fileExistsAtPath:documentsGroupXMLDir isDirectory:&isDir]) {
        [myFileManager createDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/GroupXMLDir"] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentsGroupXMLDir;
}

#pragma mark - showAlertView
-(void)showAlertView:(NSString*)showString
{
    alert = [[UIAlertView alloc] initWithTitle:[Config DPLocalizedString:@"adedit_Reminder"] message:showString delegate:nil  cancelButtonTitle:nil otherButtonTitles:nil];
    
    [alert show];
    
    
    
    
}//温馨提示



- (void)dimissAlert:(UIAlertView *)Alert
{
    if(Alert)
    {
        
        [Alert dismissWithClickedButtonIndex:[Alert cancelButtonIndex] animated:YES];
        
    }
}//温馨提示

-(void)dealloc{
    RELEASE_SAFELY(_assets);
    RELEASE_SAFELY(_selectedProjectArray);
    [super dealloc];
}
@end
