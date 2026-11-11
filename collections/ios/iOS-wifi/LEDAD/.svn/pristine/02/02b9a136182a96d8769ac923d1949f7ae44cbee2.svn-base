//
//  BaseSliderview.m
//  BaseFrame
//
//  Created by ledmedia on 13-2-21.
//  Copyright (c) 2013年 wally. All rights reserved.
//

#import "BaseSliderview.h"

@implementation BaseSliderview
@synthesize mSlider;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame andmaximumValue:(int)value0 minimumValue:(int)value1
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        mSlider = [[UISlider alloc]initWithFrame:CGRectMake(0,0, frame.size.width,frame.size.height)];
        mSlider.minimumValue = value1;
        mSlider.maximumValue = value0;
        mSlider.value =0;
//        [mSlider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
        [mSlider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
        
        
        popView = [[UILabel alloc]initWithFrame:CGRectMake(mSlider.frame.origin.x, mSlider.frame.origin.y-20, 70, 20)];
        [popView setTextAlignment:NSTextAlignmentCenter];
        [popView setBackgroundColor:[UIColor clearColor]];
        [popView setAlpha:1.0f];
        
        [self addSubview:mSlider];
        [self addSubview:popView];
    }
    [self updateValue:mSlider];
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)updateValue:(id)slider{
    UIImageView *imageView = [mSlider.subviews objectAtIndex:2];
    CGRect theRect = [self convertRect:imageView.frame fromView:imageView.superview];
    [popView setFrame:CGRectMake(theRect.origin.x-22, theRect.origin.y-30, popView.frame.size.width, popView.frame.size.height)];
    
    NSInteger v = mSlider.value+0.5;
    [popView setText:[NSString stringWithFormat:@"%d",v]];
    [UIView animateWithDuration:0.05
                     animations:^{
                         [popView setAlpha:1.f];
                     }
                     completion:^(BOOL finished){
                         // 动画结束时的处理
                     }];
    if(v==0)
    {
        NSLog(@"初始化return");
        return ;
    }
    [timer invalidate];
    timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(senderValue)
                                           userInfo:nil repeats:NO];
}

-(void)senderValue
{
    timer=nil;
    NSInteger v = mSlider.value+0.5;
    NSLog(@"v=%d",v);
    [delegate BaseSliderviewPressedAtindex:v];
}

//- (void)disPopView{
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         [popView setAlpha:0.f];
//                         timer=nil;
//                          NSLog(@"v=%d",9);
//                     }
//                     completion:^(BOOL finished){
//                         // 动画结束时的处理
//                     }];
//    
//}

@end
