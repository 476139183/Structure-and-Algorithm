//
//  ShowCalculatorViewController.m
//  Absen
//
//  Created by yixingman on 8/23/13.
//  Copyright (c) 2013 ledmedia. All rights reserved.
//

#import "ShowCalculatorViewController.h"
#import "CalculatorCell.h"
//#import "ShareData.h"
//#import "CalculatorListViewController.h"
//#import "FenXiangViewController.h"
#import "UIImageView+WebCache.h"
//#import "Fenshu.h"
#import "MyTool.h"
#import "Config.h"

#import "CustomLabel.h"
#import "CustomButton.h"
#import "UIView+MGEasyFrame.h"

@interface ShowCalculatorViewController ()

@end

@implementation ShowCalculatorViewController
//@synthesize calculator_Main_CMTabBar;
//@synthesize parameterItem;
@synthesize calculator_product_name;
@synthesize productImageUrl;
@synthesize Cabinet_Width;
@synthesize Cabinet_Height;
@synthesize Cabinet_Weight;
@synthesize Average_Power_Area;
@synthesize Total_Power_Area;
@synthesize Cabinet_Resolution;

@synthesize Pixel_Pitch;
@synthesize Brightness;
@synthesize Viewing_Angle;
@synthesize LED_Type;

@synthesize Pixel_Configuration;
@synthesize Gray_Scale;
@synthesize Refresh_Frequency;
@synthesize Input_Power_Frequency;
@synthesize Input_Voltage;
@synthesize Ingress_Protection;
@synthesize Weather_Rating;
@synthesize Operating_Temperature;
@synthesize Operating_Humidity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


/**
 *@brief   选屏计算器主界面 dealloc
 */
- (void)dealloc
{
    
    RELEASE_SAFELY(calculator_HeadImage_ScrollView);
    RELEASE_SAFELY(calculator_HeadImage_View);
    RELEASE_SAFELY(calculator_HeadImage_Right_View);
    RELEASE_SAFELY(lateral_case_number_Label);
    RELEASE_SAFELY(lateral_case_number_Minus_Button);
    RELEASE_SAFELY(lateral_case_number_TextField);
    RELEASE_SAFELY(lateral_case_number_Plus_Button);
    RELEASE_SAFELY(longitudinal_case_number_Label);
    RELEASE_SAFELY(longitudinal_case_number_Minus_Button);
    RELEASE_SAFELY(longitudinal_case_number_TextField);
    RELEASE_SAFELY(longitudinal_case_number_Plus_Button);
    
    
    [super dealloc];
}

/**
 *@brief   加载选屏计算器信息
 */
- (void)loadCalculator:(NSString *)product  andCalculator_id:(NSString *)calculator_id
{
    
    [product_name_Label setText:product];

//    修改后可读取离线包图片 2014年05月16日13:31:08
//    [calculator_HeadImage_View setImageWithURL:[NSURL URLWithString:productImageUrl]  placeholderImage:[UIImage imageNamed:DEFAULT_HEAD_IMAGE]];
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches/"];
    NSString *imageUrl =[productImageUrl stringByReplacingOccurrencesOfString:URL_FOR_IP_OR_DOMAIN withString:documentsDirectory];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:imageUrl]) {
        [calculator_HeadImage_View setImageWithURL:[NSURL URLWithString:productImageUrl] placeholderImage:[UIImage imageWithContentsOfFile:imageUrl]];
    }else{
        [calculator_HeadImage_View setImageWithURL:[NSURL URLWithString:productImageUrl] placeholderImage:[UIImage imageNamed:@"frontheadbar.png"]];
    }
    
    /**
     *@brief   主标题头
     */
//    headArray = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Cabinet_Parameters", @"箱体参数"),NSLocalizedString(@"Screen_Physical_Parameters", @"屏体物理参数"),NSLocalizedString(@"Screen_Performance_Parameters", @"屏体性能参数"),NSLocalizedString(@"Other_Parameters", @"其他参数"), nil];
    headArray = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Cabinet_Parameters", @"箱体参数"),NSLocalizedString(@"Screen_Performance_Parameters", @"屏体性能参数"),NSLocalizedString(@"Other_Parameters", @"其他参数"), nil];
    
    for (int i=0; i<[headArray count]; i++) {
        DLog(@"headArray%d: %@",i,[headArray objectAtIndex:i]);
    }
    
    /**
     *@brief   箱体参数标题
     */
    cabinet_Parameters_Title_Array = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Cabinet_Width", @"箱体宽度"),NSLocalizedString(@"Cabinet_Height", @"箱体高度"),NSLocalizedString(@"Cabinet_Resolution", @"箱体分辨率"),NSLocalizedString(@"Cabinet_Weight", @"箱体重量"),NSLocalizedString(@"Average_Power_Area", @"平均功耗"),NSLocalizedString(@"Total_Power_Area", @"最大功耗"), nil];
    
    /**
     *@brief   箱体参数数值
     */
