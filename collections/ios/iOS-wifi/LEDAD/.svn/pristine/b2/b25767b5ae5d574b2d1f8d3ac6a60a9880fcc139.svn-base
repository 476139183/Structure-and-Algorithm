//
//  BaseSliderview.h
//  BaseFrame
//
//  Created by ledmedia on 13-2-21.
//  Copyright (c) 2013年 wally. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseSliderviewdelegate;

@interface BaseSliderview : UIView
{
    NSTimer *timer;
    UISlider *mSlider;
    UILabel *popView;
    id<BaseSliderviewdelegate> delegate;
}
@property(nonatomic,strong)UISlider *mSlider;
@property(nonatomic,strong)id<BaseSliderviewdelegate> delegate;
- (id)initWithFrame:(CGRect)frame andmaximumValue:(int)value0 minimumValue:(int)value1;
- (void)updateValue:(id)slider;
@end
@protocol BaseSliderviewdelegate

-(void)BaseSliderviewPressedAtindex:(int)index;

@end
