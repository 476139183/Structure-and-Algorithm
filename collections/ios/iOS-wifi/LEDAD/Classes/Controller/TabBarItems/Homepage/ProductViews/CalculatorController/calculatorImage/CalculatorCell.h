//
//  CalculatorCell.h
//  Absen
//
//  Created by yixingman on 8/23/13.
//  Copyright (c) 2013 ledmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalculatorItem;
@class CustomLabel;

@interface CalculatorCell : UITableViewCell
{
    /**
     *@brief    选屏计算器详细信息cell 标题
     */
    CustomLabel *titleLabel;
    
    /**
     *@brief    选屏计算器详细信息cell 内容
     */
    CustomLabel *valueLabel;
    
    /**
     *@brief    选屏计算器详细信息cell 背景图
     */
    UIView *backgroundView;
}

@property (nonatomic,retain) CustomLabel *titleLabel;
@property (nonatomic,retain) CustomLabel *valueLabel;
@property (nonatomic,retain) UIView *backgroundView;

@end
