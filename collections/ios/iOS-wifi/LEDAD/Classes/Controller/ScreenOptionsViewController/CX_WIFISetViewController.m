//
//  CX_WIFISetViewController.m
//  LEDAD
//
//  Created by chengxu on 15/7/9.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "CX_WIFISetViewController.h"
#import "YXM_WiFiManagerViewController.h"
#import "Config.h"
#import "GDataXMLNode.h"
#import "AHReach.h"
#import "NSString+MD5.h"

#import "getgateway.h"
#import <arpa/inet.h>
#import <netdb.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <ifaddrs.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#include <sys/socket.h>


@interface CX_WIFISetViewController ()<ASIHTTPRequestDelegate>
{

    YXM_WiFiManagerViewController *cx;

 // 激活按钮
    UIButton *btn;
    //下一步
    UIButton *btn1;
    //完成
    UIButton *btn2;
    //绑定
    UIButton *btn5;
    
    UIImageView *imageview;
    BOOL isone;
    NSString* luyouList;
    NSMutableArray *arrlist;
    NSString *khlist;
    NSMutableArray *khdhcplist;
    NSMutableArray *maclist;
    AHReach *defaultHostReach;
    NSInteger num;
    
    NSString *ssid;
    
    
    NSString *myssid;
    
    NSString *ssid1;
    NSMutableArray *iparr;
    NSMutableArray *ssidarr;
    NSMutableArray *ledip;


    BOOL istrue;

    
    UIButton *qiaojieanniu;
    
    
}
@end

@implementation CX_WIFISetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    iparr = [[NSMutableArray alloc]init];
    ssidarr = [[NSMutableArray alloc]init];
    ledip = [[NSMutableArray alloc]init];
    
    num = 1;
    
    
    
    
//    [self hqkhd];
    self.view.backgroundColor = [UIColor whiteColor];
    
    cx = [[YXM_WiFiManagerViewController alloc]init];

    isone = YES;
    
    [self viewload];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self hqsj];


}

//视图加载
-(void)viewload{
    
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 2, 40, 40)];
    [closeButton addTarget:self action:@selector(removeSelfView:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"backToMainButton"] forState:UIControlStateNormal];
    if (DEVICE_IS_IPAD) {
        [self.view addSubview:closeButton];
    }
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-825)/2, 100, 825, 70)];
    [imageview setImage:[UIImage imageNamed:@"a1"]];
    [self.view addSubview:imageview];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(imageview.frame.origin.x, imageview.frame.origin.y + imageview.frame.size.height + 50, 300, 50)];
    lab.text = [NSString stringWithFormat:@"%@%ld%@：",[Config DPLocalizedString:@"adedit_jhyp1"],(long)fangannum,[Config DPLocalizedString:@"adedit_jhyp2"]];
    [self.view addSubview:lab];
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(lab.frame.origin.x, lab.frame.origin.y + lab.frame.size.height + 30, 300, 50)];
    lab1.text = [Config DPLocalizedString:@"adedit_jhyp3"];
    [self.view addSubview:lab1];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(lab1.frame.origin.x, lab1.frame.origin.y + lab1.frame.size.height + 5, 300, 50)];
    lab2.text = [Config DPLocalizedString:@"adedit_jhyp4"];
    [self.view addSubview:lab2];
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(lab2.frame.origin.x, lab2.frame.origin.y + lab2.frame.size.height + 80, 300, 50)];
    lab3.text = [Config DPLocalizedString:@"adedit_jhyp5"];
    [self.view addSubview:lab3];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(imageview.frame.origin.x + imageview.frame.size.width - 260, lab.frame.origin.y, 200, 260)];
    image.image = [UIImage imageNamed:@"kk"];
    [self.view addSubview:image];
    UIView *shwoview = [[UIView alloc]initWithFrame:CGRectMake(imageview.frame.origin.x + imageview.frame.size.width - 260, lab.frame.origin.y, 200, 260)];
    UILabel *slab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, shwoview.frame.size.width - 20, shwoview.frame.size.height/7)];
    slab.text = [Config DPLocalizedString:@"adedit_jhyp6"];
    [shwoview addSubview:slab];
    for (int i = 0; i<6; i++) {
       UILabel *ssidlab = [[UILabel alloc]initWithFrame:CGRectMake(slab.frame.origin.x, (slab.frame.size.height)*(i+1), shwoview.frame.size.width - 20, shwoview.frame.size.height/7)];
        ssidlab.text = [Config DPLocalizedString:@"adedit_jhyp7"];
        ssidlab.tag = i+1;
        [shwoview addSubview:ssidlab];
    }
    [self.view addSubview:shwoview];
    
    // 激活
    btn  = [[UIButton alloc]initWithFrame:CGRectMake(500, 550, 100, 50)];
    [btn setTitle:[Config DPLocalizedString:@"adedit_jhyp8"] forState:0];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [btn addTarget:self action:@selector(hqssid) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn];

