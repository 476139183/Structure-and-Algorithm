//
//  CX_LEDControlViewController.m
//  LEDAD
//
//  Created by chengxu on 15/7/29.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "CX_LEDControlViewController.h"
#import "CX_MODEL.h"
#import "CX_LYmodel.h"
#import "LayoutYXMViewController.h"
#import "XMLDictionary.h"
#import "config.h"
#import "GDataXMLNode.h"
#define Duration 0.2
@interface CX_LEDControlViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *Programtable;
    NSMutableArray *dataArr;
    NSMutableArray *sdata;
    UIScrollView *scroll;
    NSInteger ledcount;
    NSInteger cishu;
    CGRect rect;
    BOOL contain;
    CGPoint startPoint;
    CGPoint originPoint;
    NSMutableArray *filearr;
    NSInteger cellindex;
}
@property (strong , nonatomic) NSMutableArray *itemArray;
@end

@implementation CX_LEDControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    dataArr = [[NSMutableArray alloc]init];
    sdata = [[NSMutableArray alloc]init];
    filearr = [[NSMutableArray alloc]init];
    self.itemArray = [NSMutableArray array];
    cishu = 0;
    [self xml];
    [self viewload];
    // Do any additional setup after loading the view.
}

-(void)viewload{
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIButton *fhbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 2, 40, 40)];
    [fhbtn setTitle:[Config DPLocalizedString:@"adedit_back"] forState:0];
    [fhbtn setTitleColor:[UIColor blueColor] forState:0];
    [fhbtn addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:fhbtn];
    UILabel *toptitle = [[UILabel alloc]initWithFrame:CGRectMake(fhbtn.frame.origin.x + fhbtn.frame.size.width, fhbtn.frame.origin.y, topview.frame.size.width - 100, topview.frame.size.height)];
    toptitle.text = [Config DPLocalizedString:@"adedit_dlpkz"] ;
    toptitle.font = [UIFont systemFontOfSize:20];
    toptitle.textAlignment = NSTextAlignmentCenter;
    topview.backgroundColor =[UIColor cyanColor];
    [topview addSubview:toptitle];
    [self.view addSubview:topview];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, topview.frame.size.height + 5, self.view.frame.size.width, 50)];
    lab.text = [Config DPLocalizedString:@"adedit_dlpkz1"] ;
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(lab.frame.origin.x + 1,lab.frame.origin.y + lab.frame.size.height + 1, self.view.frame.size.width - 2, 150)];
    [image setImage:[UIImage imageNamed:@"kk"]];
    [self.view addSubview:image];
    UIView *showview = [[UIView alloc]initWithFrame:CGRectMake(lab.frame.origin.x + 1, lab.frame.origin.y + lab.frame.size.height + 1, self.view.frame.size.width - 2, 148)];

    Programtable = [[UITableView alloc]initWithFrame:CGRectMake(1, 1, showview.frame.size.width-2, showview.frame.size.height - 2)];
    Programtable.tag = 5000;
    Programtable.delegate = self;
    Programtable.dataSource = self;
    [showview addSubview:Programtable];
    [self.view addSubview:showview];
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, showview.frame.origin.y + showview.frame.size.height + 10, self.view.frame.size.width, 50)];
    lab1.text = [Config DPLocalizedString:@"adedit_dlpkz2"] ;
    lab1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab1];
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, lab1.frame.origin.y + lab1.frame.size.height + 10, self.view.frame.size.width, self.view.frame.size.width/6)];
    scroll.tag = 3000;
    scroll.showsVerticalScrollIndicator = FALSE;
    scroll.showsHorizontalScrollIndicator = FALSE;
    scroll.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:scroll];
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, scroll.frame.origin.y + scroll.frame.size.height + 10, self.view.frame.size.width, 50)];
    lab2.text  = [Config DPLocalizedString:@"adedit_dlpkz3"] ;
    lab2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab2];
    CGFloat width = (self.view.frame.size.width - 40)/3;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, lab2.frame.origin.y + lab2.frame.size.height + 10, width, 44)];
    [btn setTitle:[Config DPLocalizedString:@"adedit_dlpkz4"]  forState:0];
    btn.tag = 1002;
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn];

    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(btn.frame.origin.x + btn.frame.size.width +10, lab2.frame.origin.y + lab2.frame.size.height + 10, width, 44)];
    [btn1 setTitle:[Config DPLocalizedString:@"adedit_dlpkz5"]  forState:0];
    [btn1 setTitleColor:[UIColor blackColor] forState:0];
    btn1.tag = 1001;
    [btn1 addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn1];

    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.frame.origin.x + btn1.frame.size.width +10, lab2.frame.origin.y + lab2.frame.size.height + 10, width, 44)];
    [btn2 setTitle:[Config DPLocalizedString:@"NSStringYes"] forState:0];
    btn2.tag = 1000;
    [btn2 setTitleColor:[UIColor blackColor] forState:0];
    [btn2 addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [self.view addSubview:btn2];

    [self ledshow:0];


}
//移动手势响应
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    NSInteger index;
    CGFloat width = self.view.frame.size.width/6;
    if (cishu == 0) {
        index = recognizer.view.frame.origin.x/width;
    }
    cishu++;
    CGPoint translatedPoint = [recognizer translationInView:self.view];
