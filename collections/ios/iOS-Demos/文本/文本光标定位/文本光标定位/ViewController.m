//
//  ViewController.m
//  文本光标定位
//
//  Created by Yutian Duan on 2018/3/27.
//  Copyright © 2018年 duanyutian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 100, 100) textContainer:nil];
  textView.text = @"我 i 是科技兴农上课 \\n   上课时睡时是生生世世非法所得福建省地方似懂非懂沙发上发呆觉睡觉睡觉睡觉睡觉睡觉睡觉睡觉睡觉睡觉睡觉睡觉睡觉睡觉睡觉睡觉睡觉睡觉时sadasfdsifasjaidjaiod";
  //    textView.automaticallyAdjustsScrollViewInsets = NO;
  
  //当UITextView中含有文字时，系统默认将光标定位到最后的位置，下面的语句将光标定位到首位置。
  [textView becomeFirstResponder];
  BOOL  one =  textView.contentSize.height > textView.frame.size.height;
  NSLog(@"--      %d",one);
  //    contentsize.height > textview.frame
  if (one) {
    textView.selectedRange = NSMakeRange(textView.text.length,0);
  }
  textView.backgroundColor = [UIColor redColor];
  [self.view addSubview:textView];
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
