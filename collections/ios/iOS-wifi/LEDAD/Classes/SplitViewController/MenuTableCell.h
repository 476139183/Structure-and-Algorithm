//
//  MenuTableCell.h
//  LEDAD
//
//  Created by LDY on 13-9-16.
//
//

#import <UIKit/UIKit.h>

@interface MenuTableCell : UITableViewCell
{
    UIImageView *backgroundImageView;
    UIButton *titleButton;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)cellFrame;

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *titleButton;

@end