//    NSLog(@"gesture translatedPoint  is %@", NSStringFromCGPoint(translatedPoint));
    CGFloat x = recognizer.view.center.x + translatedPoint.x;
    CGFloat y = recognizer.view.center.y + translatedPoint.y;

    recognizer.view.center = CGPointMake(x, y);
    if (recognizer.view.frame.origin.x < 0) {
        recognizer.view.frame = CGRectMake(0, recognizer.view.frame.origin.y , recognizer.view.frame.size.width, recognizer.view.frame.size.height);
    }
    if (recognizer.view.frame.origin.x > (5)*width) {
        recognizer.view.frame = CGRectMake((5)*width, recognizer.view.frame.origin.y , recognizer.view.frame.size.width, recognizer.view.frame.size.height);
    }
    if (recognizer.view.frame.origin.y < 0) {
        recognizer.view.frame = CGRectMake(recognizer.view.frame.origin.x, 0 , recognizer.view.frame.size.width, recognizer.view.frame.size.height);
    }
    if (recognizer.view.frame.origin.y > 120 - width) {
        recognizer.view.frame = CGRectMake(recognizer.view.frame.origin.x, 120 - width , recognizer.view.frame.size.width, recognizer.view.frame.size.height);
    }
//    DLog(@"%.f",recognizer.view.frame.origin.x);
    if (recognizer.view.frame.origin.y > width) {

        NSInteger index1 = recognizer.view.frame.origin.x/width;
        UIButton *btn1 = (UIButton*)[self.view viewWithTag:index+100];
//        NSLog(@"%@",btn1);
        [UIView animateWithDuration:0.5 animations:^{
            [recognizer.view setFrame:CGRectMake(width*index1, 0, width, width)];
            [btn1 setFrame:CGRectMake(width*index, 0, width, width)];
        }];
        NSInteger temp = recognizer.view.tag;
        recognizer.view.tag = btn1.tag;
        btn1.tag = temp;
        cishu = 0;
//
    }
    NSLog(@"pan gesture testPanView moving  is %@,%@", NSStringFromCGPoint(recognizer.view.center), NSStringFromCGRect(recognizer.view.frame));

    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];

}




