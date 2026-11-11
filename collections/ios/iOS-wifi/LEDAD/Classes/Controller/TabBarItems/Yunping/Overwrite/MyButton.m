//
//  MyButton.m
//  云屏
//
//  Created by LDY on 14-7-25.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor= [UIColor redColor];
        // Initialization code
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (DEVICE_IS_IPAD) {
        self.imageView.frame = CGRectMake(15, 0, 30, 30);
        self.titleLabel.frame = CGRectMake(-5, 35, 70, 20);
    }else {
        
        //手机端
        self.imageView.frame = CGRectMake(15, 0, 30, 30);
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;

        self.titleLabel.frame = CGRectMake(-10, 35, 80, 20);
//        self.titleLabel.textAlignment = NSTextAlignmentLeft;

        self.titleLabel.center = CGPointMake(self.frame.size.width/2, self.titleLabel.center.y);

    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
