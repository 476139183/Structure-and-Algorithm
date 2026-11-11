//
//  ViewController.h
//  copyLabel
//
//  Created by Yutian Duan on 2018/3/27.
//  Copyright © 2018年 duanyutian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTCopyableLabel.h"

@interface ViewController : UIViewController <HTCopyableLabelDelegate>

@property(nonatomic,strong)  HTCopyableLabel *labelName;

@end

