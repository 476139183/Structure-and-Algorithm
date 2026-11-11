//
//  SendBBSViewController.m
//  LED2Buy
//
//  Created by LDY on 14-7-18.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "SendBBSViewController.h"
#import "Config.h"
#import "MyTool.h"
#import "ASIFormDataRequest.h"
#import "SGInfoAlert.h"

@interface SendBBSViewController ()

@end

@implementation SendBBSViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布帖子";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backToContentVC)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendBBS)];
    
    //   隐藏键盘
    toolbar = [[[UIToolbar alloc] init] retain];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    // set style
    [toolbar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonIsClicked)];
    NSArray *barButtonItems = @[flexBarButton, doneBarButton];
    toolbar.items = barButtonItems;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, [Config currentNavigateHeight], 50, 40)];
    titleLabel.text = @"标题:";
    [self.view addSubview:titleLabel];
    titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, [Config currentNavigateHeight], SCREEN_CGSIZE_WIDTH - 70, 40)];
    titleTextField.delegate = self;
    titleTextField.inputAccessoryView = toolbar;
    titleTextField.layer.borderColor = (CGColorRef)[UIColor blackColor];
    [self.view addSubview:titleTextField];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, [Config currentNavigateHeight] + 40, 50, 40)];
    contentLabel.text = @"内容:";
    [self.view addSubview:contentLabel];
    //    contentTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, [Config currentNavigateHeight] + 40, SCREEN_CGSIZE_WIDTH - 20, SCREEN_CGSIZE_HEIGHT - 40 - [Config currentNavigateHeight])];
    //    contentTextField.text = @"内容";
    //    contentTextField.textAlignment = NSTextAlignmentLeft;
    //    [self.view addSubview:contentTextField];
    
    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(60, [Config currentNavigateHeight] + 45, SCREEN_CGSIZE_WIDTH - 70, SCREEN_CGSIZE_HEIGHT - 45 - [Config currentNavigateHeight])];
    contentTextView.delegate = self;
    contentTextView.inputAccessoryView = toolbar;
    contentTextView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:contentTextView];
}

//返回主贴列表
- (void)backToContentVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//发布主贴
//http://www.ledmediasz.com/api_bbs/api_save_content.aspx?companyid=2287&lang=cn&userid=789&source=Led2Buy&title=测试一下&textcontent=测试一下&contenttype=1&parent_id=0&article_id=空
//发布评论
//http://www.ledmediasz.com/api_bbs/api_save_content.aspx?companyid=2287&lang=cn&userid=789&source=Led2Buy&title=测试一下&textcontent=测试一下&contenttype=1&parent_id=101&article_id=jiegou_aid
//发布贴子
- (void)sendBBS
{
    DLog(@"点击发布");
    if ([MyTool CheckIsLogin]) {
        DLog(@"已登录，可以发布");
        //        NSURL *sendURL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@&userid=789&contenttype=2&parent_id=0&title=%@&textcontent=%@",URL_BBS_SENDBBS,titleTextField.text, contentTextView.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURL *sendURL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@&contenttype=2",URL_BBS_SENDBBS] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        if (titleTextField.text.length == 0) {
            DLog(@"标题不能为空！！！");
            [SGInfoAlert showInfo:NSLocalizedString(@"评论标题不能为空",@"评论标题不能为空")
                          bgColor:[[UIColor darkGrayColor] CGColor]
                           inView:self.view
                         vertical:0.4];
            return;
        }
        if (contentTextView.text.length == 0) {
            DLog(@"评论内容不能为空！！！");
            [SGInfoAlert showInfo:NSLocalizedString(@"评论内容不能为空！！！",@"评论内容不能为空！！！")
                          bgColor:[[UIColor darkGrayColor] CGColor]
                           inView:self.view
                         vertical:0.4];
            return;
        }
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        ASIFormDataRequest *sendBBSRequest = [ASIFormDataRequest requestWithURL:sendURL];
        [sendBBSRequest addPostValue:titleTextField.text forKey:@"title"];
        [sendBBSRequest addPostValue:contentTextView.text forKey:@"textcontent"];
        [sendBBSRequest addPostValue:[ud objectForKey:KEY_USER_ID] forKey:@"userid"];
        [sendBBSRequest addPostValue:self.parent_id forKey:@"parent_id"];
        [sendBBSRequest setCompletionBlock:^{
            DLog(@"发布成功");
            [SGInfoAlert showInfo:NSLocalizedString(@"发布成功",@"发布成功")
                          bgColor:[[UIColor darkGrayColor] CGColor]
                           inView:self.view
                         vertical:0.4];
            [self performSelector:@selector(backToContentVC) withObject:nil afterDelay:0.5];
        }];
        [sendBBSRequest setFailedBlock:^{
            DLog(@"发布失败");
            [SGInfoAlert showInfo:NSLocalizedString(@"发布失败",@"发布失败")
                          bgColor:[[UIColor darkGrayColor] CGColor]
                           inView:self.view
                         vertical:0.4];
        }];
        [sendBBSRequest startAsynchronous];
        
    }else{
        DLog(@"请登录账号");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未登录" message:@"请先登录后再进行操作" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

//隐藏键盘
- (void)doneButtonIsClicked
{
    [self.view endEditing:YES];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"YES" forKey:@"request"];
}
#pragma mark - UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nilSymbol) name:UIKeyboardDidShowNotification object:nil];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
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