//    if (Cabinet_Resolution) {
//        Cabinet_Resolution = [NSString stringWithFormat:@"%d*%d",[[[Cabinet_Resolution componentsSeparatedByString:@"*"] objectAtIndex:0] integerValue],[[[Cabinet_Resolution componentsSeparatedByString:@"*"] objectAtIndex:1] integerValue]];
//    }else{
//        Cabinet_Resolution = [NSString stringWithFormat:@"%d*%d",0,0];
//    }
    cabinet_Parameters_Value_Array = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%0.1f %@",Cabinet_Width*1.00*unit_box_length,unit_box_length_String],[NSString stringWithFormat:@"%0.1f %@",Cabinet_Height*1.00*unit_box_length,unit_box_length_String],[NSString stringWithFormat:@"%@",Cabinet_Resolution],[NSString stringWithFormat:@"%0.1f %@",Cabinet_Weight*unit_weight,unit_weight_String],[NSString stringWithFormat:@"%0.1f %@",(Average_Power_Area/unit_length/unit_length)*unit_power,unit_power_String],[NSString stringWithFormat:@"%0.1f ",(Total_Power_Area/unit_length/unit_length)*unit_power], nil];
    
    
    
    /**
     *@brief   屏体物理参数标题
     */
    screen_Physical_Parameters_Title_Array = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Screen_Width", @"屏体宽度"),NSLocalizedString(@"Screen_Height", @"屏体高度"),NSLocalizedString(@"Screen_Area", @"屏体面积"),NSLocalizedString(@"Pixels_Wide", @"横向像素数"),NSLocalizedString(@"Pixels_High", @"纵向像素数"),NSLocalizedString(@"Aspect_Ratio", @"宽高比"),NSLocalizedString(@"Total_Weight", @"总重量"), nil];
    
    
//    /**
//     *@brief    屏体宽度 数值Label
//     */
//    screen_width_Value_Label = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0) withTitle:[NSString stringWithFormat:@"%0.1f",(Cabinet_Width*1.00/1000)*[lateral_case_number_TextField.text integerValue]*unit_length]];
//    
//    /**
//     *@brief    屏体高度 数值Label
//     */
//    screen_height_Value_Label = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0) withTitle:[NSString stringWithFormat:@"%0.1f %@",(Cabinet_Height*1.00/1000)*[longitudinal_case_number_TextField.text integerValue]*unit_length,unit_length_String]];
//    
//    
//    /**
//     *@brief    屏体面积 数值Label
//     */
//    screen_size_Value_Label = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0) withTitle:[NSString stringWithFormat:@"%0.2f",[screen_width_Value_Label.text doubleValue]*[screen_height_Value_Label.text doubleValue]]];
    
    /**
     *@brief   屏体物理参数数值
     */
    screen_Physical_Parameters_Value_Array = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@ %@",screen_width_Value_Label.text,unit_length_String],screen_height_Value_Label.text,[NSString stringWithFormat:@"%@ %@",screen_size_Value_Label.text,unit_area_String],[NSString stringWithFormat:@"%0.0f",1111/1.0],[NSString stringWithFormat:@"%0.0f",2222/1.0],[NSString stringWithFormat:@"%0.1f/%0.1f",((3333*1.00/1000)*[lateral_case_number_TextField.text integerValue]*unit_length),((4444*1.00/1000)*[longitudinal_case_number_TextField.text integerValue]*unit_length)],[NSString stringWithFormat:@"%0.1f %@",5555*1.00*[box_product_number_Value_Label.text integerValue]*unit_weight,unit_weight_String], nil];
    
    
    /**
     *@brief   屏体性能参数标题
     */
//    screen_Performance_Parameters_Title_Array = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Pixel_Pitch", @"点间距"),NSLocalizedString(@"Brightness", @"亮度"),NSLocalizedString(@"Total_Power", @"总功耗"),NSLocalizedString(@"Viewing_Angle", @"可视角度"),NSLocalizedString(@"Minimum_Viewing_Distance", @"推荐最小观看距离"),NSLocalizedString(@"LED_Type", @"LED规格"),NSLocalizedString(@"Pixel_Configuration", @"像素组成"), nil];
    screen_Performance_Parameters_Title_Array = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Pixel_Pitch", @"点间距"),NSLocalizedString(@"Brightness", @"亮度"),NSLocalizedString(@"Viewing_Angle", @"可视角度"),NSLocalizedString(@"LED_Type", @"LED规格"), nil];
    
    /**
     *@brief   屏体性能参数数值
     */