//  下一步
    btn1  = [[UIButton alloc]initWithFrame:CGRectMake(500, 550, 100, 50)];
    [btn1 setTitle:[Config DPLocalizedString:@"adedit_jhyp11"] forState:0];
    [btn1 setTitleColor:[UIColor blackColor] forState:0];
    [btn1 addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn1];
    btn1.hidden = YES;
//  完成
    btn2  = [[UIButton alloc]initWithFrame:CGRectMake(500, 550, 100, 50)];
    [btn2 setTitle:[Config DPLocalizedString:@"adedit_jhyp13"] forState:0];
    [btn2 setTitleColor:[UIColor blackColor] forState:0];
    [btn2 addTarget:self action:@selector(wancheng) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn2];
    btn2.hidden = YES;

    //  绑定
    btn5  = [[UIButton alloc]initWithFrame:CGRectMake(500, 550, 100, 50)];
    [btn5 setTitle:[Config DPLocalizedString:@"adedit_jhyp12"] forState:0];
    [btn5 setTitleColor:[UIColor blackColor] forState:0];
    [btn5 addTarget:self action:@selector(bangding) forControlEvents:UIControlEventTouchUpInside];
    [btn5 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn5];
    btn5.hidden = YES;

    //重置
    
    UIButton *btn3  = [[UIButton alloc]initWithFrame:CGRectMake(400, 550, 100, 50)];
    [btn3 setTitle:[Config DPLocalizedString:@"adedit_jhyp10"] forState:0];
    [btn3 setTitleColor:[UIColor blackColor] forState:0];
    [btn3 addTarget:self action:@selector(cz) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn3];
    
    
    //桥接按钮
    
    
    qiaojieanniu = [[UIButton alloc]initWithFrame:CGRectMake(500, 550, 100, 50)];
    [qiaojieanniu setTitle:@"桥接" forState:0];
    [qiaojieanniu setTitleColor:[UIColor blackColor] forState:0];

//    qiaojieanniu.backgroundColor  = [UIColor redColor];
    [qiaojieanniu setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];

    [qiaojieanniu setTitleColor:[UIColor blackColor] forState:0];
    [qiaojieanniu addTarget:self action:@selector(yanzheng) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qiaojieanniu];
    qiaojieanniu.hidden = YES;
    

    
}





-(void)wancheng{
    
    // 打开主屏的dhcp
//    [cx dhpcnum:[NSString stringWithFormat:@"192.168.0.%d",1]];

//    sleep(15);
    
    DLog(@"点击了完成云屏按钮");
    
    [self cx_yy];
    [self ProgramName];
}

-(void)ProgramName{
    
    UIView *view = [self.view viewWithTag:3000];
    if (view) {
        UIAlertView *aletview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_jhyp16"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles:@"取消", nil];
        aletview.tag = 7000;
        aletview.alertViewStyle = UIAlertViewStylePlainTextInput;
        [aletview show];
    }
}
//重置
-(void)cz{
    
    [cx hf];
}

//  绑定 按钮事件
-(void)bangding{
    
    
    
    
    
    
    NSLog(@"点击了绑定");
//    [self hqkhd];
    
    
    
    
    [self hqkhd];
    
    
    
    
    
    
    
    
}

//返回上界面

