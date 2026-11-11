//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by xiaomage on 15/10/25.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "ViewController.h"


#import "Book.h"
#import "GlobeHeader.h"

#import "RequestViewModel.h"

@interface ViewController ()
/** 请求视图模型 */
@property (nonatomic, strong) RequestViewModel *requestVM;


@end

@implementation ViewController

- (RequestViewModel *)requestVM
{
    if (_requestVM == nil) {
        _requestVM = [[RequestViewModel alloc] init];
    }
    return _requestVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // https://api.douban.com/v2/book/search?q=%22%E7%BE%8E%E5%A5%B3%22
    
    // MVVM+ RAC
    
    
    // 发送请求
   RACSignal *signal = [self.requestVM.requestCommand execute:nil];
    
    
    [signal subscribeNext:^(id x) {
       // 模型数组
        Book *book = x[0];
        NSLog(@"%@",x[0]);
        
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