//    screen_Performance_Parameters_Value_Array = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%0.1f %@",1111.0,unit_length_String],[NSString stringWithFormat:@"%d nits",2222],[NSString stringWithFormat:@"%0.1f %@",(3333/unit_length/unit_length)*1.00*[screen_size_Value_Label.text doubleValue]*unit_power,@"W"],[NSString stringWithFormat:@"%d°(H)%d°(V)",4444,5555],[NSString stringWithFormat:@"%0.1f %@",5555*unit_length,unit_length_String],[NSString stringWithFormat:@"%@",@"6666"],[NSString stringWithFormat:@"%@",@"8888"], nil];
    screen_Performance_Parameters_Value_Array = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%0.1f %@",Pixel_Pitch,unit_length_String],[NSString stringWithFormat:@"%d nits",Brightness],[NSString stringWithFormat:@"%@ ",Viewing_Angle],[NSString stringWithFormat:@"%@ ",LED_Type], nil];
    
    /**
     *@brief   其他参数标题
     */
    other_Parameters_Title_Array = [[NSArray alloc] initWithObjects:NSLocalizedString(@"Pixel_Configuration", @"亮度控制级别"),NSLocalizedString(@"Gray_Scale", @"灰度等级"),NSLocalizedString(@"Refresh_Frequency", @"刷新率"),NSLocalizedString(@"Input_Power_Frequency", @"供电频率"),NSLocalizedString(@"Input_Voltage", @"供电电压"),NSLocalizedString(@"Ingress_Protection", @"防护等级"),NSLocalizedString(@"Weather_Rating", @"使用环境"),NSLocalizedString(@"Operating_Temperature", @"运行环境温度范围"),NSLocalizedString(@"Operating_Humidity", @"运行环境湿度范围"), nil];
    
    /**
     *@brief   其他参数数值
     */
//    other_Parameters_Value_Array = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@ level",@"1111"],[NSString stringWithFormat:@"%d level",2222],[NSString stringWithFormat:@"%d hz",3333],[NSString stringWithFormat:@"50 Hz /60 Hz"],[NSString stringWithFormat:@"110 ～ 240 Volt "],[NSString stringWithFormat:@"%@/%@",@"3333",@"4444"],[NSString stringWithFormat:@"%@",@"5555"],[NSString stringWithFormat:@"﹣20～﹢50℃/﹣4～﹢122℉"],[NSString stringWithFormat:@"10％ ～ 90％"], nil];
    other_Parameters_Value_Array = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@ level",Pixel_Configuration],[NSString stringWithFormat:@"%@ level",Gray_Scale],[NSString stringWithFormat:@"%@ Hz",Refresh_Frequency],[NSString stringWithFormat:@"%@ Hz",Input_Power_Frequency],[NSString stringWithFormat:@"%@ Volt",Input_Voltage],[NSString stringWithFormat:@"%@ ",Ingress_Protection],[NSString stringWithFormat:@"%@ ",Weather_Rating],[NSString stringWithFormat:@"%@ °C",Operating_Temperature],[NSString stringWithFormat:@"%@ ",Operating_Humidity], nil];
    
    [calculator_DetailInfo_TableView reloadData];
    
}

- (void)backToSuperView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
//    [MyTool insertTopNavToolBarNoFont:self];
    /**
     *@brief    单位转换
     */
    [self unitChange];
    
//    [calculator_Main_CMTabBar.tabBar setHidden:YES];
//    originalFrame = calculator_Main_CMTabBar.selectedViewController.view.frame;
    /*注意iOS7与其之下的版本有区别需分别对待 iOS7之下的Y轴起始坐标为0 iOS7以后的Y轴起始坐标为20*/
 
//    [calculator_Main_CMTabBar.selectedViewController.view setFrame:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT)];
    
    /**
     *@brief  选屏计算器主界面标题
     */
    CustomLabel *calculator_Main_TitleLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(130, 0, SCREEN_CGSIZE_WIDTH-260, 44) withTitle:NSLocalizedString(@"Smart_Matrix", @"选屏计算器")];
    self.navigationItem.titleView = calculator_Main_TitleLabel;
    
    
    /**
     *@brief   选屏计算器主界面返回按钮
     */
