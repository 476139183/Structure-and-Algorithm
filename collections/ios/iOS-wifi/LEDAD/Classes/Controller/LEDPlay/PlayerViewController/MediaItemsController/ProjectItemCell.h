//
//  ProjectItemCell
//  LEDAD
//  项目列表的Cell
//  Created by yixingman on 8/21/14.
//  Copyright (c) 2014 yixingman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectListObject.h"
#import "QCheckBox.h"
@protocol CheckBoxSelectDelegate <NSObject>

@required
/**
 *  列表中的复选框被选择或被反选的之后的表格的索引传给代理处理者
 *
 *  @param cellIndexPath 列表的索引
 *  @param checked       是否被选中
 */
-(void)didSelectedCheckBoxWithIndexPath:(NSIndexPath*)cellIndexPath checked:(BOOL)checked;

@end

@interface ProjectItemCell : UITableViewCell<QCheckBoxDelegate>
{
    UILabel *_projectNameLabel;
    /**
     *  选择之后可以建立分组
     */
    QCheckBox *_myCheckBox;
    
    ProjectListObject *_projectObject;
    
    id<CheckBoxSelectDelegate> _delegate;
    
    NSIndexPath *_myCheckBoxOfIndexPath;
    
    //标示是否含有音乐
    UIImageView *audioIndicatorView;
    //标示此本地项目在屏端是否存在
    UILabel *ExistIndicatorLable;
    //标识是否在点击


    BOOL _isselectcell;

}

@property(nonatomic,assign)BOOL iselectcell;

@property (nonatomic,assign) id<CheckBoxSelectDelegate> delegate;
@property (nonatomic,retain) ProjectListObject *projectObject;
@property (nonatomic,retain) NSIndexPath *myCheckBoxOfIndexPath;


-(UIView*)getCellView;
+(float)projectItemCellHeight;
@end
