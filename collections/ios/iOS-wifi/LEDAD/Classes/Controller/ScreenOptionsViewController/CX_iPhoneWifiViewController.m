//
//  CX_iPhoneWifiViewController.m
//  LEDAD
//
//  Created by chengxu on 15/7/22.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "CX_iPhoneWifiViewController.h"
#import "YXM_WiFiManagerViewController.h"
#import "Config.h"
#import "GDataXMLNode.h"
#import "CX_MODEL.h"
#import "AHReach.h"
#import "CX_CountdownView.h"
#import "CX_CountdownViewController.h"
#import "NSString+MD5.h"

@interface CX_iPhoneWifiViewController ()<ASIHTTPRequestDelegate,UITextFieldDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>

{
    YXM_WiFiManagerViewController *cx;
    CX_CountdownView *cxview;
    CX_CountdownViewController *cxdown;
    CX_MODEL *cx_model;
    UIButton *btn;
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn5;
    UIImageView *imageview;
    BOOL isone;
    NSString* luyouList;
    NSMutableArray *arrlist;
    NSString *khlist;
    NSMutableArray *khdhcplist;
    NSMutableArray *maclist;
    NSInteger num;
    NSString *ssid;
    NSString *ssid1;
    NSMutableArray *iparr;
    NSMutableArray *ssidarr;
    NSMutableArray *ledip;
    
    AHReach *defaultHostReach;
    
    UILabel *showlable;
    UILabel *setinglab;
    NSTimer *time;
    NSInteger index;
    NSString *str;
    BOOL ISONE;

    BOOL istrue;
    UITextField *fid;//luyouIP
    UIView *ipview;
    UIView *qjview;//桥接
    UITextField *wifipwd;
    UITableView *mytable;
    NSString *lyname;
    NSString *lypwd;
    NSString *lyid;
    UIButton *btn3;
    UIButton *btn4;
}
@end

@implementation CX_iPhoneWifiViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    index = 0;
    
    iparr = [[NSMutableArray alloc]init];
    
    ssidarr = [[NSMutableArray alloc]init];
    
    cx_model = [[CX_MODEL alloc]init];
    
    
    ledip = [[NSMutableArray alloc]init];
    
    num = 1;
    
    isone = YES;
    ISONE = YES;
    
    [self hqsj];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    cx = [[YXM_WiFiManagerViewController alloc]init];
    
    NSString * name = [CX_MODEL getWifiName];
    
    DLog(@"wifiname===%@",name);
    
    [self viewload];
    // Do any additional setup after loading the view.
}



-(void)wifi{
    
    defaultHostReach = [AHReach reachForDefaultHost];
    
    [defaultHostReach startUpdatingWithBlock:^(AHReach *reach) {
        [self updateAvailabilityField:nil withReach:reach];
    }];
    [self updateAvailabilityField:nil withReach:defaultHostReach];
}