-(void)removeSelfView:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//生成xml
-(void)createxml{
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"LEDS"];
    GDataXMLElement *numberip = [GDataXMLNode elementWithName:@"numberip"];

    GDataXMLElement *explanation = [GDataXMLNode elementWithName:@"explanation"];
    [numberip addChild:explanation];
    DLog(@"%@",fanganname);
    GDataXMLElement *name = [GDataXMLNode elementWithName:@"name" stringValue:[NSString stringWithFormat:@"%@",fanganname]];
    [numberip addChild:name];
    GDataXMLElement *NUM = [GDataXMLNode elementWithName:@"num" stringValue:[NSString stringWithFormat:@"%ld",(long)fangannum]];
    [numberip addChild:NUM];

    [rootElement addChild:numberip];
    for (int i = 0; i<iparr.count; i++) {
        GDataXMLElement *play = [GDataXMLNode elementWithName:@"play"];
        GDataXMLElement *explanation = [GDataXMLNode elementWithName:@"explanation"];
        [play addChild:explanation];
        GDataXMLElement *dataip = [GDataXMLNode elementWithName:@"dataip" stringValue:iparr[i]];
        [play addChild:dataip];
        GDataXMLElement *dataname = [GDataXMLNode elementWithName:@"dataname" stringValue:ssidarr[i]];
        [play addChild:dataname];
        GDataXMLElement *dataledip = [GDataXMLNode elementWithName:@"dataledip" stringValue:ledip[i]];
        [play addChild:dataledip];
        GDataXMLElement *dataid;
        if (i == 0) {
            dataid = [GDataXMLNode elementWithName:@"dataid" stringValue:@"1"];

        }else{
            dataid = [GDataXMLNode elementWithName:@"dataid" stringValue:@"0"];
        }
        [play addChild:dataid];
        [rootElement addChild:play];
    }

    //使用根节点创建xml文档
    GDataXMLDocument *rootDoc = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    DLog(@"11111%@",rootDoc);
    //设置使用的xml版本号
    [rootDoc setVersion:@"1.0"];
    //设置xml文档的字符编码
    [rootDoc setCharacterEncoding:@"utf-8"];
    //获取并打印xml字符串
    NSString *XMLDocumentString = [[NSString alloc] initWithData:rootDoc.XMLData encoding:NSUTF8StringEncoding];
    DLog(@"22%@",XMLDocumentString);
    //文件字节大小
    NSInteger fileSize = [rootDoc.XMLData length];
    DLog(@"%ld",(long)fileSize);

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

    NSString *myname = [self getNowdateString];
    myname = [myname md5Encrypt];


    NSString *xmlfilePath = [[NSString alloc]initWithFormat:@"%@/%@.xml",documentsDirectoryPath,myname];

    DLog(@"------%@",xmlfilePath);

    NSError *error = nil;
    BOOL writeFileBool = [XMLDocumentString writeToFile:xmlfilePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSArray *files = [fileManager subpathsAtPath: documentsDirectoryPath];
    NSLog(@"%@",files);
    NSDictionary * dict = [fileManager attributesOfItemAtPath:xmlfilePath error:nil];
    //方法一:

    NSLog(@"22222222size = %lld",[dict fileSize]);
    if (writeFileBool) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//获取时间字符串
-(NSString *)getNowdateString{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    return [formatter stringFromDate:[NSDate date]];
}

//下一步 按钮响应
-(void)next{
    
    num ++;

    Isshow = NO;
    isone = NO;
    
    isnext = YES;
    
    DLog(@"下一步");
    
    

    [self hqsj];
    
    [imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"a%ld",(long)num]]];
    
    
    
 //    btn1.hidden = YES;
    //修改ip
    
//    [cx editIP:[NSString stringWithFormat:@"192.168.0.%ld",(long)num]];
    
//    sleep(20);
    
    
    
    
    
    
    
    //先绑定
    
    
   
    
    
    
   
//    
//    [imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"a%ld",(long)num]]];
//    
//    // 激活
//    btn.hidden = NO;
//    
//    btn1.hidden = YES;
    
}

//  桥接
-(void)yanzheng{
    
    
    
    NSString *strongip = [self getipstring];
    NSArray *myarray = [strongip componentsSeparatedByString:@"."];
    if (![myarray[0] isEqualToString:@"192"]) {
        [self showAlertView:@"请检查wifi"];
        strongip = [self routerIp];
    }

    
    [self showalertviewwithstring:@"自屏桥接中"];
    
    
    NSString *rootLoginString = [NSString stringWithFormat:@"http://%@",[self routerIp]];
    NSURL *url = [NSURL URLWithString:rootLoginString];
    ASIHTTPRequest *getRootInfo = [[ASIHTTPRequest alloc]initWithURL:url];
    
    [getRootInfo setCompletionBlock:^{
        
        NSString *responseString = [getRootInfo responseString];
        
        if (responseString != nil) {
            
            for (NSArray *arr in arrlist) {
                
                NSLog(@"======%@    %@",ssid,arrlist);
                if ([ssid isEqualToString:arr[0]]) {
                    
                    DLog(@"这算什么数组%@",arr);
                    
                    //        桥接  名字  和编号                                              showlable.text = @"桥接 4/4";
                    if (isnext) {
                        
                        //  桥接
                        [cx WANsub:arr[0] lyid:arr[2] wifipwd:@"12345678" andnum:num];
                        
                        cx.xiugaidhcp = ^(void)
                        {
                            
                            [self xiugaidhcp];
                            
                        };
//                        sleep(10);


                    }else
                    {
                    [self showAlertView:@"已经完成桥接"];
                    }
                    
            
                    
                    
                }
            }
        }
    }];
    
    
    [getRootInfo setFailedBlock:^{
        DLog(@"桥接请求失败");
        
        [self dismissalertview];
        
        [self showAlertView:@"桥接失败 ！请检测wifi网关是否正确!"];
        
//        [cx dhpcnum:[NSString stringWithFormat:@"192.168.0.%d",num]];
        
        

    }];
    [getRootInfo startAsynchronous];
}


