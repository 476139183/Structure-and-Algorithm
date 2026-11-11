//
//  CX_WIFIViewController.m
//  LEDAD
//
//  Created by chengxu on 15/7/8.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "CX_WIFIViewController.h"
#import "CX_WIFISetViewController.h"
#import "Config.h"
#import "YXM_WiFiManagerViewController.h"

@interface CX_WIFIViewController ()
{
    UIButton *btn;
    UITextField *fid1;
    UITextField *numfid;
    UIButton *btn3;
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
}
@end

@implementation CX_WIFIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self viewload];
    // Do any additional setup after loading the view.
}


-(void)viewload{
    NSInteger viewwidth = self.view.frame.size.width/8;
    NSInteger viewheight = self.view.frame.size.height/9;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(viewwidth/2, viewheight, viewwidth*2, viewheight/2)];
    lab.text = [Config DPLocalizedString:@"adedit_wifi15"];
    lab.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:lab];
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(viewwidth/2, lab.frame.origin.y + 50, 100, lab.frame.size.height)];
    lab1.text =[Config DPLocalizedString:@"adedit_wifi16"];
    lab1.tag = 201501;
    lab1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab1];
    [self showselect:lab1];
    [self ypfa:lab1 num:1];

    lab2 = [[UILabel alloc]initWithFrame:CGRectMake(lab1.frame.origin.x + lab1.frame.size.width +viewwidth/2, lab1.frame.origin.y, 140, lab.frame.size.height)];
    lab2.text = [Config DPLocalizedString:@"adedit_wifi17"];
    lab2.tag = 201502;
    lab2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab2];
    [self showselect:lab2];
    [self ypfa:lab2 num:2];

    lab3 = [[UILabel alloc]initWithFrame:CGRectMake(lab2.frame.origin.x + lab2.frame.size.width +viewwidth/2, lab2.frame.origin.y, 300, lab.frame.size.height)];
    lab3.text = [Config DPLocalizedString:@"adedit_wifi18"];
    lab3.tag = 201503;
    lab3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab3];
    [self showselect:lab3];
    [self ypfa:lab3 num:6];
    btn = [[UIButton alloc]initWithFrame:CGRectMake(lab3.frame.origin.x + lab3.frame.size.width +viewwidth/2, lab3.frame.origin.y + lab3.frame.size.height + 20 + 100 - 45, 100, 45)];
    [btn setTitle:[Config DPLocalizedString:@"adedit_wifi19"] forState:0];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    [btn setBackgroundImage:[UIImage imageNamed:@"3"] forState:0];
    [btn addTarget:self action:@selector(qtfa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/12, btn.frame.origin.y + btn.frame.size.height + 180 - 40, 150, 40)];
    lab4.text = [Config DPLocalizedString:@"adedit_jhyp16"];
    fid1 = [[UITextField alloc]initWithFrame:CGRectMake(lab4.frame.origin.x + lab4.frame.size.width, lab4.frame.origin.y, 200, 40)];
    [fid1 setBackground:[UIImage imageNamed:@"4"]];
    btn3 = [[UIButton alloc]initWithFrame:CGRectMake(fid1.frame.origin.x + fid1.frame.size.width + 10, fid1.frame.origin.y, 90, 40)];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [btn3 setTitle:[Config DPLocalizedString:@"NSStringYes"] forState:0];
    [btn3 setTitleColor:[UIColor blackColor] forState:0];
    [btn3 addTarget:self action:@selector(name) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:lab4];
//    [self.view addSubview:fid1];
//    [self.view addSubview:btn3];

    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(lab2.frame.origin.x+100, lab4.frame.origin.y + lab4.frame.size.height + 100, 100, 45)];
    [btn4 setBackgroundImage:[UIImage imageNamed:@"3"] forState:0];
    [btn4 setTitle:[Config DPLocalizedString:@"adedit_wifi22"] forState:0];
    [btn4 setTitleColor:[UIColor blackColor] forState:0];
    [btn4 addTarget:self action:@selector(setview) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];

    UIButton *btn5 = [[UIButton alloc]initWithFrame:CGRectMake(btn4.frame.origin.x + btn4.frame.size.width + 100, btn4.frame.origin.y, 100, 45)];
    [btn5 setBackgroundImage:[UIImage imageNamed:@"3"] forState:0];
    [btn5 setTitle:[Config DPLocalizedString:@"adedit_wifi20"] forState:0];
    [btn5 setTitleColor:[UIColor blackColor] forState:0];
    [self.view addSubview:btn5];
    [btn5 addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
}

