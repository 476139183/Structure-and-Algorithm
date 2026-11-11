//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by xiaomage on 15/10/25.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"

#import "GlobeHeader.h"


#import "LoginViewModel.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) LoginViewModel *loginVM;

@end

@implementation ViewController

- (LoginViewModel *)loginVM
{
    if (_loginVM == nil) {
        _loginVM = [[LoginViewModel alloc] init];
    }
    
    return _loginVM;
}
// MVVM:
// VM:视图模型,处理界面上所有业务逻辑

// 每一个控制器对应一个VM模型
// VM:最好不要包括视图V

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self bindViewModel];
    
    [self loginEvent];
    
//    self.loginVM.loginEnableSiganl = nil;
    
    
    // MVVM:先创建VM模型,把整个界面的一些业务逻辑处理完
    
    
    // 回到控制器去执行
}

// 绑定viewModel
- (void)bindViewModel
{
    // 1.给视图模型的账号和密码绑定信号
    RAC(self.loginVM, account) = _accountFiled.rac_textSignal;
    RAC(self.loginVM, pwd) = _pwdField.rac_textSignal;
}
// 登录事件
- (void)loginEvent
{
    // 1.处理文本框业务逻辑
    // 设置按钮能否点击
    RAC(_loginBtn,enabled) = self.loginVM.loginEnableSiganl;
    
    
    // 2.监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        // 处理登录事件
        [self.loginVM.loginCommand execute:nil];
        
    }];

}

@end
