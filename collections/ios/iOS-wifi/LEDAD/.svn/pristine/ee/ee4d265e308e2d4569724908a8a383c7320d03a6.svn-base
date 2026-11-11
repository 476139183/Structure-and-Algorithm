//
//  DYT_Hardwaredetectionview.m
//  LEDAD
//
//  Created by laidiya on 15/7/20.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_Hardwaredetectionview.h"
#import "MyTool.h"
#import "DYT_AsyModel.h"
#import "NSString+SBJSON.h"

#define UrlStr @"http://www.ledmediasz.com/Ledad/Ledad_VersionShow_api.aspx"

@interface DYT_Hardwaredetectionview ()<myasydelete>
{
    
    
    
    DYT_AsyModel *mymodel;
    
    UIView *Brightnessview;
    
    BOOL temorhist;
    NSString *banben;
    
    
//    hong lv  lan
    UILabel *labelred;
    UILabel *labelgreen;
    UILabel *labelblue;
    
    
//     x   y
    
    UILabel *labelx;
    UILabel *labely;
    
    
//    跟新按钮
    UIButton *getnewbutton;
    UILabel *newwareversion;
    
    UIButton *cputembutton;
    UIButton *historebutton;
}
@end

@implementation DYT_Hardwaredetectionview
-(id)initWithFrame:(CGRect)frame andname:(NSString *)name
{
    self = [super initWithFrame:frame];
    if (self) {
        
        mymodel = [[DYT_AsyModel alloc]init];
        mymodel.mydelegate = self;
        self.yunpingname = name;
        [self loadview];
    }
    return self;

}


-(void)loadview
{

    
    
    
    if (jianceip==nil) {
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_shoose"] delegate:nil cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles: nil];
        [alertview show];
    }
    
    
    [self initfirstview];

    
    [self  starasi];
    
    [self starsocket];
    // Do any additional setup after loading the view.
    

    
    
    
    
    


}

