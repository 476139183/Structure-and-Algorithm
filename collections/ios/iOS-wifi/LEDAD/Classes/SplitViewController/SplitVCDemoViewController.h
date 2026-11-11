//
//  LEDADViewController.h
//  LEDAD
//
//  yixingman on 11-10-22.
//  ledmedia All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface SplitVCDemoViewController : UIViewController {
	UISplitViewController* splitVC;
}
@property (retain,nonatomic)IBOutlet UISplitViewController* splitVC;
@end

