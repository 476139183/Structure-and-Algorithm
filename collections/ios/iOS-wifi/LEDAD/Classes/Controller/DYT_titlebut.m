//
//  DYT_titlebut.m
//  LEDAD
//
//  Created by laidiya on 15/7/21.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_titlebut.h"

@implementation DYT_titlebut
-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.height-20, frame.size.height-20)];
        self.button.center = CGPointMake(frame.size.width/2, self.button.center.y);
        self.namelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        [self addSubview:self.button];
        [self addSubview:self.namelabel];
        self.namelabel.textAlignment = NSTextAlignmentCenter;
        self.namelabel.font = [UIFont systemFontOfSize:12];
        self.namelabel.textColor = [UIColor whiteColor];

    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
