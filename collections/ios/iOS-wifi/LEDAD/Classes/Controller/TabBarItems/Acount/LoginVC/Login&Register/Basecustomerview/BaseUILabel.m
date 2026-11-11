//
//  BaseUILabel.m
//  BaseFrame
//
//  Created by ledmedia on 13-2-20.
//  Copyright (c) 2013年 wally. All rights reserved.
//

#import "BaseUILabel.h"

@implementation BaseUILabel

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)titlestr;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //设置字体:粗体，正常的是 SystemFontOfSize
        self.font = [UIFont systemFontOfSize:14];
        //设置文字颜色
        self.textColor = [UIColor blackColor];
//        self.textColor = [UIColor purpleColor];
        //设置文字位置
        self.textAlignment = NSTextAlignmentLeft;
//        self.textAlignment = NSTextAlignmentRight;
//        self.textAlignment = NSTextAlignmentCenter;
        //设置字体大小适应label宽度
        self.adjustsFontSizeToFitWidth = YES;
        //设置label的行数
        self.numberOfLines = 0;
        //设置高亮
        self.highlighted = YES;
        self.highlightedTextColor = [UIColor blackColor];
        //设置阴影
//        self.shadowColor = [UIColor blackColor];
//        self.shadowOffset = CGSizeMake(1.0,1.0);
        //设置是否能与用户进行交互
        self.userInteractionEnabled = YES;
        //设置label中的文字是否可变，默认值是YES
        self.enabled = NO;
        //设置文字过长时的显示格式
        self.lineBreakMode = NSLineBreakByCharWrapping;//截去中间
//        typedef NS_ENUM(NSInteger, NSLineBreakMode) {		/* What to do with long lines */
//            NSLineBreakByWordWrapping = 0,     	/* Wrap at word boundaries, default */
//            NSLineBreakByCharWrapping,		/* Wrap at character boundaries */
//            NSLineBreakByClipping,		/* Simply clip */
//            NSLineBreakByTruncatingHead,	/* Truncate at head of line: "...wxyz" */
//            NSLineBreakByTruncatingTail,	/* Truncate at tail of line: "abcd..." */
//            NSLineBreakByTruncatingMiddle	/* Truncate middle of line:  "ab...yz" */
//        }
        //如果adjustsFontSizeToFitWidth属性设置为YES，这个属性就来控制文本基线的行为
        self.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        //  typedef enum {
        //      UIBaselineAdjustmentAlignBaselines,     
        //      UIBaselineAdjustmentAlignCenters,     
        //      UIBaselineAdjustmentNone,     
        //  } UIBaselineAdjustment;
        //设置背景透明
        self.backgroundColor=[UIColor clearColor];
        self.text=titlestr;
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
