//
//  ShowCalculatorViewController.h
//  Absen
//
//  Created by yixingman on 8/23/13.
//  Copyright (c) 2013 ledmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
//#import "CalculatorDBOperation.h"
//#import "CMTabBarController.h"
//#import "ParameterItem.h"

@class CustomButton;
@class CustomLabel;


@interface ShowCalculatorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIPageViewControllerDelegate,MFMailComposeViewControllerDelegate>
{
    
    UIToolbar *toolbar;
    /**
     *@brief   选屏计算器 头ScrollView 包含 产品图片/横向箱体数/竖向箱体数/产品名称/箱体总数
     */
    UIScrollView *calculator_HeadImage_ScrollView;
    
    /**
     *@brief   产品图片
     */
    UIImageView *calculator_HeadImage_View;
    
    /**
     *@brief   右侧视图
     */
    UIImageView *calculator_HeadImage_Right_View;
    
    /**
     *@brief 横向箱体数Label
     */
    CustomLabel *lateral_case_number_Label;
    
    /**
     *@brief 横向箱体数 减按钮Button
     */
    CustomButton *lateral_case_number_Minus_Button;
    
    /**
     *@brief 横向箱体数  TextField
     */
    UITextField *lateral_case_number_TextField;
    
    /**
     *@brief 横向箱体数 加按钮Button
     */
    CustomButton *lateral_case_number_Plus_Button;
    
    /**
     *@brief 竖向箱体数Label
     */
    CustomLabel *longitudinal_case_number_Label;
    
    /**
     *@brief 竖向箱体数 减按钮Button
     */
    CustomButton *longitudinal_case_number_Minus_Button;
    
    /**
     *@brief 竖向箱体数  TextField
     */
    UITextField *longitudinal_case_number_TextField;
    
    /**
     *@brief 竖向箱体数 加按钮Button
     */
    CustomButton *longitudinal_case_number_Plus_Button;
    
    /**
     *@brief  产品名称和总数的Label
     */
    CustomLabel *product_name_and_number_Label;
    
    
    /**
     *@brief 产品名称Label
     */
    CustomLabel *product_name_Label;
    
    /**
     *@brief 箱体总数Label
     */
    CustomLabel *box_product_number_Label;
    
    /**
     *@brief 箱体总数 数值Label
     */
    CustomLabel *box_product_number_Value_Label;
    
    
    
    /**
     *@brief  选屏计算器的详细信息上下滑动 UIScrollView 包含剩下的全部信息
     */
    UIScrollView *calculator_DetailInfo_ScrollView;
    
    /**
     *@brief   选屏计算器详细信息 UITableView
     */
    UITableView *calculator_DetailInfo_TableView;
    
    /**
     *@brief   主标题头
     */
    NSArray *headArray;
    
    /**
     *@brief   箱体参数标题
     */
    NSArray  *cabinet_Parameters_Title_Array;
    
    /**
     *@brief   箱体参数数值
     */
    NSArray *cabinet_Parameters_Value_Array;
    
    /**
     *@brief   屏体物理参数标题
     */
    NSArray  *screen_Physical_Parameters_Title_Array;
    
    /**
     *@brief   屏体物理参数数值
     */
    NSArray *screen_Physical_Parameters_Value_Array;
    
    
    /**
     *@brief   屏体性能参数标题
     */
    NSArray  *screen_Performance_Parameters_Title_Array;
    
    /**
     *@brief   屏体性能参数数值
     */
    NSArray *screen_Performance_Parameters_Value_Array;
    
    
    /**
     *@brief   其他参数标题
     */
    NSArray  *other_Parameters_Title_Array;
    
    /**
     *@brief   其他参数数值
     */
    NSArray *other_Parameters_Value_Array;
    
    
    
    CGRect originalFrame;
    
    
    /**
     *@brief    选屏计算器主界面分享按钮
     */
    CustomButton *calculator_Main_Share_Button;
    
    /**
     *@brief    选屏计算器主界面列表按钮
     */
    CustomButton *calculator_Main_List_Button;
    
    /**
     *@brief   选屏计算器主界面 导航条右侧视图
     */
    UIView *calculator_right_View;
    
    /**
     *@brief    选屏计算器主界面产品 的名称
     */
    NSString *calculator_product_name;
    
    
    /**
     *@brief    屏体宽度 数值Label
     */
    CustomLabel *screen_width_Value_Label;
    
    
    
    /**
     *@brief    屏体高度 数值Label
     */
    CustomLabel *screen_height_Value_Label;
    
    
    