-(void)xiugaidhcp
{
    
    
//    NSString *strongip = [self getipstring];
//    NSArray *myarray = [strongip componentsSeparatedByString:@"."];
//    if (![myarray[0] isEqualToString:@"192"]) {
//        [self showAlertView:@"请检查wifi"];
//        strongip = [self routerIp];
//    }

    
    [self showalertviewwithstring:@"子屏打开dhcp中"];
    
    if (num   == fangannum) {
        
        NSLog(@"全部桥接成功le");
        
        // 打开最后一个的dhcp
        [cx dhpcnum:[NSString stringWithFormat:@"192.168.0.%d",num]];
        cx.Opengdhcp = ^(void)
        {
            [self dismissalertview];
            [self showAlertView:@"打开dhcp成功!"];
            qiaojieanniu.hidden = YES;
            btn2.hidden = NO;
//            [self showalertviewwithstring:@"子屏打开dhcp成功"];
        
        };
        
        
//        [cx alert:[Config DPLocalizedString:@"User_Prompt"] alertMsg:[Config DPLocalizedString:@"adedit_wifi11"]];
        
        //                        [cx dhpcnum:[NSString stringWithFormat:@"192.168.0.%d",num]];
        
        //                        sleep(15);
        //                        btn2.hidden = YES;
        //                        btn5.enabled = YES;
        isnext = NO;
        
        
        
        
        
        
    }else
        
    {
        
        
        DLog(@"桥接成功之后  子屏尚未完成全部的");
        
        [cx dhpcnum:[NSString stringWithFormat:@"192.168.0.%d",num]];
        
        cx.Opengdhcp = ^(void)
        {
            [self dismissalertview];
            [self showAlertView:@"DHCP已经打开"];
            btn.hidden = YES;
            //        下一步
            btn1.hidden = NO;
            
            btn2.hidden = YES;
            
            btn5.hidden = YES;
            qiaojieanniu.hidden = YES;
        
        };
        
        
        
        
    }
    


}


-(void)wifi{
    
//    defaultHostReach = [AHReach reachForDefaultHost];
//    [defaultHostReach startUpdatingWithBlock:^(AHReach *reach) {
//        [self updateAvailabilityField:nil withReach:reach];
//    }];
//    [self updateAvailabilityField:nil withReach:defaultHostReach];
    DLog(@"子屏验证");
    
    
    qiaojieanniu.hidden = NO;
    btn.hidden = YES;
    btn2.hidden = YES;
    btn1.hidden = YES;
    
    if ([self routerIp].length !=0) {
        
    
    
    
    if (isone) {
        //            showlable.text = @"密码 4/4";
        DLog(@"修改主屏密码");
        isone = NO;
        
    }else{
        
        
        
        //            if (!issuccse) {
        //                return;
        //            }
        
        
        if (num > 1) {
            
            DLog(@"子屏wifi ");
//            
            
//            [self yanzheng];
            //                if (num == fangannum) {
            //                    sleep(40);
            //                    [self hqkhd];
            //                }
        }
        
    }
    
    
    
    
    
    
    UIView *view = [self.view viewWithTag:3000];
    if (view) {
        [view removeFromSuperview];
    }
    
    if (num==fangannum) {
        DLog(@"如果子屏全部成功");
        btn1.hidden = YES;
        btn.hidden = YES;
        btn2.hidden = NO;
        
        //完成出现
        btn5.hidden = YES;
        
        
    }else{
        NSLog(@"切换wifi");
        btn1.hidden = NO;
        btn.hidden = YES;
        
        
        
        
        
    }
    UILabel *lab = (UILabel *)[self.view viewWithTag:num];
    lab.text = [NSString stringWithFormat:@"%@",ssid1];
    
       }else{
    //对不起 请链接云片
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_jhyp14"] delegate:self cancelButtonTitle:nil otherButtonTitles:[Config DPLocalizedString:@"adedit_jhyp15"], nil];
    alert.delegate = self;
    alert.tag = 1000;
    [alert show];

       }
    
    
    [self dismissalertview];
    
}

