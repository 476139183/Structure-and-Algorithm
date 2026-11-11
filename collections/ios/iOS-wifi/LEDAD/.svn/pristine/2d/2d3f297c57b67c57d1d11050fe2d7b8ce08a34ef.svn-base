//
//  CX_CountdownView.m
//  LEDAD
//
//  Created by chengxu on 15/7/23.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "CX_CountdownView.h"
//#import "MZTimerLabel.h"
@implementation CX_CountdownView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        [self viewload];
    }
    return self;
}


-(void)viewload{
//    MZTimerLabel *timerExample6;

    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    lab.text = @"正在设置，请等待。。。";
    
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:60];
//    timerExample6 = [[MZTimerLabel alloc] initWithLabel:lab andTimerType:MZTimerLabelTypeTimer];
//    [timerExample6 setCountDownTime:80];
//    timerExample6.delegate = self;
//    [timerExample6 start];
    [self addSubview:lab];


}
- (void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{

    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