    /**
     *@brief    屏体面积 数值Label
     */
    CustomLabel *screen_size_Value_Label;
    
    
    /**
     *@brief  技术参数 View
     */
    UIView  *paraView;
    
    /**
     *@brief
     */
//    ParameterItem *parameterItem;
    
    /**
     *@brief   长度单位
     */
    double  unit_length;
    
    /**
     *@brief   屏体的长度单位，公制采用mm，英制采用ft
     */
    NSString *unit_length_String;
    
    /**
     *@brief   箱体的长度单位，公制采用mm，英制采用ft
     */
    NSString *unit_box_length_String;
    
    /**
     *@brief    屏体的质量单位
     */
    double unit_weight;
    
    /**
     *@brief    屏体的质量单位
     */
    double unit_box_length;
    
    /**
     *@brief    屏体的质量单位   公制采用 kg  英制 pounds
     */
    NSString *unit_weight_String;
    
    /**
     *@brief   功率单位
     */
    double unit_power;
    
    /**
     *@brief  功率单位   公制采用 W/sqm  英制 W/sqft
     */
    NSString *unit_power_String;
    
    /**
     *@brief   面积单位
     */
    double unit_area;
    
    /**
     *@brief  面积单位  公制采用  sqm  英制 sqft
     */
    NSString *unit_area_String;
    
    
    
    /**
     *@brief   单位转换 UD
     */
    NSUserDefaults *unitChangeUD;
    
    
    /**
     *@brief    选屏计算器主界面 分享按钮
     */
    CustomButton *calculator_Share_Button;
    
    /**
     *@brief    选屏计算器主界面 列表按钮
     */
    CustomButton *calculator_List_Button;
    
    
    /**
     *@brief    选屏计算器主界面 含 分享/列表按钮 View
     */
    UIView *calculator_Right_View;
    
    /**
     *@brief  判断是否从相册来
     */
    NSUserDefaults *fromPhotosUD;
    
}
/**
 *@brief   选屏计算器主界面自定义TabBar
 */
//@property (nonatomic,assign) CMTabBarController *calculator_Main_CMTabBar;
/**
 *@brief
 */
//@property (nonatomic,retain)  ParameterItem *parameterItem;

/**
 *@brief   加载选屏计算器信息
 */
- (void)loadCalculator:(NSString *)product  andCalculator_id:(NSString *)calculator_id;

/**
 *@brief   横向箱体数 增加按钮点击事件
 */
- (void)lateral_case_number_Plus_Button:(CustomButton *)sender;
/**
 *@brief   横向箱体数 减少按钮点击事件
 */
- (void)lateral_case_number_Minus_Button:(CustomButton *)sender;

/**
 *@brief   竖向箱体数 增加按钮点击事件
 */
- (void)longitudinal_case_number_Plus_Button:(CustomButton *)sender;
/**
 *@brief   竖向箱体数 减少按钮点击事件
 */
- (void)longitudinal_case_number_Minus_Button:(CustomButton *)sender;

//2014年04月19日21:55:15
@property (nonatomic , retain) NSString *productImageUrl;
@property (nonatomic,retain) NSString *calculator_product_name;
//箱体参数
@property (nonatomic,assign) NSInteger Cabinet_Width;
@property (nonatomic,assign) NSInteger Cabinet_Height;
@property (nonatomic,assign) NSInteger Cabinet_Weight;
@property (nonatomic,assign) NSInteger Average_Power_Area;
@property (nonatomic,assign) NSInteger Total_Power_Area;
@property (nonatomic,retain) NSString *Cabinet_Resolution;
//屏体性能参数
@property (nonatomic,assign) float Pixel_Pitch;
@property (nonatomic,assign) NSInteger Brightness;
@property (nonatomic,retain) NSString *Viewing_Angle;
@property (nonatomic,retain) NSString *LED_Type;
//其他参数
@property (nonatomic,retain) NSString *Pixel_Configuration;
@property (nonatomic,retain) NSString *Gray_Scale;
@property (nonatomic,retain) NSString *Refresh_Frequency;
@property (nonatomic,retain) NSString *Input_Power_Frequency;
@property (nonatomic,retain) NSString *Input_Voltage;
@property (nonatomic,retain) NSString *Ingress_Protection;
@property (nonatomic,retain) NSString *Weather_Rating;
@property (nonatomic,retain) NSString *Operating_Temperature;
@property (nonatomic,retain) NSString *Operating_Humidity;

@end