- (void)updateAvailabilityField:(UITextField *)field withReach:(AHReach *)reach {
    
    if([reach isReachableViaWiFi]){
        DLog(@"已连接wifi");
//        if (isone) {
//            //            showlable.text = @"密码 4/4";
//            DLog(@"修改主屏密码");
//            isone = NO;
//            
//        }else{
//            
//            
//            
////            if (!issuccse) {
////                return;
////            }
//            
//            
//            if (num > 1) {
//                
//                DLog(@"子屏wifi ");
//                
//
//                [self yanzheng];
//                //                if (num == fangannum) {
//                //                    sleep(40);
//                //                    [self hqkhd];
//                //                }
//            }
//
//        }
//        
//        
//        
//        
//        
//        
//        UIView *view = [self.view viewWithTag:3000];
//        if (view) {
//            [view removeFromSuperview];
//        }
//        
//        if (num==fangannum) {
//            DLog(@"如果子屏全部成功");
//            btn1.hidden = YES;
//            btn.hidden = YES;
//            btn2.hidden = NO;
//            
//            //完成出现
//            btn5.hidden = YES;
//            
//            
//        }else{
//            NSLog(@"切换wifi");
//            btn1.hidden = NO;
//            btn.hidden = YES;
//        }
//        UILabel *lab = (UILabel *)[self.view viewWithTag:num];
//        lab.text = [NSString stringWithFormat:@"%@",ssid1];
//
//    }else{
//        //对不起 请链接云片
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_jhyp14"] delegate:self cancelButtonTitle:nil otherButtonTitles:[Config DPLocalizedString:@"adedit_jhyp15"], nil];
//        alert.delegate = self;
//        alert.tag = 1000;
//        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 7000) {
        if (buttonIndex == 0) {
            UITextField *myfid = [alertView textFieldAtIndex:0];
            fanganname = myfid.text;
            [self createxml];
        }
    }
    
}

//一键桥接   激活
-(void)setting{
    
    DLog(@"点击激活 时 //  或者子屏激活");
    [iparr addObject:[NSString stringWithFormat:@"192.168.0.%ld",(long)num]];
    [ssidarr addObject:ssid1];
    [ledip addObject:[NSString stringWithFormat:@"192.168.0.%ld",(long)(188 + num * 10)]];
    
    
    if (isone) {
        //        showlable.text = @"信道 1/4";
        // 30
        
        
        
            
            [self hqkhd];
        
        
//            sleep(15);
        
            
        

        
        
        DLog(@"主屏信道")
        

        
        
        
//        [self  hqkhd];

    }else{
        
        
        
        
        DLog(@"子屏激活===子屏修改wifi");
        
        //        showlable.text = @"修改IP 1/4";  请静待15秒
        [self showalertviewwithstring:@"子屏修改ip"];
        [cx editIP:[NSString stringWithFormat:@"192.168.0.%ld",(long)num]];
        
        cx.edingip = ^(void)
        {
//            [self dismissalertview];
            
            [self wifi];
        };
        
//
//        sleep(30);
        
        
        
        
//        [self wifi];
        

    }
}


//获取数据
-(void)hqsj{
    
    
    
    [self showalertviewwithstring:@"获取列表中"];

//    DLog(@"我获取的地址=====%@",[self routerIp]);
    
//    if ([self routerIp]) {
//        <#statements#>
//    }
    
    
    
    NSString *strongip = [self getipstring];
    NSArray *myarray = [strongip componentsSeparatedByString:@"."];
    if (![myarray[0] isEqualToString:@"192"]) {
        [self showAlertView:@"请检查wifi"];
        strongip = [self routerIp];
    }
    

    
    NSString *rootLoginString1 = [NSString stringWithFormat:@"http://%@/goform/WDSScan",[self routerIp]];
    
    
    DLog(@"获取数据＝＝＝＝＝%@",rootLoginString1);
    
    
    NSURL *url1 = [NSURL URLWithString:rootLoginString1];
    
    ASIHTTPRequest *getRootInfo1 = [[ASIHTTPRequest alloc]initWithURL:url1];

    [getRootInfo1 setCompletionBlock:^{
        
        
        DLog(@"获取数据请求%@",[getRootInfo1 responseString]);
        
        luyouList = [getRootInfo1 responseString];
        
        // 点击下一步
        [self hqmac];
        
        
        if (!isone) {
            
            btn.hidden = YES;
            //绑定出现
            btn5.hidden  = NO;

        }
        
        if (Isshow) {
            btn.hidden = NO;
            btn5.hidden  = YES;

        }
        
        

    }];
    
    
    [getRootInfo1 setFailedBlock:^{
       
        DLog(@"初始化获取数据失败");
        
        [self showAlertView:@"请检查wifi连接"];
        
//        sleep(5);
        
        [self performSelector:@selector(hqsj) withObject:nil afterDelay:5];

//        [self hqsj];
        
        
    }];
    
    [getRootInfo1 startAsynchronous];
    
}

