//
//  NewSCenterPullViewControllerGraidCell.h
//  PullingTableDemo
//
//  Created by ledmedia on 13-8-18.
//
//

// modify yxm 2013年11月06日10:27:35
#import "EScrollerView.h"
#import "MyTool.h"
#import "ASIHTTPRequest.h"
#import "YGPSegmentedController.h"
//#import "NewsWebCycleViewController.h"
#import "MJRefresh.h"

@class DataColumns;
@class DataCategories;
@class NewsWebViewController;
//NewsWebCycleViewController *newsWebCycleViewController;

@interface  ListPullViewController: UIViewController<ASIHTTPRequestDelegate,UITableViewDataSource,
UITableViewDelegate,YGPSegmentedControllerDelegate>
{
    NSString *firstitemurl;
    NSMutableArray *newslist;
    NSMutableArray *tablelist;
    NewsWebViewController *webViewController;
    DataColumns *oneDataColumns;
    
    //主界面底部滚动视图
    UIScrollView *mainFloorScrollView;
    //主界面链接按钮
    UIScrollView *mainLinksScrollView;
    //主界面的九宫格菜单
    UIScrollView *mainGridcellScrollView;
    
    NSInteger state;
    
    //广告模块的图片
    NSMutableArray *adimagArray;
    //广告模块的标题
    NSMutableArray *adtitleArray;
    //广告模块的链接
    NSMutableArray *adlinksArray;
    
    //九宫格模块的图片
    NSMutableArray *mainGridcelliconArray;
    //九宫格模块的标题
    NSMutableArray *mainGridcelltitleArray;
    //九宫格模块的链接
    NSMutableArray *mainGridcellinksArray;
    
    //访问网络
    ASIHTTPRequest *asiHttp;
    
    //二级目录的菜单
    NSMutableArray *secondMenuArray;
    //横向侧滑菜单
    YGPSegmentedController * _ygp;
    NSMutableArray *YGPtitleArray;
    //横向侧滑菜单被选择的索引
    NSInteger horizMenuindex;
    
    //主界面九宫格菜单字体
    NSInteger mainGridcelltitleFont;
    //九宫格标题的label宽度
    NSInteger mainGridcelltitleViewWidth;
    //主界面链接菜单高度
    NSInteger mainLinksModelHeight;
    //主界面链接文字大小
    NSInteger mainLinksButtonFont;
    //主界面链接菜单缩放比例
    NSInteger iconScale;
    
    NSInteger prIndex;
    
    UILabel *titleLabel;
    NSString *columnName;
    
    //下拉刷新
    MJRefreshHeaderView *header;
    //上拉加载
    MJRefreshFooterView *_footer;
    UITableView *dataTableView;
    //
    NSString *_firstPageUrl;
    //下一页的URL
    NSMutableString *_nextPageUrl;
    
    NSMutableArray *_newsList;
    
    
    //下拉刷新
    MJRefreshBaseView *mjRefreshBaseView;
}
//@property (retain,nonatomic) PullingRefreshTableView *tableView;
@property(nonatomic,retain) NSMutableArray *secondMenuArray;
@property(nonatomic,retain) DataColumns *oneDataColumns;
@property(nonatomic,retain) DataCategories *oneDataCategory;
//@property(nonatomic,strong) NSMutableArray *newslist;

//标题
@property(nonatomic,retain) NSString *titleLabelText;

-(void)reloadData:(DataColumns *)columns;
-(void)reloadCategoryData:(DataCategories *)oneDataCategory;

/** 
 *@brief 搜索产品
 */
-(void)reloadSearchData:(NSString *)searchUrl;

extern UINavigationController *newsnav;
@end
