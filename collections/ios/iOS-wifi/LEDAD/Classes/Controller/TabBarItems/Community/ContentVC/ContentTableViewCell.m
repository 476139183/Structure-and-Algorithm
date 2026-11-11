//
//  ContentTableViewCell.m
//  LED2Buy
//
//  Created by LDY on 14-7-16.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "ContentTableViewCell.h"

@implementation ContentTableViewCell
@synthesize dateLabel;
@synthesize leftImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        leftImageView = [[UIImageView alloc] init];
        dateLabel = [[UILabel alloc] init];
        [self addSubview:leftImageView];
        [self addSubview:dateLabel];
        self.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.detailTextLabel.numberOfLines = 0;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    leftImageView.frame = CGRectMake(5, 5, 70, 70);
    self.textLabel.frame = CGRectMake(85, 5, SCREEN_CGSIZE_WIDTH - 175, 30);
    self.detailTextLabel.frame = CGRectMake(85, 35, SCREEN_CGSIZE_WIDTH - 90, 45);
    dateLabel.frame = CGRectMake(SCREEN_CGSIZE_WIDTH - 90, 10, 85, 20);
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
