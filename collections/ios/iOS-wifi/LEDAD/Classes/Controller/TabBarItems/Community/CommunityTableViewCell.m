//
//  CommunityTableViewCell.m
//  LED2Buy
//
//  Created by LDY on 14-7-16.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "CommunityTableViewCell.h"

@implementation CommunityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(10, 10, 40, 40);
    self.textLabel.frame = CGRectMake(65, 5, SCREEN_CGSIZE_WIDTH - 90, 30);
    self.detailTextLabel.frame = CGRectMake(65, 35, SCREEN_CGSIZE_WIDTH - 90, 25);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
