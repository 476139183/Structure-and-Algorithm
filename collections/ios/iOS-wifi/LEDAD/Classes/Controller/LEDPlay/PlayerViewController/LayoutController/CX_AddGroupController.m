//
//  CX_AddGroupController.m
//  LEDAD
//
//  Created by duanyutian on 15/6/29.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "CX_AddGroupController.h"

@interface CX_AddGroupController ()

@end

@implementation CX_AddGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
    
    [self viewload];
    
    // Do any additional setup after loading the view.
}

//视图加载
-(void)viewload{
    NSInteger groupwidth = self.view.frame.size.width/4;
    NSInteger groupheigh = self.view.frame.size.height/9;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(groupwidth, groupheigh, groupwidth*2, groupheigh*7)];
    view.backgroundColor = [UIColor whiteColor];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height/12)];
    view1.backgroundColor = [UIColor brownColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 70, view1.frame.size.height-20)];
    label.text = @"新建组";
    label.font = [UIFont systemFontOfSize:18];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width-50, 10, view1.frame.size.height-20, view1.frame.size.height-20)];
    [btn setImage:[UIImage imageNamed:@"xx"] forState:0];
    [btn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    UITextField *textfiield = [[UITextField alloc]initWithFrame:CGRectMake(30, view1.frame.origin.y+view1.frame.size.height+20, view.frame.size.width-60, 35)];
    textfiield.placeholder = @"请输入分组的名称";
    textfiield.borderStyle = UITextBorderStyleBezel;
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(textfiield.frame.origin.x, textfiield.frame.origin.y + textfiield.frame.size.height + 10, (textfiield.frame.size.width - 20)/2, textfiield.frame.size.height)];
    label1.text = @"分组信息";
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(label1.frame.origin.x + label1.frame.size.width +20, label1.frame.origin.y, label1.frame.size.width, label1.frame.size.height)];
    label2.text = @"已有素材";
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(label1.frame.origin.x, label1.frame.origin.y + label1.frame.size.height + 5, label1.frame.size.width, 300)];
    view2.backgroundColor = [UIColor cyanColor];
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(label2.frame.origin.x, label2.frame.origin.y + label2.frame.size.height + 5, label2.frame.size.width, 300)];
    view3.backgroundColor = [UIColor cyanColor];
//    UIImageView *image = [UIImageView alloc]initWithFrame:CGRectMake(view2.frame.origin.x + view2.frame.size.width, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    [view addSubview:view2];
    [view addSubview:view3];
    [view addSubview:label2];
    [view addSubview:label1];
    [view addSubview:textfiield];
    [view1 addSubview:btn];
    [view1 addSubview:label];
    [view addSubview:view1];
    [self.view addSubview:view];
}

//退出添加分组页面
-(void)exit{
    [self.view removeFromSuperview];
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
