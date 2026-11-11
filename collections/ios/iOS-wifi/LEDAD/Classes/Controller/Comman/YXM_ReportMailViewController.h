//
//  YXM_ReportMailViewController.h
//  LEDAD
//
//  Created by yixingman on 14-9-26.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface YXM_ReportMailViewController : UIViewController<UIActionSheetDelegate,MFMailComposeViewControllerDelegate>

/**
 *@brief 点击发送邮件按钮后，触发这个方法
 */
-(void)sendEMail;
@end