//    CustomButton *calculator_Main_BackButton = [[CustomButton alloc] initWithFrame:CGRectMake(7, 7, 47, 30) withNormalImage:NSLocalizedString(@"Back_Button", @"返回按钮图片") withHighImage:nil];
//    [calculator_Main_BackButton addTarget:self action:@selector(calculator_Main_BackButton:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *calculator_Main_BackButtonItem = [[UIBarButtonItem alloc] initWithCustomView:calculator_Main_BackButton];
//    self.navigationItem.leftBarButtonItem = calculator_Main_BackButtonItem;
    
    
    /**
     *@brief   选屏计算器主界面局部变量 安全Release
     */
    RELEASE_SAFELY(calculator_Main_TitleLabel);
//    RELEASE_SAFELY(calculator_Main_BackButton);
//    RELEASE_SAFELY(calculator_Main_BackButtonItem);

    
    /**
     *@brief    选屏计算器类 赋值 通过 产品名称和定位id
     */
//    calculatorItem = [[calculator_DB getCategoryList:calculator_product_name andCalculator_id:calculator_loacation_id] lastObject];
    
//    DLog(@"选屏计算器%@的全部信息%@",calculator_product_name,calculatorItem);
    
    /**
     *@brief   选屏计算器 头ScrollView 包含 产品图片/横向箱体数/竖向箱体数/产品名称/箱体总数
     */
    calculator_HeadImage_ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT-20-44-(SCREEN_CGSIZE_HEIGHT*0.6))];
    
    /**
     *@brief   产品图片
     */
    calculator_HeadImage_View = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/4, 0, SCREEN_CGSIZE_WIDTH/2, calculator_HeadImage_ScrollView.frame.size.height)];
    
//    修改后可读取离包图片2014年05月16日13:30:41
//    [calculator_HeadImage_View setImageWithURL:[NSURL URLWithString:productImageUrl] placeholderImage:[UIImage imageNamed:BACKGROUND_IMAGE_DEFAULT]];
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches/"];
    NSString *imageUrl =[productImageUrl stringByReplacingOccurrencesOfString:URL_FOR_IP_OR_DOMAIN withString:documentsDirectory];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:imageUrl]) {
        [calculator_HeadImage_View setImageWithURL:[NSURL URLWithString:productImageUrl] placeholderImage:[UIImage imageWithContentsOfFile:imageUrl]];
    }else{
        [calculator_HeadImage_View setImageWithURL:[NSURL URLWithString:productImageUrl] placeholderImage:[UIImage imageNamed:@"frontheadbar.png"]];
    }
    
    [calculator_HeadImage_ScrollView addSubview:calculator_HeadImage_View];
    [calculator_HeadImage_ScrollView setUserInteractionEnabled:YES];
    [calculator_HeadImage_ScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_background.png"]]];
    
    /**
     *@brief   加减视图
     */
    calculator_HeadImage_Right_View = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30+44+calculator_HeadImage_ScrollView.frame.size.height, SCREEN_CGSIZE_WIDTH, 70)];
    calculator_HeadImage_Right_View.userInteractionEnabled = YES;
    [calculator_HeadImage_Right_View setImage:[UIImage imageNamed:@"magazineHeadViewImage.png"]];
    
    
    /**
     *@brief 横向箱体数Label
     */
    lateral_case_number_Label = [[CustomLabel alloc] initWithFrame:CGRectMake(5, 5, SCREEN_CGSIZE_WIDTH/2-10, 30) withTitle:NSLocalizedString(@"Cabinet_Width_Number", @"横向箱体数") withFont:15];
    
    /**
     *@brief 横向箱体数 减按钮Button
     */
    lateral_case_number_Minus_Button = [[CustomButton alloc] initWithFrame:CGRectMake(5, 30, SCREEN_CGSIZE_WIDTH/8, 30) withNormalImage:NewSubtraction withHighImage:nil];
    [lateral_case_number_Minus_Button addTarget:self action:@selector(lateral_case_number_Minus_Button:) forControlEvents:UIControlEventTouchUpInside];
    
//   隐藏键盘
    toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
