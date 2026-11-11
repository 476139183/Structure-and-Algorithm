//
//  DetailImageViewController.m
//  云屏
//
//  Created by LDY on 7/21/14.
//  Copyright (c) 2014 LDY. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "DetailImageViewController.h"
#import "UIImageView+WebCache.h"
#import "MyLabel.h"
#import "SGInfoAlert.h"
//#import "ImageListViewController.h"
#import "ProductionsViewController.h"

@interface DetailImageViewController ()
{
//    ImageListViewController *imageListVC;
    ALAssetsLibrary *myLibrary;
}

@end

@implementation DetailImageViewController
@synthesize oneImageEntity;
@synthesize albumName;
@synthesize _detailImage = detailImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        albumName = [[NSString alloc] init];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.953 alpha:1.000];
    //返回按钮
    backToMainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backToMainButton.frame = CGRectMake(2, 2, 40, 40);
    [backToMainButton setBackgroundImage:[UIImage imageNamed:@"backToMainButton"] forState:UIControlStateNormal];
    [backToMainButton setBackgroundColor:[UIColor blackColor]];
    [backToMainButton addTarget:self action:@selector(backToMainImageView) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backToMainButton];
    
    //图片
    detailImage = [[UIImageView alloc] initWithFrame:CGRectMake(120, 120, SCREEN_CGSIZE_WIDTH - 240, SCREEN_CGSIZE_WIDTH - 240)];
    detailImage.contentMode = UIViewContentModeScaleAspectFit;
    detailImage.backgroundColor = [UIColor clearColor];
    [detailImage setImageWithURL:[NSURL URLWithString:oneImageEntity.image2] placeholderImage:[UIImage imageNamed:@"Icon"]];
    DLog(@"oneImageEntity.image2 = %@",oneImageEntity.image2);
    [self.view addSubview:backToMainButton];
    [self.view addSubview:detailImage];
    
    if (!DEVICE_IS_IPAD) {
        detailImage.frame = CGRectMake(5, 45, SCREEN_CGSIZE_WIDTH - 10, SCREEN_CGSIZE_WIDTH - 10);
    }
    //图片描述
    [self initDescriptionView];
}

-(void)saveImageButtonClick{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片到相册" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
#pragma mark - UiAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
//        2014年08月26日15:47:56修改
//        UIImageWriteToSavedPhotosAlbum(detailImage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        myLibrary = [[ALAssetsLibrary alloc] init];
        [myLibrary writeImageDataToSavedPhotosAlbum:UIImagePNGRepresentation(detailImage.image)
                                           metadata:nil
                                    completionBlock:^(NSURL *assetURL, NSError *error) {
                                        if (error != nil) {
                                            //show error message
                                            NSLog(@"take picture failed");
                                        }else
                                        {
                                            //show message image successfully saved
                                            UIAlertView *noImageAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"YunPing_ImageSaved", @"图片已保存") message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"NSStringOKButtonTitle", @"确定") otherButtonTitles:nil, nil];
                                            [noImageAlert show];
//                                            [SGInfoAlert showInfo:[NSString stringWithFormat:@"%@",@"保存图片成功"]
//                                                          bgColor:[[UIColor darkGrayColor] CGColor]
//                                                           inView:self.view
//                                                         vertical:0.5];
                                            //2014年09月03日17:39:12（新增功能：保存图片到自建相簿）
                                            __block BOOL albumWasFound = NO;
                                            [myLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum
                                                                     usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                                                         DLog(@"albumName = %@",[group valueForProperty:ALAssetsGroupPropertyName]);
                                                                         if ([albumName compare: [group valueForProperty:ALAssetsGroupPropertyName]]==NSOrderedSame) {
                                                                             albumWasFound = YES;
                                                                             [myLibrary assetForURL: assetURL
                                                                                        resultBlock:^(ALAsset *asset) {
                                                                                            [group addAsset: asset];
                                                                                        } failureBlock: nil];
                                                                             return;
                                                                         }
                                                                         if (group==nil && albumWasFound==NO) {
                                                                             ALAssetsLibrary *weakSelf = myLibrary;
                                                                             [myLibrary addAssetsGroupAlbumWithName:albumName
                                                                                                        resultBlock:^(ALAssetsGroup *group) {
                                                                                                            [weakSelf assetForURL: assetURL
                                                                                                                      resultBlock:^(ALAsset *asset) {
                                                                                                                          [group addAsset: asset];
                                                                                                                      } failureBlock: nil];
                                                                                                        } failureBlock: nil];
                                                                             return;
                                                                         }
                                                                     } failureBlock: nil];
                                        }
                                    }];
    }else {
        DLog(@"取消保存！！");
    }
}


- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*) error contextInfo:(void*)contextInfo
{
//    detailImage.image = image;
//    detailImage.backgroundColor = [UIColor colorWithRed:0.847 green:0.843 blue:0.852 alpha:1.000];
    //NSLog(@"save result");
    if (error != nil) {
        //show error message
        NSLog(@"take picture failed");
    }else
    {
        //show message image successfully saved
        [SGInfoAlert showInfo:[NSString stringWithFormat:@"%@",@"保存图片成功"]
                      bgColor:[[UIColor darkGrayColor] CGColor]
                       inView:self.view
                     vertical:0.5];
    }
}


//右侧描述页面
- (void)initDescriptionView
{
    descriptionView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH - 100, 120, SCREEN_CGSIZE_HEIGHT - SCREEN_CGSIZE_WIDTH + 90, SCREEN_CGSIZE_WIDTH - 240)];
    NSInteger labelWidth = SCREEN_CGSIZE_HEIGHT - SCREEN_CGSIZE_WIDTH + 90;
    
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    if (![[ud objectForKey:@"Category_Id"] isEqualToString:@"1"])
//    if ([[ud objectForKey:@"PingtiOrImage"] isEqualToString:@"image"])
    DLog(@"oneImageEntity.parm10.length = %d",oneImageEntity.parm10.length);
    if (oneImageEntity.parm10.length == 0)
    {
        label1 = [[MyLabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 200)];
        label2 = [[MyLabel alloc] initWithFrame:CGRectMake(0, 200, labelWidth, 50)];
        label3 = [[MyLabel alloc] initWithFrame:CGRectMake(0, 250, labelWidth, 50)];
        label4 = [[MyLabel alloc] initWithFrame:CGRectMake(0, 300, labelWidth, 100)];
        
        label1.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"YunPing_type", @"类型"), oneImageEntity.parm1];
        label1.font = [UIFont systemFontOfSize:30];
        label2.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"YunPing_size", @"分辨率"), oneImageEntity.parm2];
        label2.font = [UIFont systemFontOfSize:18];
        label3.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"YunPing_designer", @"设计者"), oneImageEntity.parm3];
        label3.font = [UIFont systemFontOfSize:18];
        label4.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"YunPing_description", @"描述"), oneImageEntity.parm4];
        label4.font = [UIFont systemFontOfSize:13];
        
        [descriptionView addSubview:label1];
        [descriptionView addSubview:label2];
        [descriptionView addSubview:label3];
        [descriptionView addSubview:label4];
        
