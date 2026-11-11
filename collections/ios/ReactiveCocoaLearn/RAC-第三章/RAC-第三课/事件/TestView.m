//
//  TestView.m
//  RAC-第三课
//
//  Created by Yutian Duan on 2018/11/18.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "TestView.h"
#import <ReactiveObjC/ReactiveObjC.h>

//! KVO 类
#import <NSObject+RACKVOWrapper.h>


@interface TestView ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *sender;

@end

@implementation TestView

- (UITextField *)textField {
  if (!_textField) {
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width, 30)];
    _textField.placeholder = @"输入点什么";
    _textField.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_textField];
    
    //TODO: 4. 监听文本输入框
    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
      NSLog(@"输入:%@",x);
    }];
    
    
  }
  
  return _textField;
}

- (UIButton *)sender {
  if (!_sender) {
    _sender = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, 300, 45)];
    _sender.backgroundColor = [UIColor orangeColor];
    [_sender setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:_sender];
    
    //TODO: 3.监听事件,注意循环 引用问题
    __weak typeof(self) weakSelf = self;
    [[_sender rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
      NSLog(@"点击按钮%@",x);
      [weakSelf clickButton:x];
    }];
  }
  return _sender;
}

- (instancetype) initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    
    self.textField.hidden = NO;
    self.sender.hidden = NO;
    
    //!TODO: 2. 代替KVO
    [self.sender rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
      NSLog(@"frame.value\n%@\n%@",value,change);
    }];

    //TODO: 1. 代替通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
      NSLog(@"键盘出现%@",x);
    }];

    
  }
  return self;
}

//! 按钮点击事件
- (void)clickButton:(UIButton *)sender {
  NSLog(@"调用了clickButton方法");
  [self endEditing:YES];
}

- (void)dealloc {
  NSLog(@"TestView dealloc");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *view = [super hitTest:point withEvent:event];
  if (view == self) {
    static int x = 20;
    x += 5;
    
    CGRect rect = _sender.frame;
    rect.origin.x = x;
    _sender.frame = rect;
  }
  
  return view;

}

@end
