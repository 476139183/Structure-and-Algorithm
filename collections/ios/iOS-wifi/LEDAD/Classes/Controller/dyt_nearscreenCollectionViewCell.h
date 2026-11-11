//
//  dyt_nearscreenCollectionViewCell.h
//  LEDAD
//
//  Created by laidiya on 15/7/31.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dyt_nearscreenCollectionViewCell : UICollectionViewCell<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *dataarray;
-(void)review;
@end