- (void)updateAvailabilityField:(UITextField *)field withReach:(AHReach *)reach {
    if([reach isReachableViaWiFi]){
        DLog(@"已连接wifi");
        if (isone) {
//            showlable.text = @"密码 4/4";
            [cx editPassword];
            isone = NO;
        }else{
            [self yanzheng];
            //                if (num == fangannum) {
            //                    sleep(40);
            //                    [self hqkhd];
            //                }

        }
        UIView *view = [self.view viewWithTag:3000];
        if (view) {
            [view removeFromSuperview];
        }
        [time invalidate];
        if (num==fangannum) {
            btn1.hidden = YES;
            btn.hidden = YES;
            btn2.hidden = YES;
            btn5.hidden = NO;
            
            
            [cx dhpc:@"192.168.0.100" IP2:@"192.168.0.190"];

        }else{
            btn1.hidden = NO;
            btn.hidden = YES;
        }
        
        //   改变label的 名字
        
        UILabel *lab = (UILabel *)[self.view viewWithTag:num];
        lab.text = [NSString stringWithFormat:@"%@",ssid1];

    }else{
        DLog(@"未连接");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_jhyp14"] delegate:self cancelButtonTitle:nil otherButtonTitles:[Config DPLocalizedString:@"adedit_jhyp15"], nil];
        alert.delegate = self;
        alert.tag = 1000;
        [alert show];
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


//视图加载
-(void)viewload{
    
    
    NSInteger vheight = (self.view.frame.size.height - 50) /12;
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIButton *fhbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 2, 40, 40)];
    //返回
    [fhbtn setTitle:[Config DPLocalizedString:@"adedit_back"] forState:0];
    [fhbtn setTitleColor:[UIColor blueColor] forState:0];
    [fhbtn addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:fhbtn];
    UILabel *toptitle = [[UILabel alloc]initWithFrame:CGRectMake(fhbtn.frame.origin.x + fhbtn.frame.size.width, fhbtn.frame.origin.y, topview.frame.size.width - 100, topview.frame.size.height)];
    //激活云片方案
    toptitle.text = [Config DPLocalizedString:@"adedit_jhyp"];
    toptitle.font = [UIFont systemFontOfSize:20];
    toptitle.textAlignment = NSTextAlignmentCenter;
    topview.backgroundColor =[UIColor cyanColor];
    [topview addSubview:toptitle];
    [self.view addSubview:topview];
    //激活
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10 , 50, 50, vheight)];
    lab.text = [Config DPLocalizedString:@"adedit_jhyp1"];
    [self.view addSubview:lab];
    UITextField *file = [[UITextField alloc]initWithFrame:CGRectMake(lab.frame.origin.x + lab.frame.size.width, lab.frame.origin.y, 50, lab.frame.size.height)];
    [file setBackground:[UIImage imageNamed:@"1"]];
    file.text = @"0";
    file.tag = 9400;
    file.textAlignment = NSTextAlignmentCenter;
    file.returnKeyType = UIReturnKeyDone;
    file.delegate = self;

    [self.view addSubview:file];
    UILabel *labh = [[UILabel alloc]initWithFrame:CGRectMake(file.frame.origin.x + file.frame.size.width, lab.frame.origin.y, 200, lab.frame.size.height)];
    //连屏方案
    labh.text = [Config DPLocalizedString:@"adedit_jhyp2"];
    [self.view addSubview:labh];
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(lab.frame.origin.x, lab.frame.origin.y + lab.frame.size.height , 300, vheight)];
    //第一步：请在苹果设置连接云屏
    lab1.text = [Config DPLocalizedString:@"adedit_jhyp3"];
    [self.view addSubview:lab1];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(lab1.frame.origin.x, lab1.frame.origin.y + lab1.frame.size.height , 300, vheight)];
    // （提示：选择最左边的云屏视为最佳状态）
    lab2.text = [Config DPLocalizedString:@"adedit_jhyp4"];
    [self.view addSubview:lab2];
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(lab2.frame.origin.x, lab2.frame.origin.y + lab2.frame.size.height , 300, vheight)];
    //（连接状态：已连接（请选择其他云屏））
    lab3.text = [Config DPLocalizedString:@"adedit_jhyp5"];
    [self.view addSubview:lab3];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(lab3.frame.origin.x, lab3.frame.origin.y + lab3.frame.size.height , 200, vheight*6)];
    image.image = [UIImage imageNamed:@"kk"];
    [self.view addSubview:image];
    UIView *shwoview = [[UIView alloc]initWithFrame:CGRectMake(lab3.frame.origin.x, lab3.frame.origin.y + lab3.frame.size.height , 200, vheight*6)];
    UILabel *slab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, shwoview.frame.size.width - 20, shwoview.frame.size.height/7)];
    
    //已激活
    slab.text = [Config DPLocalizedString:@"adedit_jhyp6"];
    
    
    [shwoview addSubview:slab];
    
    for (int i = 0; i<6; i++) {
        UILabel *ssidlab = [[UILabel alloc]initWithFrame:CGRectMake(slab.frame.origin.x, (slab.frame.size.height)*(i+1), shwoview.frame.size.width - 20, shwoview.frame.size.height/7)];
        //显示路由器
        ssidlab.text = [Config DPLocalizedString:@"adedit_jhyp7"];
        ssidlab.tag = i+1;
        [shwoview addSubview:ssidlab];
    }
    
    [self.view addSubview:shwoview];

    btn  = [[UIButton alloc]initWithFrame:CGRectMake(shwoview.frame.origin.x,shwoview.frame.origin.y + shwoview.frame.size.height +10,100,vheight)];
    //激活
    [btn setTitle:[Config DPLocalizedString:@"adedit_jhyp8"] forState:0];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [btn addTarget:self action:@selector(hqssid) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn];

    btn1  = [[UIButton alloc]initWithFrame:CGRectMake(shwoview.frame.origin.x,shwoview.frame.origin.y + shwoview.frame.size.height +10,100,vheight)];
    
    
    //下一步
    [btn1 setTitle:[Config DPLocalizedString:@"adedit_jhyp11"] forState:0];
    [btn1 setTitleColor:[UIColor blackColor] forState:0];
    [btn1 addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn1];
    btn1.hidden = YES;
