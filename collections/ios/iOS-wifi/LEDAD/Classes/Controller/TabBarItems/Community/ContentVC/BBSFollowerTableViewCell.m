//
//  BBSFollowerTableViewCell.m
//  LED2Buy
//
//  Created by LDY on 14-7-17.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "BBSFollowerTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MyTool.h"

@implementation BBSFollowerTableViewCell
@synthesize followHead;
@synthesize followName;
@synthesize followComment;
@synthesize followDate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        followHead = [[UIImageView alloc] init];
        followName = [[UILabel alloc] init];
        followDate = [[UILabel alloc] init];
        followComment = [[UILabel alloc] init];
        followComment.lineBreakMode = NSLineBreakByCharWrapping;
        followComment.numberOfLines = 0;
        
        followName.font = [UIFont systemFontOfSize:16];
        followName.textColor = [UIColor colorWithRed:70.0/256 green:130.0/256 blue:180.0/256 alpha:1.0];
        followDate.font = [UIFont systemFontOfSize:12];
        followComment.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:followHead];
        [self addSubview:followName];
        [self addSubview:followDate];
        [self addSubview:followComment];
    }
    return self;
}

- (void)initData:(BBSContentEntity *)oneFollow
{
    [self.followHead setImageWithURL:[NSURL URLWithString:[oneFollow.user objectForKey:@"headimg"]] placeholderImage:[UIImage imageNamed:@"comment_profile_default_hd"]];
    self.followName.text = [oneFollow.user objectForKey:@"username"];
    self.followDate.text = [MyTool TimestampToDate:oneFollow.publishtime];
    self.followComment.text = oneFollow.text;
    
//    CGSize size = [oneFollow.text sizeWithFont:self.followComment.font constrainedToSize:CGSizeMake(400, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attrivutesDic = @{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                    NSParagraphStyleAttributeName : paragraph};
    CGSize size = [oneFollow.text boundingRectWithSize:CGSizeMake(400, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrivutesDic context:nil].size;
    DLog(@"size.height = %f", size.height);
    self.followComment.frame = CGRectMake(80, 40, 500 - 100, size.height);
    if (!DEVICE_IS_IPAD) {
        CGSize size = [oneFollow.text boundingRectWithSize:CGSizeMake(SCREEN_CGSIZE_WIDTH - 65, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrivutesDic context:nil].size;
        DLog(@"size.height = %f", size.height);
        self.followComment.frame = CGRectMake(60, 40, SCREEN_CGSIZE_WIDTH - 65, size.height);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    followHead.frame = CGRectMake(5, 5, 40, 40);
//    followName.frame = CGRectMake(50, 5, SCREEN_CGSIZE_WIDTH - 80, 20);
//    followDate.frame = CGRectMake(50, 25, SCREEN_CGSIZE_WIDTH - 80, 15);
//    followComment.frame = CGRectMake(50, 40, SCREEN_CGSIZE_WIDTH - 60, 40);
    if (DEVICE_IS_IPAD) {
        followHead.frame = CGRectMake(35, 5, 30, 30);
        followHead.layer.cornerRadius = 15;
        followHead.backgroundColor = [UIColor colorWithRed:0.872 green:0.844 blue:0.723 alpha:1.000];
        followName.frame = CGRectMake(80, 5, 500 - 100, 20);
        followDate.frame = CGRectMake(80, 25, 500 - 100, 15);
    }else {
        followHead.frame = CGRectMake(15, 5, 30, 30);
        followHead.layer.cornerRadius = 15;
        followHead.backgroundColor = [UIColor colorWithRed:0.872 green:0.844 blue:0.723 alpha:1.000];
        followName.frame = CGRectMake(60, 5, SCREEN_CGSIZE_WIDTH - 65, 20);
        followDate.frame = CGRectMake(60, 25, SCREEN_CGSIZE_WIDTH - 65, 15);
    }
//    followComment.frame = CGRectMake(80, 40, 500 - 100, 40);
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
