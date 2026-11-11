//
//  MenuTableCell.m
//  LEDAD
//
//  Created by LDY on 13-9-16.
//
//

#import "MenuTableCell.h"

@implementation MenuTableCell
@synthesize backgroundImageView;
@synthesize titleButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)cellFrame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.frame = cellFrame;
        self.titleButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 4, cellFrame.size.width-80, cellFrame.size.height-8)];
        [self.titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        self.titleButton.titleLabel.font = [UIFont systemFontOfSize:20];
        self.titleButton.backgroundColor = [UIColor clearColor];
        
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:cellFrame];
//        self.backgroundImageView.image = [UIImage imageNamed:@"navi_button1_l.png"];
        [self.backgroundImageView addSubview:self.titleButton];
        [self addSubview:self.backgroundImageView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
