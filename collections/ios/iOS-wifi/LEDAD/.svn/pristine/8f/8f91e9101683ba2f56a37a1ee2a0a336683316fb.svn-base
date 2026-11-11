//
//  ProjectListObject.h
//  LEDAD
//  项目列表信息
//  Created by yixingman on 14-6-12.
//
//

#import <Foundation/Foundation.h>

@interface ProjectListObject : NSObject
{
    //项目xml文件的路径或者是分组xml文件的路径
    NSString *_project_filename;
    //项目名称或者分组名称
    NSString *_project_name;
    //项目播放时长
    NSString *_project_duration;
    //列表项目的类型，是分组还是项目
    NSString *_project_list_type;
    //如果是分组需要判断是否处于打开状态
    BOOL _isOpen;
    //列表对应表格中的索引
    NSIndexPath *_project_indexpath;
    //项目是否被选择
    BOOL _isSelected;
    //是否带音频
    BOOL _isIncludeMusic;
    //是否在屏端已经存在
    BOOL _isExist;
    //判断项目
    BOOL _isp;
}
/**
 *  项目xml文件的路径或者是分组xml文件的路径
 */
@property (nonatomic,retain) NSString *project_filename;
/**
 *  项目名称或者分组名称
 */
@property (nonatomic,retain) NSString *project_name;
/**
 *  项目播放时长
 */
@property (nonatomic,retain) NSString *project_duration;
/**
 *  列表项目的类型，是分组还是项目
 */
@property (nonatomic,retain) NSString *project_list_type;
/**
 *  如果是分组需要判断是否处于打开状态
 */
@property (nonatomic,assign) BOOL isOpen;
/**
 *  列表对应表格中的索引
 */
@property (nonatomic,retain) NSIndexPath *project_indexpath;
/**
 *  项目是否被选择
 */
@property (nonatomic,assign) BOOL isSelected;
/**
 *  项目是否包含音频
 */
@property (nonatomic,assign) BOOL isIncludeMusic;

/*
 
 --------------------------------------------项目是否存在屏端
 
 */


@property (nonatomic,assign) BOOL isExist;
@property (nonatomic,assign) BOOL isp;
@end
