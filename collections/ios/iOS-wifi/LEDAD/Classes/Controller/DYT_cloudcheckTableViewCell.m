//
//  DYT_cloudcheckTableViewCell.m
//  LEDAD
//
//  Created by laidiya on 15/7/23.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_cloudcheckTableViewCell.h"
#import "Config.h"
@implementation DYT_cloudcheckTableViewCell
@synthesize myproject = _myproject;

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
        [self getview];
    }

    return self;
}



-(void)setMyproject:(Project *)myproject
{
    
    



}


-(void)getview
{

    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, self.frame.size.width, 44)];
    namelabel.text = self.myproject.Material_Name;
    [self.contentView addSubview:namelabel];
    
    
    
    

    
    

}


@end
