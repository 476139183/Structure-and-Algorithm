//
//  ImageListViewController.m
//  云屏
//
//  Created by LDY on 7/21/14.
//  Copyright (c) 2014 LDY. All rights reserved.
//

#import "ImageListViewController.h"
#import "UIImageView+WebCache.h"
#import "MyTool.h"
#import "NSString+SBJSON.h"
#import "DetailImageViewController.h"
#import "ImageDescriptionEntity.h"
#import "MyLabel.h"
#import "ProductionsViewController.h"
#import "KLCPopup.h"
#import "BBSDetailViewController.h"
#import "Config.h"
#import "LayoutYXMViewController.h"
#import "ASIFormDataRequest.h"
#import "UINavigationController+Transition.h"

#define TAG_BY_DOWNLOAD_BUTTON 100880
#define TAG_BY_DOWNLOAD2_BUTTON 100890
#define TAG_BY_UPLOAD_BUTTON 100891
#define TAG_BY_DESIGNER_BUTTON 100892
#define TAG_UPLOAD_PROJECT_LIST_VIEW 100893
#define TAG_REQUEST_GET_PROJECT_LIST 100894
#define TAG_REQUEST_GET_PROJECT_NEXT 100895
@interface ImageListViewController ()
{
    KLCPopup* popup;
    


}

@end

static NSString *MJCollectionViewCellIdentifier = @"myCollectionCell";
@implementation ImageListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    headView  = [[UIView alloc] initWithFrame:CGRectMake(-1, -1, SCREEN_CGSIZE_HEIGHT +2, SCREEN_CGSIZE_WIDTH/3 + 31)];
    headView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    headView.layer.borderWidth = 1.0f;
    backToMainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backToMainButton.frame = CGRectMake(2, 2, 40, 40);
    [backToMainButton setBackgroundImage:[UIImage imageNamed:@"backToMainButton"] forState:UIControlStateNormal];
    [backToMainButton setBackgroundColor:[UIColor blackColor]];
    [backToMainButton addTarget:self action:@selector(backToMainImageView) forControlEvents:UIControlEventTouchUpInside];
    
    mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 50, SCREEN_CGSIZE_WIDTH/3 - 40, SCREEN_CGSIZE_WIDTH/3 - 40)];
    mainImageView.contentMode = UIViewContentModeScaleAspectFit;