//
-(void)hqmac{
    
//    if (!isone) {
//        return;
//    }
//    
    
    NSArray *arr = [[NSArray alloc]init];
    arr =[luyouList componentsSeparatedByString:@"\r"];
    arrlist = [[NSMutableArray alloc]init];
    
    for (int i =0; i<arr.count; i++) {
        
        NSArray *arr1 = [arr[i] componentsSeparatedByString:@"\t"];
        [arrlist addObject:arr1];
        
//        DLog(@"wifi数组%@",arr1);
    }
 
    
    
    
//    
//    btn.enabled = YES;
//    btn.hidden = NO;
//    
//    
//    sleep(10);
//
    
    // 激活
//    [self wifi];
    DLog(@"wifi数组＝＝＝%@",arrlist);
    
    
    [self dismissalertview];
    [self showAlertView:@"获取列表成功!"];

}

//获取客户端列表
-(void)hqdhcp{
    
    
    
    khdhcplist = [[NSMutableArray alloc]init];
    maclist = [[NSMutableArray alloc]init];
    NSArray *arr = [khlist componentsSeparatedByString:@"("];
    DLog(@"%@",arr);
    NSArray *arr1 = [arr[1] componentsSeparatedByString:@")"];
    DLog(@"%@",arr1);
    NSArray *arr2 = [arr1[0] componentsSeparatedByString:@"'"];
    DLog(@"%@",arr2);
    for (int i = 0; i < arr2.count; i ++) {
        if (i % 2 != 0) {
            NSArray * arr3 = [arr2[i] componentsSeparatedByString:@";"];
            DLog(@"%@",arr3);
            if ([arr3[0] componentsSeparatedByString:@"ledmedia"].count > 1) {
                [khdhcplist addObject:arr3];
            }
        }
    }
    
    
    DLog(@"khdhcplist=======%@",khdhcplist);

    if (khdhcplist.count != 1 ) {
        
        [self showAlertView:@"请确认路由器是否绑定过"];
        
        [self performSelector:@selector(hqkhd) withObject:nil afterDelay:4];
//        sleep(3);
    
        
        //绑定ip
//        [self hqkhd];
        
    }else{
        
        
        [self showalertviewwithstring:@"绑定中"];
        
        //绑定
        [cx dhcpipbangding:khdhcplist andtag:num];
        
        
        cx.bangding = ^(void)
        {
            
            
            
         
            
            
            [self bangdingip];
            
        };

        
        
        // 修改密码
//        [self  hqkhd];

        
        
        
        
//        [cx dhcpList:khdhcplist];
    }
    
    DLog(@"%@",khdhcplist);
    //    NSArray *arr4 = [khlist componentsSeparatedByString:@"StaticList = new Array"];
    //    NSArray *arr5 = [arr4[1] componentsSeparatedByString:@"("];
    //    DLog(@"%@",arr5);
    //    NSArray *arr6 = [arr5[1] componentsSeparatedByString:@")"];
    //    DLog(@"%@",arr6);
    //    NSArray *arr7 = [arr6[0] componentsSeparatedByString:@"'"];
    //    DLog(@"%@",arr7);
    //    for (int i = 0; i< arr7.count; i++) {
    //        if (i % 2 != 0) {
    //            NSArray *arr8 = [arr7[i] componentsSeparatedByString:@";"];
    //            DLog(@"%@",arr8);
    //            [maclist addObject:arr8];
    //        }
    //    }
    //    DLog(@"%@",maclist);
}


-(void)bangdingip
{

    
    btn5.hidden = YES;
    
    
    btn2.hidden = YES;
    
    btn1.hidden = YES;

    
    if (isone) {
        
        
        
//        sleep(10);
        
        //修改信道
        [self showalertviewwithstring:@"主屏修改信道"];
        
        [cx submitButtonClicked:ssid];
        
        cx.xiugaidhcp = ^(void)
        {
            
            
            [self changemianxindao];
            
        };
        
//        sleep(30);
        //        showlable.text = @"dhcp 2/4";
        //  修改密码  设置主屏
        
        //        [cx dhpc:@"192.168.0.100" IP2:@"192.168.0.190"];
  
        
        
        
    }else
    {
        //子屏   激活按钮出现
        
        btn.hidden = NO;
        
        btn1.hidden = YES;
        
        Isshow =  YES;
        DLog(@"  请等待20");
        
//        sleep(20);
        
        [self hqsj];
        
        
        //            sleep(20);
        
        //修改子屏密码
        
        
        
        
        
        
    }

}