-(void)ledshow:(NSInteger)num{
//    UIView *view = [self.view viewWithTag:3000];
    if (scroll) {
        [scroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.itemArray removeAllObjects];
        CX_MODEL *model = dataArr[num];
        ledcount = model.num;
        NSInteger a = model.num/6;
        NSInteger b = model.num%6;
        CGFloat width = self.view.frame.size.width/6;
        if (b>0) {
            a++;
        }
        CX_LYmodel *cxmodel = [[CX_LYmodel alloc]init];
        scroll.contentSize = CGSizeMake(self.view.frame.size.width *a, 120);
        sdata = model.lyarr;
        for (int j = 0; j<model.num; j++) {
            cxmodel = sdata[j];
            DLog(@"%@",cxmodel.ledip);
            NSString *str = [[cxmodel.ledip componentsSeparatedByString:@"."] lastObject];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setImage:[UIImage imageNamed:@"LEDYES"] forState:0];
            [btn setBackgroundImage:[UIImage imageNamed:@"LEDYES"] forState:0];
            btn.frame = CGRectMake(width*j, 0, width, width);
            btn.tag = j+1;
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
            [btn setTitle:[NSString stringWithFormat:@"%@",str] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(playclick:) forControlEvents:UIControlEventTouchUpInside];
            [scroll addSubview:btn];
            UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
            [btn addGestureRecognizer:longGesture];
            [self.itemArray addObject:btn];

//            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(width*j, 0, width, width)];
//            [btn setImage:[UIImage imageNamed:@"LEDYES"] forState:0];
//            btn.tag = j+100;
//            [scroll addSubview:btn];
//            UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//            [panRecognizer setMinimumNumberOfTouches:1];
//            [panRecognizer setMaximumNumberOfTouches:1];
//            //                [panRecognizer setDelegate:self];
//            [btn addGestureRecognizer:panRecognizer];
//            [panRecognizer release];
        }
    }
}

-(void)playclick:(UIButton*)sender{
    CX_LYmodel *cxmodel = [[CX_LYmodel alloc]init];
    cxmodel = sdata[sender.tag - 1];
    ipAddressString =cxmodel.ledip;
    isConnect = NO;
    [self startSocket];
    if (sender.tag == 1) {
        [self commandResetServerWithType:0xa1 andContent:nil andContentLength:0];
    }
    if (sender.tag == 2) {
        [self commandResetServerWithType:0xa2 andContent:nil andContentLength:0];
    }
    if (sender.tag == 3) {
        [self commandResetServerWithType:0xa3 andContent:nil andContentLength:0];
    }
    if (sender.tag == 4) {
        [self commandResetServerWithType:0xa4 andContent:nil andContentLength:0];
    }
    if (sender.tag == 5) {
        [self commandResetServerWithType:0xa5 andContent:nil andContentLength:0];
    }
    if (sender.tag == 6) {
        [self commandResetServerWithType:0xa6 andContent:nil andContentLength:0];
    }

}

//======================socket连接====================
/**
 *  启动网络连接
 */
-(void)startSocket{
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


    //初始化数据仓库
    if (!_currentDataArray) {
        _currentDataArray = [[NSMutableArray alloc]init];
    }


    //发送索引
    _currentDataAreaIndex = 0;
}

/**
 *  重置服务端
 *
 *  @param commandType   命令类型
 *  @param contentBytes  发送内容
 *  @param contentLength 内容长度
 */
-(void)commandResetServerWithType:(Byte)commandType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength
{
    DLog(@"%x",commandType);
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


#pragma mark - Socket
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    DLog(@"%s %d", __FUNCTION__, __LINE__);
    [_sendPlayerSocket readDataWithTimeout: -1 tag: 0];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    DLog(@"%s %d, tag = %ld", __FUNCTION__, __LINE__, tag);
    DLog(@"写数据完成");
    [_sendPlayerSocket readDataWithTimeout: -1 tag: tag];
}


- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    DLog(@"返回的数据-------%d",data.length);
    Byte *AckByte = (Byte *)[data bytes];

    DLog(@"ack[0]=%x",AckByte[0]);
    DLog(@"ack[1]=%x",AckByte[1]);
    DLog(@"ack[2]=%x",AckByte[2]);
    DLog(@"ack[3]=%x",AckByte[3]);
    DLog(@"ack[4]=%x",AckByte[4]);
    DLog(@"ack[5]=%x",AckByte[5]);
    DLog(@"ack[6]=%x",AckByte[6]);
    DLog(@"ack[7]=%x",AckByte[7]);
    DLog(@"ack[8]=%x",AckByte[8]);
    DLog(@"ack[9]=%x",AckByte[9]);
    DLog(@"ack[10]=%x",AckByte[10]);
    if (AckByte[1] == 0xb1) {
        cishu ++;
        if (cishu<ledcount) {
            [self qxlp];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_dlpkz6"] delegate:self cancelButtonTitle:nil otherButtonTitles:[Config DPLocalizedString:@"NSStringYes"], nil];
            alert.delegate = self;
            [alert show];
        }
    }



    [_sendPlayerSocket readDataWithTimeout: -1 tag: tag];
}



- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    DLog(@"willDisconnectWithError, err = %@", err);
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    DLog(@"%s %d", __FUNCTION__, __LINE__);
}
//===================================================

//======================换位置========================
- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender
{

    UIButton *btn = (UIButton *)sender.view;
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        startPoint = [sender locationInView:sender.view];
        originPoint = btn.center;
        [UIView animateWithDuration:Duration animations:^{

            btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            btn.alpha = 0.7;
        }];

    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {

        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x-startPoint.x;
        CGFloat deltaY = newPoint.y-startPoint.y;
        btn.center = CGPointMake(btn.center.x+deltaX,btn.center.y+deltaY);
        //NSLog(@"center = %@",NSStringFromCGPoint(btn.center));
        NSInteger index = [self indexOfPoint:btn.center withButton:btn];
        if (index<0)
        {
            contain = NO;
        }
        else
        {
            [UIView animateWithDuration:Duration animations:^{

                CGPoint temp = CGPointZero;
                UIButton *button = _itemArray[index];
                temp = button.center;
                button.center = originPoint;
                btn.center = temp;
                originPoint = btn.center;
                contain = YES;
                [sdata exchangeObjectAtIndex:sender.view.tag-1 withObjectAtIndex:button.tag-1];
                NSInteger index = sender.view.tag;
                sender.view.tag = button.tag;
                button.tag = index;
            }];
        }


    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:Duration animations:^{

            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
            if (!contain)
            {
                btn.center = originPoint;
            }
        }];
    }
}


- (NSInteger)indexOfPoint:(CGPoint)point withButton:(UIButton *)btn
{
    for (NSInteger i = 0;i<_itemArray.count;i++)
    {
        UIButton *button = _itemArray[i];
        if (button != btn)
        {
            if (CGRectContainsPoint(button.frame, point))
            {
                return i;
            }
        }
    }
    return -1;
}
//=============================================

-(void)btnclick:(UIButton *)sender{
    if (sender.tag == 1000) {
        NSString *mypath = filearr[cellindex];
        CX_MODEL *model = dataArr[cellindex];
        NSArray *arr = [mypath componentsSeparatedByString:@"/"];
        DLog(@"%@",arr);
        [self createxml:[arr lastObject] model:model];
    }
    if (sender.tag == 1001) {
        CX_MODEL *model = [[CX_MODEL alloc]init];
        model = dataArr[cellindex];
        sdata = model.lyarr;
        [self qxlp];
    }
    if (sender.tag == 1002) {
       NSDictionary *dataDictionary = [NSDictionary dictionaryWithXMLFile:filearr[cellindex]];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:dataDictionary forKey:@"Recent"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_zc25"] delegate:self cancelButtonTitle:nil otherButtonTitles:[Config DPLocalizedString:@"NSStringYes"], nil];
        alert.delegate = self;
        [alert show];
    }
}

-(void)qxlp{
    CX_LYmodel *cxmodel = [[CX_LYmodel alloc]init];
    cxmodel = sdata[cishu];
    ipAddressString =cxmodel.ledip;
    isConnect = NO;
    [self startSocket];
    [self commandResetServerWithType:0xb1 andContent:nil andContentLength:0];
}