//    [mainImageView setImageWithURL:[NSURL URLWithString:self.mainImageName] placeholderImage:[UIImage imageNamed:@"Icon"]];//写到viewWillAppear方法中
    
    productionTitleLabel  = [[MyLabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/3 + 30, 50, SCREEN_CGSIZE_HEIGHT - SCREEN_CGSIZE_WIDTH/3 - 20, 40)];
    authorImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/3 + 30, 100, 60, 60)];
    authorNameLabel = [[MyLabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/3 + 100, 100, 300, 20)];
    productionDateLabel = [[MyLabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/3 + 100, 120, 300, 20)];
    
    aboutDesignerButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutDesignerButton.frame = CGRectMake(SCREEN_CGSIZE_WIDTH/3 + 30, 180, 250, 45);
    [aboutDesignerButton setBackgroundColor:[UIColor lightGrayColor]];
    [aboutDesignerButton setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
    [aboutDesignerButton addTarget:self action:@selector(showDesignerProduction:) forControlEvents:UIControlEventTouchUpInside];
    aboutButtonCurve = [[UIImageView alloc] initWithFrame:CGRectMake(220, 12.5, 20, 20)];
    aboutButtonCurve.image = [UIImage imageNamed:@"chevron_black"];
    [aboutDesignerButton addSubview:aboutButtonCurve];
    
    productionTitleLabel.font = [UIFont systemFontOfSize:30.0f];
    authorNameLabel.textColor = [UIColor lightGrayColor];


    //上传项目
    aboutDesignerButton2  = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutDesignerButton2.frame = CGRectMake(aboutDesignerButton.frame.origin.x +aboutDesignerButton.frame.size.width + 20, aboutDesignerButton.frame.origin.y, 70, 45);
    [aboutDesignerButton2 setBackgroundColor:[UIColor lightGrayColor]];
    [aboutDesignerButton2 setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
    [aboutDesignerButton2 setTitle:[Config DPLocalizedString:@"adedit_uploadproject"] forState:UIControlStateNormal];
    [aboutDesignerButton2 setTag:TAG_BY_UPLOAD_BUTTON];
    [aboutDesignerButton2 addTarget:self action:@selector(showDesignerProduction:) forControlEvents:UIControlEventTouchUpInside];


    //下载项目
    aboutDesignerButton3  = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutDesignerButton3.frame = CGRectMake(aboutDesignerButton2.frame.origin.x +aboutDesignerButton2.frame.size.width + 20, aboutDesignerButton2.frame.origin.y, 120, 45);
    [aboutDesignerButton3 setBackgroundColor:[UIColor lightGrayColor]];
    [aboutDesignerButton3 setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
    [aboutDesignerButton3 setTitle:[Config DPLocalizedString:@"adedit_downloadproject"] forState:UIControlStateNormal];
    [aboutDesignerButton3 setTag:TAG_BY_DOWNLOAD_BUTTON];
    [aboutDesignerButton3 addTarget:self action:@selector(showDesignerProduction:) forControlEvents:UIControlEventTouchUpInside];


    //提示右滑动隐藏列表
    promptSwipeHidenLabel = [[UILabel alloc]initWithFrame:CGRectMake(aboutDesignerButton.frame.origin.x, aboutDesignerButton.frame.origin.y+aboutDesignerButton.frame.size.height+10, aboutDesignerButton.frame.size.width, aboutDesignerButton.frame.size.height)];
    [promptSwipeHidenLabel setBackgroundColor:[UIColor clearColor]];
    [promptSwipeHidenLabel setFont:[UIFont boldSystemFontOfSize:16]];

    //下载项目
    aboutCommentButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutCommentButton.frame = CGRectMake(SCREEN_CGSIZE_HEIGHT - 150, 185, 150, 35);
    [aboutCommentButton setBackgroundColor:[UIColor lightGrayColor]];
    [aboutCommentButton setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
    [aboutCommentButton setTitle:[Config DPLocalizedString:@"adedit_downloadproject"] forState:UIControlStateNormal];
    [aboutCommentButton setTag:TAG_BY_DOWNLOAD2_BUTTON];
    [aboutCommentButton addTarget:self action:@selector(showDesignerProduction:) forControlEvents:UIControlEventTouchUpInside];


    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    if (![[ud objectForKey:@"Category_Id"] isEqualToString:@"1"])
    if ([[ud objectForKey:@"PingtiOrImage"] isEqualToString:@"image"])
    {
        [headView addSubview:aboutDesignerButton];
        [headView addSubview:authorImageView];
        [headView addSubview:authorNameLabel];
        [headView addSubview:productionDateLabel];
        if (DEVICE_IS_IPAD) {
            [headView addSubview:aboutDesignerButton2];
            [headView addSubview:aboutDesignerButton3];
            [headView addSubview:promptSwipeHidenLabel];
        }else{
            [headView addSubview:aboutCommentButton];
        }
    }
    
    [headView addSubview:productionTitleLabel];
    [headView addSubview:backToMainButton];
    [headView addSubview:mainImageView];
    [self.view addSubview:headView];
    
//    //评论模块展示无法使用
//    //    评论
//    aboutCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    aboutCommentButton.frame = CGRectMake(SCREEN_CGSIZE_HEIGHT - 150, 185, 35, 35);
//    [aboutCommentButton setImage:[UIImage imageNamed:@"action_comment_34x34"] forState:UIControlStateNormal];
//    [aboutCommentButton setImage:[UIImage imageNamed:@"action_comment_press_34x34"] forState:UIControlStateHighlighted];
//    [aboutCommentButton addTarget:self action:@selector(showCommontView) forControlEvents:UIControlEventTouchUpInside];
//    [headView addSubview:aboutCommentButton];



    //    显示评论页面的左滑手势
//    UISwipeGestureRecognizer *showComment = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showCommontView)];
//    showComment.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.view addGestureRecognizer:showComment];

    if (!DEVICE_IS_IPAD) {
        headView.frame = CGRectMake(-1, -1, SCREEN_CGSIZE_WIDTH +2, SCREEN_CGSIZE_WIDTH/2 + 51);
        mainImageView.frame = CGRectMake(5, 50, SCREEN_CGSIZE_WIDTH/2 - 10, SCREEN_CGSIZE_WIDTH/2 - 10);
        productionTitleLabel.frame = CGRectMake(SCREEN_CGSIZE_WIDTH/2 + 5, 50,  SCREEN_CGSIZE_WIDTH/2 - 10, 45);
        productionTitleLabel.font = [UIFont systemFontOfSize:18.0f];
        authorImageView.frame = CGRectMake(SCREEN_CGSIZE_WIDTH/2 + 5, 110, 35, 35);
        authorNameLabel.frame = CGRectMake(SCREEN_CGSIZE_WIDTH/2 + 50, 110, SCREEN_CGSIZE_WIDTH/2 - 55, 20);
        aboutDesignerButton.frame = CGRectMake(SCREEN_CGSIZE_WIDTH/2 + 5, authorImageView.frame.origin.y + 50, SCREEN_CGSIZE_WIDTH/2 - 10, 35);
        aboutButtonCurve.frame = CGRectMake(SCREEN_CGSIZE_WIDTH/2 - 10 - 25, 7.5, 20, 20);
        
        aboutCommentButton.frame = CGRectMake(SCREEN_CGSIZE_WIDTH - 120, 5, 120, 35);
    }
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backToMainButton];
    self.navigationController.navigationBar.hidden = YES;
    //网格视图的容器
    [self initCollectionView];



}

- (void)viewWillAppear:(BOOL)animated
{
    [mainImageView setImageWithURL:[NSURL URLWithString:self.mainImageName] placeholderImage:[UIImage imageNamed:@"Icon"]];
}

/** 进入设计师页面 */
- (void)showDesignerProduction:(UIButton *)sender
{
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setObject:@"fromImageList" forKey:@"fromWhere"];
//    ProductionsViewController *productionVC = [[ProductionsViewController alloc] init];
//    productionVC.requestUrl = designerProcuctionUrl;
////    productionVC.requestUrl = @"http://www.ledmediasz.com/api_yunping/api_showUserMessage.aspx?userid=66";
//    productionVC.nameString = nameString;
//    productionVC.qqString = qqString;
//    productionVC.telString = telString;
//    productionVC.descriptionString = descriptionString;
//    productionVC.photoUrl = photoUrl;
//    [self presentViewController:productionVC animated:YES completion:nil];

    if ((sender.tag == TAG_BY_DOWNLOAD_BUTTON)||(sender.tag == TAG_BY_DOWNLOAD2_BUTTON)) {
        DLog(@"下载项目");
        if (projectFileListArray==nil) {
            projectFileListArray = [[NSMutableArray alloc]init];
        }
        [projectFileListArray removeAllObjects];

        NSString *downloadURLString = [NSString stringWithFormat:@"http://www.ledmediasz.com/API_yunping/api_download.aspx?id=%@",itemId];
//        NSString *downloadURLString = [NSString stringWithFormat:@"http://192.168.1.99//api_newbbs/api_bbsArticle_List.aspx"];
        DLog(@"downloadURLString = %@",downloadURLString);
        //获取项目列表
        
        ASIHTTPRequest *myRquest = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:downloadURLString]];
        [myRquest setTag:TAG_REQUEST_GET_PROJECT_LIST];
        [myRquest setCompletionBlock:^{
            DLog(@"url = %@,获取项目列表请求成功 = %@",[myRquest url],[myRquest responseString]);
            //解析返回的数据，提取xml和图片列表
            [self analyzingProjectData:[myRquest responseString]];
        }];
        [myRquest setFailedBlock:^{
            DLog(@"获取项目请求失败");
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_downloadisfailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
        }];
        [myRquest startAsynchronous];
    }


    if (sender.tag == TAG_BY_UPLOAD_BUTTON) {
        DLog(@"上传项目");
        UISwipeGestureRecognizer *swipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenProjectList:)];
        //        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenProjectList:)];
        [self.view addGestureRecognizer:swipeGesture];
        [swipeGesture release];
        //设置提示文字
        [promptSwipeHidenLabel setText:[Config DPLocalizedString:@"adedit_swipe_hiddenlist"]];
        [promptSwipeHidenLabel setTextColor:[UIColor redColor]];
        //项目列表容器
        CGRect rectInitProjView = CGRectMake(self.view.frame.size.height, 0,320,self.view.frame.size.width);
        CGRect rectDistProjView = CGRectMake(self.view.frame.size.height-320, 0,320,self.view.frame.size.width);
        if (OS_VERSION_FLOAT>7.9) {
            rectInitProjView = CGRectMake(self.view.frame.size.width, 0,320,self.view.frame.size.height);
            rectDistProjView = CGRectMake(self.view.frame.size.width-320, 0,320,self.view.frame.size.height);
        }

        UIView *tempProjView = [self.view viewWithTag:TAG_UPLOAD_PROJECT_LIST_VIEW];
        if (tempProjView) {
            [tempProjView removeFromSuperview];
        }
        UIView *projectItemView = [[UIView alloc]initWithFrame:rectInitProjView];
        [projectItemView setTag:TAG_UPLOAD_PROJECT_LIST_VIEW];
        projectItemView.layer.borderWidth = 2.0f;
        projectItemView.layer.borderColor = [UIColor blackColor].CGColor;

        //项目列表TableView
        if (myProjectCtrl==nil) {
            myProjectCtrl = [[MyProjectListViewController alloc]init];
            [myProjectCtrl.view setFrame:CGRectMake(0, 0, projectItemView.frame.size.width, projectItemView.frame.size.height)];
            myProjectCtrl.delegate = self;
            [myProjectCtrl setIsMulitSelected:YES];
        }

        [projectItemView addSubview:myProjectCtrl.view];
        [self.view addSubview:projectItemView];
        [projectItemView release];

        [UIView animateWithDuration:0.6 animations:^{
            [projectItemView setFrame:rectDistProjView];
        } completion:^(BOOL finished) {

        }];
    }

}