-(void)starasi
{
    DLog(@"urlStr = %@",UrlStr)
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",UrlStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIHTTPRequest *asiHttp = [[ASIHTTPRequest alloc]initWithURL:url];
    asiHttp.delegate = self;
    [asiHttp startAsynchronous];
    
    
    
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    
    DLog(@"数据加载完成");
    NSString *jsonString = [request responseString];
    //网络未读取到数据的时候，判断缓存是否存在，存在则读取缓存，有网络则写缓存
    NSString *urlStr = [[NSString alloc]initWithFormat:@"%@",[request url]];
    //缓存数据
    
    if ([jsonString length]==0) {
        if ([MyTool isExistsCacheFile:urlStr]) {
            jsonString = [MyTool readCacheString:urlStr];
        }
    }else{
        [MyTool writeCache:jsonString requestUrl:urlStr];
    }
    jsonString = [MyTool filterResponseString:jsonString];
    
    DLog(@"解析的网络数据====%@",jsonString);
    NSDictionary *itemsDataDictionary = [jsonString JSONValue];
    banben = @"";
    if (itemsDataDictionary[@"VersionNumber"]) {
        banben = itemsDataDictionary[@"VersionNumber"];
        
    }
    
    [self changeview];
    
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    DLog(@"加载数据失败，检查网络");
    
    DLog(@"数据加载失败");
    NSString *jsonString = [request responseString];
    //网络未读取到数据的时候，判断缓存是否存在，存在则读取缓存，有网络则写缓存
    NSString *urlStr = [[NSString alloc]initWithFormat:@"%@",[request url]];
    //缓存数据
    
    if ([jsonString length]==0) {
        if ([MyTool isExistsCacheFile:urlStr]) {
            jsonString = [MyTool readCacheString:urlStr];
        }
    }else{
        [MyTool writeCache:jsonString requestUrl:urlStr];
    }
    jsonString = [MyTool filterResponseString:jsonString];
    
    DLog(@"解析的网络数据====%@",jsonString);
    NSDictionary *itemsDataDictionary = [jsonString JSONValue];
    banben = @"";
    if (itemsDataDictionary[@"VersionNumber"]) {
        banben = itemsDataDictionary[@"VersionNumber"];
        
    }
    
}
-(void)starsocket
{
//    [mymodel startSocket];
    [mymodel getScreenbrightness];

}
-(void)returemydata:(NSData *)mydata
{
    
    Byte *AckByte = (Byte *)[mydata bytes];
    NSLog(@"获取亮度回馈%@",mydata);
    
    if(AckByte[1]==0x12){
        DLog(@"获取屏幕亮度成功");
        
        NSString *red=[NSString stringWithFormat:@"%x",AckByte[4]];
        NSString *green=[NSString stringWithFormat:@"%x",AckByte[5]];
        NSString *blue=[NSString stringWithFormat:@"%x",AckByte[6]];
        NSString *alpha=[NSString stringWithFormat:@"%x",AckByte[3]];
        
        NSInteger _red2=strtoul([red UTF8String], 0, 16);
        NSInteger  _green2=strtoul([green UTF8String], 0, 16);
        NSInteger  _blue2=strtoul([blue UTF8String], 0, 16);
        NSInteger   _alpha2=strtoul([alpha UTF8String], 0, 16);
        NSInteger    _height2=strtoul([[NSString stringWithFormat:@"%x",AckByte[7]] UTF8String], 0, 16)+strtoul([[NSString stringWithFormat:@"%x",AckByte[8]] UTF8String], 0, 16)*255;
        NSInteger     _width2=strtoul([[NSString stringWithFormat:@"%x",AckByte[9]] UTF8String], 0, 16)+strtoul([[NSString stringWithFormat:@"%x",AckByte[10]] UTF8String], 0, 16)*255;
        
        if(strtoul([[NSString stringWithFormat:@"%x",AckByte[8]] UTF8String], 0, 16)>0){
            _height2=_height2+1;
        }
        if(strtoul([[NSString stringWithFormat:@"%x",AckByte[10]] UTF8String], 0, 16)>0){
            _width2=_width2+1;
        }
        NSMutableArray *number = [[NSMutableArray alloc]init];
        
        [number addObject:[NSString stringWithFormat:@"%ld",(long)_red2]];
        [number addObject:[NSString stringWithFormat:@"%ld",(long)_green2]];
        [number addObject:[NSString stringWithFormat:@"%ld",(long)_blue2]];
        [number addObject:[NSString stringWithFormat:@"%ld",(long)_alpha2]];
        [number addObject:[NSString stringWithFormat:@"%ld",(long)_width2]];
        [number addObject:[NSString stringWithFormat:@"%ld",(long)_height2]];
        
        DLog(@"获取rgba===%lu,%lu,%lu,%lu,%lu,%lu",_red2,_green2,_blue2,_alpha2,_height2,_width2);
        
        //        硬件检测
         [self changedata:number];
    }

    
    
    
   
    
    

}

-(void)changeview
{

    newwareversion.text = [NSString stringWithFormat:@"%@: %@",[Config DPLocalizedString:@"adedit_zc20"],banben];



}
-(void)changedata:(NSMutableArray *)array
{
    labelred.text = array[0];
    labelgreen.text = array[1];
    labelblue.text = array[2];
//    labelred.text = array[3];
    labelx.text = array[4];
    labely.text = array[5];
//    labelred.text = array[6];
//    labelred.text = array[7];

    
    

}

-(void)initfirstview
{
    self.backgroundColor = [UIColor whiteColor];
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.frame.size.width, 20)];
    titlelabel.text = [Config DPLocalizedString:@"adedit_Hardware"];
    [self addSubview:titlelabel];
    
//    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, self.frame.size.width-50, 20)];
//    DLog(@"self===%@",self.yunpingname);
//    namelabel.text = [NSString stringWithFormat:@"%@: %@",[Config DPLocalizedString:@"adedit_LEDname"],self.yunpingname];
//    [self addSubview:namelabel];

  
    
