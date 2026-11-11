//
//  ViewController.m
//  copyLabel
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
  
  _labelName = [[HTCopyableLabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
  _labelName.copyableLabelDelegate = self;
  _labelName.text  = @"段雨田帅 ！";
  [self.view addSubview:_labelName];
  
  UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 300, 50)];
  field.placeholder = @"复制内容放这里";
  field.backgroundColor = [UIColor redColor];
  
  [self.view addSubview:field];
  
  // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - HTCopyableLabelDelegate

- (NSString *)stringToCopyForCopyableLabel:(HTCopyableLabel *)copyableLabel {
  NSString *stringToCopy = @"";
  if (copyableLabel == _labelName) {
    stringToCopy =_labelName.text;
  } else {
    stringToCopy = @"胖子是🐷";
  }
  NSLog(@"%@",stringToCopy);
  return stringToCopy;
}

// copy 代理
- (CGRect)copyMenuTargetRectInCopyableLabelCoordinates:(HTCopyableLabel *)copyableLabel {
  CGRect rect;
  
  if (copyableLabel == _labelName) {
    rect = copyableLabel.bounds;
    // The UIMenuController will appear close to container, indicating all of its contents will be copied
    //rect = [self.labelContainer1 convertRect:self.labelContainer1.bounds toView:copyableLabel];
  } else {
    // The UIMenuController will appear close to the label itself
    rect = copyableLabel.bounds;
  }
  
  return rect;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}



@end
