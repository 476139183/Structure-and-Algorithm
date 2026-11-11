//
//  CX_CountdownViewController.m
//  LEDAD
//
//  Created by chengxu on 15/7/24.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "CX_CountdownViewController.h"
#import "MZTimerLabel.h"
@interface CX_CountdownViewController ()<MZTimerLabelDelegate>

@end

@implementation CX_CountdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
    [self viewload];
    // Do any additional setup after loading the view.
}

-(void)viewload{
    MZTimerLabel *timerExample6;

    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:60];
    timerExample6 = [[MZTimerLabel alloc] initWithLabel:lab andTimerType:MZTimerLabelTypeTimer];
    [timerExample6 setCountDownTime:80];
    timerExample6.delegate = self;
    [timerExample6 start];
    [self.view addSubview:lab];


}
- (void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{

    [self dismissViewControllerAnimated:YES completion:nil];
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
