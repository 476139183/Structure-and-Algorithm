//
//  RootVC.h
//  LEDAD
//
//  yixingman on 11-10-22.
//  ledmedia All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailVC.h"
#import "LayoutYXMViewController.h"
#import "HomepageViewController.h"

#import "YXM_SettingViewController.h"
@class YXM_VideoEditerViewController;

@protocol SubstitutableDetailViewController

@end//用你妹的协议啊   ！~~~ 写了协议协议里面还啥遵循的都没有。~~ 你妹啊 用block多好  粗暴简单，解决问题~

@interface RootVC : UITableViewController <UISplitViewControllerDelegate,UIAlertViewDelegate> {
	
	UISplitViewController *splitViewController;
    
    //广告市场页面
    HomepageViewController *homepageVC;

    YXM_VideoEditerViewController *_videoEditer;

//    YXM_SettingViewController *_settingViewController;

}

@property (nonatomic, assign) IBOutlet UISplitViewController *splitViewController;
@end
