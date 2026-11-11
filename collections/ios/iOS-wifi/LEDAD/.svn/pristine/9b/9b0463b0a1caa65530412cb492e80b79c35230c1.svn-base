


#import <UIKit/UIKit.h>
#import "ProjectListObject.h"
#import "ProjectItemCell.h"
#import "AsyncSocket.h"
#import "YXM_FTPManager.h"
#import "MRProgressOverlayView.h"

@protocol MyProjectListSelectDelegate <NSObject>

@required
-(void)playOneWithProjectObj:(ProjectListObject *) asset cellIndexPath:(NSIndexPath*)cellIndexPath;

-(void)selectedProjectWithObject:(NSMutableArray *)mySelectedProjectList;

@end


@interface MyProjectListViewController : UITableViewController<CheckBoxSelectDelegate,UploadResultDelegate>
{
    YXM_FTPManager *_ftpMgr;
    NSMutableArray *_itemDurationArray;
    /**
     *  项目对象列表
     */
    NSMutableArray *_assets;
    //浮动的进度条
    MRProgressOverlayView *myMRProgressView;
    
    UIView *eventView;
    //被选择的项目
    NSMutableArray *_selectedProjectArray;
    
    //列表内否禁止多选
    BOOL _isMulitSelected;

    //soket连接
    AsyncSocket *_sendPlayerSocket;
    //是否连接中
    BOOL isConnect;
    //当前数据区域的索引
    NSInteger _currentDataAreaIndex;
    //当前数据仓库
    NSMutableArray *_currentDataArray;
    //发送配置文件的总次数
    int totalPage;
    
}

@property (nonatomic,strong) id<MyProjectListSelectDelegate> delegate;
@property (nonatomic,retain) NSMutableArray *itemDurationArray;
@property (nonatomic, retain) NSMutableArray *assets;
@property (nonatomic,assign) BOOL isMulitSelected;
-(void)reloadMyPlaylist;


///**
// *  根据资源的类型描述返回资源类型
// *
// *  @param 资源描述类型
// *
// *  @return 返回Video/Photo
// */
//+(NSString*)sourceType:(NSString *)sourceTitle;


//-(void)setDurationToCell:(NSIndexPath*)cellIndexPath duration:(NSString *)durationString;

/**
 *  加载项目列表
 */
-(void)loadProjectList;

/**
 *  通过项目名称搜索项目列表
 */
-(BOOL)searchProjectListWithProjectName:(NSString *)projectName;

/**
 *  根据传入的文件对象，解析文件中的项目的播放时间返回
 *
 *  @param asset 文件对象
 *
 *  @return 指定项目的播放时间
 */
-(int)getProjectDurationWithFileName:(NSString *)myFilePath;

/**
 *  使用分组信息重新加载项目列表
 */
-(void)useGroupInfoReloadProjectList;

/**
 *  根据传入的文件对象，解析文件中的项目名称返回
 *
 *  @param asset 文件对象
 *
 *  @return 项目名称
 */
-(void)getProjectNameWithFileName:(NSString *)myFilePath andProjectObj:(ProjectListObject*)myProjectObj;
-(void)downxiazai;
-(void)downjiance;
-(void)delete:(NSString*)path;







//添加项目
-(void)addreloadview;

//添加分组
-(void)addgroup;

//删除分组
-(void)deletegroup;

//首次刷新
-(void)loadfirstview;

-(void)deletePlayProject:(ProjectListObject *)projects;


-(void)review;

-(void)shangchu:(NSString *)str;

@end


