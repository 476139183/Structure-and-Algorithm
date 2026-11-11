//
//  CX_SelectIPViewController.m
//  LEDAD
//   进入屏体选择界面
//  Created by chengxu on 15/4/16.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "CX_SelectIPViewController.h"
#import "Config.h"
#import "Common.h"
#import "LayoutYXMViewController.h"
#import "YXM_SettingViewController.h"
#import "SliderViewController.h"
#import "BFPaperButton.h"


@interface CX_SelectIPViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    LayoutYXMViewController *lay;
    YXM_SettingViewController * cx;
    SliderViewController *CX;
    
    NSInteger yheigth;
}
@end

@implementation CX_SelectIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入屏体选择界面");
    
    
    lay = [[LayoutYXMViewController alloc]init];
    
    cx = [[YXM_SettingViewController alloc]init];
    [self initload];

    // Do any additional setup after loading the view.
}

-(void)initload{
    
    
    yheigth = self.view.frame.size.height-140;
    
    
    
    
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    
    UIButton *backbutton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [backbutton setTitle:@"返回" forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(backview:) forControlEvents:UIControlEventTouchUpInside];
    backbutton.backgroundColor = [UIColor redColor];
    
    [view addSubview:backbutton];

    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-200)];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
   [view addSubview:table];

    
    NSInteger wweih = (self.view.frame.size.width-10)/3;
    NSArray *titlearray = [[NSArray alloc]initWithObjects:@"硬件检测",@"多屏同步",@"屏幕亮度", @"定时播放",@"云屏背景",@"重启云屏",@"安全退出",@"重置云屏",@"上次设置",nil];
    for (int k=0; k<9; k++) {
        BFPaperButton *button = [[BFPaperButton alloc]initWithFrame:CGRectMake(5 + wweih*(k%3), yheigth+40*(k/3), wweih-5, 35)];
        
        button.tag = 2000+k;
        [button addTarget:self action:@selector(mycontrol:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titlearray[k] forState:UIControlStateNormal];
        [view addSubview:button];

    }
    
    
    
    
    
    
//    //    多屏同步
//    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height-200, 100, 40)];
//
//
//    [btn1 setTitle:[Config DPLocalizedString:@"adedit_tongbu"] forState:UIControlStateNormal];
//    [btn1 setBackgroundImage:[UIImage imageNamed:@"btnselected"] forState:UIControlStateNormal];
//    btn1.tag = 1058;
//    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:btn1];
//
////屏幕亮度
//    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.frame.origin.x + btn1.frame.size.width + 20, self.view.frame.size.height-200, 100, 40)];
//    [btn2 setBackgroundImage:[UIImage imageNamed:@"btnselected"] forState:UIControlStateNormal];
//    [btn2 setTitle:[Config DPLocalizedString:@"adedit_brightness"] forState:UIControlStateNormal];
//    btn2.tag = 1059;
//    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    [btn2 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:btn2];
//
//
//    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.frame.origin.x , self.view.frame.size.height-150, 100, 40)];
//    [btn3 setBackgroundImage:[UIImage imageNamed:@"btnselected"] forState:UIControlStateNormal];
//    [btn3 setTitle:[Config DPLocalizedString:@"adedit_guanji"] forState:UIControlStateNormal];
//    btn3.tag = 1060;
//    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    [btn3 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:btn3];
//
//
//    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(btn3.frame.origin.x + btn3.frame.size.width + 20, self.view.frame.size.height-150, 100, 40)];
//    [btn4 setBackgroundImage:[UIImage imageNamed:@"btnselected"] forState:UIControlStateNormal];
//    [btn4 setTitle:[Config DPLocalizedString:@"adedit_chongqi"] forState:UIControlStateNormal];
//    btn4.tag = 1061;
//    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    [btn4 addTarget:self action:@selector(btnonclick:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:btn4];
   
//
}

-(void)backview:(UIButton *)sender
{

  [self dismissViewControllerAnimated:YES completion:^{
      
  }];

}

-(void)mycontrol:(BFPaperButton *)sender
{

    
    if (ipAddressString == nil) {
        
        //如没有联网
        UIAlertView *mynextalertview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_NoipError"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles: nil];
        [mynextalertview show];
        return;
    }

    
//    硬件检测
    if (sender.tag == 2000) {
        
    }

//     多屏同步
    if (sender.tag == 2001) {
        
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        [ud setObject:selectIpArr forKey:@"selectIPArr"];
        [ud setObject:selectNameArr forKey:@"selectNameArr"];
     //多屏同步
//          [lay tongBu_buttonOnClick];

    }
//  屏幕亮度
    if (sender.tag == 2002) {
        
        CX = [[SliderViewController alloc]init];
        [self.view addSubview:CX.view];
    }
    
//    定时播放
    if (sender.tag == 2003) {
        
    }
//    云屏背景
    if (sender.tag == 2004) {
        
    }
    
//    重启云屏
    if (sender.tag == 2005) {
        
//                  DLog(@"重置   ");
//            if (ipAddressString == nil) {
//                
//                //如没有联网
//                UIAlertView *mynextalertview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_NoipError"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles: nil];
//                [mynextalertview show];
//                return;
//            }
        
            //重置
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_resetscreenbutton"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptno"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptyes"], nil];
            [myAlertView setTag:TAG_ALTERVIEW_TAG_REST_SCREEN_AS_BUTTON];
            myAlertView.delegate = self;
            [myAlertView show];
        


    }
//    安全退出
    if (sender.tag == 2006) {
        
        [cx resetguanji];
    }
//    重置云屏
    if (sender.tag == 2007) {
        
        [cx resetchongqi];

    }
//      上次设置
    if (sender.tag == 2008) {
        
    }
    

}