-(void)name{
    fanganname = fid1.text;
    DLog(@"=====%@",fanganname);
    
}
-(void)num{
    fangannum = [numfid.text integerValue];
    [self edit];
}

-(void)setview{
    if (fangannum == 1) {
        YXM_WiFiManagerViewController *cxwifi = [[YXM_WiFiManagerViewController alloc]init];
        [self.view addSubview:cxwifi.view];
    }else
    {
        CX_WIFISetViewController * cx = [[CX_WIFISetViewController alloc]init];
        [self presentViewController:cx animated:YES completion:nil];
    }
}

-(void)fanhui{
    [self.view removeFromSuperview];
}

-(void)qtfa{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(btn.frame.origin.x + btn.frame.size.width - 300, btn.frame.origin.y + btn.frame.size.height, 300, 180)];
    view.tag = 20150709;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    imageview.image = [UIImage imageNamed:@"5"];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 160, 45)];
    lab.text = [Config DPLocalizedString:@"adedit_wifi21"];
    lab.textAlignment = NSTextAlignmentCenter;
    numfid = [[UITextField alloc]initWithFrame:CGRectMake(lab.frame.origin.x + lab.frame.size.width, lab.frame.origin.y, 100, 45)];
    [numfid setBackground:[UIImage imageNamed:@"4"]];
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(lab.frame.origin.x + 20, lab.frame.origin.y + lab.frame.size.height + 20, 100, 40)];
    [btn1 setTitle:[Config DPLocalizedString:@"NSStringYes"] forState:0];
    [btn1 setTitleColor:[UIColor blackColor] forState:0];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [btn1 addTarget:self action:@selector(num) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(numfid.frame.origin.x, btn1.frame.origin.y , 100, 40)];
    [btn2 setTitle:[Config DPLocalizedString:@"adedit_wifi23"] forState:0];
    [btn2 setTitleColor:[UIColor blackColor] forState:0];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"2"] forState:0];
    [btn2 addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:imageview];
    [view addSubview:lab];
    [view addSubview:numfid];
    [view addSubview:btn1];
    [view addSubview:btn2];
    [self.view addSubview:view];

}

-(void)edit{
    UIView *view = [self.view viewWithTag:20150709];
    [view removeFromSuperview];
}

-(void)ypfa:(UILabel *)lab num:(NSInteger)num{
    for (int i = 0; i<num; i++) {
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(lab.frame.origin.x + 40*i ,lab.frame.origin.y + lab.frame.size.height + 20, 100, 100)];
        [btn1 setImage:[UIImage imageNamed:@"LEDYES"] forState:0];
        [btn1 addTarget:self action:@selector(xuanze:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
    }
}

-(void)xuanze:(UIButton*)sender{
    CGFloat x = sender.frame.origin.x;
    UIView *view1 = [self.view viewWithTag:201511];
    UIView *view2 = [self.view viewWithTag:201512];
    UIView *view3 = [self.view viewWithTag:201513];
    if (x>=lab1.frame.origin.x && x<lab2.frame.origin.x) {
        view1.hidden = NO;
        view2.hidden = YES;
        view3.hidden = YES;
        fangannum = 1;
    }else if (x>=lab2.frame.origin.x && x<lab3.frame.origin.x) {
        view1.hidden = YES;
        view2.hidden = NO;
        view3.hidden = YES;
        fangannum = 2;
    }else{
        view1.hidden = YES;
        view2.hidden = YES;
        view3.hidden = NO;
        fangannum = 3;
    }
}

-(void)showselect:(UILabel*)lab{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(lab.frame.origin.x-1, lab.frame.origin.y + lab.frame.size.height + 20 -1, lab.frame.size.width+2, 102)];
    view.backgroundColor = [UIColor redColor];
    view.tag = lab.tag+10;
    view.hidden = YES;
    [self.view addSubview:view];
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
