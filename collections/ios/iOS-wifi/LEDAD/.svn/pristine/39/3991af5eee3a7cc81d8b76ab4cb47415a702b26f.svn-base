//
//  ASViewController.m
//  ValueTrackingSlider
//
//  Created by Alan Skipp on 19/10/2013.
//  Copyright (c) 2013 Alan Skipp. All rights reserved.
//

#import "SliderViewController.h"
#import "ASValueTrackingSlider.h"
#import "Config.h"
#import "AsyncSocket.h"

@interface SliderViewController () <ASValueTrackingSliderDataSource,AsyncSocketDelegate>
@property (strong, nonatomic)  ASValueTrackingSlider *slider1;
@property (strong, nonatomic)  ASValueTrackingSlider *slider2;
@property (strong, nonatomic)  ASValueTrackingSlider *slider3;
@property (strong, nonatomic)  ASValueTrackingSlider *slider4;
@property (strong, nonatomic)  UISwitch *animateSwitch;
@end

@implementation SliderViewController
{
    NSArray *_sliders;
    UIView *containerView;
    UITextField *field1;
    UITextField *field2;
    //soket连接
    AsyncSocket *_sendPlayerSocket;

    //当前数据仓库
    NSMutableArray *_currentDataArray;

    //是否连接中
    BOOL isConnect;

    //当前数据区域的索引
    NSInteger _currentDataAreaIndex;
    NSInteger Num;

}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor orangeColor];
    [super viewDidLoad];
    Num = 0;

    [self huoqu];
//    [self initload];

}

