
 

#define TAG_DURATION_CELL 210010

#import "CTAssetsPickerController.h"
#import "MyPlayListViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LayoutYXMViewController.h"



@interface MyPlayListViewController () <UINavigationControllerDelegate, CTAssetsPickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *assets;

@end



@implementation MyPlayListViewController
@synthesize delegate;
@synthesize selectedIndexPath;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[RMSwipeTableViewCelliOS7UIDemoTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView setRowHeight:80];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try {
        
        NSString *CellIdentifier =[[NSString alloc]initWithFormat:@"%@-%d-%d",@"cell",[indexPath section],[indexPath row]];
        
        
        RMSwipeTableViewCelliOS7UIDemoTableViewCell *myRMSCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (myRMSCell==nil) {
            myRMSCell = [[RMSwipeTableViewCelliOS7UIDemoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        myRMSCell.selectionStyle = UITableViewCellSelectionStyleGray;
        myRMSCell.delegate = self;
        myRMSCell.demoDelegate = self;

        NSDictionary *assetDict = [self.assets objectAtIndex:indexPath.row];
        
        NSString *durationString = [assetDict objectForKey:@"duration"];
        MaterialObject *asset = (MaterialObject*)[assetDict objectForKey:@"asset"];
        //素材类型和间隔时间
        myRMSCell.textLabel.text = [MyPlayListViewController sourceType:[asset material_type]];

        NSString *materialType = [asset material_type];
        NSString *textLabelString = myRMSCell.textLabel.text;
        if ([materialType isEqualToString:@"Photo"]) {
            [myRMSCell.textLabel setText:[NSString stringWithFormat:@"%@  %@second",textLabelString,durationString]];
        }else if ([materialType isEqualToString:@"Video"]) {
            if ([asset material_duration]) {
               [myRMSCell.textLabel setText:[NSString stringWithFormat:@"%@  %dsecond",textLabelString,[asset material_duration]]];
            }
        }

        if ([[asset material_type] isEqualToString:@"Photo"]) {
            [myRMSCell.imageView setFrame:CGRectMake(5, 5, 50, 80)];
            myRMSCell.imageView.contentMode = UIViewContentModeScaleAspectFit;

            //使用缩略图
            UIImage *myThumbnailImage = nil;
            NSString *sThumbnailImagePath = nil;

            if ([asset material_thumbnail] != NULL) {
                myThumbnailImage = [UIImage imageWithCGImage:[asset material_thumbnail]];
            }else{
                NSFileManager *fileMgr = [NSFileManager defaultManager];
                sThumbnailImagePath = [NSString stringWithFormat:@"%@",[asset material_path]];
                if ([fileMgr fileExistsAtPath:sThumbnailImagePath]) {
                    myThumbnailImage = [UIImage imageWithContentsOfFile:sThumbnailImagePath];
                }else{
                    sThumbnailImagePath = [NSString stringWithFormat:@"%@/%@",[LayoutYXMViewController defaultProjectRootPath],[asset material_path]];
                    if ([fileMgr fileExistsAtPath:sThumbnailImagePath]) {
                        myThumbnailImage = [UIImage imageWithContentsOfFile:sThumbnailImagePath];
                    }
                }
            }

            if (myThumbnailImage) {
                myRMSCell.imageView.image = myThumbnailImage;
            }
        }else{
            if ([asset material_thumbnail]) {
                myRMSCell.imageView.image = [UIImage imageWithCGImage:[asset material_thumbnail]];
            }
        }
        DLog(@"[asset material_path] =%@",[asset material_path]);
        return myRMSCell;
    }
    @catch (NSException *exception) {
        DLog(@"cellForRowAtIndexPath.exception = %@",exception);
    }
    @finally {
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *assetDict = [self.assets objectAtIndex:indexPath.row];
    [self.delegate playOneWithALAsset:assetDict cellIndexPath:indexPath];
}


-(void)setDurationToCell:(NSIndexPath*)cellIndexPath duration:(NSString *)durationString{
    NSInteger indexRow = cellIndexPath.row;
    NSDictionary *assetDict = [self.assets objectAtIndex:indexRow];
    MaterialObject *asset = (MaterialObject*)[assetDict objectForKey:@"asset"];
    if (!durationString) {
        if ([assetDict objectForKey:@"duration"]) {
            durationString = [assetDict objectForKey:@"duration"];
        }else{
            durationString = DEFAULT_TIME;
        }
    }
    if ([durationString length]<1) {
        durationString = DEFAULT_TIME;
    }
    
    if ([[asset material_type] isEqualToString:@"Video"]) {
        NSURL    *movieURL = [NSURL URLWithString:[asset material_path]];
        NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                         forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:movieURL options:opts];  // 初始化视频媒体文件
        int minute = 0, second = 0;
        second = urlAsset.duration.value / urlAsset.duration.timescale; // 获取视频总时长,单位秒

        if (second >= 60) {
            int index = second / 60;
            minute = index;
            second = second - index*60;
        }
        durationString = [[NSString alloc]initWithFormat:@"%d",second];
        DLog(@"movie duration : %d", second);
    }
    

    for (int i=0; i<[self.assets count]; i++) {
        if (i == indexRow) {
            [asset setMaterial_duration:[durationString integerValue]];
            NSDictionary *myAssetDict = [[NSDictionary alloc]initWithObjectsAndKeys:durationString,@"duration",asset,@"asset",nil];
            [self.assets replaceObjectAtIndex:i withObject:myAssetDict];
        }
    }
    
    [self.tableView reloadData];
}

-(void)setDirectionToCell:(NSIndexPath*)cellIndexPath myDirection:(NSString *)directionString{
    NSInteger indexRow = cellIndexPath.row;
    NSDictionary *assetDict = [self.assets objectAtIndex:indexRow];
    MaterialObject *asset = (MaterialObject*)[assetDict objectForKey:@"asset"];

    if ([[asset material_type] isEqualToString:@"Photo"]) {
        for (int i=0; i<[self.assets count]; i++) {
            if (i == indexRow) {
                [asset setMaterial_direction:directionString];
                NSDictionary *myAssetDict = [[NSDictionary alloc]initWithObjectsAndKeys:[assetDict objectForKey:@"duration"],@"duration",asset,@"asset",nil];
                [self.assets replaceObjectAtIndex:i withObject:myAssetDict];
            }
        }
        [self.tableView reloadData];
    }
}

-(void)setAlphaToCell:(NSIndexPath*)cellIndexPath myDirection:(NSString *)alphaString{
    NSInteger indexRow = cellIndexPath.row;
    NSDictionary *assetDict = [self.assets objectAtIndex:indexRow];
    MaterialObject *asset = (MaterialObject*)[assetDict objectForKey:@"asset"];

    if ([[asset material_type] isEqualToString:@"Photo"]) {
        for (int i=0; i<[self.assets count]; i++) {
            if (i == indexRow) {
                [asset setMaterial_alpha:alphaString];
                NSDictionary *myAssetDict = [[NSDictionary alloc]initWithObjectsAndKeys:[assetDict objectForKey:@"duration"],@"duration",asset,@"asset",nil];
                [self.assets replaceObjectAtIndex:i withObject:myAssetDict];
            }
        }
        [self.tableView reloadData];
    }
}


#pragma mark - Assets Picker Delegate

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:[self indexPathOfNewlyAddedAssets:assets]
                          withRowAnimation:UITableViewRowAnimationBottom];
    
    [self.assets addObjectsFromArray:assets];
    [self.tableView endUpdates];
}

