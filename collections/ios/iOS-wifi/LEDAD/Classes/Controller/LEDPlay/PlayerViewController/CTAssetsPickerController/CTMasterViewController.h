


#import <UIKit/UIKit.h>
#import "ALAsset+isEqual.h"
#import "ALAsset+assetType.h"
#import "ALAssetsGroup+isEqual.h"
#import "ALAsset+accessibilityLabel.h"
#import "CTAssetsPickerController.h"
#import "CTAssetsPageViewController.h"
#import "YXM_FTPManager.h"
#import "MRProgressOverlayView.h"
#import "AsyncSocket.h"

#import "MaterialObject.h"

@protocol SelectPhotoDelegate <NSObject>

-(void)selectPhotoToLayerWithALAsset:(ALAsset*) asset cellIndexPath:(NSIndexPath*)cellIndexPath;

-(void)selectPhotoToLayerWithMaterialObj:(MaterialObject *) asset cellIndexPath:(NSIndexPath*)cellIndexPath;
@end


@interface CTMasterViewController : UITableViewController<CTAssetsPickerControllerDelegate, UIPopoverControllerDelegate>
{
    NSString *_sAssetType;
    NSInteger _iAssetMaxSelect;
    YXM_FTPManager *_ftpMgr;
    //上传的文件的长度
    long long _sendFileCountSize;

    //上传的文件的总长度
    long long _uploadFileTotalSize;
    //浮动的进度条
    MRProgressOverlayView *myMRProgressView;
    //soket连接
    AsyncSocket *_sendPlayerSocket;
    BOOL isConnect;
    //当前数据区域的索引
    NSInteger _currentDataAreaIndex;
    //当前数据仓库
    NSMutableArray *_currentDataArray;

}
@property (nonatomic,retain) NSString *sAssetType;
@property (nonatomic,assign) NSInteger iAssetMaxSelect;
@property (nonatomic,assign) id<SelectPhotoDelegate> delegate;
@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic, assign) BOOL islist;
- (void)clearAssets:(id)sender;
- (void)pickAssets:(id)sender;
@end