//网格图片列表
- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //每个格子的大小
    layout.itemSize = CGSizeMake((SCREEN_CGSIZE_HEIGHT - 0)/4, (SCREEN_CGSIZE_WIDTH - 50)/3);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    thumbnailCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_CGSIZE_WIDTH/3 + 30, SCREEN_CGSIZE_HEIGHT - 0, SCREEN_CGSIZE_WIDTH/3*2 - 30) collectionViewLayout:layout];
    thumbnailCV.backgroundColor = [UIColor whiteColor];
    [thumbnailCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
    thumbnailCV.delegate = self;
    thumbnailCV.dataSource = self;
    [self.view addSubview:thumbnailCV];
    
    if (!DEVICE_IS_IPAD) {
        layout.itemSize = CGSizeMake(SCREEN_CGSIZE_WIDTH/2, SCREEN_CGSIZE_WIDTH/2);
        thumbnailCV.frame = CGRectMake(0, headView.frame.size.height - 1, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT - headView.frame.size.height);
    }
}

//设计师的相关内容
- (void)descriptionOfDesigner
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"PingtiOrImage"] isEqualToString:@"image"])
    {
        [authorImageView setImageWithURL:[NSURL URLWithString:[itemsDataDictionary objectForKey:@"athor_img"]] placeholderImage:[UIImage imageNamed:@"Icon"]];
        authorNameLabel.text = [itemsDataDictionary objectForKey:@"athor_name"];
        productionDateLabel = [itemsDataDictionary objectForKey:@"athor_description"];
        [aboutDesignerButton setTitle:[NSString stringWithFormat:@"BY %@",[itemsDataDictionary objectForKey:@"athor_name"]] forState:UIControlStateNormal];
    }
    productionTitleLabel.text = productionTitle;
    //设计师介绍信息
    designerProcuctionUrl = [[itemsDataDictionary objectForKey:@"list_ByUser"] retain];
    nameString = [[itemsDataDictionary objectForKey:@"athor_name"] retain];
    telString = [[itemsDataDictionary objectForKey:@"athor_phone"] retain];
    qqString = [[itemsDataDictionary objectForKey:@"athor_qq"] retain];
    descriptionString = [[itemsDataDictionary objectForKey:@"athor_description"] retain];
    photoUrl = [[itemsDataDictionary objectForKey:@"athor_img"] retain];
}

