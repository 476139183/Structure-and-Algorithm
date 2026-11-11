//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by xiaomage on 15/10/25.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"

#import "GlobeHeader.h"

#import "MBProgressHUD+XMG.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1.处理文本框业务逻辑
    RACSignal *loginEnableSiganl = [RACSignal combineLatest:@[_accountFiled.rac_textSignal,_pwdField.rac_textSignal] reduce:^id(NSString *account,NSString *pwd){
        return @(account.length && pwd.length);
    }];
    
    // 设置按钮能否点击
    RAC(_loginBtn,enabled) = loginEnableSiganl;
    
    
    // 创建登录命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block:执行命令就会调用
        // block作用:事件处理
        // 发送登录请求
        NSLog(@"发送登录请求");
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                // 发送数据
                [subscriber sendNext:@"请求登录的数据"];
                [subscriber sendCompleted];
            });
            
            return nil;
            
        }];
    }];
    
    // 获取命令中信号源
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    // 监听命令执行过程
    [[command.executing skip:1] subscribeNext:^(id x) {
       
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            // 显示蒙版
            [MBProgressHUD showMessage:@"正在登录ing.."];
            
        }else{
            // 执行完成
            // 隐藏蒙版
            [MBProgressHUD hideHUD];
            
            NSLog(@"执行完成");
        }
        
    }];
    
    
    // 监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击登录按钮");
        // 处理登录事件
        [command execute:nil];
        
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
