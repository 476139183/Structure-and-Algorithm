//
//  BBSFollowerTableViewCell.h
//  LED2Buy
//
//  Created by LDY on 14-7-17.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSContentEntity.h"

@interface BBSFollowerTableViewCell : UITableViewCell
{
    UIImageView *followHead;
    UILabel *followName;
    UILabel *followDate;
    UILabel *followComment;
}
@property (nonatomic, retain) UIImageView *followHead;
@property (nonatomic, retain) UILabel *followName;
@property (nonatomic, retain) UILabel *followDate;
@property (nonatomic, retain) UILabel *followComment;

- (void)initData:(BBSContentEntity *)oneFollow;
@end
