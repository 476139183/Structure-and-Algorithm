//
//  视频播放列表
//  Created by yixingman on 2014年03月27日11:08:28.
//  Copyright (c) 2014 ledmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "LEDVideoItem.h"
#import "FDLabelView.h"

@protocol PlayOfOneVideoInListDelegate <NSObject>

/**
 *@brief 点击视频列表播放视频的回调方法
 */
-(void)playWithOneVideoOfDictionary:(NSDictionary *)oneVideoDict videoID:(NSString *)videoID videoIndex:(NSInteger)videoIndex;

@end

@interface VideoDirectoryTableViewController : UITableViewController
{
    CGRect _tableFrame;
    //数据源,存放LEDVideoItem对象
    NSMutableArray *_dataSourceArray;
    NSInteger _sectionHeadHeight;
    NSInteger _rowHeadHeight;
    
    id<PlayOfOneVideoInListDelegate> delegate;
}
@property (nonatomic,assign) id<PlayOfOneVideoInListDelegate> delegate;
@property (nonatomic,assign) CGRect tableFrame;
/**
 *@brief 数据源,包含LEDVideoItem对象
 */
@property (nonatomic,retain) NSMutableArray *dataSourceArray;
/**
 *@brief 章标题的高度
 */
@property (nonatomic,assign) NSInteger sectionHeadHeight;
/**
 *@brief 节标题的高度
 */
@property (nonatomic,assign) NSInteger rowHeadHeight;
@end