//        jumpToImageButton  = [UIButton buttonWithType:UIButtonTypeCustom];
//        jumpToImageButton.frame = CGRectMake(0, 400, labelWidth - 100, 45);
//        [jumpToImageButton setBackgroundColor:[UIColor colorWithWhite:0.800 alpha:1.000]];
//        [jumpToImageButton setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
//        jumpToImageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [jumpToImageButton setTitle:@" 查看相关屏体" forState:UIControlStateNormal];
//        [jumpToImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        jumpToImageButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//        //        jumpToImageButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [jumpToImageButton addTarget:self action:@selector(jumpToPingTiView) forControlEvents:UIControlEventTouchUpInside];
//        
//        aboutButtonCurve = [[UIImageView alloc] initWithFrame:CGRectMake(labelWidth - 100 - 30, 12.5, 20, 20)];
//        aboutButtonCurve.image = [UIImage imageNamed:@"chevron_black"];
//        [jumpToImageButton addSubview:aboutButtonCurve];
//        [descriptionView addSubview:jumpToImageButton];
    }
    else
    {
        //测试一下
        NSInteger labelHight = 50;
        label11 = [[MyLabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, labelHight)];
        label12 = [[MyLabel alloc] initWithFrame:CGRectMake(0, labelHight, labelWidth, labelHight)];
        label13 = [[MyLabel alloc] initWithFrame:CGRectMake(0, labelHight*2, labelWidth, labelHight)];
        label14 = [[MyLabel alloc] initWithFrame:CGRectMake(0, labelHight*3, labelWidth, labelHight)];
        label15 = [[MyLabel alloc] initWithFrame:CGRectMake(0, labelHight*4, labelWidth, labelHight)];
        label16 = [[MyLabel alloc] initWithFrame:CGRectMake(0, labelHight*5, labelWidth, labelHight)];
        label17 = [[MyLabel alloc] initWithFrame:CGRectMake(0, labelHight*6, labelWidth, labelHight)];
        
        label11.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"YunPing_size", @"分辨率"), oneImageEntity.parm9];
        label11.font = [UIFont systemFontOfSize:18];
        label12.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"YunPing_PhysicalSize", @"物理尺寸"), oneImageEntity.parm11];
        label12.font = [UIFont systemFontOfSize:18];
        label13.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"YunPing_Weight", @"重量"), oneImageEntity.parm6];
        label13.font = [UIFont systemFontOfSize:18];
        label14.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"YunPing_Brightness", @"亮度"), oneImageEntity.parm7];
        label14.font = [UIFont systemFontOfSize:18];
        label15.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"YunPing_Power", @"功耗"), oneImageEntity.parm8];
        label15.font = [UIFont systemFontOfSize:18];
        label16.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"YunPing_Install", @"安装方式"), oneImageEntity.parm5];
        label16.font = [UIFont systemFontOfSize:18];
        label17.text = [NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"YunPing_Price", @"价格"), oneImageEntity.parm10];
        label17.font = [UIFont systemFontOfSize:18];
        
        [descriptionView addSubview:label11];
        [descriptionView addSubview:label12];
        [descriptionView addSubview:label13];
        [descriptionView addSubview:label14];
        [descriptionView addSubview:label15];
        [descriptionView addSubview:label16];
        //    [descriptionView addSubview:label17];
        
        jumpToImageButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        jumpToImageButton.frame = CGRectMake(0, labelHight*7, labelWidth - 100, 45);
        [jumpToImageButton setBackgroundColor:[UIColor colorWithWhite:0.800 alpha:1.000]];
        [jumpToImageButton setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
        jumpToImageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [jumpToImageButton setTitle:@" 查看设计效果图片" forState:UIControlStateNormal];
        [jumpToImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        jumpToImageButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//        jumpToImageButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [jumpToImageButton addTarget:self action:@selector(jumpToImageListView) forControlEvents:UIControlEventTouchUpInside];
        
        aboutButtonCurve = [[UIImageView alloc] initWithFrame:CGRectMake(labelWidth - 100 - 30, 12.5, 20, 20)];
        aboutButtonCurve.image = [UIImage imageNamed:@"chevron_black"];
        [jumpToImageButton addSubview:aboutButtonCurve];
        [descriptionView addSubview:jumpToImageButton];
    }
    //保存图片到相册
    UIButton *saveImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveImageButton.backgroundColor = [UIColor clearColor];
    saveImageButton.frame = CGRectMake(0, 460, 40, 40);
    [saveImageButton setImage:[UIImage imageNamed:@"saveImage"] forState:UIControlStateNormal];
    [saveImageButton setImage:[UIImage imageNamed:@"saveImage_pressed"] forState:UIControlStateHighlighted];
    [saveImageButton addTarget:self action:@selector(saveImageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:descriptionView];
    
    if (DEVICE_IS_IPAD) {
        [descriptionView addSubview:saveImageButton];
    }else {
        descriptionView.frame = CGRectMake(0, detailImage.frame.origin.y + detailImage.frame.size.height, SCREEN_CGSIZE_HEIGHT, SCREEN_CGSIZE_HEIGHT - detailImage.frame.origin.y - detailImage.frame.size.height);
        saveImageButton.frame = CGRectMake(SCREEN_CGSIZE_WIDTH - 45, SCREEN_CGSIZE_HEIGHT - 45, 40, 40);
        [self.view addSubview:saveImageButton];
        
        label1.frame = CGRectMake(10, 0, SCREEN_CGSIZE_WIDTH - 15, 30);
        label2.frame = CGRectMake(10, 30, SCREEN_CGSIZE_WIDTH - 15, 30);
        label3.frame = CGRectMake(10, 60, SCREEN_CGSIZE_WIDTH - 15, 30);
        label1.font = [UIFont systemFontOfSize:20.0f];
        label2.font = [UIFont systemFontOfSize:16.0f];
        label3.font = [UIFont systemFontOfSize:16.0f];
        label4.font = [UIFont systemFontOfSize:14.0f];
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attrivutesDic = @{NSFontAttributeName : [UIFont systemFontOfSize:14],
                                        NSParagraphStyleAttributeName : paragraph};
        CGSize size = [label4.text boundingRectWithSize:CGSizeMake(400, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrivutesDic context:nil].size;
        label4.frame = CGRectMake(10, label3.frame.origin.y + 30, SCREEN_CGSIZE_WIDTH - 15, size.height);
        DLog(@"size.height = %f", size.height);
        
        NSInteger labelHight = 25;
        labelWidth = SCREEN_CGSIZE_WIDTH - 15;
        label11.frame = CGRectMake(10, 0, labelWidth, labelHight);
        label12.frame = CGRectMake(10, labelHight, labelWidth, labelHight);
        label13.frame = CGRectMake(10, labelHight*2, labelWidth, labelHight);
        label14.frame = CGRectMake(10, labelHight*3, labelWidth, labelHight);
        label15.frame = CGRectMake(10, labelHight*4, labelWidth, labelHight);
        label16.frame = CGRectMake(10, labelHight*5, labelWidth, labelHight);
        label17.frame = CGRectMake(10, labelHight*6, labelWidth, labelHight);
    }
}

//屏体跳转到相关图片页面
- (void)jumpToImageListView
{
#warning 这里跳转
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"1" forKey:@"jump"];
    [ud setObject:@"image" forKey:@"PingtiOrImage"];
//    imageListVC = [[ImageListViewController alloc] init];
//    imageListVC.mainImageName = @"http://www.ledmediasz.com/UploadFiles/2733/img/20140801/2014080110292957.png";
//    [imageListVC requestImageDataFromUrl:@"http://www.ledmediasz.com/api_LED/LEDFourthStepAPI.aspx?itemid=52130"];
//    //    imageListVC.modalPresentationStyle = UIModalPresentationFormSheet;
//    [self presentViewController:imageListVC animated:YES completion:nil];
    
    [ud setObject:@"fromPingtiDetailImageVC" forKey:@"fromWhere"];
    ProductionsViewController *productionVC = [[ProductionsViewController alloc] init];
    productionVC.requestUrl = [NSString stringWithFormat:@"%@%@",URL_PINGTI_IMAGES, self.itemId];
    [self presentViewController:productionVC animated:YES completion:nil];
}
//图片跳转到相关屏体页面--操作过于多余（舍弃2014年08月21日）
//- (void)jumpToPingTiView
//{
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    
//    ProductionsViewController *productionVC = [[ProductionsViewController alloc] init];
//    productionVC.requestUrl = [NSString stringWithFormat:@"%@%@",URL_ITEM_URL, self.parentId];
//    DLog(@"")
//    [self presentViewController:productionVC animated:YES completion:nil];
//}

//返回图片列表页面
- (void)backToMainImageView
{
//    2014年09月16日10:52:10---keep people oriented
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
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

@end
