//
//  YXM_FeedbackViewController.m
//  LEDAD
//
//  Created by laidiya on 15/9/10.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "YXM_FeedbackViewController.h"

@interface YXM_FeedbackViewController ()
{

    
    UITextView *feedbacktextview;
    

}
@end

@implementation YXM_FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backbutton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [backbutton setBackgroundImage:[UIImage imageNamed:@"dyt_back"] forState:0];
    [backbutton addTarget:self action:@selector(myviewback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    
    
    
    [self _initview];
    
    
    // Do any additional setup after loading the view.
}

-(void)_initview
{

    //  输入框
    feedbacktextview  = [[UITextView alloc]initWithFrame:CGRectMake(10, 40, self.view.frame.size.width-20, 350)];
    feedbacktextview.textColor=[UIColor lightGrayColor];//设置提示内容颜色

    
    feedbacktextview.delegate = self;
    feedbacktextview.backgroundColor = [UIColor whiteColor];
    
    feedbacktextview.layer.masksToBounds = YES;
    
    feedbacktextview.layer.borderWidth = 1.0;
    
    feedbacktextview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    feedbacktextview.layer.cornerRadius = 8.0;
    
    feedbacktextview.text = NSLocalizedString(@"请输入正文", nil);//提示语
    feedbacktextview.selectedRange = NSMakeRange(0,0) ;//光标起始位置

    [self.view addSubview:feedbacktextview];
    
    //确定按钮
    
    
    UIButton *sendmsgbutton = [[UIButton alloc]initWithFrame:CGRectMake(feedbacktextview.frame.size.width/2, feedbacktextview.frame.origin.y+feedbacktextview.frame.size.height, 100, 30)];
    
    [sendmsgbutton setTitle:@"发送" forState:0];
    sendmsgbutton.backgroundColor = [UIColor blueColor];
    [sendmsgbutton addTarget:self action:@selector(sendmsg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendmsgbutton];
    
    

}

//发生意见反馈
-(void)sendmsg
{
    
    
    
    if (feedbacktextview.text.length == 0||[feedbacktextview.text isEqualToString:NSLocalizedString(@"请输入正文", nil)]) {
//        [self showAlertView:@"文本不能为空！"];
        
        return;
    }


}


- (void)textViewDidChangeSelection:(UITextView *)textView

{
    
    if (textView.textColor==[UIColor lightGrayColor]
        &&[textView.text isEqualToString:NSLocalizedString(@"请输入正文", nil)]
        )//如果是提示内容，光标放置开始位置
    {
        NSRange range;
        range.location = 0;
        range.length = 0;
        textView.selectedRange = range;
    }else if(textView.textColor==[UIColor lightGrayColor])//中文输入键盘
    {
        NSString *placeholder=NSLocalizedString(@"请输入正文", nil);
        textView.textColor=[UIColor blackColor];
        textView.text=[textView.text substringWithRange:NSMakeRange(0, textView.text.length- placeholder.length)];
    }
}
//以上是当在UITextView中输入文字的时候，光标都从最初点开始。

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        textView.backgroundColor = [UIColor whiteColor];
        textView.textColor=[UIColor lightGrayColor];//设置提示内容颜色
        textView.text = NSLocalizedString(@"请输入正文", nil);//提示语
        textView.selectedRange=NSMakeRange(0,0) ;//光标起始位置
        
        
    }
    
}

-(void)myviewback
{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
