//
//  CX_ DetectViewController.m
//  LEDAD
//
//  Created by chengxu on 15/8/14.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "CX_ DetectViewController.h"
#import "DYT_ScreenupgradeViewController.h"

@interface CX__DetectViewController ()

@end

@implementation CX__DetectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DYT_ScreenupgradeViewController *dyt = [[DYT_ScreenupgradeViewController alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:dyt];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [back setBackgroundImage: [UIImage imageNamed:@"dyt_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(upgback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];

    // Do any additional setup after loading the view.
}

-(void)upgback:(UIButton *)sender
{

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
