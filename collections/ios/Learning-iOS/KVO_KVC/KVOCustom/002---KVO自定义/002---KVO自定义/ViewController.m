//
//  ViewController.m
//  002---KVO自定义
//
//  Created by Cooci on 2018/5/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+KCKVO.h"

@interface ViewController ()
@property (nonatomic, strong) Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //KVO底层到底怎么实现?
    //1: NSKVONotifying_Person自动生成一个动态子类
    //2: 调用了Setter方法 子类重写
    //3: 消息转发

    self.p = [[Person alloc] init];
    
//    [self.p addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:nil];
    
    [self.p kc_addObserver:self forKeyPath:@"name" handler:^(id observer, NSString *keyPath, id newValue, id oldValue) {
       
        NSLog(@"%@ --- %@",newValue,oldValue);
    }];
    
//    [self.p kc_addObserver:self forKeyPath:@"age" handler:^(id observer, NSString *keyPath, id newValue, id oldValue) {
//        
//        NSLog(@"%@ --- %@",newValue,oldValue);
//    }];

    self.p.name = @"海阔天空"; //实例还是setter方法
    


}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//
//    NSLog(@"%@",change);
//}



- (void)dealloc{

    //不移除 是不是有BUG
    //    [self.p removeObserver:self forKeyPath:@"mArray"];
//    [self.p removeObserver:self forKeyPath:@"name"];

    NSLog(@"移除了");

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
