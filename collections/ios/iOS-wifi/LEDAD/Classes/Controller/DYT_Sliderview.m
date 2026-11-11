//
//  DYT_Sliderview.m
//  LEDAD
//
//  Created by laidiya on 15/7/28.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_Sliderview.h"
#import "ASValueTrackingSlider.h"
#import "Config.h"
#import "BFPaperButton.h"
#import "DYT_AsyModel.h"
@interface DYT_Sliderview () <ASValueTrackingSliderDataSource,myasydelete,UITextFieldDelegate>
@property (strong, nonatomic)  UISwitch *animateSwitch;
@end



@implementation DYT_Sliderview
{
 NSMutableArray *_sliders;
    NSMutableArray *filearr;
    UITextField *filedx;
    UITextField *filedy;
    NSMutableArray *number;
    NSInteger numberone;
    UIView *topview;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self _setview];
        [self starsokect];
      
    }
    return self;

}
-(void)starsokect
{
    
        DYT_AsyModel *mymodel = [[DYT_AsyModel alloc]init];
        mymodel.mydelegate = self;
        [mymodel getScreenbrightness];
    
    

}

-(void)_setview
{
    filearr = [[NSMutableArray alloc]init];
    
    number  = [[NSMutableArray alloc]init];
    
    _sliders = [[NSMutableArray alloc]init];
    topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-40, 30)];
    topview.hidden = YES;
    [self addSubview:topview];
    NSArray *xy = [[NSArray alloc]initWithObjects:@"x",@"y", nil];
    for (int i=0; i<xy.count; i++) {
        CGRect rect = CGRectMake((self.frame.size.width-40)/2*i, 0, (self.frame.size.width-40)/2,30);
        [self setfiledtext:xy[i] andfram:rect andtag:i+100];
    }
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 40, 0, 40, 40)];
    [btn setTitle:[Config DPLocalizedString:@"adedit_hide"] forState:0];
    [btn setTitle:[Config DPLocalizedString:@"adedit_show"] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    btn.selected = NO;
    [btn addTarget:self action:@selector(showhidde:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    NSArray *title = [[NSArray alloc]initWithObjects:@"ld",@"dyt_red",@"dyt_green",@"dyt_blue", nil];
    
    
    
    
    for (int i=0; i<title.count; i++) {
        CGRect rect = CGRectMake(0, 40+30*i, self.frame.size.width, 30);
        [self settxt:title[i] andfram:rect andtag:i+200];
    }
    
    
//    按钮
    NSArray *buttontitle = [[NSArray alloc]initWithObjects:[Config DPLocalizedString:@"adedit_Done"],[Config DPLocalizedString:@"adedit_Complete_set1"],[Config DPLocalizedString:@"NSStringNO"], nil];
    NSInteger wid = (self.frame.size.width-30)/3;
    for (int i=0; i<buttontitle.count ; i++) {
        BFPaperButton *makebutton = [[BFPaperButton alloc]initWithFrame:CGRectMake(5+(wid+5)*i, 160, wid, 25)];
        [makebutton setTitle:buttontitle[i] forState:UIControlStateNormal];
        makebutton.tag  = i+300;
        [makebutton addTarget:self action:@selector(returebutton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:makebutton];
    }
   
    

    
    
    
}
-(void)showhidde:(UIButton*)sender{
    if (sender.selected) {
        sender.selected = NO;
        topview.hidden = YES;
    }else{
        sender.selected = YES;
        topview.hidden = NO;
    }
}

//
-(void)returebutton:(BFPaperButton *)sender
{

    
    if (sender.tag==300) {
//        确定屏幕亮度
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        
        for (int i=0; i<_sliders.count; i++) {
            ASValueTrackingSlider *a = _sliders[i];
            DLog(@"====%f",a.value);
            [array addObject:[NSString stringWithFormat:@"%f",a.value]];
            
        }
        
        for (int k=0; k<filearr.count; k++) {
            UITextField *f = filearr[k];
            DLog(@"===%@",f.text);
            [array addObject:f.text];
            
        }
      
        DLog(@"===%@",array);
        
        numberone = selectIpArr.count;
        for (int i=0; i<selectIpArr.count; i++) {
            DYT_AsyModel *model = [[DYT_AsyModel alloc]init];
            model.mydelegate  = self;
            [model startSocket:selectIpArr[i]];
            [model setscreenBrightness:0x13 andContent:nil andContentLength:0 and:array];
            
            
        }
        
    
        return;
        
    }
    if (sender.tag==301) {
//        复位
        for (int i=0; i<_sliders.count; i++) {
            ASValueTrackingSlider *a = _sliders[i];
            a.value = 255.0;
        }
        
        
        
        return;
    }
    
//
    if (sender.tag==302) {
         _canlerblock();
        
    }

}



-(void)setfiledtext:(NSString *)text andfram:(CGRect)fram andtag:(NSInteger)tag
{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(fram.origin.x, fram.origin.y, 30, fram.size.height)];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    [topview addSubview:label];
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(label.frame.origin.x+30, fram.origin.y, fram.size.width-40, fram.size.height)];
    field.tag = tag;
    [field.layer setBorderWidth:1.0];
    field.delegate = self;
    [field.layer setBorderColor:[UIColor blackColor].CGColor];

    [topview addSubview:field];

    [filearr addObject:field];

}


//设置滑块
-(void)settxt:(NSString  *)title andfram:(CGRect)fram andtag:(NSInteger )tag
{

    UIImageView *label = [[UIImageView alloc]initWithFrame:CGRectMake(fram.origin.x, fram.origin.y, 30, fram.size.height)];
    [label setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",title]]];

    [self addSubview:label];
    
    ASValueTrackingSlider *slider1 = [[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(fram.origin.x+40, fram.origin.y, fram.size.width-60, fram.size.height)];
//    slider1.delegate = self;
    slider1.tag = tag;
    slider1.maximumValue = 255.0;
    slider1.popUpViewCornerRadius = 0.0;
    slider1.value = __alpha2;
    [slider1 setMaxFractionDigitsDisplayed:0];
    slider1.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    slider1.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
    slider1.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];

    
    [self addSubview:slider1];

    [_sliders addObject:slider1];


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
            _height2 =_height2+1;
        }
        if(strtoul([[NSString stringWithFormat:@"%x",AckByte[10]] UTF8String], 0, 16)>0){
            _width2 = _width2+1;
        }
        
        [number removeAllObjects];
        
        [number addObject:[NSString stringWithFormat:@"%ld",(long)_alpha2]];
        [number addObject:[NSString stringWithFormat:@"%ld",(long)_red2]];
        [number addObject:[NSString stringWithFormat:@"%ld",(long)_green2]];
        [number addObject:[NSString stringWithFormat:@"%ld",(long)_blue2]];
       
        [number addObject:[NSString stringWithFormat:@"%ld",(long)_height2]];
        [number addObject:[NSString stringWithFormat:@"%ld",(long)_width2]];
        
        DLog(@"获取rgba===%lu,%lu,%lu,%lu,%lu,%lu",_red2,_green2,_blue2,_alpha2,_height2,_width2);
        
        //        硬件检测
        [self changedataview:number];
    }
    
    if (AckByte[1]==0x13) {
        
        numberone--;
        if (numberone==0) {
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_settingsucess"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];

        }
    }
    
    
    
    
    
    
}
-(void)changedataview:(NSMutableArray *)array
{

    for (int i=0; i<_sliders.count; i++) {
        ASValueTrackingSlider *a = _sliders[i];
        a.value = [array[i] integerValue];
    }
    
    for (int i=0; i<filearr.count; i++) {
        UITextField *f = filearr[i];
        f.text = array[i+4];
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