-(void)changemianxindao
{
    //            [cx dhpcnum:[NSString stringWithFormat:@"192.168.0.%d",num]];
    // 主屏修改密码
    
    [self showalertviewwithstring:@"主屏修改密码"];
    
    [cx editPassword];
    
    cx.changepassword = ^(void)
    {
        
        
        [self dismissalertview];

        
        [self showAlertView:@"修改成功!"];
        UIView *view = [self.view viewWithTag:3000];
        if (view) {
            [view removeFromSuperview];
        }
        
        if (num==fangannum) {
            
            btn1.hidden = YES;
            btn.hidden = YES;
            btn2.hidden = YES;
            //绑定出现
            btn5.hidden = NO;
            
        }else{
            
            
            NSLog(@"切换wifi");
            
            btn1.hidden = NO;
            if (!isone) {
                
                btn1.hidden = YES;
            }
            btn.hidden = YES;
        }
        
        
    };
    
//    sleep(15);
    
    //        [cx dhcpipbangding:khdhcplist andtag:num];
    
//    DLog(@"继续30秒");
    
    //        showlable.text = @"MAC地址 3/4";
    //            [self wifi];
    
    

}


//获取客户端列表
-(void)hqkhd{
    
    DLog(@"获取客户端 绑定的步骤    dhcp 客户端列表界面");
    
    NSString *strongip = [self getipstring];
    NSArray *myarray = [strongip componentsSeparatedByString:@"."];
    if (![myarray[0] isEqualToString:@"192"]) {
        [self showAlertView:@"请检查wifi"];
        strongip = [self routerIp];
    }
    

    [self showalertviewwithstring:@"绑定中"];

    
    NSString *rootLoginString = [NSString stringWithFormat:@"http://%@/lan_dhcp_clients.asp",[self routerIp]];
    
    DLog(@"客户端列表======%@",rootLoginString);
    NSURL *url = [NSURL URLWithString:rootLoginString];
    
    ASIHTTPRequest *getRootInfo = [[ASIHTTPRequest alloc]initWithURL:url];
    
    __block ASIHTTPRequest *weaf = getRootInfo;
    
    [getRootInfo setCompletionBlock:^{
        
        DLog(@"绑定成功%@",[weaf responseString]);
        
        khlist = [weaf responseString];
        
        
        [self hqdhcp];
        
    }];
    
    [getRootInfo setFailedBlock:^{
       
//        sleep(3);
        
        [self showAlertView:@"获取客户端列表失败"];
        
        [self performSelector:@selector(hqkhd) withObject:nil afterDelay:3];
//        [self hqkhd];
        DLog(@"绑定失败了＝＝＝");
    }];
    
    [getRootInfo startAsynchronous];
}



//  激活
-(void)hqssid{

    
    DLog(@"a 点击了激活主屏激活按钮  和子屏 激活 同时调用");
    
    if (fangannum == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入需要激活的屏的个数" delegate:self cancelButtonTitle:nil otherButtonTitles:[Config DPLocalizedString:@"NSStringYes"], nil];
        [alert show];
    }else{
        
        
        //        cxdown = [[CX_CountdownViewController alloc]init];
        //        [self presentViewController:cxdown animated:YES completion:nil];
        //        cxview = [[CX_CountdownView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        //        [self.view addSubview:cxview];
        
        
        
        
//        [self cx_yy];
        
        NSString *strongip = [self getipstring];
        NSArray *myarray = [strongip componentsSeparatedByString:@"."];
        if (![myarray[0] isEqualToString:@"192"]) {
            [self showAlertView:@"请检查wifi"];
            strongip = [self routerIp];
        }
        

        
        [self showalertviewwithstring:@"激活中"];
        
        
        
        
        
        
        NSString *rootLoginString = [NSString stringWithFormat:@"http://%@",[self routerIp]];
        NSURL *url = [NSURL URLWithString:rootLoginString];
        
        ASIHTTPRequest *getRootInfo = [[ASIHTTPRequest alloc]initWithURL:url];
        
        [getRootInfo setCompletionBlock:^{
            
            DLog(@"主屏激活或者子屏%@",[getRootInfo responseString]);
            
            NSString *responseString = [getRootInfo responseString];
            
            [self settingWifiInfo:[self infoAnaylis:responseString]];
            
        }];
        
        [getRootInfo setFailedBlock:^{
            
            [self dismissalertview];
            
            [self showAlertView:@"请确认wifi连接是否正常!"];
            
            DLog(@"获取列表失败－－－－－－－导致激活失败");
            
//            [self performSelector:@selector(hqssid) withObject:nil afterDelay:5];
            
            
            
        }];
        [getRootInfo startAsynchronous];
    }
    
}