////    亮度值
//    UILabel *brightlabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, 100, 20)];
//    brightlabel.text = [Config DPLocalizedString:@"adedit_Luminancestate"];
//    [self addSubview:brightlabel];
////    红
//    UIImageView *imageviewred = [[UIImageView alloc]initWithFrame:CGRectMake(70, 40, 20, 20)];
//    imageviewred.image = [UIImage imageNamed:@"dyt_red"];
//    [self addSubview:imageviewred];
//    labelred = [[UILabel alloc]initWithFrame:CGRectMake(imageviewred.frame.origin.x+25, imageviewred.frame.origin.y, 25, 20)];
//    labelred.text = @" ";
//    labelred.font = [UIFont systemFontOfSize:12];
//    [self addSubview:labelred];
////  绿色
//    
//    UIImageView *imageviewgreen = [[UIImageView alloc]initWithFrame:CGRectMake(labelred.frame.origin.x+25, labelred.frame.origin.y, 20, 20)];
//    imageviewgreen.image = [UIImage imageNamed:@"dyt_green"];
//    [self addSubview:imageviewgreen];
//    labelgreen = [[UILabel alloc]initWithFrame:CGRectMake(imageviewgreen.frame.origin.x+25, imageviewgreen.frame.origin.y, 25, 20)];
//    labelgreen.text = @" ";
//    labelgreen.font = [UIFont systemFontOfSize:12];
//    [self addSubview:labelgreen];
//
////    蓝色
//    
//    UIImageView *imageviewblue = [[UIImageView alloc]initWithFrame:CGRectMake(labelgreen.frame.origin.x+25, labelgreen.frame.origin.y, 20, 20)];
//    imageviewblue.image = [UIImage imageNamed:@"dyt_blue"];
//    [self addSubview:imageviewblue];
//    labelblue = [[UILabel alloc]initWithFrame:CGRectMake(imageviewblue.frame.origin.x+25, imageviewblue.frame.origin.y, 25, 20)];
//    labelblue.text = @" ";
//    labelblue.font = [UIFont systemFontOfSize:12];
//    [self addSubview:labelblue];
//
////    视频初始位置
//    UILabel *screenPosition = [[UILabel alloc]initWithFrame:CGRectMake(5, labelblue.frame.origin.y+25, 120, 20)];
//    screenPosition.text = [Config DPLocalizedString:@"adedit_cswz"];
//    [self addSubview:screenPosition];
//    
////    x
//    UILabel *screenlabelx = [[UILabel alloc]initWithFrame:CGRectMake(120, screenPosition.frame.origin.y, 25, 20)];
//    screenlabelx.text = @"x:";
//    
//    [self addSubview:screenlabelx];
//    labelx = [[UILabel alloc]initWithFrame:CGRectMake(screenlabelx.frame.origin.x+25, screenlabelx.frame.origin.y, 25, 20)];
//    labelx.text = @" ";
//    labelx.font = [UIFont systemFontOfSize:12];
//
//    [self addSubview:labelx];
//    
////   y
//    UILabel *screenlabely = [[UILabel alloc]initWithFrame:CGRectMake(labelx.frame.origin.x+25, screenPosition.frame.origin.y, 25, 20)];
//    screenlabely.text = @"y:";
//    
//    [self addSubview:screenlabely];
//    labely = [[UILabel alloc]initWithFrame:CGRectMake(screenlabely.frame.origin.x+25, screenlabely.frame.origin.y, 25, 20)];
//    labely.text = @" ";
//    labely.font = [UIFont systemFontOfSize:12];
//
//    [self addSubview:labely];

    
    
    
    
    
    
    //    硬件版本
    UILabel *Hardwareversion = [[UILabel alloc]initWithFrame:CGRectMake(5, titlelabel.frame.origin.y+20, self.frame.size.width/2, 25)];
    Hardwareversion.text = [NSString stringWithFormat:@"%@ : %@",[Config DPLocalizedString:@"Online_HardwareVersion"],@"4.1.0"];
    [self addSubview:Hardwareversion];
    
    
    
//    //    新版本
//    
    newwareversion = [[UILabel alloc]initWithFrame:CGRectMake(Hardwareversion.frame.size.width, Hardwareversion.frame.origin.y, Hardwareversion.frame.size.width, 25)];
    newwareversion.text = [NSString stringWithFormat:@"%@: %@",[Config DPLocalizedString:@"Soft_SoftVersionnow"],@" "];
    newwareversion.textAlignment = NSTextAlignmentCenter;
    [self addSubview:newwareversion];
//
    getnewbutton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2-30, Hardwareversion.frame.origin.y, 30, 25)];
    
    [getnewbutton setTitle:[Config DPLocalizedString:@"adedit_updata"] forState:UIControlStateNormal];
    getnewbutton.backgroundColor = [UIColor redColor];
    [getnewbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self addSubview:getnewbutton];

    
