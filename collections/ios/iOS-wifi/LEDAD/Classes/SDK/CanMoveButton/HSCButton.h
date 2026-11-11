//
//  HSCButton.m
//  可以按住左右移动的按钮，松开手的时候按钮回到初始的位置
//
//  Created by yixingman on 2014年11月05日10:58:46.
//  Copyright (c) 2014年 yixingman. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XValueChangeDelegate <NSObject>

@required
-(void)xValueChange:(float)offsetx andSender:(id)sender;
-(void)moveEnd:(id)sender;
@end


@interface HSCButton : UIButton
{
    CGPoint beginPoint;
    CGRect beginRect;
    float _offsetX;

    id<XValueChangeDelegate> _delegate;
}

@property (nonatomic,assign) id<XValueChangeDelegate> delegate;
@property (nonatomic) BOOL dragEnable;
@property (nonatomic) float offsetX;
@end
