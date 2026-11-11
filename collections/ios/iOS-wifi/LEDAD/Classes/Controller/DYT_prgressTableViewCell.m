//
//  DYT_prgressTableViewCell.m
//  LEDAD
//
//  Created by laidiya on 15/7/16.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_prgressTableViewCell.h"

@implementation DYT_prgressTableViewCell

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
        
        
        self.projectnamelabel = [[UILabel alloc]init];
        self.progressview = [[UIProgressView alloc]init];
        
       self.progressview.tintColor = [UIColor blueColor];
        
        self.progresslabel = [[UILabel alloc]init];
                             
        self.progresslabel.font = [UIFont systemFontOfSize:12];
        self.progresslabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.projectnamelabel];	        [self addSubview:self.progressview];
        [self addSubview:self.progresslabel];
        
        
    }
    
    return self;

}


- (void)layoutSubviews
{
    
    self.projectnamelabel.frame = CGRectMake(5, 0, self.wid, 30);
    
    self.progressview.frame = CGRectMake(5, self.projectnamelabel.frame.size.height+self.projectnamelabel.frame.origin.y, self.wid-10, 5);
    self.progresslabel.frame = CGRectMake(self.projectnamelabel.frame.size.width-100, self.progressview.frame.origin.y+5, 100, 30);
    
    [super layoutSubviews];
    
    
    
    
    


}




@end