-(void)btnonclick:(UIButton*)sender{
    
    if (ipAddressString == nil) {
        
        //如没有联网
        UIAlertView *mynextalertview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_NoipError"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles: nil];
        [mynextalertview show];
        return;
    }

    
    
    if (sender.tag == 1058) {
        
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        [ud setObject:selectIpArr forKey:@"selectIPArr"];
        [ud setObject:selectNameArr forKey:@"selectNameArr"];
         // 修改了多屏同步
//        [lay tongBu_buttonOnClick];
        
        
    }else if (sender.tag == 1059){
        CX = [[SliderViewController alloc]init];
        [self.view addSubview:CX.view];
    }else if (sender.tag == 1060){
        [cx resetguanji];
    }else if (sender.tag == 1061){
        [cx resetchongqi];
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdetify = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
    }

    //*********
    int a = (int)_ipName.count/3;
    int b = (int)_ipName.count%3;
    int c;
    int d = 0;
    if (b>0) {
        a++;
    }
    for (int i=0; i<a; i++) {
        if (i+1 == a) {
            if (b>0) {
                c = b;
            }
        }else{
            c = 3;
        }
        
        
        //创建多个连屏的按钮
        for (int j=0; j<c; j++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(5+(100+5)*j, 5+(100+5+40)*i, 100 , 100)];
            [btn setImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
//            if ([selectIpArr containsObject:_ipadress[d]]) {
//                btn.selected = YES;
//            }else{
                btn.selected = NO;
//            }
            btn.tag = d+1;
            
            [btn addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y+btn.frame.size.height+10, btn.frame.size.width, 50)];
            lab.numberOfLines = 0;
            [lab setText:[NSString stringWithFormat:@"%@",ipNameArr[d]]];
            lab.textAlignment = NSTextAlignmentLeft;
            //            UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(lab.frame.origin.x, lab.frame.origin.y+lab.frame.size.height+10, btn.frame.size.width, 40)];
            //            [lab1 setText:[NSString stringWithFormat:@"%@",ipAddressArr[d]]];
            //            [lab1 setFont:[UIFont systemFontOfSize:12]];
            //            lab1.textAlignment = NSTextAlignmentCenter;
            d++;
            [cell.contentView addSubview:lab];
            //            [viewlist addSubview:lab1];
        }
    }
    //**********
//    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
//    for (int i=0; i<selectNameArr.count; i++) {
//        if (selectNameArr[i] == _ipName[indexPath.row]) {
//            img.image = [UIImage imageNamed:@"select_No"];
//        }else{
//            img.image = [UIImage imageNamed:@"select_Yes"];
//        }
//    }
//
//    img.tag = 1995+indexPath.row;
//    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, cell.frame.size.width-40, 50)];
//    lable.text = _ipName[indexPath.row];
////    lable.tag = 2015+indexPath.row;
//    lable.textAlignment = NSTextAlignmentCenter;
//    [cell.contentView addSubview:img];
//    [cell.contentView addSubview:lable];
    return cell;
}

-(void)onclick:(UIButton *)sender{
    
    DLog(@"选择的状态%d",sender.selected);
    if (!sender.selected) {
        sender.selected = YES;;
        [sender setImage:[UIImage imageNamed:@"LEDYES"] forState:UIControlStateSelected];
        ipAddressString = _ipadress[sender.tag-1];
        [selectNameArr addObject:_ipName[sender.tag-1]];
        [selectIpArr addObject:_ipadress[sender.tag-1]];
        DLog(@"11%@  %@",selectNameArr,selectIpArr);
        DLog(@"11%@  %@",_ipadress,_ipName);
    }else{
        sender.selected = NO;
        [sender setImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
        [selectIpArr removeObject:_ipadress[sender.tag-1]];
        [selectNameArr removeObject:_ipName[sender.tag-1]];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int a = (int)_ipName.count/3;
    int b = (int)_ipName.count%3;
    if (b>0) {
        a++;
    }
    return a*150;
}



//手机版


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (alertView.tag == TAG_ALTERVIEW_TAG_REST_SCREEN_AS_BUTTON) {
        if (buttonIndex==1) {
            DLog(@"重置");
//            [self resetScreenPlayList];
        }
    }



}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *tablecell = (UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//    UIImageView *image = (UIImageView *)[tablecell viewWithTag:1995+indexPath.row];
//    if ([image.image isEqual:[UIImage imageNamed:@"select_Yes"]]) {
//        image.image = [UIImage imageNamed:@"select_No"];
//        [selectIpArr removeObject:_ipadress[indexPath.row]];
//        [selectNameArr removeObject:_ipName[indexPath.row]];
//    }else{
//        image.image = [UIImage imageNamed:@"select_Yes"];
//        ipAddressString = _ipadress[indexPath.row];
//        playerNameString = _ipName[indexPath.row];
//        [selectIpArr addObject:_ipadress[indexPath.row]];;
//        [selectNameArr addObject:_ipName[indexPath.row]];
//    }
//}

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