// set style
    [toolbar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonIsClicked)];
    NSArray *barButtonItems = @[ flexBarButton, doneBarButton];
    toolbar.items = barButtonItems;
    /**
     *@brief 横向箱体数  TextField
     */
    lateral_case_number_TextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/8+10, 30, SCREEN_CGSIZE_WIDTH/4-20, 30)];
    [lateral_case_number_TextField setBorderStyle:UITextBorderStyleNone];
    [lateral_case_number_TextField setBackground:[UIImage imageNamed:@"inputBackgroundImage"]];
    lateral_case_number_TextField.delegate = self;
    lateral_case_number_TextField.textAlignment = NSTextAlignmentCenter;
    [lateral_case_number_TextField setText:@"1"];
    [lateral_case_number_TextField setKeyboardType:UIKeyboardTypeDecimalPad];
    
    
    /**
     *@brief 横向箱体数 加按钮Button
     */
    lateral_case_number_Plus_Button = [[CustomButton alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/8*3-5, 30, SCREEN_CGSIZE_WIDTH/8, 30) withNormalImage:NewIncrease withHighImage:nil];
    [lateral_case_number_Plus_Button addTarget:self action:@selector(lateral_case_number_Plus_Button:) forControlEvents:UIControlEventTouchUpInside];
    
    /**
     *@brief 竖向箱体数Label
     */
    longitudinal_case_number_Label = [[CustomLabel alloc] initWithFrame:CGRectMake(5+SCREEN_CGSIZE_WIDTH/2, 5, SCREEN_CGSIZE_WIDTH/2-10, 30) withTitle:NSLocalizedString(@"Cabinet_High_Number", @"竖向箱体数") withFont:15];
    
    /**
     *@brief 竖向箱体数 减按钮Button
     */
    longitudinal_case_number_Minus_Button = [[CustomButton alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/2+5, 30, SCREEN_CGSIZE_WIDTH/8, 30) withNormalImage:NewSubtraction withHighImage:nil];
    [longitudinal_case_number_Minus_Button addTarget:self action:@selector(longitudinal_case_number_Minus_Button:) forControlEvents:UIControlEventTouchUpInside];
    
    /**
     *@brief 竖向箱体数  TextField
     */
    longitudinal_case_number_TextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/2+SCREEN_CGSIZE_WIDTH/8+10, 30, SCREEN_CGSIZE_WIDTH/4-20, 30)];
    [longitudinal_case_number_TextField setBorderStyle:UITextBorderStyleNone];
    [longitudinal_case_number_TextField setBackground:[UIImage imageNamed:@"inputBackgroundImage"]];
    longitudinal_case_number_TextField.delegate = self;
    longitudinal_case_number_TextField.textAlignment = NSTextAlignmentCenter;
    [longitudinal_case_number_TextField setText:@"1"];
    [longitudinal_case_number_TextField setKeyboardType:UIKeyboardTypeDecimalPad];
    
    /**
     *@brief 竖向箱体数 加按钮Button
     */
    longitudinal_case_number_Plus_Button= [[CustomButton alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/2+SCREEN_CGSIZE_WIDTH/8*3-5, 30, SCREEN_CGSIZE_WIDTH/8, 30) withNormalImage:NewIncrease withHighImage:nil];
    [longitudinal_case_number_Plus_Button addTarget:self action:@selector(longitudinal_case_number_Plus_Button:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [calculator_HeadImage_Right_View addSubview:lateral_case_number_Label];
    [calculator_HeadImage_Right_View addSubview:lateral_case_number_Minus_Button];
    [calculator_HeadImage_Right_View addSubview:lateral_case_number_TextField];
    [calculator_HeadImage_Right_View addSubview:lateral_case_number_Plus_Button];
    [calculator_HeadImage_Right_View addSubview:longitudinal_case_number_Label];
    [calculator_HeadImage_Right_View addSubview:longitudinal_case_number_Minus_Button];
    [calculator_HeadImage_Right_View addSubview:longitudinal_case_number_TextField];
    [calculator_HeadImage_Right_View addSubview:longitudinal_case_number_Plus_Button];
    
    [self.view addSubview:calculator_HeadImage_ScrollView];
    [self.view addSubview:calculator_HeadImage_Right_View];
    
    /**
     *@brief  产品名称和总数的Label
     */
    product_name_and_number_Label = [[CustomLabel alloc]initWithFrame:CGRectMake(0, calculator_HeadImage_View.frame.size.height+44, SCREEN_CGSIZE_WIDTH, 30) withTitle:nil];
    [product_name_and_number_Label setBackgroundColor:[UIColor grayColor]];
    
    /**
     *@brief 产品名称Label
     */
    product_name_Label = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH/2-2, 30) withTitle:nil withFont:15];
    [product_name_Label setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"productTotal"]]];
    
    /**
     *@brief 箱体总数Label
     */
    box_product_number_Label = [[CustomLabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/2, 0, 100, 30) withTitle:NSLocalizedString(@"Total", @"总计:") withFont:15];
    box_product_number_Label.textAlignment = NSTextAlignmentLeft;
    [box_product_number_Label setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"productTotal"]]];
    
    /**
     *@brief 箱体总数 数值Label
     */
    box_product_number_Value_Label = [[CustomLabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/2+100, 0, SCREEN_CGSIZE_WIDTH/2-100, 30) withTitle:[NSString stringWithFormat:@"%d",1] withFont:15];
    [box_product_number_Value_Label setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"productTotal"]]];
    
    [product_name_and_number_Label addSubview:product_name_Label];
    [product_name_and_number_Label addSubview:box_product_number_Label];
    [product_name_and_number_Label addSubview:box_product_number_Value_Label];
    [self.view addSubview:product_name_and_number_Label];
    
    
    /**
     *@brief   选屏计算器详细信息 UITableView
     */
    calculator_DetailInfo_TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, calculator_HeadImage_View.frame.size.height+30+44+70, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT-20-44-calculator_HeadImage_View.frame.size.height-30-70) style:UITableViewStylePlain];
    [calculator_DetailInfo_TableView setContentSize:CGSizeMake(SCREEN_CGSIZE_WIDTH, 30*23)];
    calculator_DetailInfo_TableView.delegate = self;
    calculator_DetailInfo_TableView.dataSource = self;
    calculator_DetailInfo_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    calculator_DetailInfo_TableView.showsHorizontalScrollIndicator = NO;
    calculator_DetailInfo_TableView.showsVerticalScrollIndicator = NO;
    [calculator_DetailInfo_TableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:nil]]];
    [self.view addSubview:calculator_DetailInfo_TableView];
    
    
    
    /**
     *@brief    选屏计算器主界面 含 分享/列表按钮 View
     */
    calculator_Right_View = [[UIView alloc] initWithFrame:CGRectMake(200, 0, 88, 38)];
    
    /**
     *@brief    选屏计算器主界面 列表按钮
     */