//阴影层
-(void)cx_yy{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.tag = 3000;
    view.backgroundColor = [UIColor blackColor];
    view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
    [self.view addSubview:view];
}



-(void)settingWifiInfo:(NSDictionary *)infoDict{
    
    
    if (num == 1) {
        // 主屏
        ssid = [infoDict objectForKey:@"name"];
    }else
    {
        myssid  = [infoDict objectForKey:@"name"];
        
    }
    
    ssid1 = [infoDict objectForKey:@"name"];
    [self setting];
}

-(NSDictionary *)infoAnaylis:(NSString *)responseString{
    /*---------------在串中搜索子串----------------*/
    DLog(@"%@",responseString);

    NSString *string1 = @"def_wirelesspassword";
    NSRange range = [responseString rangeOfString:string1];
    NSInteger location = range.location;


    //-substringFromIndex: 以指定位置开始（包括指定位置的字符），并包括之后的全部字符
    NSString *string2 = [responseString substringFromIndex:location];


    NSString *string3 = @"\";";
    NSRange range3 = [string2 rangeOfString:string3];
    NSInteger location3 = range3.location;


    NSString *string4 = [string2 substringWithRange:NSMakeRange(0, location3)];
    DLog(@"string4 = %@",string4);

    NSArray *string4Array = [string4 componentsSeparatedByString:@"\""];
    DLog(@"string4Array = %@",string4Array);
    NSString *password = [string4Array objectAtIndex:1];
    NSString *wifiname = [string4Array lastObject];
    NSDictionary *wifiinfoDict = [[NSDictionary alloc]initWithObjectsAndKeys:password,@"pwd",wifiname,@"name",nil];
    return wifiinfoDict;
}




- (NSString *)routerIp
{
    
    
//    int i = 0;
    
    
    NSString *string = [self getipstring];
    
    NSArray *array = [string componentsSeparatedByString:@"."];
    
//    if (![array[0] isEqualToString:@"192"]) {
//        [self showalertviewwithstring:@"请确保wifi连接正常!"];
//    }
    
    
    while ((![array[0] isEqualToString:@"192"])) {
        
        [self showAlertView:@"请检查wifi"];
        
        
        sleep(3);

        string = [self getipstring];
//        i++;
        array = [string componentsSeparatedByString:@"."];
        
    }
    
    
    
    return string;
    
    
    
    
    
}





-(NSString *)getipstring
{

    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        //*/
        while(temp_addr != NULL)
        /*/
         int i=255;
         while((i--)>0)
         //*/
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String //ifa_addr
                    //ifa->ifa_dstaddr is the broadcast address, which explains the "255's"
                    //                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
                    
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                    //routerIP----192.168.1.255 广播地址
                    NSLog(@"broadcast address--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)]);
                    //--192.168.1.106 本机地址
                    NSLog(@"local device ip--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]);
                    //--255.255.255.0 子网掩码地址
                    NSLog(@"netmask--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)]);
                    //--en0 端口地址
                    NSLog(@"interface--%@",[NSString stringWithUTF8String:temp_addr->ifa_name]);
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    
    
    in_addr_t i =inet_addr([address cStringUsingEncoding:NSUTF8StringEncoding]);
    in_addr_t* x =&i;
    
    
    unsigned char *s=getdefaultgateway(x);
    NSString *ip=[NSString stringWithFormat:@"%d.%d.%d.%d",s[0],s[1],s[2],s[3]];
    free(s);
    
    //    while ([ip isEqualToString:@"64.70.98.51"]) {
    //     ip = [self routerIp];
    //    }
    DLog(@"ip=====%@",ip);
    return ip;

    




}

//提示语
-(void)showalertviewwithstring:(NSString *)messge
{
    if (My_Alertview !=nil) {
        [self dismissalertview];
    }
    
    My_Alertview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:messge delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [My_Alertview show];

}

-(void)dismissalertview
{
    if (My_Alertview !=nil) {
        [My_Alertview dismissWithClickedButtonIndex:[My_Alertview cancelButtonIndex] animated:YES];
        [My_Alertview removeFromSuperview];
        My_Alertview = nil;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
