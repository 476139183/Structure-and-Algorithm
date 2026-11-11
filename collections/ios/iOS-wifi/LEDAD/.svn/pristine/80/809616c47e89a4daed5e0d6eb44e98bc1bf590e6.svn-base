


#import <UIKit/UIKit.h>
#import "MaterialObject.h"
#import "RMSwipeTableViewCelliOS7UIDemoTableViewCell.h"

@protocol PlayListSelectDelegate <NSObject>

-(void)playOneWithALAsset:(NSDictionary*)assetDict cellIndexPath:(NSIndexPath*)cellIndexPath;
/**
 *  点击更多按钮的回调方法
 *
 *  @param assetDict          选中的数据
 *  @param cellIndexPath      选中数据的索引
 *  @param swipeTableViewCell 单元格本身
 */
-(void)deleteButtonClicked:(NSDictionary*)assetDict cellIndexPath:(NSIndexPath*)cellIndexPath andSwipeTableViewCell:(RMSwipeTableViewCelliOS7UIDemoTableViewCell *)swipeTableViewCell;
@end


@interface MyPlayListViewController : UITableViewController<RMSwipeTableViewCellDelegate,RMSwipeTableViewCelliOS7UIDemoTableViewCellDelegate>


@property (nonatomic,assign) id<PlayListSelectDelegate> delegate;

@property (nonatomic, retain) NSIndexPath *selectedIndexPath;

-(void)reloadMyPlaylist:(NSArray *)assetArray;


/**
 *  根据资源的类型描述返回资源类型
 *
 *  @param 资源描述类型
 *
 *  @return 返回Video/Photo
 */
+(NSString*)sourceType:(NSString *)sourceTitle;


-(void)setDurationToCell:(NSIndexPath*)cellIndexPath duration:(NSString *)durationString;
-(void)setDirectionToCell:(NSIndexPath*)cellIndexPath myDirection:(NSString *)directionString;
/**
 *@brief 重新设置图片的大小
 */
+(UIImage *)scale:(UIImage *)image toSize:(CGSize)size;

/**
 *  删除列表中的一行
 *
 *  @param assetDict     行内容
 *  @param cellIndexPath 行标示
 */
-(void)deleteSelectRowWithOneAssetDict:(NSDictionary*)assetDict cellIndexPath:(NSIndexPath*)cellIndexPath andSwipeTableViewCell:(RMSwipeTableViewCelliOS7UIDemoTableViewCell *)swipeTableViewCell isEdit:(BOOL)isEdit;


-(void)setAlphaToCell:(NSIndexPath*)cellIndexPath myDirection:(NSString *)alphaString;
@end