//    calculator_List_Button = [[CustomButton alloc] initWithFrame:CGRectMake(44, 0, 44, 38) withNormalImage:NSLocalizedString(Calculator_Main_List_BG, @"选屏计算器 公司列表 图片") withHighImage:nil];
//    [calculator_List_Button addTarget:self action:@selector(calculator_List_Button:) forControlEvents:UIControlEventTouchUpInside];
//    [calculator_Right_View addSubview:calculator_List_Button];
    
    
    UIBarButtonItem *rightBttonItem = [[UIBarButtonItem alloc] initWithCustomView:calculator_Right_View];
    [rightBttonItem setStyle:UIBarButtonItemStyleBordered];
    self.navigationItem.rightBarButtonItem = rightBttonItem;
}


/**
 *@brief    单位转换
 */
- (void)unitChange
{
    /**
     *@brief   单位转换 UD
     */
    unitChangeUD = [NSUserDefaults standardUserDefaults];
    if ([[unitChangeUD objectForKey:UNIT_STRING] isEqualToString:METRIC]) {
        
        /**
         *@brief   长度单位
         */
        unit_length = 1.00;
        unit_box_length = 1.00;
        
        /**
         *@brief   屏体的长度单位，公制采用m，英制采用ft
         */
        unit_length_String = METRIC_Unit_Case_Length;
        
        /**
         *@brief   箱体的长度单位，公制采用mm，英制采用ft
         */
        unit_box_length_String = METRIC_Unit_Box_Length;
        
        /**
         *@brief    屏体的质量单位
         */
        unit_weight = 1.00;
        
        unit_weight_String = METRIC_Unit_Case_Weight;
        
        /**
         *@brief   功率单位
         */
        unit_power = 1.00;
        
        unit_power_String = METRIC_Unit_Power;
        
        /**
         *@brief   面积单位
         */
        unit_area = 1.00;
        
        unit_area_String = METRIC_Unit_Area;
    }
    if ([[unitChangeUD objectForKey:UNIT_STRING] isEqualToString:IMPERIAL]) {
        
        /**
         *@brief   长度单位
         */
        unit_length = 0.0032808399*1000;
        unit_box_length = 0.0032808399;
        
        /**
         *@brief   屏体的长度单位，公制采用m，英制采用ft
         */
        unit_length_String = IMPERIAL_Unit_Case_Length;
        
        /**
         *@brief   箱体的长度单位，公制采用mm，英制采用ft
         */
        unit_box_length_String = IMPERIAL_Unit_Box_Length;
        
        /**
         *@brief    屏体的质量单位
         */
        unit_weight = 1.00;
        
        unit_weight_String = IMPERIAL_Unit_Case_Weight;
        
        /**
         *@brief   功率单位
         */
        unit_power = 1.00;
        
        unit_power_String = IMPERIAL_Unit_Power;
        
        /**
         *@brief   面积单位
         */
        unit_area = 1.00;
        
        unit_area_String = IMPERIAL_Unit_Area;
    }
    
}

/**
 *@brief 横向箱体数 减按钮Button 点击事件
 */
