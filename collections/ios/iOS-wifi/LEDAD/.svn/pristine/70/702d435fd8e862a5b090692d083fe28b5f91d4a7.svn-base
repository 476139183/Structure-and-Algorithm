//
//  CircularProgressView.m
//  CircularProgressView
//
//  Created by nijino saki on 13-3-2.
//  Copyright (c) 2013年 nijino. All rights reserved.
//  QQ:20118368
//  http://nijino_saki.blog.163.com

#import "CircularProgressView.h"

@interface CircularProgressView ()

@property (strong, nonatomic) UIColor *backColor;
@property (strong, nonatomic) UIColor *progressColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) float progress;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation CircularProgressView

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _backColor = backColor;
        _progressColor = progressColor;
        _lineWidth = lineWidth;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    @try {
        //draw background circle
        UIBezierPath *backCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2)
                                                                  radius:self.bounds.size.width / 2 - self.lineWidth / 2
                                                              startAngle:(CGFloat) - M_PI_2
                                                                endAngle:(CGFloat)(1.5 * M_PI)
                                                               clockwise:YES];
        [self.backColor setStroke];
        backCircle.lineWidth = self.lineWidth;
        [backCircle stroke];
        
        if (self.progress != 0) {
            //draw progress circle
            UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2)
                                                                          radius:self.bounds.size.width / 2 - self.lineWidth / 2
                                                                      startAngle:(CGFloat) - M_PI_2
                                                                        endAngle:(CGFloat)(- M_PI_2 + self.progress * 2 * M_PI)
                                                                       clockwise:YES];
            [self.progressColor setStroke];
            progressCircle.lineWidth = self.lineWidth;
            [progressCircle stroke];
        }

    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    @finally {
        
    }
}

- (void)updateProgressCircle:(float)myProgressValue{
    //update progress value
    self.progress = (float)myProgressValue;
    //redraw back & progress circles
    [self setNeedsDisplay];
}









@end
