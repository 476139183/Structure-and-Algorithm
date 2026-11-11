//
//  DYT_colorTestview.m
//  LEDAD
//
//  Created by laidiya on 15/7/28.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_colorTestview.h"
#import "BFPaperButton.h"
@implementation DYT_colorTestview
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _setview];
    }
    return self;

}
-(void)_setview
{
    NSArray *titlearray = [[NSArray alloc]initWithObjects:@" ［192*640］",@" ［160*640］",@" ［768*160］", nil];
    
    for (int i=0; i<titlearray.count; i++) {
        DYT_Qchexbutton *button = [[DYT_Qchexbutton alloc]initWithFrame:CGRectMake(5, 5+40*i, self.frame.size.width/2, 30)];
        button.backgroundColor = [UIColor blackColor];
        button.tag = i+1000;
        [button addTarget:self action:@selector(qchex:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titlearray[i] forState:UIControlStateNormal];
        [self addSubview:button];
    }
    
    
    
    
    BFPaperButton *makebutton = [[BFPaperButton alloc]initWithFrame:CGRectMake(self.frame.size.width/4, self.frame.size.height-50, self.frame.size.width/4, 30)];
    [makebutton setTitle:[Config DPLocalizedString:@"adedit_qdyl"] forState:UIControlStateNormal];
    [makebutton addTarget:self action:@selector(colormakesure:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:makebutton];
    
    BFPaperButton *canleyulanbutton = [[BFPaperButton alloc]initWithFrame:CGRectMake(makebutton.frame.size.width+makebutton.frame.origin.x, makebutton.frame.origin.y, makebutton.frame.size.width, 30)];
    [canleyulanbutton setTitle:[Config DPLocalizedString:@"adedit_qxyl"] forState:UIControlStateNormal];
    [canleyulanbutton addTarget:self action:@selector(colorcanleyulan:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:canleyulanbutton];
    
    
    BFPaperButton *canlebutton = [[BFPaperButton alloc]initWithFrame:CGRectMake(canleyulanbutton.frame.size.width+canleyulanbutton.frame.origin.x, canleyulanbutton.frame.origin.y, canleyulanbutton.frame.size.width, 30)];
    [canlebutton setTitle:[Config DPLocalizedString:@"adedit_back"] forState:UIControlStateNormal];
    [canlebutton addTarget:self action:@selector(colorcanle:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:canlebutton];
    

}
-(void)qchex:(DYT_Qchexbutton *)sender
{
    for (int i=0; i<3; i++) {
        DYT_Qchexbutton *button = (DYT_Qchexbutton*)[self viewWithTag:1000+i];
        button.selected = NO;
        
    }
    sender.selected = YES;
    

}

-(void)colormakesure:(id)sender
{
    NSInteger j = 0;
    for (int i=0; i<3; i++) {
         DYT_Qchexbutton *button = (DYT_Qchexbutton*)[self viewWithTag:1000+i];
        if (button.selected==YES) {
            j = button.tag;
        }
    }
    
    if (j== 0) {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_shoose"] delegate:nil cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles: nil];
        [aler show];
        return;
    }
    
    number = selectIpArr.count;
    DLog(@"=====%d",selectIpArr.count);
    for (int i=0; i<selectIpArr.count; i++) {
        
        DYT_AsyModel *model = [[DYT_AsyModel alloc]init];
        model.mydelegate = self;
        [model startSocket:selectIpArr[i]];
        
        if (j==1000) {
            [ model commandResetServerWithType:0xa7 andContent:nil andContentLength:nil];
            
        }else if(j==1001)
        {
            [ model commandResetServerWithType:0xa9 andContent:nil andContentLength:nil];
            
        }else if (j==1002)
        {
            [ model commandResetServerWithType:0xa8 andContent:nil andContentLength:nil];
            
            
        }

        

    }
    
    
    
    
    
    

}

//取消
-(void)colorcanleyulan:(id)sender
{

    number = selectIpArr.count;
    for (int i=0; i<selectIpArr.count ; i++) {
        DYT_AsyModel *model = [[DYT_AsyModel alloc]init];
        model.mydelegate = self;
        [model startSocket:selectIpArr[i]];
        
        [ model commandResetServerWithType:0xb1 andContent:nil andContentLength:nil];
    }
  

    

}

-(void)returemydata:(NSData *)mydata;
{
    
    Byte *AckByte = (Byte *)[mydata bytes];
    NSLog(@"反馈数据=====%@",mydata);

    
    
    
    if (AckByte[1]==0xb1) {
        number--;
        if (number==0) {
            _canlerblock();
        }
        
        
    }else
    {
    
        number--;
        if (number==0) {
            UIAlertView *aler = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_cg"] delegate:nil cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles: nil];
            
            [aler show];
        }
    
    }
   

}

-(void)colorcanle:(id)sender
{
    
   _canlerblock();
    


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
