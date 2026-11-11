//
//  DYT_prgressTableViewCell.h
//  LEDAD
//
//  Created by laidiya on 15/7/16.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYT_prgressTableViewCell : UITableViewCell

@property(nonatomic,assign)NSInteger wid;
@property(nonatomic,retain)UILabel *progresslabel;
@property(nonatomic,retain)UILabel *projectnamelabel;
@property(nonatomic,retain)UIProgressView *progressview;
@end