- (NSArray *)indexPathOfNewlyAddedAssets:(NSArray *)assets
{
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = self.assets.count; i < self.assets.count + assets.count ; i++)
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    
    return indexPaths;
}

-(void)reloadMyPlaylist:(NSArray *)assetArray{
    if (!_assets) {
        _assets = [[NSMutableArray alloc]init];
    }
    [self.assets removeAllObjects];
    if (assetArray) {
        [self.assets addObjectsFromArray:assetArray];
    }
    [self.tableView reloadData];
}


/**
 *  根据资源的类型描述返回资源类型
 *
 *  @param 资源描述类型
 *
 *  @return 返回Video/Photo
 */
+(NSString*)sourceType:(NSString *)sourceTitle{
    if ([sourceTitle isEqualToString:@"ALAssetTypePhoto"]) {
        return @"Photo";
    }
    if ([sourceTitle isEqualToString:@"ALAssetTypeVideo"]) {
        return @"Video";
    }
    return sourceTitle;
}


/**
 *@brief 重新设置图片的大小
 */
+(UIImage *)scale:(UIImage *)image toSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}


#pragma mark - RMSwipeTableViewCelliOS7UIDemoTableViewCell delegate method
//点击删除
-(void)swipeTableViewCellDidDelete:(RMSwipeTableViewCelliOS7UIDemoTableViewCell *)swipeTableViewCell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:swipeTableViewCell];
    
    NSDictionary *myOneAssetDict = [self.assets objectAtIndex:indexPath.row];
    DLog(@"myOneAssetDict = %@",myOneAssetDict);
    
    [self.delegate deleteButtonClicked:myOneAssetDict cellIndexPath:indexPath andSwipeTableViewCell:swipeTableViewCell];
    swipeTableViewCell.selectionStyle = UITableViewCellSelectionStyleGray;
}

