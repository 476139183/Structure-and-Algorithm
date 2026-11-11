//
//  DYT_screenTableViewCell.m
//  乐得
//
//  Created by laidiya on 15/7/18.
//  Copyright (c) 2015年 laidiya. All rights reserved.
//

#import "DYT_screenTableViewCell.h"

@implementation DYT_screenTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.button = [[UIButton alloc]init];
        self.namelabel = [[UILabel alloc]init];
        [self.button setBackgroundImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageNamed:@"LEDYES"] forState:UIControlStateSelected];
    }
    return self;

}
-(void)layoutSubviews
{
    
    self.button.frame = CGRectMake(0, 0, 80, 80);
    
    self.namelabel.frame = CGRectMake(0, 80, 80, 20);
    
    
//    [self.contentView addSubview:self.button];
    [self.contentView addSubview:self.namelabel];
    
    
    

    
    

}

@end
