//
//  CustomLabel.m
//  Absens
//
//  Created by LDY on 2/21/14.
//  Copyright (c) 2014 com.ledmedia. All rights reserved.
//

#import "CustomLabel.h"
#import "Config.h"

@implementation CustomLabel

/**
 *@brief  标题 Label
 */
- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        /*设置字体大小*/
        if ([[Config isRunningOnLanguage]isEqualToString:@"zh-Hans"]) {
            self.font = [UIFont systemFontOfSize:18];
//            self.font = [UIFont fontWithName:@"DFWaWaW5-GB" size:18];
        }
        if ([[Config isRunningOnLanguage]isEqualToString:@"en"]) {
            self.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        }
        /*颜色*/
        self.textColor = [UIColor whiteColor];
        /*文字位置*/
        self.textAlignment = NSTextAlignmentCenter;
        /*自适应*/
        self.adjustsFontSizeToFitWidth = YES;
        /*行数*/
        self.numberOfLines = 1;
        /*交互*/
        self.userInteractionEnabled = YES;
        /*设置文字过长时显示格式*/
        self.lineBreakMode = NSLineBreakByWordWrapping;
        /*控制文本基本行为*/
        self.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        /*设置背景透明*/
        self.backgroundColor = [UIColor clearColor];
        
        /*设置文本内容*/
        self.text = title;
    }
    
    return self;
}

/**
 *@brief  更多页面 Label
 */
- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withFont:(CGFloat)font
{
    self = [super initWithFrame:frame];
    if (self) {
        /*设置字体大小*/
        if ([[Config isRunningOnLanguage]isEqualToString:@"zh-Hans"]) {
            self.font = [UIFont systemFontOfSize:font];
            
//            self.font = [UIFont fontWithName:@"DFWaWaW5-GB" size:15];
            
        }
        if ([[Config isRunningOnLanguage]isEqualToString:@"en"]) {
            self.font = [UIFont fontWithName:@"HelveticaNeue" size:font];
        }
        /*颜色*/
        self.textColor = [UIColor blackColor];
        /*文字位置*/
        self.textAlignment = NSTextAlignmentCenter;
        /*自适应*/
        self.adjustsFontSizeToFitWidth = YES;
        /*行数*/
        self.numberOfLines = 1;
        /*交互*/
        self.userInteractionEnabled = YES;
        /*设置文字过长时显示格式*/
        self.lineBreakMode = NSLineBreakByWordWrapping;
        /*控制文本基本行为*/
        self.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        /*设置背景透明*/
        self.backgroundColor = [UIColor clearColor];
        
        /*设置文本内容*/
        self.text = title;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
