//
//  VideosCenterCollectionPullViewController.h
//  视频播放的网格显示界面
//
//  Created by yixingman on 2014年03月21日.
//
//

#import "MJRefresh.h"
#import "YGPSegmentedController.h"

@class DataColumns;
@class VideoViewController;

@interface VideosCenterCollectionPullViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,MJRefreshBaseViewDelegate,YGPSegmentedControllerDelegate>
{
    /**
     *@brief 存储视频列表第一页的地址,下拉刷新的时候使用
     */
    NSString *_firstPageUrl;
    /**
     *@brief 存储视频播放列表的数据集
     */
    NSMutableArray *_videosList;
    /**
     *@brief 视频播放的详细页面
     */
    VideoViewController *videoViewController;
    /**
     *@brief 二级目录的数据
     */
    DataColumns *oneDataColumns;

    
    //下拉刷新
    MJRefreshHeaderView *_header;
    //上拉加载
    MJRefreshFooterView *_footer;
    //网格的视图
    UICollectionView *_gridCollectionView;
    UIScrollView *floorScrollView;
    
    //横向侧滑菜单
    YGPSegmentedController * _ygp;
    NSMutableArray *YGPtitleArray;
    UILabel *titleLabel;
    
    //下拉刷新
    MJRefreshBaseView *mjRefreshBaseView;
    MJRefreshHeaderView *header;
    //下一页的URL
    NSMutableString *_nextPageUrl;
}
@property(nonatomic,retain) NSString *titleLabelText;
//水平滑动按钮
@property(nonatomic,retain) NSMutableArray *secondMenuArray;

//网格视图
@property (nonatomic,retain) UICollectionView *gridCollectionView;

@property(nonatomic,retain) DataColumns *oneDataColumns;
@property(nonatomic,retain) NSMutableArray *videosList;

-(void)reloadData:(DataColumns *)columns;
//extern VideosCenterCollectionPullViewController *videoCenterCollectionPullViewCtrl;
@end
