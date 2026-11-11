//
//  LanguageSettingViewController.h
//  XCloudManager
//  语言设置
//  Created by LDY on 13-9-21.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RootVC.h"
#import "AppDelegate.h"

@class BaseButton;
@class LoginViewController;

@interface LanguageSettingViewController : UIViewController<SubstitutableDetailViewController,UIAlertViewDelegate>
{
//    /*存储选择语言的状态的数组*/
//    NSMutableArray *language_Selected_Array;
//    
//    NSMutableDictionary *simpleChineseDic;
//    NSMutableDictionary *traditionalChineseDic;
//    NSMutableDictionary *englishDic;
    SplitVCDemoViewController *splitVCDemoViewController;
    
    //容器视图
    UIView *containerView;
    
    /*中文简体*/
    BOOL simpleChineseSelected;
    BaseButton *language_SimplifiedChineseButton;
    
    /*中文繁体*/
    BOOL traditionalChineseSelected;
    BaseButton *language_TraditionalChineseButton;
    
    /*English*/
    BOOL englishSelected;
    BaseButton *language_EnglishButton;
    
    /*德语*/
    BOOL deutschSelected;
    BaseButton *language_DeutschButton;

    /*法语*/
    BOOL frenchSelected;
    BaseButton *language_FrenchButton;

    /*意大利语*/
    BOOL italianaSelected;
    BaseButton *language_ItalianaButton;

    /*西班牙语*/
    BOOL espanishSelected;
    BaseButton *language_EspanishButton;

    /*俄语*/
    BOOL pycckNNSelected;
    BaseButton *language_pycckNNButton;

    /*葡萄牙语*/
    BOOL portuguesSelected;
    BaseButton *language_PortuguesButton;

    /*日语*/
    BOOL japaneseSelected;
    BaseButton *language_JapaneseButton;

    /*韩语*/
    BOOL koreanSelected;
    BaseButton *language_KoreanButton;

    /*希伯来语*/
    BOOL aLBSelected;
    BaseButton *language_ALBButton;
    
    /*注销进入登录界面*/
    LoginViewController *loginViewController;
}

@end