//获取xml
-(void)xml{
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    NSArray *filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                                fromDirPath:documentsDirectory AndIsGroupDir:YES];
    DLog(@"%@",filenameArray);
    for (int i = 0; i<filenameArray.count; i ++) {
        if (![[filenameArray[i] lastPathComponent] isEqualToString:@"ip.xml"]) {
            [self xmljx:filenameArray[i]];
            [filearr addObject:filenameArray[i]];
        }
    }

}
//xml解析
-(void)xmljx:(NSString*)mypath{
    CX_MODEL *model = [[CX_MODEL alloc]init];
    NSDictionary *dataDictionary = [NSDictionary dictionaryWithXMLFile:mypath];
//    DLog(@"%@",dataDictionary);
    NSDictionary *dic = [dataDictionary objectForKey:@"numberip"];
//    DLog(@"%@,%@",[dic objectForKey:@"name"],[dic objectForKey:@"num"]);
    model.name = [dic objectForKey:@"name"];
    model.num = [[dic objectForKey:@"num"] integerValue];
    NSArray *arr1 = [dataDictionary objectForKey:@"play"];
    model.lyarr = [[NSMutableArray alloc]init];
//    DLog(@"%@",arr1);
    for (int i = 0; i<arr1.count; i ++) {
        CX_LYmodel *lymodel = [[CX_LYmodel alloc]init];
        NSDictionary *lydic = arr1[i];
//        DLog(@"===%@",lydic);
        lymodel.lytype = [[lydic objectForKey:@"dataid"] integerValue];
        lymodel.lyip = [lydic objectForKey:@"dataip"];
        lymodel.lyname = [lydic objectForKey:@"dataname"];
        lymodel.ledip = [lydic objectForKey:@"dataledip"];
        [model.lyarr addObject:lymodel];
    }
    [dataArr addObject:model];
    [Programtable reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    CX_MODEL *model = [[CX_MODEL alloc]init];
    if (tableView.tag == 5000) {
        [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        model = dataArr[indexPath.row];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, tableView.frame.size.width - 60, 50)];
        lab.text = [NSString stringWithFormat:@"%@",model.name];
        [cell addSubview:lab];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(tableView.frame.size.width - 60, 15, 20, 20)];
        [btn setBackgroundImage:[UIImage imageNamed:@"xx"] forState:0];
        [btn addTarget:self action:@selector(btndelete:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 2000+indexPath.row;
        [cell addSubview:btn];
    }
    return cell;
}

-(void)btndelete:(UIButton*)sender{
    [dataArr removeObjectAtIndex:sender.tag-2000];
    [Programtable reloadData];
    NSString *mypath = filearr[cellindex];
    NSFileManager* fileManager=[NSFileManager defaultManager];
    DLog(@"xmlpath = %@",mypath);
    [fileManager removeItemAtPath:mypath error:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    cellindex = indexPath.row;
    [self ledshow:indexPath.row];
}

-(void)fanhui:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createxml:(NSString*)xmlname model:(CX_MODEL*)model{
    DLog(@"%@",model);
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"LEDS"];
    GDataXMLElement *numberip = [GDataXMLNode elementWithName:@"numberip"];

    GDataXMLElement *explanation = [GDataXMLNode elementWithName:@"explanation"];
    [numberip addChild:explanation];
    GDataXMLElement *name = [GDataXMLNode elementWithName:@"name" stringValue:[NSString stringWithFormat:@"%@",model.name]];
    [numberip addChild:name];
    GDataXMLElement *NUM = [GDataXMLNode elementWithName:@"num" stringValue:[NSString stringWithFormat:@"%ld",(long)model.num]];
    [numberip addChild:NUM];

    [rootElement addChild:numberip];
    sdata = model.lyarr;
    for (int i = 0; i<model.num; i++) {
        CX_LYmodel *lymodel = [[CX_LYmodel alloc]init];
        lymodel = sdata[i];
        GDataXMLElement *play = [GDataXMLNode elementWithName:@"play"];
        GDataXMLElement *explanation = [GDataXMLNode elementWithName:@"explanation"];
        [play addChild:explanation];
        GDataXMLElement *dataip = [GDataXMLNode elementWithName:@"dataip" stringValue:lymodel.lyip];
        [play addChild:dataip];
        GDataXMLElement *dataname = [GDataXMLNode elementWithName:@"dataname" stringValue:lymodel.lyname];
        [play addChild:dataname];
        GDataXMLElement *dataledip = [GDataXMLNode elementWithName:@"dataledip" stringValue:lymodel.ledip];
        [play addChild:dataledip];
        GDataXMLElement *dataid =[GDataXMLNode elementWithName:@"dataid" stringValue:[NSString stringWithFormat:@"%ld",(long)lymodel.lytype]];
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
    NSString *xmlfilePath = [[NSString alloc]initWithFormat:@"%@/%@",documentsDirectoryPath,xmlname];
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