#pragma mark - RMSwipeTableViewCell delegate methods

-(void)swipeTableViewCellDidStartSwiping:(RMSwipeTableViewCell *)swipeTableViewCell {
    NSIndexPath *indexPathForCell = [self.tableView indexPathForCell:swipeTableViewCell];
    if (self.selectedIndexPath.row != indexPathForCell.row) {
        [self resetSelectedCell];
    }
}

-(void)resetSelectedCell {
    RMSwipeTableViewCelliOS7UIDemoTableViewCell *cell = (RMSwipeTableViewCelliOS7UIDemoTableViewCell*)[self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
    [cell resetContentView];
    self.selectedIndexPath = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
}

-(void)swipeTableViewCellWillResetState:(RMSwipeTableViewCell *)swipeTableViewCell fromPoint:(CGPoint)point animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity {
    DLog(@"point.x = %lf, point.y = %lf",point.x,point.y);
    DLog(@"velocity.x = %lf, velocity.y = %lf",velocity.x,velocity.y);
    if (velocity.x <= -500) {
        self.selectedIndexPath = [self.tableView indexPathForCell:swipeTableViewCell];
        swipeTableViewCell.shouldAnimateCellReset = NO;
        swipeTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSTimeInterval duration = MAX(-point.x / ABS(velocity.x), 0.10f);
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             swipeTableViewCell.contentView.frame = CGRectOffset(swipeTableViewCell.contentView.bounds, point.x - (ABS(velocity.x) / 150), 0);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:duration
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  swipeTableViewCell.contentView.frame = CGRectOffset(swipeTableViewCell.contentView.bounds, -80, 0);
                                              }
                                              completion:^(BOOL finished) {
                                              }];
                         }];
    }
}

/**
 *  删除列表中的一行
 *
 *  @param assetDict     行内容
 *  @param cellIndexPath 行标示
 */
-(void)deleteSelectRowWithOneAssetDict:(NSDictionary*)assetDict cellIndexPath:(NSIndexPath*)cellIndexPath andSwipeTableViewCell:(RMSwipeTableViewCelliOS7UIDemoTableViewCell *)swipeTableViewCell isEdit:(BOOL)isEdit{
    @try {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:swipeTableViewCell];

        NSFileManager *myFileManager = [NSFileManager defaultManager];
        NSDictionary *myOneAssetDict = [self.assets objectAtIndex:indexPath.row];
        MaterialObject *oneMaterial = [myOneAssetDict objectForKey:@"asset"];
        NSString *fileStringPath = [[NSString alloc]initWithFormat:@"%@/%@",[MaterialObject createMatrialRootPath],oneMaterial.material_path];
        if (![myFileManager fileExistsAtPath:fileStringPath]) {
            fileStringPath = [[NSString alloc]initWithFormat:@"%@/%@",[LayoutYXMViewController defaultProjectRootPath],oneMaterial.material_path];
        }
        NSError *myRemoveFileError;
        [myFileManager removeItemAtPath:fileStringPath error:&myRemoveFileError];


        //需要删除数组tableView的数据源中对应的数据然后刷新tableView
        [self.assets removeObjectAtIndex:indexPath.row];
        
        [self.tableView reloadData];
        [swipeTableViewCell resetContentView];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
    @catch (NSException *exception) {
        DLog(@"deleteSelectRowWithOneAssetDicNSException = %@",exception);
    }
    @finally {
        
    }
    
}

-(void)dealloc{
    RELEASE_SAFELY(_assets);
    [super dealloc];
}
@end
