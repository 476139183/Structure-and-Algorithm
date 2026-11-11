//
//  YXM_PlayerListTableViewCell.m
//  LEDAD
//
//  Created by yixingman on 14-10-11.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import "YXM_PlayerListTableViewCell.h"

@implementation YXM_PlayerListTableViewCell
@synthesize myObj = _myObj;

-(YXM_PlayerListObject*)myObj{
    return _myObj;
}

-(void)setMyObj:(YXM_PlayerListObject *)myObj{
    if (_myObj != myObj) {
        [_myObj release];
        _myObj = [myObj retain];

        [_serverNameLabel setText:myObj.player_name];
        [_serverIPLabel setText:myObj.player_ip];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

-(UIView*)getCellView{
    CGRect rectCellView = CGRectMake(0, 0, 500, 40);
    UIView *cellView = [[[UIView alloc]initWithFrame:rectCellView] autorelease];

    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:rectCellView];
    backgroundImageView.image = [UIImage imageNamed:@"CustomCell.png"];
    //终端名称
    _serverNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 500/2, 30)];
    _serverNameLabel.backgroundColor = [UIColor clearColor];
    _serverNameLabel.textColor = [UIColor blackColor];
    _serverNameLabel.textAlignment = NSTextAlignmentCenter;
    __select = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    __select.tag=10;
    __select.image=[UIImage imageNamed:@"select_No"];
    [cellView addSubview:__select];
    //屏端的IP地址
    _serverIPLabel = [[UILabel alloc] initWithFrame:CGRectMake(500/2, 5, 500/2, 30)];
    _serverIPLabel.backgroundColor = [UIColor clearColor];
    _serverIPLabel.textColor = [UIColor blackColor];
    _serverIPLabel.textAlignment = NSTextAlignmentCenter;
    [cellView addSubview:backgroundImageView];
    [cellView addSubview:_serverNameLabel];

    [cellView addSubview:_serverIPLabel];

    return cellView;
}
@end
