//
//  CalculatorCell.m
//  Absen
//
//  Created by yixingman on 8/23/13.
//  Copyright (c) 2013 ledmedia. All rights reserved.
//

#import "CalculatorCell.h"
#import "CustomLabel.h"
#import "Config.h"

@implementation CalculatorCell

@synthesize titleLabel;
@synthesize valueLabel;
@synthesize backgroundView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, 20);
    
    /**
     *@brief    选屏计算器详细信息cell 标题
     */
    titleLabel = [[CustomLabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH/2, 25) withTitle:nil withFont:12];
    titleLabel.backgroundColor = [UIColor whiteColor];
    
    
    /**
     *@brief    选屏计算器详细信息cell 内容
     */
    valueLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/2, 0, SCREEN_CGSIZE_WIDTH/2, 25) withTitle:nil withFont:12];
    valueLabel.backgroundColor = [UIColor whiteColor];
    
    /**
     *@brief    选屏计算器详细信息cell 背景图
     */
    backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calculator_main_cell.png"]];
    
    [self addSubview:backgroundView];
    [self addSubview:titleLabel];
    [self addSubview:valueLabel];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    backgroundView.frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, 25);
    titleLabel.frame = CGRectMake(0.5, 0.5, SCREEN_CGSIZE_WIDTH/2-1.5, 25-1);
    valueLabel.frame = CGRectMake(SCREEN_CGSIZE_WIDTH/2+1, 0.5, SCREEN_CGSIZE_WIDTH/2-1.5, 25-1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