- (void)lateral_case_number_Minus_Button:(CustomButton *)sender
{
    NSInteger one = 0;
    if ([lateral_case_number_TextField.text length]>0) {
        one = [lateral_case_number_TextField.text integerValue];
    }
    one--;
    if (one<MIN_SCRENN_NUM) {
        one=MIN_SCRENN_NUM;
    }
    [lateral_case_number_TextField setText:[NSString stringWithFormat:@"%d",one]];
    [self totalNumber];
}

/**
 *@brief 横向箱体数 加按钮Button
 */
- (void)lateral_case_number_Plus_Button:(CustomButton *)sender
{
    NSInteger one = 0;
    if ([lateral_case_number_TextField.text length]>0) {
        one = [lateral_case_number_TextField.text integerValue];
    }
    one++;
    if (one<MIN_SCRENN_NUM) {
        one=MIN_SCRENN_NUM;
    }
    [lateral_case_number_TextField setText:[NSString stringWithFormat:@"%d",one]];
    [self totalNumber];
}

/**
 *@brief 竖向箱体数 减按钮Button
 */
- (void)longitudinal_case_number_Minus_Button:(CustomButton *)sender
{
    NSInteger one = 0;
    if ([longitudinal_case_number_TextField.text length]>0) {
        one = [longitudinal_case_number_TextField.text integerValue];
    }
    one--;
    if (one<MIN_SCRENN_NUM) {
        one=MIN_SCRENN_NUM;
    }
    [longitudinal_case_number_TextField setText:[NSString stringWithFormat:@"%d",one]];
    [self totalNumber];
}

/**
 *@brief 竖向箱体数 加按钮Button
 */
- (void)longitudinal_case_number_Plus_Button:(CustomButton *)sender
{
    NSInteger one = 0;
    if ([longitudinal_case_number_TextField.text length]>0) {
        one = [longitudinal_case_number_TextField.text integerValue];
    }
    one++;
    if (one<MIN_SCRENN_NUM) {
        one=MIN_SCRENN_NUM;
    }
    [longitudinal_case_number_TextField setText:[NSString stringWithFormat:@"%d",one]];
    [self totalNumber];
}

/**
 *@brief 箱体总数
 */
- (void)totalNumber
{
    NSInteger one = 0;
    NSInteger two = 0;
    if ([lateral_case_number_TextField.text length]>0) {
        one = [lateral_case_number_TextField.text integerValue];
    }
    if ([longitudinal_case_number_TextField.text length]>0) {
        two = [longitudinal_case_number_TextField.text integerValue];
    }
    //改变箱体参数值
    DLog(@"location = %d",[Cabinet_Resolution rangeOfString:@"*"].location);
    NSString *pingtiFenbianlv;
    if (Cabinet_Resolution && ([Cabinet_Resolution rangeOfString:@"*"].location != NSNotFound)) {
        pingtiFenbianlv = [NSString stringWithFormat:@"%lld*%lld",[[[Cabinet_Resolution componentsSeparatedByString:@"*"] objectAtIndex:0] longLongValue]*one,[[[Cabinet_Resolution componentsSeparatedByString:@"*"] objectAtIndex:1] longLongValue]*two];
    }else{
        pingtiFenbianlv = [NSString stringWithFormat:@"%d*%d",0,0];
    }
    cabinet_Parameters_Value_Array = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%0.1f %@",Cabinet_Width*1.00*unit_box_length*one,unit_box_length_String],[NSString stringWithFormat:@"%0.1f %@",Cabinet_Height*1.00*unit_box_length*two,unit_box_length_String],pingtiFenbianlv,[NSString stringWithFormat:@"%0.1f %@",Cabinet_Weight*unit_weight*one*two,unit_weight_String],[NSString stringWithFormat:@"%0.1f %@",(Average_Power_Area/unit_length/unit_length)*unit_power,unit_power_String],[NSString stringWithFormat:@"%0.1f ",(Total_Power_Area/unit_length/unit_length)*unit_power*one*two], nil];
    [box_product_number_Value_Label setText:[NSString stringWithFormat:@"%d",one*two]];
    [calculator_DetailInfo_TableView reloadData];
}

///*水平方向的箱体数和垂直方向的箱体数变化的时候修改显示参数*/
- (void)changeValue
{
    
}

//键盘呈现
- (void)keyboardDidAppearance:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    float tmp0 = SCREEN_CGSIZE_HEIGHT - calculator_DetailInfo_TableView.frame.origin.y;
    float tmp1 = keyboardSize.height + toolbar.height;
    if (tmp1 > tmp0) {
        self.view.frame = CGRectMake(0, tmp0 - tmp1 + 20, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT);
    }
    DLog(@"\ninfo = %@\naValue = %@\ntmp0 = %f\ntmp1 = %f",info,aValue,tmp0,tmp1);
}
//隐藏键盘
- (void)doneButtonIsClicked{
    [self.view endEditing:YES];
//    [lateral_case_number_TextField resignFirstResponder];
//    [longitudinal_case_number_TextField resignFirstResponder];
}