//
//    
//    
//    
//    
    //    近期30分钟cpu温度
    UILabel *cpuTemperature  = [[UILabel alloc]initWithFrame:CGRectMake(5, getnewbutton.frame.origin.y+20, self.frame.size.width/2, 30)];
    cpuTemperature.text = [NSString stringWithFormat:@"%@:",[Config DPLocalizedString:@"adedit_CPUtemperature"]];
    [self addSubview:cpuTemperature];
//
   cputembutton = [[UIButton alloc]initWithFrame:CGRectMake(cpuTemperature.frame.size.width+5, cpuTemperature.frame.origin.y, 50, 25)];
    //    更新
    [cputembutton setTitle:[Config DPLocalizedString:@"adedit_updata"] forState:UIControlStateNormal];
    cputembutton.backgroundColor = [UIColor cyanColor];
    
    [cputembutton addTarget:self action:@selector(upTemperature) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:cputembutton];
//    cputembutton.hidden = !self.showbutton;
//
//    
//    
    //    开机历史纪录
    UILabel *histore = [[UILabel alloc]initWithFrame:CGRectMake(5, cpuTemperature.frame.origin.y+30, self.frame.size.width/2, 30)];
    histore.text = [NSString stringWithFormat:@"%@ :",[Config DPLocalizedString:@"adedit_Bootrecord"]];
    [self addSubview:histore];
//
    historebutton = [[UIButton alloc]initWithFrame:CGRectMake(histore.frame.size.width+5, histore.frame.origin.y, 50, 25)];
    
    [historebutton setTitle:[Config DPLocalizedString:@"adedit_updata"] forState:UIControlStateNormal];
    historebutton.backgroundColor = [UIColor cyanColor];
    
    [historebutton addTarget:self action:@selector(unhistore) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:historebutton];
    
//    historebutton.hidden = !self.showbutton;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, historebutton.frame.origin.y +historebutton.frame.size.height + 50, self.frame.size.width, 44)];
    [btn setTitle:[Config DPLocalizedString:@"adedit_back"] forState:0];
    [btn addTarget:self action:@selector(backonclick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor cyanColor];
    [self addSubview:btn];
}

-(void)backonclick{
    [self removeFromSuperview];
}

//下载温度  并且预览
-(void)upTemperature
{
    
    
    
    temorhist = YES;
      //
    //温度
    [self ftphistore:1000 anduppath:@"cloudtest.txt" anddownpath:@"duanyutianTemperature.txt"];
}


-(void)unhistore
{
    
    temorhist = NO;
    //开机历史
    [self ftphistore:2000 anduppath:@"time.txt" anddownpath:@"duanyutianHistory.txt"];
    
}






//ftp
-(void)ftphistore:(NSInteger *)tag anduppath:(NSString *)uppath anddownpath:(NSString *)downpath
{
    
    if ([jianceip length]>0)
    {
        //        登陆
        requestsManager1 = [[GRRequestsManager alloc] initWithHostname:[[NSString alloc]initWithFormat:@"%@/config",jianceip]
                                                                  user:@"ftpuser"
                                                              password:@"ftpuser"];
        requestsManager1.delegate = self;
    }
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //    本地路径
    NSString *FilePath = [documentsDirectoryPath stringByAppendingPathComponent:downpath];
    
    
    
    //下载完存储目录
    
    
    
    //    [fileManager removeItemAtPath:FilePath error:nil];
    
    [requestsManager1 addRequestForDownloadFileAtRemotePath:uppath toLocalPath:FilePath];
    [requestsManager1 startProcessingRequests];
    
    
    
}