// 完成
    btn2  = [[UIButton alloc]initWithFrame:CGRectMake(shwoview.frame.origin.x,shwoview.frame.origin.y + shwoview.frame.size.height +10,100,vheight)];
    [btn2 setTitle:[Config DPLocalizedString:@"adedit_jhyp13"] forState:0];
    [btn2 setTitleColor:[UIColor blackColor] forState:0];
    [btn2 addTarget:self action:@selector(wancheng) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn2];
    btn2.hidden = YES;
    btn5  = [[UIButton alloc]initWithFrame:CGRectMake(shwoview.frame.origin.x,shwoview.frame.origin.y + shwoview.frame.size.height +10,100,vheight)];
//    绑定
    [btn5 setTitle:[Config DPLocalizedString:@"adedit_jhyp12"] forState:0];
    [btn5 setTitleColor:[UIColor blackColor] forState:0];
    [btn5 addTarget:self action:@selector(bangding) forControlEvents:UIControlEventTouchUpInside];
    [btn5 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn5];
    btn5.hidden = YES;

    btn3  = [[UIButton alloc]initWithFrame:CGRectMake(btn2.frame.origin.x + btn2.frame.size.width,btn.frame.origin.y,100,btn.frame.size.height)];
    //重启
    [btn3 setTitle:[Config DPLocalizedString:@"adedit_jhyp9"] forState:0];
    [btn3 setTitleColor:[UIColor blackColor] forState:0];
    [btn3 addTarget:self action:@selector(cq) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn3];
    

    btn4  = [[UIButton alloc]initWithFrame:CGRectMake(btn3.frame.origin.x + btn3.frame.size.width,btn.frame.origin.y,100,btn.frame.size.height)];
    // 重置
    [btn4 setTitle:[Config DPLocalizedString:@"adedit_jhyp10"] forState:0];
    [btn4 setTitleColor:[UIColor blackColor] forState:0];
    [btn4 addTarget:self action:@selector(cz) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn4];

}
-(void)bangding{
    [self hqkhd];
    btn5.hidden = YES;
    btn2.hidden = NO;
}

-(void)fanhui:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    DLog(@"点击了");

}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    DLog(@"编辑完成");
    if (textField.tag == 9400) {
        fangannum = [textField.text integerValue];
        DLog(@"%@",textField.text);
    }

}

//当textField编辑结束时调用的方法

//阴影层
-(void)cx_yy{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.tag = 3000;
    view.backgroundColor = [UIColor blackColor];
    view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
    [self.view addSubview:view];
    
    
    
}

//移除阴影
-(void)yy_miss
{
    
    UIView *view = [self.view viewWithTag:3000];
    if (view) {
        [view removeFromSuperview];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alert show];
    
    
    

}

//方案名称
-(void)ProgramName{
    UIView *view = [self.view viewWithTag:3000];
    if (view) {
        //提示 请输入方案名称 确定
        UIAlertView *aletview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_jhyp16"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles: nil];
        aletview.tag = 7000;
        aletview.alertViewStyle = UIAlertViewStylePlainTextInput;
        [aletview show];
    }
}

////正在设置
//-(void)seting{
//    UIView *view = [self.view viewWithTag:3000];
//    if (view) {
//        CGFloat height =  self.view.frame.size.height/4;
//        setinglab = [[UILabel alloc]initWithFrame:CGRectMake(0, height, view.frame.size.width, height)];
//        setinglab.text = @"正在设置，请稍等";
////        time=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(aaa) userInfo:nil repeats:YES];
//        setinglab.textAlignment = NSTextAlignmentCenter;
//        [view addSubview:setinglab];
//        showlable = [[UILabel alloc]initWithFrame:CGRectMake(0, height*2, view.frame.size.width, height)];
//        showlable.textAlignment = NSTextAlignmentCenter;
////        showlable.text = @"出来";
//        [view addSubview:showlable];
//    }
//}
//-(void)aaa{
//
//    str = @"正在设置，请稍等";
//    for (int i = 0; i<index; i++) {
//        str = [NSString stringWithFormat:@"%@。",str];
//        setinglab.text = str;
//    }
//    index++;
//    if (index == 3) {
//        index = 0;
//    }
//}