//返回主图片页面
- (void)backToMainImageView
{
    if (OS_VERSION_FLOAT >= 8.0) {
        [self.navigationController.view removeFromSuperview];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)requestImageDataFromUrl:(NSString *)urlString
{
    [self sendAsynchronous:urlString];
}

- (void)requestImageData:(DataItems *)oneDataItem
{
    DLog(@"oneDataItem.item_url = %@",oneDataItem.item_url);
    [self sendAsynchronous:oneDataItem.item_url];
    
    itemId = [[NSString alloc] initWithString:oneDataItem.item_id];
    
    productionIntroduce = oneDataItem.item_introduce;//作品描述
    productionTitle = oneDataItem.item_title;//作品描述
}
//异步请求网络数据
-(void)sendAsynchronous:(NSString*)urlStr{
    DLog(@"urlStr = %@",urlStr)
//    //******
//    urlStr = @"http://192.168.1.99/LEDFirstStepAPI.aspx?companyid=8&lang=cn&module=2";
////    http://www.ledmediasz.com/api_LED/LEDFourthStepAPI.aspx?itemid=52430
//    //******
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",urlStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIHTTPRequest *asiHttp = [[ASIHTTPRequest alloc]initWithURL:url];
    asiHttp.delegate = self;
    [asiHttp startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    DLog(@"数据加载完成");
    [self parseDataItemsJsonString:request];
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    DLog(@"加载数据失败，检查网络");
    [self parseDataItemsJsonString:request];
}


/**
 *@brief 解析返回的JSON数据的到列表对象的集合和下一页的URL
 */
-(void)parseDataItemsJsonString:(ASIHTTPRequest *)request{
    
    NSString *jsonString = [request responseString];
    DLog(@"222222%@",jsonString);
    //网络未读取到数据的时候，判断缓存是否存在，存在则读取缓存，有网络则写缓存
    NSString *urlStr = [[NSString alloc]initWithFormat:@"%@",[request url]];
    //缓存数据
    if ([jsonString length]==0) {
        if ([MyTool isExistsCacheFile:urlStr]) {
            jsonString = [MyTool readCacheString:urlStr];
        }
    }else{
        [MyTool writeCache:jsonString requestUrl:urlStr];
    }
    jsonString = [MyTool filterResponseString:jsonString];
    
    itemsDataDictionary = [jsonString JSONValue];
    if ((itemsDataDictionary == nil) || (![itemsDataDictionary isKindOfClass:[NSDictionary class]])) {
        DLog(@"返回的数据非法，不是一个字典");
        return;
    }
    
    [self descriptionOfDesigner];//获得设计者相关数据
//    舍弃2014年08月21日
//    parentId = [[NSString alloc] initWithString:[itemsDataDictionary objectForKey:@"parent"]];
//    DLog("parentId = %@",parentId);
    
    NSArray *itemsDataArray = [itemsDataDictionary objectForKey:@"img"];
    if ((itemsDataArray == nil) || (![itemsDataArray isKindOfClass:[NSArray class]])) {
        DLog(@"返回的数据非法，字典内部不是包含的数组");
        return;
    }
    
    if (!thumbnailList) {
        thumbnailList = [[NSMutableArray alloc]init];
    }
    if (!bigImageList) {
        bigImageList = [[NSMutableArray alloc]init];
    }
    if (!imageEntities) {
        imageEntities = [[NSMutableArray alloc] init];
    }

    for (NSDictionary *oneDataItemDict in itemsDataArray) {
        [thumbnailList addObject:[oneDataItemDict objectForKey:@"img1"]];
        [bigImageList addObject:[oneDataItemDict objectForKey:@"img2"]];
        ImageDescriptionEntity *oneImageEntity = [[ImageDescriptionEntity alloc] init];
        oneImageEntity.image1 = [oneDataItemDict objectForKey:@"img1"];
        oneImageEntity.image2 = [oneDataItemDict objectForKey:@"img2"];
        oneImageEntity.parm1 = [oneDataItemDict objectForKey:@"parm1"];
        oneImageEntity.parm2 = [oneDataItemDict objectForKey:@"parm2"];
        oneImageEntity.parm3 = [oneDataItemDict objectForKey:@"parm3"];
        oneImageEntity.parm4 = [oneDataItemDict objectForKey:@"parm4"];
        oneImageEntity.parm5 = [oneDataItemDict objectForKey:@"parm5"];
        oneImageEntity.parm6 = [oneDataItemDict objectForKey:@"parm6"];
        oneImageEntity.parm7 = [oneDataItemDict objectForKey:@"parm7"];
        oneImageEntity.parm8 = [oneDataItemDict objectForKey:@"parm8"];
        oneImageEntity.parm9 = [oneDataItemDict objectForKey:@"parm9"];
        oneImageEntity.parm10 = [oneDataItemDict objectForKey:@"parm10"];
        oneImageEntity.parm11 = [oneDataItemDict objectForKey:@"parm11"];
        [imageEntities addObject:oneImageEntity];
    }
    [thumbnailCV reloadData];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [thumbnailList count];
//    return 15;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *myCollectionCell = [NSString stringWithFormat:@"myCollectionCell%d",indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
    //图片
    UIImageView *thumbnailView = [[UIImageView alloc] init];
    thumbnailView.contentMode = UIViewContentModeScaleAspectFit;
    [thumbnailView setImageWithURL:[NSURL URLWithString:[thumbnailList objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"Icon-152"]];
//    cell.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    cell.layer.borderWidth = 1.0f;
    cell.backgroundView = thumbnailView;
    cell.backgroundView.frame = CGRectMake(50, 30, SCREEN_CGSIZE_HEIGHT/4-100, SCREEN_CGSIZE_HEIGHT/4-100);
    
    //网格线
    UIView *horizontalLineView = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, cell.frame.size.width, 1)];
    horizontalLineView.backgroundColor = [UIColor lightGrayColor];
    UIView *verticalLineView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.size.width - 1, 0, 1, cell.frame.size.height)];
    verticalLineView.backgroundColor = [UIColor lightGrayColor];
    
    //图片名称
    MyLabel *pictureTitle = [[MyLabel alloc] initWithFrame:CGRectMake(10, SCREEN_CGSIZE_HEIGHT/4 - 70, SCREEN_CGSIZE_HEIGHT/4 - 20, 60)];
    pictureTitle.tag = 1001;
    pictureTitle.text = [(ImageDescriptionEntity *)[imageEntities objectAtIndex:indexPath.row] parm1];
    pictureTitle.textAlignment = NSTextAlignmentCenter;
    pictureTitle.textColor = [UIColor lightGrayColor];
    [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除子视图防止重叠
    [[cell contentView] addSubview:pictureTitle];
    [[cell contentView] addSubview:verticalLineView];
    [[cell contentView] addSubview:horizontalLineView];
    
    
    if (!DEVICE_IS_IPAD) {
        cell.backgroundView.frame = CGRectMake(15, 5, SCREEN_CGSIZE_WIDTH/2 - 30, SCREEN_CGSIZE_WIDTH/2 - 30);
        pictureTitle.frame = CGRectMake(10, SCREEN_CGSIZE_WIDTH/2 - 25, SCREEN_CGSIZE_WIDTH/2 - 20, 20);
        pictureTitle.font = [UIFont systemFontOfSize:14.0f];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"测试一下");
    DetailImageViewController *detailImageVC = [[DetailImageViewController alloc] init];
    detailImageVC.detailImageName = [bigImageList objectAtIndex:indexPath.row];
    detailImageVC.oneImageEntity = [imageEntities objectAtIndex:indexPath.row];
    
    detailImageVC.itemId = itemId;
    detailImageVC.parentId = parentId;
    detailImageVC.albumName = productionTitle;
    DLog(@"detailImageVC.itemId = %@\ndetailImageVC.parentId = %@",detailImageVC.itemId, detailImageVC.parentId);
    
//    [self presentViewController:detailImageVC animated:YES completion:nil];
    
    [self.navigationController pushViewController:detailImageVC
                                         fromView:^UIView *(UIViewController *viewcontroller) {                                             return [thumbnailCV cellForItemAtIndexPath:indexPath].backgroundView;
                                         }
                                           toView:^UIView *(UIViewController *viewcontroller) {
                                               return detailImageVC._detailImage;
                                           }];
}


