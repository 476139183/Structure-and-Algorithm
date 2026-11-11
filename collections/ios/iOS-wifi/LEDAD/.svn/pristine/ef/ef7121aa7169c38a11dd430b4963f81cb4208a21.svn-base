//
//  CustomButton.m
//  Absens
//
//  Created by LDY on 2/21/14.
//  Copyright (c) 2014 com.ledmedia. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

/**
 *@brief  返回按钮 只含图片
 */
- (id)initWithFrame:(CGRect)frame withNormalImage:(NSString *)normalImage withHighImage:(NSString *)highImage
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    return self;
}

/**
 *@brief  带标题的图片
 */
- (id)initWithFrame:(CGRect)frame withNormalImage:(NSString *)normalImage withHighImage:(NSString *)highImage withTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
//        self.titleLabel.font = [UIFont fontWithName:@"DFWaWaW5-GB" size:15];

    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.titleLabel.font = [UIFont fontWithName:@"DFWaWaW5-GB" size:15];
    }
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

@end