//按下Done按钮的调用方法，我们让键盘消失

-(BOOL)textFieldShouldReturn:(UITextField *)textField{


    [textField resignFirstResponder];

    return YES;
}

//重置
-(void)cz{
    
    [cx hf];
}

//重启
-(void)cq{
    [cx rest];
}
//返回上界面
-(void)removeSelfView:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//生成方案
-(void)wancheng{
    [self cx_yy];
    [self ProgramName];
}

//生成xml
-(void)createxml{
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"LEDS"];
    GDataXMLElement *numberip = [GDataXMLNode elementWithName:@"numberip"];

    GDataXMLElement *explanation = [GDataXMLNode elementWithName:@"explanation"];
    [numberip addChild:explanation];
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

//下一步按钮响应
-(void)next{
    
    DLog(@"走下一步");
    
    num ++;
    [self hqsj];
    
    [imageview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"a%ld",(long)num]]];
    
    btn.hidden = NO;
    btn1.hidden = YES;
}
//计时器
//-(void)time{
//    [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(yanzheng:) userInfo:nil repeats:NO];
//}

//一键桥接
-(void)setting{
    
   
    if (fangannum == 1) {
        UIView *view2 = [self.view viewWithTag:3000];
        
//        view2.backgroundColor = [UIColor blackColor];
//        view2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        ipview = [[UIView alloc]initWithFrame:CGRectMake(0,0, view2.frame.size.width, view2.frame.size.height)];
        NSInteger ipwidth = ipview.frame.size.width/2;
        NSInteger ipheight = ipview.frame.size.height/2;
        UILabel *iplabel = [[UILabel alloc]initWithFrame:CGRectMake(ipwidth-135, ipheight-100, 90, 44)];
        iplabel.text =@"网关IP";
        iplabel.textAlignment = NSTextAlignmentCenter;
        [ipview addSubview:iplabel];
        fid = [[UITextField alloc]initWithFrame:CGRectMake(iplabel.frame.origin.x + iplabel.frame.size.width, iplabel.frame.origin.y, 180, 44)];
        fid.borderStyle = UITextBorderStyleBezel;
        fid.textAlignment = NSTextAlignmentCenter;
        fid.returnKeyType = UIReturnKeyDone;
        fid.delegate = self;
        UIButton *ipbtn = [[UIButton alloc]initWithFrame:CGRectMake(iplabel.frame.origin.x, iplabel.frame.origin.y + iplabel.frame.size.height + 10, iplabel.frame.size.width + fid.frame.size.width, 44)];
        [ipbtn setTitle:[Config DPLocalizedString:@"NSStringYes"] forState:0];
        [ipbtn setTitleColor:[UIColor blackColor] forState:0];
        ipbtn.backgroundColor = [UIColor redColor];
        [ipbtn addTarget:self action:@selector(IPclick:) forControlEvents:UIControlEventTouchUpInside];
        [ipview addSubview:ipbtn];
        [ipview addSubview:fid];
        [view2 addSubview:ipview];

        qjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, view2.frame.size.width, view2.frame.size.height)];

        mytable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, qjview.frame.size.width, qjview.frame.size.height - 100)];
        mytable.delegate = self;
        mytable.dataSource = self;
        [qjview addSubview:mytable];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(view2.frame.size.width/5, mytable.frame.size.height + 10, view2.frame.size.width/5, 44)];
        lab.text = @"wifi密码：";
        wifipwd = [[UITextField alloc]initWithFrame:CGRectMake(lab.frame.origin.x + lab.frame.size.width , lab.frame.origin.y, view2.frame.size.width/5*2, 44)];
        wifipwd.borderStyle = UITextBorderStyleBezel;
        wifipwd.textAlignment = NSTextAlignmentCenter;
        wifipwd.returnKeyType = UIReturnKeyDone;
        wifipwd.delegate = self;
        UIButton *btn6 = [[UIButton alloc]initWithFrame:CGRectMake(view2.frame.size.width/5*2, lab.frame.origin.y + lab.frame.size.height, view2.frame.size.width/5, 44)];
        btn6.layer.borderWidth = 1;
        [btn6 setTitle:[Config DPLocalizedString:@"NSStringYes"] forState:0];
        [btn6 setTitleColor:[UIColor blackColor] forState:0];
        btn6.backgroundColor = [UIColor cyanColor];
        [btn6 addTarget:self action:@selector(WANsub) forControlEvents:UIControlEventTouchUpInside];
        [qjview addSubview:lab];
        [qjview addSubview:btn6];
        [qjview addSubview:wifipwd];
        [view2 addSubview:qjview];
        qjview.hidden = YES;

    }else{

        [iparr addObject:[NSString stringWithFormat:@"192.168.0.%ld",(long)num]];
        [ssidarr addObject:ssid1];
        [ledip addObject:[NSString stringWithFormat:@"192.168.0.%ld",(long)(188 + num * 10)]];
        
        if (isone) {
            //        showlable.text = @"信道 1/4";
            [cx submitButtonClicked:ssid];
            sleep(30);
            //        showlable.text = @"dhcp 2/4";
            [cx dhpc:@"192.168.0.100" IP2:@"192.168.0.190"];
            sleep(30);
            //        showlable.text = @"MAC地址 3/4";
            [self wifi];

        }else{
            //        showlable.text = @"修改IP 1/4";
            [cx editIP:[NSString stringWithFormat:@"192.168.0.%ld",(long)num]];
            sleep(30);
            [self wifi];
            
        }
    }
}

