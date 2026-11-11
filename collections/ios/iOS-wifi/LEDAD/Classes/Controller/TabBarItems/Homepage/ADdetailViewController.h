//
//  ADdetailViewController.h
//  LED2Buy
//
//  Created by LDY on 14-7-4.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKProgressTimer.h"

@interface ADdetailViewController : UIViewController<UIWebViewDelegate, KKProgressTimerDelegate>
{
    UIWebView *AdDetaiWebview;
    NSInteger fontSize;
    NSInteger haploid;
}

@property(nonatomic, retain) NSString *ad_link;
@property(nonatomic, retain) NSString *ad_title;
@end
