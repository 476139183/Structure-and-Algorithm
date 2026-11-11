//
//  PushMyFriendsCell.h
//  ZDEC
//  选择要推送的列表的页面
//  Created by yixingman on 9/6/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoEntity.h"
#import "BaseButton.h"
#import "BaseTextField.h"
#import "BaseUILabel.h"

#import "QCheckBox.h"

@interface PushMyFriendsCell : UITableViewCell<QCheckBoxDelegate>
{
    BaseButton *headImageButton;
    BaseUILabel *nameLabel;
    BaseUILabel *positionLabel;
    //复选框
    QCheckBox *_check1;
    
    UserInfoEntity *_ecus;
}
@property (nonatomic,retain) UserInfoEntity *ecus;
-(UIView*)getCellView;
@end
