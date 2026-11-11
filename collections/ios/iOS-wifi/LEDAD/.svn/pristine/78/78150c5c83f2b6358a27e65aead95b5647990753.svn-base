//
//  SalerMyCustomerCell.m
//  ZDEC
//  选择要推送的列表的页面
//  Created by yixingman on 9/6/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import "PushMyFriendsCell.h"
#import "UIButton+WebCache.h"
#import "Config.h"
#import "UIButton+WebCache.h"
#import "QCheckBox.h"

@implementation PushMyFriendsCell
@synthesize ecus = _ecus;

-(UserInfoEntity*)ecus{
    return _ecus;
}

-(void)setEcus:(UserInfoEntity *)ecus{
    if (_ecus!=ecus) {
        [_ecus release];
        _ecus = [ecus retain];
        NSURL *url = [NSURL URLWithString:ecus.user_headimg];
        [headImageButton setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"frontheadbar.png"]];
        [nameLabel setText:ecus.user_name];
        [positionLabel setText:ecus.user_position];
        [_check1 setTag:[ecus.user_sid integerValue]];
    }
}

-(UIView*)getCellView{
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_CGSIZE_WIDTH,90)];
    headImageButton = [[BaseButton alloc]initWithFrame:CGRectMake(10, 5, 70, 70)];
    
    nameLabel = [[BaseUILabel alloc]initWithFrame:CGRectMake(headImageButton.frame.size.width+5+5, 3, SCREEN_CGSIZE_WIDTH-headImageButton.frame.size.width-100, 30)];
    positionLabel = [[BaseUILabel alloc]initWithFrame:CGRectMake(headImageButton.frame.size.width+5+5, 3+40, SCREEN_CGSIZE_WIDTH-headImageButton.frame.size.width+5+5-10, 30)];
    _check1 = [[QCheckBox alloc] initWithDelegate:self];
    _check1.frame = CGRectMake(SCREEN_CGSIZE_WIDTH-55, 10, 100, 50);
    [_check1 setTitle:@"" forState:UIControlStateNormal];
    [_check1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_check1.titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [cellView addSubview:_check1];
   
    [cellView addSubview:positionLabel];
    [cellView addSubview:headImageButton];
    [cellView addSubview:nameLabel];
    return cellView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *cellView = [self getCellView];
        [self.contentView addSubview:cellView];
    }
    return self;
}

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    DLog(@"checkbox.tag=%d",checkbox.tag);
    if (checked) {
        //被选中
        NSDictionary *userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:[[NSString alloc]initWithFormat:@"%d",checkbox.tag],@"user_id",@"1",@"ischecked",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHECK_BOX object:nil userInfo:userInfo];
    }else{
        //取消选中
        NSDictionary *userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:[[NSString alloc]initWithFormat:@"%d",checkbox.tag],@"user_id",@"0",@"ischecked",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHECK_BOX object:nil userInfo:userInfo];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