#pragma mark - UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    if (![[[UIDevice currentDevice] model] isEqualToString:@"iPad"]) {
//        self.view.frame = CGRectMake(0, -60, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT);
//    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidAppearance:) name:UIKeyboardDidShowNotification object:nil];
    
    textField.inputAccessoryView = toolbar;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT);
    [self totalNumber];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    /**
     *@brief   加载选屏计算器信息
     */
    [self loadCalculator:calculator_product_name andCalculator_id:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    DLog(@"[headArray count] = %d",[headArray count]);
    return [headArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    for (int i=0; i<[headArray count]; i++) {
        DLog(@"headArray:%d:%@",section,[headArray objectAtIndex:section]);
    }
    return [headArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger cellCount;
//    if (section==0) {
//        cellCount = [cabinet_Parameters_Title_Array count];
//        DLog(@"section==0 :%d",cellCount);
//    }else if (section==1){
//        cellCount = [screen_Physical_Parameters_Title_Array count];
//        DLog(@"section==1 :%d",cellCount);
//    }else if (section==2){
//        cellCount = [screen_Performance_Parameters_Title_Array count];
//        DLog(@"section==2 :%d",cellCount);
//    }else {
//        cellCount = [other_Parameters_Title_Array count];
//        DLog(@"section==3 :%d",cellCount);
//    }
    if (section==0) {
        cellCount = [cabinet_Parameters_Title_Array count];
        DLog(@"section==0 :%d",cellCount);
    }else if (section==1){
        cellCount = [screen_Performance_Parameters_Title_Array count];
        DLog(@"section==1 :%d",cellCount);
    }else {
        cellCount = [other_Parameters_Title_Array count];
        DLog(@"section==2 :%d",cellCount);
    }
    return cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CalculatorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[CalculatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if ([indexPath section]==0) {
//        cell.titleLabel.text = [cabinet_Parameters_Title_Array objectAtIndex:[indexPath row]];
//        cell.valueLabel.text = [cabinet_Parameters_Value_Array objectAtIndex:[indexPath row]];
//        DLog(@"%@=%@",cell.titleLabel.text,cell.valueLabel.text);
//    }
//    if ([indexPath section]==1) {
//        cell.titleLabel.text = [screen_Physical_Parameters_Title_Array objectAtIndex:[indexPath row]];
//        cell.valueLabel.text = [screen_Physical_Parameters_Value_Array objectAtIndex:[indexPath row]];
//    }
//    if ([indexPath section]==2) {
//        cell.titleLabel.text = [screen_Performance_Parameters_Title_Array objectAtIndex:[indexPath row]];
//        cell.valueLabel.text = [screen_Performance_Parameters_Value_Array objectAtIndex:[indexPath row]];
//    }
//    if ([indexPath section]==3) {
//        cell.titleLabel.text = [other_Parameters_Title_Array objectAtIndex:[indexPath row]];
//        cell.valueLabel.text = [other_Parameters_Value_Array objectAtIndex:[indexPath row]];
//    }
    if ([indexPath section]==0) {
        cell.titleLabel.text = [cabinet_Parameters_Title_Array objectAtIndex:[indexPath row]];
        cell.valueLabel.text = [cabinet_Parameters_Value_Array objectAtIndex:[indexPath row]];
        DLog(@"%@=%@",cell.titleLabel.text,cell.valueLabel.text);
    }
//    if ([indexPath section]==1) {
//        cell.titleLabel.text = [screen_Physical_Parameters_Title_Array objectAtIndex:[indexPath row]];
//        cell.valueLabel.text = [screen_Physical_Parameters_Value_Array objectAtIndex:[indexPath row]];
//    }
    if ([indexPath section]==1) {
        cell.titleLabel.text = [screen_Performance_Parameters_Title_Array objectAtIndex:[indexPath row]];
        cell.valueLabel.text = [screen_Performance_Parameters_Value_Array objectAtIndex:[indexPath row]];
    }
    if ([indexPath section]==2) {
        cell.titleLabel.text = [other_Parameters_Title_Array objectAtIndex:[indexPath row]];
        cell.valueLabel.text = [other_Parameters_Value_Array objectAtIndex:[indexPath row]];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *sectionView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"magazineHeadViewImage.png"]];
    CustomLabel *titleLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, 25) withTitle:[headArray objectAtIndex:section] withFont:15];
    [sectionView addSubview:titleLabel];
    
    return sectionView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