#pragma mark - 评论页面
- (void)showCommontView
{
    // Generate content view to present
    UIView* contentView = [[UIView alloc] init];
    //    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    contentView.backgroundColor = [UIColor colorWithRed:0.177 green:0.833 blue:0.546 alpha:1.000];
    //  contentView.layer.cornerRadius = 12.0;
    contentView.frame = CGRectMake(0, 0, 500, SCREEN_CGSIZE_WIDTH);
    
    if (!DEVICE_IS_IPAD) {
        contentView.frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT);
    }
    //论坛
    BBSDetailViewController *commentVC = [[BBSDetailViewController alloc] init];
    commentVC.item_id = itemId;
    [contentView addSubview:commentVC.view];
    
    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutRight,
                                               (KLCPopupVerticalLayout)KLCPopupVerticalLayoutCenter);
    
    popup = [KLCPopup popupWithContentView:contentView
                                            showType:(KLCPopupShowType)KLCPopupShowTypeSlideInFromRight
                                         dismissType:(KLCPopupDismissType)KLCPopupDismissTypeSlideOutToRight
                                            maskType:(KLCPopupMaskType)KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
    if (!DEVICE_IS_IPAD) {
        UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dismissButton.frame = CGRectMake(0, 0, 54, 44);
        [dismissButton setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [dismissButton setBackgroundImage:[UIImage imageNamed:@"icon_back_highlighted"] forState:UIControlStateHighlighted];
        [dismissButton addTarget:popup action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        [commentVC.view addSubview:dismissButton];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)analyzingProjectData:(NSString *)projectJsonString{
    DLog(@"%@",projectJsonString);
    
    @try {
        if (projectJsonString) {
            if ([projectJsonString length]>0) {
                NSDictionary *projectDict = [projectJsonString JSONValue];
                if (projectDict) {
                    if ([projectDict isKindOfClass:[NSDictionary class]]) {
                        NSString *xmlPathString = [projectDict objectForKey:@"xml"];
                        DLog(@"xmlPathString = %@",xmlPathString);
                        [projectFileListArray addObject:xmlPathString];
                        //创建项目文件夹
                        //获得项目文件夹的名称
                        NSString *projectFolderString = [xmlPathString lastPathComponent];
                        projectFolderString = [projectFolderString stringByReplacingOccurrencesOfString:@".xml" withString:@""];
                        DLog(@"projectFolderString = %@",projectFolderString);
                        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/"];
                        NSString *myFolderPath = [[NSString alloc]initWithFormat:@"%@/%@",documentsDirectory,projectFolderString];
                        NSFileManager *myProManger = [NSFileManager defaultManager];
                        if ([myProManger fileExistsAtPath:myFolderPath isDirectory:nil]) {
                            DLog(@"项目文件夹已经存在");
                        }else{
                            DLog(@"创建项目文件夹 = %@",myFolderPath);
                            [myProManger createDirectoryAtPath:myFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
                        }


                        NSArray *myImagePathArray = [projectDict objectForKey:@"img"];
                        for (NSDictionary *oneImageDict in myImagePathArray) {
                            DLog(@"imageFilePath = %@",[oneImageDict objectForKey:@"img"]);
                            [projectFileListArray addObject:[oneImageDict objectForKey:@"img"]];
                        }
                        [self startProgress];
                        //根据返回的信息去下载项目内的文件
                        [self downloadProjectFileWithFileListArray:projectFileListArray andFolderPath:myFolderPath];
                    }
                }else{
                    DLog(@"获取项目列表请求失败");
                    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_downloadisfailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                    [myAlertView show];
                    [myAlertView release];
                }
            }
        }
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    @finally {

    }

}

-(void)downloadProjectFileWithFileListArray:(NSArray*)myfileListArray andFolderPath:(NSString *)myFolderPath{
    projectDownloadListCount = 0;
    _isShowPrompt = NO;
    DLog(@"myfileListArray =%@",myfileListArray);
    if (myfileListArray) {
        if ([myfileListArray count]>0) {
            if (!_myNetworkQueue) {
                _myNetworkQueue = [[ASINetworkQueue alloc]init];
            }
            // 使得每一次下载都是重新来过的
            [_myNetworkQueue reset];

            for (NSString *oneFilePath in myfileListArray) {
                DLog(@"oneFilePath = %@",oneFilePath);
                ASIHTTPRequest *myDownloadRequest = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:oneFilePath]];
                [myDownloadRequest setAccessibilityValue:oneFilePath];
                NSString *myFilePath = [[NSString alloc]initWithFormat:@"%@/%@",myFolderPath,[oneFilePath lastPathComponent]];
                DLog(@"myFilePath = %@",myFilePath);
                if (![[NSFileManager defaultManager] fileExistsAtPath:myFilePath])
                {
                    [[NSFileManager defaultManager]
                     createDirectoryAtPath:myFilePath
                     withIntermediateDirectories:YES attributes:nil error:nil];
                }
                [myDownloadRequest setDownloadDestinationPath:myFilePath];
                [myDownloadRequest setCompletionBlock:^{
                    projectDownloadListCount ++;
                    if (projectDownloadListCount==[myfileListArray count]) {
                        [self stopProgress:self.view];
                        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_downloadisCompleted"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                        [myAlertView show];
                        [myAlertView release];
                    }
                }];
                [myDownloadRequest setFailedBlock:^{
                    DLog(@"下载文件失败");
                    projectDownloadListCount = 0;
                    if (!_isShowPrompt) {
                        _isShowPrompt = YES;
                        [self stopProgress:self.view];
                        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_downloadisfailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                        [myAlertView show];
                        [myAlertView release];
                    }
                }];
                [_myNetworkQueue addOperation:myDownloadRequest];
            }

            [_myNetworkQueue go];
        }
    }
}


/**
 *@brief 开始进度条
 */
-(void)startProgress{
    KKProgressTimer *myProgress = [[KKProgressTimer alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [myProgress setCenter:CGPointMake(SCREEN_CGSIZE_WIDTH/2, SCREEN_CGSIZE_HEIGHT/2)];
    myProgress.delegate = self;
    [myProgress setTag:TAG_PROGRESS + 1];
    [self.view addSubview:myProgress];
    __block CGFloat i3 = 0;
    [myProgress startWithBlock:^CGFloat {
        return ((i3++ >= 50) ? (i3 = 0) : i3) / 50;
    }];
}

/**
 *@brief 停止进度条
 */
-(void)stopProgress:(UIView *)containtView{
    KKProgressTimer *oldProgress = (KKProgressTimer *)[containtView viewWithTag:TAG_PROGRESS + 1];
    [oldProgress stop];
    if (oldProgress) {
        [oldProgress removeFromSuperview];
    }
}


-(void)selectedProjectWithObject:(NSMutableArray *)mySelectedProjectList{
    DLog(@"已经选择的播放项目 = %@",mySelectedProjectList);

    
    CGRect rectInitProjView = CGRectMake(self.view.frame.size.height, 0,320,self.view.frame.size.width);
    if (OS_VERSION_FLOAT>7.9) {
        rectInitProjView = CGRectMake(self.view.frame.size.width, 0,320,self.view.frame.size.height);
    }
    UIView *projView = [self.view viewWithTag:TAG_UPLOAD_PROJECT_LIST_VIEW];
    [UIView animateWithDuration:1 animations:^{
        [projView setFrame:rectInitProjView];
    } completion:^(BOOL finished) {
        if (mySelectedProjectList) {
            if ([mySelectedProjectList count]>0) {
                if ([mySelectedProjectList count]==1) {
                    ProjectListObject *myProjObj = [mySelectedProjectList objectAtIndex:0];
                   
                    
                    NSString *xmlPath = [myProjObj project_filename];
                    NSString *lastString =  [xmlPath lastPathComponent];
                    NSString *dirPath = [[NSString alloc] initWithString: xmlPath];
                    DLog(@"dirPath = %@,lastString = %@",dirPath,lastString);
                    dirPath = [dirPath stringByReplacingOccurrencesOfString:lastString withString:@""];
                    DLog(@"dirPath = %@",dirPath);
                    

                    //                    filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"png"
                    //                                                                                fromDirPath:dirPath AndIsGroupDir:YES];
                    myFilenameArray = [[NSArray alloc]initWithArray:[LayoutYXMViewController getFilenamelistOfType:nil
                                                                                                       fromDirPath:dirPath AndIsGroupDir:YES]];
                    DLog(@"filenameArray = %@",myFilenameArray);
                    xmlfilenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                                          fromDirPath:dirPath AndIsGroupDir:YES];
                    DLog(@"xmlfilenameArray = %@",xmlfilenameArray);

                    NSString *xmlUploadPath = [xmlfilenameArray objectAtIndex:0];
                    
                    DLog(@"开始上传XML = %@",xmlUploadPath);

                    //使用ftp上传广告播放项目
                    _waitForUploadFilesArray = [[NSMutableArray alloc]initWithArray:myFilenameArray];
                    [_waitForUploadFilesArray addObjectsFromArray:xmlfilenameArray];
                    DLog(@"_waitForUploadFilesArray = %@",_waitForUploadFilesArray);
                    [self startupPublish];
                    //
                    [self uploadXml:xmlUploadPath];
                }
            }
        }
    }];
}

-(void)uploadXml:(NSString*)xmlPath{
    _countPu = 0;
   
    
    ASIFormDataRequest *publishRequest = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.ledmediasz.com/api_yunping/api_yingyong_uploadfiles.aspx?del=1"]];
    [publishRequest setFile:xmlPath forKey:@"Filedata"];
    [publishRequest addPostValue:@"3" forKey:@"type"];
    [publishRequest addPostValue:URL_COMPANYID forKey:@"companyid"];
    [publishRequest addPostValue:itemId forKey:@"id"];
    [publishRequest setCompletionBlock:^{
        NSString *responseString = [publishRequest responseString];
        DLog(@"发布xml请求成功 = %@",responseString);
        [self uploadImageWith:myFilenameArray];
    }];
    [publishRequest setFailedBlock:^{
        NSString *responseString = [publishRequest responseString];
        DLog(@"发布xml请求失败 = %@",responseString);
     
    }];
    [publishRequest startAsynchronous];
}
bool clcik=NO;
-(void)uploadImageWith:(NSArray *)imagePathArray{
    _countPu = 0;
    ASINetworkQueue *queue = [[ASINetworkQueue alloc] init];
    [queue setQueueDidFinishSelector:@selector(myNetworkQueueFinish:)];
    [queue setRequestDidFailSelector:@selector(myNetworkQueueFailed:)];
    DLog(@"imagePathArray = %@",imagePathArray);
    if ([imagePathArray count]<1) {
        [self stopProgress:self.view];
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_uploadprojectfailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }
    for (NSString *onePath in imagePathArray)
    {
        NSFileManager *myFileMager = [NSFileManager defaultManager];
        if ([myFileMager fileExistsAtPath:onePath])
        {
            NSString *urlString = @"http://www.ledmediasz.com/api_yunping/api_yingyong_uploadfiles.aspx";
            ASIFormDataRequest *publishFormRequest = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
            [publishFormRequest setRequestMethod:@"POST"];
            [publishFormRequest setTimeOutSeconds:600];
            [publishFormRequest setFile:onePath forKey:@"Filedata"];
            [publishFormRequest setPostValue:@"parm1" forKey:@"parm1"];
            [publishFormRequest setPostValue:@"parm2" forKey:@"parm2"];
            [publishFormRequest setPostValue:@"parm3" forKey:@"parm3"];
            [publishFormRequest setPostValue:@"parm4" forKey:@"parm4"];
            [publishFormRequest addPostValue:@"2" forKey:@"type"];
            [publishFormRequest addPostValue:itemId forKey:@"id"];
            [publishFormRequest addPostValue:URL_COMPANYID forKey:@"companyid"];
            [publishFormRequest setCompletionBlock:^{
                NSString *responseString = [publishFormRequest responseString];
                DLog(@"发布请求成功 = %@",responseString);
                _countPu ++;
                if (_countPu==[imagePathArray count]&&clcik) {
                    clcik=NO;
                    [self stopProgress:self.view];
                    UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_uploadprojectcompleted"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                    [myAlertView show];
                    [myAlertView release];
                }
            }];
            [publishFormRequest setFailedBlock:^{
                NSString *responseString = [publishFormRequest responseString];
                DLog(@"发布请求失败 = %@",responseString);
                [self stopProgress:self.view];
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_uploadprojectfailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
                [myAlertView show];
                [myAlertView release];

            }];

            [queue addOperation:publishFormRequest];
        }
    }
    
    [queue go];
}


-(void)playOneWithProjectObj:(ProjectListObject *)asset cellIndexPath:(NSIndexPath *)cellIndexPath{
    DLog(@"已经选择的播放项目 = %@",asset);

    CGRect rectInitProjView = CGRectMake(self.view.frame.size.height, 0,320,self.view.frame.size.width);
    if (OS_VERSION_FLOAT>7.9) {
        rectInitProjView = CGRectMake(self.view.frame.size.width, 0,320,self.view.frame.size.height);
    }
    UIView *projView = [self.view viewWithTag:TAG_UPLOAD_PROJECT_LIST_VIEW];
    [UIView animateWithDuration:1 animations:^{
        [projView setFrame:rectInitProjView];
    } completion:^(BOOL finished) {

    }];
}

-(void)hiddenProjectList:(UIGestureRecognizer*)myGesture{
    CGRect rectInitProjView = CGRectMake(self.view.frame.size.height, 0,320,self.view.frame.size.width);
    if (OS_VERSION_FLOAT>7.9) {
        rectInitProjView = CGRectMake(self.view.frame.size.width, 0,320,self.view.frame.size.height);
    }
    UIView *tempProjView = [self.view viewWithTag:TAG_UPLOAD_PROJECT_LIST_VIEW];
    [UIView animateWithDuration:0.6 animations:^{
        [tempProjView setFrame:rectInitProjView];
    } completion:^(BOOL finished) {

    }];

    //设置提示文字
    [promptSwipeHidenLabel setText:@""];
}

/**
 *  //在确认连接成功之后开始发布
 */
-(void)startupPublish{
    _currentDataAreaIndex = 0;

    //启动发布的进度条
    myMRProgressView = [MRProgressOverlayView showOverlayAddedTo:self.view title:[Config DPLocalizedString:@"adedit_publishprojecting"] mode:MRProgressOverlayViewModeDeterminateHorizontalBar animated:YES stopBlock:^(MRProgressOverlayView *progressOverlayView) {
        progressOverlayView.mode = MRProgressOverlayViewModeCheckmark;
        progressOverlayView.titleLabelText = @"Succeed";
        [progressOverlayView dismiss:YES];
    }];

//    [myMRProgressView setFrame:CGRectMake(myMRProgressView.frame.origin.x, myMRProgressView.frame.origin.y , myMRProgressView.frame.size.width , myMRProgressView.frame.size.height)];
    //计算文件总大小
    for (NSString *sFielPath in _waitForUploadFilesArray) {
        _uploadFileTotalSize += [LayoutYXMViewController fileSizeAtPath:sFielPath];
    }
    //开始发送文件，使用ftp的方式
    [self useFTPSendProject];
}

/**
 *  使用ftp发送项目
 */
-(void)useFTPSendProject{
    if (!_ftpMgr) {
        //连接ftp服务器
        _ftpMgr = [[YXM_FTPManager alloc]init];
        _ftpMgr.delegate = self;
    }
    NSString *sZipPath = nil;

    NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://www.ledmediasz.com:10021"];
    if ([_waitForUploadFilesArray count]>_currentDataAreaIndex) {
        sZipPath = [_waitForUploadFilesArray objectAtIndex:_currentDataAreaIndex];
        DLog(@"zipPath = %@,sUploadUrl = %@,_currentDataAreaIndex=%d",sZipPath,sUploadUrl,_currentDataAreaIndex);
        [_ftpMgr startUploadFileWithAccount:@"ledmedia" andPassword:@"Q123456az" andUrl:sUploadUrl andFilePath:sZipPath];
        _currentDataAreaIndex ++;
    }
//    else{
//        [myMRProgressView removeFromSuperview];
//    }
}


/**
 *  反映上传进度的回调，每次写入流的数据长度
 *
 *  @param writeDataLength 数据长度
 */
-(void)uploadWriteData:(NSInteger)writeDataLength{
    _sendFileCountSize += writeDataLength;
    float progressValue = _sendFileCountSize*1.00f / _uploadFileTotalSize*1.00f;
    [myMRProgressView setProgress:progressValue animated:YES];

    [myMRProgressView setTitleLabelText:[NSString stringWithFormat:@"%@ %0.0lf％",[Config DPLocalizedString:@"adedit_publishprojecting"],progressValue*100]];
    if(progressValue==1){

        myMRProgressView.hidden=YES;
        [myMRProgressView removeFromSuperview];
       UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_Uploaded_successfully"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
    }
}


/**
 *  ftp上传文件的反馈结果
 *
 *  @param sInfo 反馈结果字符串
 */
-(void)uploadResultInfo:(NSString *)sInfo{
    clcik=YES;
    DLog(@"sInfo = %@",sInfo);

    if ([sInfo isEqualToString:@"uploadComplete"]) {
        DLog(@"_waitForUploadFilesArray = %@,_currentDataAreaIndex=%d",_waitForUploadFilesArray,_currentDataAreaIndex);
        if ([_waitForUploadFilesArray count]>_currentDataAreaIndex) {
            
            
            [self useFTPSendProject];
            
            
            
        }else if(([sInfo isEqualToString:@"error_ReadFileError"])||([sInfo isEqualToString:@"error_StreamOpenError"])){
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
            [myAlertView show];
            [myAlertView release];
            myMRProgressView.hidden=YES;
     
            
            [myMRProgressView removeFromSuperview];
        }
    }else{
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_netconnecterror"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
        [myAlertView release];
        myMRProgressView.hidden=YES;
        [myMRProgressView removeFromSuperview];
    }
   
}

@end
