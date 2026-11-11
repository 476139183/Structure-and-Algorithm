//
//  YXM_ReportMailViewController.m
//  LEDAD
//
//  Created by yixingman on 14-9-26.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import "YXM_ReportMailViewController.h"
#import "MyTool.h"

@interface YXM_ReportMailViewController ()

@end

@implementation YXM_ReportMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *@brief 点击发送邮件按钮后，触发这个方法
 */
-(void)sendEMail
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *path = [[MyTool applicationDocumentsDirectory] stringByAppendingPathComponent:@"ExceptionReport.txt"];
    if ([fileMgr fileExistsAtPath:path]) {
        Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));

        if (mailClass != nil)
        {
            if ([mailClass canSendMail])
            {
                NSLog(@"可以发送邮件");
                [self displayComposerSheet];
            }
            else
            {
                //            [self launchMailAppOnDevice];
            }
        }
        else
        {
            //        [self launchMailAppOnDevice];
        }
    }

}


/**
 *@brief 可以发送邮件的话
 */
-(void)displayComposerSheet
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];

    mailPicker.mailComposeDelegate = self;

    /*设置主题*/
    [mailPicker setSubject:@"错误报告"];
    /*添加发送者*/
    NSArray *toRecipients = [NSArray arrayWithObject: @"xmyi@zdec.com"];
    [mailPicker setToRecipients: toRecipients];


    //设置邮件的主体
    NSString *path = [[MyTool applicationDocumentsDirectory] stringByAppendingPathComponent:@"ExceptionReport.txt"];

    NSString *mailBody = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [mailPicker setMessageBody:mailBody isHTML:YES];

    [self presentModalViewController:mailPicker animated:YES];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *msg;

    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSent:
        {
            msg = @"邮件发送成功";
            [self alertWithTitle:nil msg:msg];
            NSFileManager *fileMgr = [NSFileManager defaultManager];
            NSString *path = [[MyTool applicationDocumentsDirectory] stringByAppendingPathComponent:@"ExceptionReport.txt"];
            [fileMgr removeItemAtPath:path error:nil];
        }
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            [self alertWithTitle:nil msg:msg];
            break;
        default:
            break;
    }

    [self dismissModalViewControllerAnimated:YES];
}

- (void)alertWithTitle: (NSString *)_title_ msg: (NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

@end
