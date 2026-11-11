//
//  BaseButton.m
//  BaseFrame
//
//  Created by ledmedia on 13-2-19.
//  Copyright (c) 2013年 wally. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

-(id)initWithFrame:(CGRect)frame andNorImg:(NSString *)norimage andHigImg:(NSString *)higimg andTitle:(NSString *)titlestr;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundImage:[UIImage imageNamed:norimage] forState:UIControlStateNormal];
         //点击后的图片
        [self setBackgroundImage:[UIImage imageNamed:higimg] forState:UIControlStateHighlighted];
        [self setTitle:titlestr forState:UIControlStateNormal];
        self.titleLabel.font            =[UIFont systemFontOfSize:17];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.lineBreakMode   =NSLineBreakByCharWrapping;
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
