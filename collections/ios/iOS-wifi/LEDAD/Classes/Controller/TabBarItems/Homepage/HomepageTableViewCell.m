//
//  HomepageTableViewCell.m
//  LED2Buy
//
//  Created by LDY on 14-7-4.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "HomepageTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HomepageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withdataNewsLeditem:(DataCategories *)categoryItem  {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ];
    if (!self) {
        return nil;
    }
    self.frame=CGRectMake(0, 0, self.frame.size.width, 100);
    self.textLabel.adjustsFontSizeToFitWidth    =NO;
    
    self.textLabel.text                         =categoryItem.category_name;
    self.textLabel.textColor                    =[UIColor darkGrayColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
//    self.leftimageView                          =[[UIImageView alloc]init];
    NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@",categoryItem.category_img];
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches/"];
    imageUrl =[imageUrl stringByReplacingOccurrencesOfString:@"http://www.ledmedia.info/pocket" withString:documentsDirectory];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"HomepageTableViewCell" forKey:@"From"];
    if ([fm fileExistsAtPath:imageUrl]) {
        [self.imageView setImageWithURL:[NSURL URLWithString:categoryItem.category_img] placeholderImage:[UIImage imageWithContentsOfFile:imageUrl]];
    }else{
        [self.imageView setImageWithURL:[NSURL URLWithString:categoryItem.category_img] placeholderImage:[UIImage imageNamed:@"frontheadbar.png"]];
    }
    return self;
}


#pragma mark - UIView


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
    
    self.imageView.frame    = CGRectMake(5.0f, 5.0f, 40.0f, 40.0f);
    self.textLabel.frame        = CGRectMake(50.0f, 5.0f, SCREEN_CGSIZE_WIDTH-100.0f, 40.0f);
}

@end
