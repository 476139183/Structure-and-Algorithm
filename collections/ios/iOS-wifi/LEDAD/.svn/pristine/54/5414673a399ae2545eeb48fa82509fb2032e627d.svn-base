//
//  HSCButton.m
//  可以按住左右移动的按钮，松开手的时候按钮回到初始的位置
//
//  Created by yixingman on 2014年11月05日10:58:46.
//  Copyright (c) 2014年 yixingman. All rights reserved.
//

#import "HSCButton.h"

@implementation HSCButton

@synthesize dragEnable;
@synthesize offsetX = _offsetX;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!dragEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    
    beginPoint = [touch locationInView:self];
    beginRect = self.frame;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!dragEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    
    CGPoint nowPoint = [touch locationInView:self];
    
    _offsetX = nowPoint.x - beginPoint.x;
    [self.delegate xValueChange:_offsetX andSender:self];
    self.frame = CGRectMake(self.frame.origin.x + _offsetX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (!dragEnable) {
        return;
    }
//    self.frame = beginRect;
    [self.delegate moveEnd:self];
}



@end