-(void)IPclick:(UIButton*)sender{

    ipview.hidden = YES;
    qjview.hidden = NO;
    [cx editIP:[NSString stringWithFormat:@"%@",fid.text]];
    NSString *alertMsg = [[NSString alloc]initWithFormat:@"修改成功"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网关IP" message:alertMsg delegate:self cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles:nil, nil];
    alert.delegate = self;
    [alert show];
}
#pragma mark - showAlertView
-(void)showAlertView:(NSString*)showString
{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:showString delegate:nil  cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
        [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:15.0];



}//温馨提示



- (void)dimissAlert:(UIAlertView *)alert
{
    if(alert)
    {

        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
        
    }
}//温馨提示

//验证wifi是否连上
-(void)yanzheng{
    NSString *rootLoginString = [NSString stringWithFormat:@"http://%@",NULL];
    NSURL *url = [NSURL URLWithString:rootLoginString];
    
    ASIHTTPRequest *getRootInfo = [[ASIHTTPRequest alloc]initWithURL:url];
    __block ASIHTTPRequest *weaf = getRootInfo;
    [getRootInfo setCompletionBlock:^{
        
        NSString *responseString = [weaf responseString];
        DLog(@"responsestring===%@",responseString);
        if (responseString != nil) {
            for (NSArray *arr in arrlist) {
                if ([ssid isEqualToString:arr[0]]) {
                    DLog(@"%@",arr);
                    [cx WANsub:arr[0] lyid:arr[2] wifipwd:@"12345678" andnum:num];
                    sleep(10);
                    [cx WANsub:arr[0] lyid:arr[2] wifipwd:@"12345678" andnum:num];
//                    [cx dhpc:@"192.168.0.100" IP2:@"192.168.0.190"];

                    if (num == fangannum) {
                        sleep(10);
                        [cx alert:[Config DPLocalizedString:@"User_Prompt"] alertMsg:[Config DPLocalizedString:@"adedit_wifi11"]];
                    }


                }
            }
        }
    }];
    
    [getRootInfo setFailedBlock:^{
        
        //请求失败的时候调用
        DLog(@"桥接时请求失败====%@",[weaf responseString]);
        
    }];

    
    
    [getRootInfo startAsynchronous];
}


//获取数据
-(void)hqsj{

    NSString *rootLoginString1 = [NSString stringWithFormat:@"http://%@/goform/WDSScan",NULL];
    
    DLog(@"%@",rootLoginString1);
    
    NSURL *url1 = [NSURL URLWithString:rootLoginString1];
    
    ASIHTTPRequest *getRootInfo1 = [[ASIHTTPRequest alloc]initWithURL:url1];

    [getRootInfo1 setCompletionBlock:^{
        
        DLog(@"wife%@",[getRootInfo1 responseString]);
        
        luyouList = [getRootInfo1 responseString];
        
        [self hqmac];

    }];
    
    
    [getRootInfo1 setFailedBlock:^{
        
        //请求失败的时候调用
       
        [self yy_miss];
        DLog(@"请求失败");
        
    }];

    [getRootInfo1 startAsynchronous];

}


//获取客户端列表  点击绑定 按钮
-(void)hqkhd{
    
    
    NSString *rootLoginString = [NSString stringWithFormat:@"http://192.168.0.%d/lan_dhcp_clients.asp",num];
    
    DLog(@"绑定按钮%@",rootLoginString);
    
    NSURL *url = [NSURL URLWithString:rootLoginString];
    
    ASIHTTPRequest *getRootInfo = [[ASIHTTPRequest alloc]initWithURL:url];

    [getRootInfo setCompletionBlock:^{
        DLog(@"绑定成功%@",[getRootInfo responseString]);
        
        khlist = [getRootInfo responseString];
        
        [self hqdhcp];
    }];
    
    [getRootInfo setFailedBlock:^{
        
        //请求失败的时候调用
        DLog(@"绑定请求失败");
        
        
    }];

    
    [getRootInfo startAsynchronous];
}


//获取dhcp
-(void)hqmac{
    
    
    NSArray *arr = [[NSArray alloc]init];
    arr =[luyouList componentsSeparatedByString:@"\r"];
    arrlist = [[NSMutableArray alloc]init];
    for (int i =0; i<arr.count; i++) {
        NSArray *arr1 = [arr[i] componentsSeparatedByString:@"\t"];
        [arrlist addObject:arr1];
        DLog(@"%@",arr1);
    }
    DLog(@"绑定mac%@",arrlist);
    [mytable reloadData];
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
    if (khdhcplist.count!=fangannum) {
        [self hqkhd];
        
    }else{
        
        

        [cx dhcpList:khdhcplist];
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

//获取wifi名字
-(void)hqssid{
    
    
    btn3.hidden = YES;
    btn4.hidden = YES;
    if (fangannum == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_dlpkz7"] delegate:self cancelButtonTitle:nil otherButtonTitles:[Config DPLocalizedString:@"NSStringYes"], nil];
        [alert show];
    }else{
//        cxdown = [[CX_CountdownViewController alloc]init];
//        [self presentViewController:cxdown animated:YES completion:nil];
//        cxview = [[CX_CountdownView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        [self.view addSubview:cxview];
        // 得到阴影层
        [self cx_yy];
        
        NSString *rootLoginString = [NSString stringWithFormat:@"http://%@",NULL];
        
        NSURL *url = [NSURL URLWithString:rootLoginString];
        ASIHTTPRequest *getRootInfo = [[ASIHTTPRequest alloc]initWithURL:url];
        
        [getRootInfo setCompletionBlock:^{
            
            
            DLog(@"成功%@",[getRootInfo responseString]);
            
            NSString *responseString = [getRootInfo responseString];
            
            [self settingWifiInfo:[self infoAnaylis:responseString]];
        }];
        
        
        [getRootInfo setFailedBlock:^{
            
        //请求失败的时候调用
            DLog(@"请求失败");
            btn3.hidden = NO;
            btn4.hidden = NO;

            
            [self yy_miss];
            
                }];
        
        
        [getRootInfo startAsynchronous];
    }

}


//进行一键  桥接
-(void)settingWifiInfo:(NSDictionary *)infoDict{
    
    if (num == 1) {
        ssid = [infoDict objectForKey:@"name"];
    }
    ssid1 = [infoDict objectForKey:@"name"];
    
    
    
    [self setting];
}


//字符串
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
    //获取密码
    NSString *password = [string4Array objectAtIndex:1];
    
    NSString *wifiname = [string4Array lastObject];
    
    NSDictionary *wifiinfoDict = [[NSDictionary alloc]initWithObjectsAndKeys:password,@"pwd",wifiname,@"name",nil];
    return wifiinfoDict;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    DLog(@"%@",arrlist);
    cell.textLabel.text = arrlist[indexPath.row][0];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    lyname = arrlist[indexPath.row][0];
    lyid = arrlist[indexPath.row][2];
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