#pragma mark - GRRequestsManagerDelegate

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didStartRequest:(id<GRRequestProtocol>)request
{
    //    NSLog(@"requestsManager:didStartRequest:");
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteListingRequest:(id<GRRequestProtocol>)request listing:(NSArray *)listing
{
    //    DLog(@"1233213");
}
- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteCreateDirectoryRequest:(id<GRRequestProtocol>)request
{
    //    NSLog(@"requestsManager:didCompleteCreateDirectoryRequest:");
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteDeleteRequest:(id<GRRequestProtocol>)request
{
    //    NSLog(@"requestsManager:didCompleteDeleteRequest:");
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompletePercent:(float)percent forRequest:(id<GRRequestProtocol>)request
{
    //    NSLog(@"requestsManager:didCompletePercent:forRequest: %f", percent);
    
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteUploadRequest:(id<GRDataExchangeRequestProtocol>)request
{
    //    NSLog(@"requestsManager:didCompleteUploadRequest:");
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didCompleteDownloadRequest:(id<GRDataExchangeRequestProtocol>)request
{
    //    NSLog(@" 完成 ===requestsManager:didCompleteDownloadRequest:");
    
    
    
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *FilePath = [[NSString alloc]init];
    
    if (temorhist == YES) {
        FilePath = [documentsDirectoryPath stringByAppendingPathComponent:@"duanyutianTemperature.txt"];
        
    }else if (temorhist== NO)
    {
        FilePath = [documentsDirectoryPath stringByAppendingPathComponent:@"duanyutianHistory.txt"];
        
        
    }
    //    本地路径
    
    
    
    NSFileHandle * handle =  [NSFileHandle fileHandleForReadingAtPath:FilePath];
    NSData *data = [handle readDataOfLength:12];
    
    DLog(@"ewfesfsdfsdfsd====%@",data);
    
    NSString*str=[[NSString alloc] initWithContentsOfFile:FilePath];
    
    
    NSError *Error;
    
    NSString *Data = [NSString stringWithContentsOfFile:FilePath encoding:4 error:& Error];
    
    
    
    NSLog(@"我是段雨田==duan==%@",Data);
    
    //    NSFileManager * fm = [NSFileManager defaultManager];
    //
    //    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //
    //    //    本地路径
    //    NSString *FilePath = [documentsDirectoryPath stringByAppendingPathComponent:@"text"];
    //
    //    NSString *fileD = [FilePath stringByAppendingPathComponent:@"time.txt"];
    //
    //
    //
    //    NSDictionary * dict = [fm attributesOfItemAtPath:FilePath error:nil];
    //
    //    DLog(@"完成；  \\\====%@",dict);
    //
    //
    //    NSString*filePath=[[NSBundle mainBundle] pathForResource:FilePath ofType:@"txt"];
    //
    //    NSString*str=[[NSString alloc] initWithContentsOfFile:FilePath];
    //
    UITextView *label = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    
    label.text = Data;
    label.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dictore:)];
    [label addGestureRecognizer:tap];
    [self addSubview:label];
    
    
    
    NSLog(@"这是神噩梦%@",str);
    
    
}


- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didFailWritingFileAtPath:(NSString *)path forRequest:(id<GRDataExchangeRequestProtocol>)request error:(NSError *)error
{
    NSLog(@"requestsManager:didFailWritingFileAtPath:forRequest:error: \n %@", error);
}

- (void)requestsManager:(id<GRRequestsManagerProtocol>)requestsManager didFailRequest:(id<GRRequestProtocol>)request withError:(NSError *)error
{
    NSLog(@"requestsManager:didFailRequest:withError: \n %@", error);
}


-(void)dictore:(UITapGestureRecognizer *)mytap
{
    
    
    UILabel *label = (UILabel *)[mytap view];
    
    [label removeFromSuperview];
    
    
    //    删除文件
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *FilePath = [[NSString alloc]init];
    
    if (temorhist==YES) {
        
        
        //    本地路径
        FilePath = [documentsDirectoryPath stringByAppendingPathComponent:@"duanyutianTemperature.txt"];
        
    }else if(temorhist ==NO)
    {
        
        FilePath = [documentsDirectoryPath stringByAppendingPathComponent:@"duanyutianHistory.txt"];
        
    }
    
    
    //通过文件管理器获取文件属性然后通过字典获取文件长度
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:documentsDirectoryPath])
    {
        DLog(@"不存在这个地址");
        [fileManager createDirectoryAtPath:FilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if ([fileManager fileExistsAtPath:FilePath]) {
        DLog(@"有文件");
        NSDictionary * dict1 = [fileManager attributesOfItemAtPath:FilePath error:nil];
        //方法一:
        DLog(@" %d,第一次我想要的视频size = %lld",[fileManager fileExistsAtPath:FilePath],[dict1 fileSize]);
        
        [fileManager removeItemAtPath:FilePath error:nil];
        
        DLog(@" %d,第2次我想要的视频size = %lld",[fileManager fileExistsAtPath:FilePath],[dict1 fileSize]);
        
    }
    
    
    
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
