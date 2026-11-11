//
//  AccountTableViewCell.m
//  LED2Buy
//
//  Created by LDY on 14-7-9.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "AccountTableViewCell.h"

@implementation AccountTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(BOOL)checkDevice:(NSString*)name
{
    NSString* deviceType = [UIDevice currentDevice].model;
    //    DLog(@"deviceType = %@", deviceType);
    
    NSRange range = [deviceType rangeOfString:name];
    return range.location != NSNotFound;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    NSString *  nsStrIpad=@"iPad";
    
    bool  bIsiPad=false;
    
    bIsiPad=[self checkDevice:nsStrIpad];
    
    
    //    if (bIsiPad == false) {
    //        self.imageView.frame    = CGRectMake(5.0f, 5.0f, 40.0f, 40.0f);
    //        self.textLabel.frame        = CGRectMake(50.0f, 5.0f, SCREEN_CGSIZE_WIDTH-100.0f, 40.0f);
    //    }else if (bIsiPad == true) {
    //        self.imageView.frame    = CGRectMake(5.0f, 5.0f, 90.0f, 90.0f);
    //        self.textLabel.frame        = CGRectMake(100.0f, 5.0f, SCREEN_CGSIZE_WIDTH-100.0f, 20.0f);
    //    }
    
    self.imageView.frame  = CGRectMake(15.0f, 5.0f, 40.0f, 40.0f);
    self.textLabel.frame  = CGRectMake(75.0f, 5.0f, SCREEN_CGSIZE_WIDTH - 100.0f, 40.0f);
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