-(void)initload{
    CGFloat a;
    CGFloat b;
    if(DEVICE_IS_IPAD){
        a = 50;
        b =300;
    }else{
        a = 0;
        b = 200;
    }
    NSInteger divheight = self.view.frame.size.height/6;
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rectContainerView = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-20);
    if (OS_VERSION_FLOAT>7.9) {
        rectContainerView = CGRectMake(0, 0, self.view.frame.size.width-320,self.view.frame.size.height-20);
    }


    //    UIButton *

    containerView = [[UIView alloc]initWithFrame:rectContainerView];
    [self.view addSubview:containerView];

    NSString *topnavistr=[[NSString alloc]initWithFormat:@"置顶横条"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:topnavistr]];
    titleImageView.frame = CGRectMake(0, 0, containerView.frame.size.width, 44);

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [Config DPLocalizedString:@"adedit_brightness"];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleImageView addSubview:titleLabel];
    [titleLabel release];
    [containerView addSubview:titleImageView];
    [titleImageView release];
    self.slider1 = [[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(50+a, divheight, b, 44)];
    self.slider2 = [[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(50+a, divheight*2, b, 44)];
    self.slider3 = [[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(50+a, divheight*3, b, 44)];
    self.slider4 = [[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(50+a, divheight*4, b, 44)];
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(a, divheight, 44, 44)];
    [lable1 setText:@"A:"];
    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(a, divheight*2, 44, 44)];
    [lable2 setText:@"R:"];
    UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(a, divheight*3, 44, 44)];
    [lable3 setText:@"G:"];
    UILabel *lable4 = [[UILabel alloc]initWithFrame:CGRectMake(a, divheight*4, 44, 44)];
    [lable4 setText:@"B:"];
    UILabel *lable5 = [[UILabel alloc]initWithFrame:CGRectMake(_slider1.frame.origin.x+_slider1.frame.size.width-70, divheight*1.5, 44, 44)];
    [lable5 setText:@"H:"];
    UILabel *lable6 = [[UILabel alloc]initWithFrame:CGRectMake(_slider1.frame.origin.x+_slider1.frame.size.width-70, divheight*3.5, 44, 44)];
    [lable6 setText:@"W:"];
    field1 = [[UITextField alloc]initWithFrame:CGRectMake(lable5.frame.origin.x+lable5.frame.size.width, divheight*1.5, 90, 44)];
    [field1.layer setBorderWidth:1.0];
    field1.text=[NSString stringWithFormat:@"%ld",(long)_width2];
    [field1.layer setBorderColor:[UIColor blackColor].CGColor];
    field2 = [[UITextField alloc]initWithFrame:CGRectMake(lable6.frame.origin.x+lable6.frame.size.width, divheight*3.5, 90, 44)];
    [field2.layer setBorderWidth:1.0];
    field2.text=[NSString stringWithFormat:@"%ld",(long)_height2];
    [field2.layer setBorderColor:[UIColor blackColor].CGColor];
    UIButton *btnOK = [[UIButton alloc]initWithFrame:CGRectMake(50+a, divheight*5, b, 44)];
    [btnOK setTitle:[Config DPLocalizedString:@"adedit_Complete_set"] forState:UIControlStateNormal];
    [btnOK setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnOK.layer setBorderWidth:1.0];
    btnOK.backgroundColor = [UIColor blueColor];
    [btnOK.layer setBorderColor:[UIColor redColor].CGColor];
    [btnOK addTarget:self action:@selector(onclickOK:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btnOK1 = [[UIButton alloc]initWithFrame:CGRectMake(50+a+btnOK.frame.size.width+10, divheight*5, 90, 44)];
    [btnOK1 setTitle:[Config DPLocalizedString:@"adedit_Complete_set1"] forState:UIControlStateNormal];
    [btnOK1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnOK1.layer setBorderWidth:1.0];
    btnOK1.backgroundColor = [UIColor blueColor];
    [btnOK1.layer setBorderColor:[UIColor redColor].CGColor];
    [btnOK1 addTarget:self action:@selector(onclickOK1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOK];
    [self.view addSubview:btnOK1];
    [self.view addSubview:_slider1];
    [self.view addSubview:_slider2];
    [self.view addSubview:_slider3];
    [self.view addSubview:_slider4];
    [self.view addSubview:lable1];
    [self.view addSubview:lable2];
    [self.view addSubview:lable3];
    [self.view addSubview:lable4];
    [self.view addSubview:lable5];
    [self.view addSubview:lable6];
    [self.view addSubview:field1];
    [self.view addSubview:field2];
    //    [self.view addSubview:_animateSwitch];
    [self.view addSubview:titleImageView];
    // customize slider 1
    self.slider1.maximumValue = 255.0;
    self.slider1.popUpViewCornerRadius = 0.0;
    _slider1.value = _alpha2;
    [self.slider1 setMaxFractionDigitsDisplayed:0];
    self.slider1.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    self.slider1.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
    self.slider1.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];

    self.slider2.maximumValue = 255.0;
    self.slider2.popUpViewCornerRadius = 0.0;
    _slider2.value = _red2;
    [self.slider2 setMaxFractionDigitsDisplayed:0];
    self.slider2.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    self.slider2.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
    self.slider2.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];

    self.slider3.maximumValue = 255.0;
    self.slider3.popUpViewCornerRadius = 0.0;
    _slider3.value = _green2;
    [self.slider3 setMaxFractionDigitsDisplayed:0];
    self.slider3.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    self.slider3.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
    self.slider3.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];

    self.slider4.maximumValue = 255.0;
    self.slider4.popUpViewCornerRadius = 0.0;
    _slider4.value = _blue2;
    [self.slider4 setMaxFractionDigitsDisplayed:0];
    self.slider4.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    self.slider4.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
    self.slider4.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];

    
    //手势去掉键盘
    UITapGestureRecognizer *tapview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:tapview];
    
    
    
    
    //
    //    // customize slider 2
    //    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    //    [self.slider2 setNumberFormatter:formatter];
    //    self.slider2.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:26];
    //    self.slider2.popUpViewAnimatedColors = @[[UIColor purpleColor], [UIColor redColor], [UIColor orangeColor]];
    //
    //
    //    // customize slider 3
    //    NSNumberFormatter *tempFormatter = [[NSNumberFormatter alloc] init];
    //    [tempFormatter setPositiveSuffix:@"°C"];
    //    [tempFormatter setNegativeSuffix:@"°C"];
    //
    //    self.slider3.dataSource = self;
    //    [self.slider3 setNumberFormatter:tempFormatter];
    //    self.slider3.minimumValue = -20.0;
    //    self.slider3.maximumValue = 60.0;
    //    self.slider3.popUpViewCornerRadius = 16.0;
    //
    //    self.slider3.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:26];
    //    self.slider3.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    //
    //    UIColor *coldBlue = [UIColor colorWithHue:0.6 saturation:0.7 brightness:1.0 alpha:1.0];
    //    UIColor *blue = [UIColor colorWithHue:0.55 saturation:0.75 brightness:1.0 alpha:1.0];
    //    UIColor *green = [UIColor colorWithHue:0.3 saturation:0.65 brightness:0.8 alpha:1.0];
    //    UIColor *yellow = [UIColor colorWithHue:0.15 saturation:0.9 brightness:0.9 alpha:1.0];
    //    UIColor *red = [UIColor colorWithHue:0.0 saturation:0.8 brightness:1.0 alpha:1.0];
    //
    //    [self.slider3 setPopUpViewAnimatedColors:@[coldBlue, blue, green, yellow, red]
    //                               withPositions:@[@-20, @0, @5, @25, @60]];
    
    _sliders = @[_slider1, _slider2, _slider3,_slider4];
}

