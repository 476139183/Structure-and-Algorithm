//
//  BaseTextField.m
//  BaseFrame
//
//  Created by ledmedia on 13-2-25.
//  Copyright (c) 2013年 wally. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField

- (id)initWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeStr
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      [self setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
//        [self setBorderStyle:UITextBorderStyleNone]; //外框类型
        self.placeholder            = placeStr; //默认显示的字
        self.secureTextEntry        = NO; //密码
        [self setBackgroundColor:[UIColor whiteColor]];
//      self.autocorrectionType   = UITextAutocorrectionTypeNo;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.autocorrectionType     = UITextAutocorrectionTypeDefault;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.returnKeyType          = UIReturnKeyDone;
        self.clearButtonMode        = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        self.backgroundColor = [UIColor clearColor];
        self.borderStyle = UITextBorderStyleNone;
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
