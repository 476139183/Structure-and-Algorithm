//
//  视频播放列表
//  Created by yixingman on 2014年03月27日11:08:28.
//  Copyright (c) 2014 ledmedia. All rights reserved.
//

#import "VideoDirectoryTableViewController.h"
#import "GeneralDatabaseOperation.h"
#import "MyTool.h"

@implementation VideoDirectoryTableViewController
@synthesize tableFrame = _tableFrame;
@synthesize dataSourceArray = _dataSourceArray;
@synthesize sectionHeadHeight = _sectionHeadHeight;
@synthesize rowHeadHeight = _rowHeadHeight;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    self.view.frame = _tableFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    DLog(@"总章数 = %lu",[_dataSourceArray count]);
    return [_dataSourceArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    DLog(@"章标题的高度 = %ld",(long)_sectionHeadHeight);
    return _sectionHeadHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"节标题的高度 = %ld",(long)_rowHeadHeight);
    return _rowHeadHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *titleOfSection = ((LEDVideoItem*)[_dataSourceArray objectAtIndex:section]).video_title;
    DLog(@"章的标题 = %@",titleOfSection);
    return titleOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection = [((LEDVideoItem*)[_dataSourceArray objectAtIndex:section]).video_video count];
    return numberOfRowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LEDVideoItem *oneDataItem = [_dataSourceArray objectAtIndex:indexPath.section];
    NSDictionary *oneVideoDict = [oneDataItem.video_video objectAtIndex:indexPath.row];
    
    static NSString *myCellIdentifier = @"myCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCellIdentifier];
    }
//    [[cell contentView] removeAllSubviews];
    [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除子视图
    [[cell contentView] addSubview:[self createTitleViewOfVideoID:oneDataItem.video_id videoTitle:[oneVideoDict objectForKey:KEY_VIDEO_TITLE] videoIndex:[[NSString alloc] initWithFormat:@"%d",indexPath.row]]];
//    [cell setBackgroundView:[self createTitleViewOfVideoID:oneDataItem.video_id videoTitle:[oneVideoDict objectForKey:KEY_VIDEO_TITLE] videoIndex:[[NSString alloc] initWithFormat:@"%d",indexPath.row]]];
    
    if ([MyTool isExistsVideoFile:[[oneDataItem.video_video objectAtIndex:indexPath.row] objectForKey:@"video_url"]]) {
        cell.detailTextLabel.text = @"已下载";
    }else {
        cell.detailTextLabel.text = nil;
    }
    return cell;
}

-(UIView *)createTitleViewOfVideoID:(NSString *)oneVideoID videoTitle:(NSString *)videoTitle videoIndex:(NSString *)videoIndex
{
    GeneralDatabaseOperation *dbOperation = [[GeneralDatabaseOperation alloc]init];
    UIView *videoTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, 40)];
    NSString *stateImageName = [dbOperation selectVideoPlayState:oneVideoID videoIndex:videoIndex];
    
    DLog(@"当前视频的播放状态 = %@",stateImageName);
    if (stateImageName==nil||([stateImageName length]==0)) {
        stateImageName=@"video_noread";
    }
    UIImage *stateImage = [UIImage imageNamed:stateImageName];
    UIImageView *videoStateImageView = [[UIImageView alloc]initWithImage:stateImage];
    [videoStateImageView setFrame:CGRectMake(20, 5, 30, 30)];
    [videoTitleView addSubview:videoStateImageView];


    FDLabelView *titleLabel = [[FDLabelView alloc] initWithFrame:CGRectMake(50, 0, SCREEN_CGSIZE_WIDTH-50, 40)];
    titleLabel.text = videoTitle;
    titleLabel.textColor = [UIColor blackColor];
    [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    titleLabel.minimumScaleFactor = 0.50;
    [titleLabel setNumberOfLines:0];
    [titleLabel setFont:[UIFont systemFontOfSize:13]];
    titleLabel.lineHeightScale = 0.62;
    titleLabel.fixedLineHeight = 0.00;
    titleLabel.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleLabel.fdTextAlignment = FDTextAlignmentLeft;
    titleLabel.fdAutoFitMode = FDAutoFitModeNone;
    titleLabel.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [videoTitleView addSubview:titleLabel];
    
    return videoTitleView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LEDVideoItem *oneDataItem = [_dataSourceArray objectAtIndex:section];
    //视屏标题
    FDLabelView *titleLabel = [[FDLabelView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, 40)];
    titleLabel.backgroundColor = [UIColor lightGrayColor];
    titleLabel.text = oneDataItem.video_title;
    titleLabel.textColor = [UIColor blackColor];
    [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    titleLabel.minimumScaleFactor = 0.50;
    [titleLabel setNumberOfLines:0];
    [titleLabel setFont:[UIFont systemFontOfSize:15]];
    titleLabel.lineHeightScale = 0.62;
    titleLabel.fixedLineHeight = 0.00;
    titleLabel.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleLabel.fdTextAlignment = FDTextAlignmentLeft;
    titleLabel.fdAutoFitMode = FDAutoFitModeNone;
    titleLabel.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    return titleLabel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LEDVideoItem *oneDataItem = [_dataSourceArray objectAtIndex:indexPath.section];
    NSString *videoID = oneDataItem.video_id;
    NSDictionary *oneVideoDict = [oneDataItem.video_video objectAtIndex:indexPath.row];
    DLog(@"点击视频列表,%@,%@",videoID,oneVideoDict);
    [delegate playWithOneVideoOfDictionary:oneVideoDict videoID:videoID videoIndex:indexPath.row];
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navi_button1_l.png"]]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


@end