-(void)click:(UITapGestureRecognizer *)tap
{

    [field1  resignFirstResponder];
    [field2 resignFirstResponder];
    

}


//完成设置按钮
-(void)onclickOK:(UIButton *)sender{
    _alpha1 = _slider1.value;
    _red1 = _slider2.value;
    _green1 = _slider3.value;
    _blue1 = _slider4.value;
    _width1 = [field1.text integerValue];
    _height1 = [field2.text integerValue];
    DLog(@"%d,%d,%d,%d,%d,%d",_alpha1,_red1,_green1,_blue1,_width1,_height1);
    [self shezhi];
}

//复位按钮
-(void)onclickOK1:(UIButton *)sender{
    _slider1.value = 255;
    _slider2.value = 255;
    _slider3.value = 255;
    _slider4.value = 255;
}

//获取当前屏幕亮度
-(void)huoqu{
    isConnect = NO;
    [self startSocket];

    //0x12
    [self commandResetServerWithType:0x12 andContent:nil andContentLength:0];
}


//设置当前屏幕亮度
-(void)shezhi{
    ipAddressString = selectIpArr[Num];
    isConnect = NO;
    [self startSocket];
    //0x13
    [self commandServerWithType:0x13 andContent:nil andContentLength:0];
}

#pragma mark - ASValueTrackingSliderDataSource

- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value;
{
    value = roundf(value);
    NSString *s;
    if (value < -10.0) {
        s = @"❄️Brrr!⛄️";
    } else if (value > 29.0 && value < 50.0) {
        s = [NSString stringWithFormat:@"😎 %@ 😎", [slider.numberFormatter stringFromNumber:@(value)]];
    } else if (value >= 50.0) {
        s = @"I’m Melting!";
    }
    return s;
}

#pragma mark - IBActions

- (void)toggleShowHide:(UIButton *)sender
{
    sender.selected = !sender.selected;
    for (ASValueTrackingSlider *slider in _sliders) {
        sender.selected ? [slider showPopUpView] : [slider hidePopUpView];
    }
}

- (void)moveSlidersToMinimum:(UIButton *)sender
{
    for (ASValueTrackingSlider *slider in _sliders) {
        if (self.animateSwitch.on) {
            [self animateSlider:slider toValue:slider.minimumValue];
        }
        else {
            slider.value = slider.minimumValue;
        }
    }
}

