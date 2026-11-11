//
//  DYT_cloudcheckTableViewCell.h
//  LEDAD
//
//  Created by laidiya on 15/7/23.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
#import "Project.h"
@protocol dyt_CheckBoxSelectDelegate <NSObject>

@required
/**
 *  列表中的复选框被选择或被反选的之后的表格的索引传给代理处理者
 *
 *  @param cellIndexPath 列表的索引
 *  @param checked       是否被选中
 */
-(void)dyt_didSelectedCheckBoxWithIndexPath:(NSIndexPath*)cellIndexPath checked:(BOOL)checked;

@end


@interface DYT_cloudcheckTableViewCell : UITableViewCell
@property(nonatomic,assign)id<dyt_CheckBoxSelectDelegate> delegate;
@property(nonatomic,retain)Project *myproject;
@property(nonatomic,retain)NSIndexPath *mychecboxindexpath;
@end