- (void)moveSlidersToMaximum:(UIButton *)sender
{
    for (ASValueTrackingSlider *slider in _sliders) {
        if (self.animateSwitch.on) {
            [self animateSlider:slider toValue:slider.maximumValue];
        }
        else {
            slider.value = slider.maximumValue;
        }
    }
}

// the behaviour of setValue:animated: is different between iOS6 and iOS7
// need to use animation block on iOS7
- (void)animateSlider:(ASValueTrackingSlider*)slider toValue:(float)value
{
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        [UIView animateWithDuration:0.5 animations:^{
            [slider setValue:value animated:YES];
        }];
    }
    else {
        [slider setValue:value animated:YES];
    }
}


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

/**resetBrightness
 *  重置服务端
 *
 *  @param commandType   命令类型
 *  @param contentBytes  发送内容
 *  @param contentLength 内容长度
 */
-(void)commandResetServerWithType:(Byte)commandType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength
{
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

-(void)commandServerWithType:(Byte)commandType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength
{
    NSInteger a=_height1%256;
    NSInteger b=_height1/256;
    NSInteger c=_width1%256;
    NSInteger d=_width1/256;
    int byteLength = 13;
    Byte outdate[byteLength];
    memset(outdate, 0x00, byteLength);
    outdate[0]=0x7D;
    outdate[1]=commandType;//命令类型
    outdate[2]=0x00; /*命令执行与状态检查2：获取服务器端的数据*/
    outdate[3]=_alpha1;
    outdate[4]=_red1;
    outdate[5]=_green1;
    outdate[6]=_blue1;
    outdate[7]=a;
    outdate[8]=b;
    outdate[9]=c;
    outdate[10]=d;
    outdate[11]=9;
    outdate[12]=0xff;
    //    outdate[byteLength-3]=(Byte)byteLength;
    //    outdate[byteLength-2]=(Byte)(byteLength>>11);
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
    DLog(@"返回的数据");
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

    if(AckByte[1]==0x12){
        DLog(@"获取屏幕亮度成功");
        NSString *red=[NSString stringWithFormat:@"%x",AckByte[4]];
        NSString *green=[NSString stringWithFormat:@"%x",AckByte[5]];
        NSString *blue=[NSString stringWithFormat:@"%x",AckByte[6]];
        NSString *alpha=[NSString stringWithFormat:@"%x",AckByte[3]];
        _red2=strtoul([red UTF8String], 0, 16);
        _green2=strtoul([green UTF8String], 0, 16);
        _blue2=strtoul([blue UTF8String], 0, 16);
        _alpha2=strtoul([alpha UTF8String], 0, 16);
        _height2=strtoul([[NSString stringWithFormat:@"%x",AckByte[7]] UTF8String], 0, 16)+strtoul([[NSString stringWithFormat:@"%x",AckByte[8]] UTF8String], 0, 16)*255;
        _width2=strtoul([[NSString stringWithFormat:@"%x",AckByte[9]] UTF8String], 0, 16)+strtoul([[NSString stringWithFormat:@"%x",AckByte[10]] UTF8String], 0, 16)*255;
        if(strtoul([[NSString stringWithFormat:@"%x",AckByte[8]] UTF8String], 0, 16)>0){
            _height2=_height2+1;
        }
        if(strtoul([[NSString stringWithFormat:@"%x",AckByte[10]] UTF8String], 0, 16)>0){
            _width2=_width2+1;
        }
        DLog(@"获取rgba===%d,%d,%d,%d,%d,%d",_red2,_green2,_blue2,_alpha2,_height2,_width2);

        [self initload];
    }
    if (AckByte[1]==0x13) {
        Num ++;
        if (Num<selectIpArr.count) {
            [self shezhi];
        }else{
            Num = 0;
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_settingsucess"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            self.view.hidden = YES;
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
//    if (isSendState) {
//        [self stopPublishProgress];
//        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
//        [myAlertView show];
//        [myAlertView release];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
