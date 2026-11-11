//
//  DYT_screensetViewController.m
//  LEDAD
//
//  Created by laidiya on 15/7/22.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_screensetViewController.h"
#import "DYT_LanguageSettingViewViewController.h"
#import "DYT_ScreenupgradeViewController.h"

#import "YXM_FeedbackViewController.h"
@interface DYT_screensetViewController ()
{
//
//    DYT_LanguageSettingViewViewController *dyt_languageview;
    
    
//    升级界面
    DYT_ScreenupgradeViewController *dyt_upview;
    

}
@end

@implementation DYT_screensetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    self.view.backgroundColor = [UIColor whiteColor];
    [self _setbaseview];
    
    
    // Do any additional setup after loading the view.
}
- (void)_setbaseview
{

    NSArray *array = [[NSArray alloc]initWithObjects:[Config DPLocalizedString:@"adedit_yy"],[Config DPLocalizedString:@"adedit_sj"],[Config DPLocalizedString:@"adedit_gy"],@"意见反馈" ,nil];
    
    NSArray *imagename = [[NSArray alloc]initWithObjects:@"语言",@"升级",@"关于",@"意见反馈", nil];
    for (int i=0; i<array.count; i++) {
        
        UIButton *shenjibutton = [[UIButton alloc]initWithFrame:CGRectMake(15, 10+(5+30)*i, 180, 30)];
        
        [shenjibutton setImage:[UIImage imageNamed:imagename[i]] forState:UIControlStateNormal];

        [shenjibutton setTitle:array[i] forState:UIControlStateNormal];
        [shenjibutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        shenjibutton.tag = 1000+i;
        [shenjibutton addTarget:self action:@selector(shenji:) forControlEvents:UIControlEventTouchUpInside];
         shenjibutton.titleEdgeInsets = UIEdgeInsetsMake(0, 25.0, 0, 0);
        shenjibutton.imageEdgeInsets =UIEdgeInsetsMake(0, 15.0, 0, 0);
        
        shenjibutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.view addSubview:shenjibutton];

        
    }
    
    
    



}


-(void)shenji:(UIButton *)sender
{
    
    if (sender.tag==1000) {
        
//        if (!dyt_languageview) {
         DYT_LanguageSettingViewViewController *dyt_languageview = [[DYT_LanguageSettingViewViewController alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [self.view addSubview:dyt_languageview];
        
            
//        }
  

        
        return;
        
    }
    
    
//    升级
    if (sender.tag==1001) {
        
        if (!dyt_upview) {
            dyt_upview = [[DYT_ScreenupgradeViewController alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            [self.view addSubview:dyt_upview];
            dyt_upview.hidden = YES;
            
        }
        dyt_upview.hidden = NO;

        
        return;
    }
    //检测版本
    if (sender.tag == 1002) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_zc18"] message:@"4.2.0" delegate:nil cancelButtonTitle:[Config DPLocalizedString:@"adedit_Done"] otherButtonTitles: nil];
        [alert show];
        
    }
    
    if (sender.tag ==1003) {
        // 意见反馈
        
        YXM_FeedbackViewController *feedback = [[YXM_FeedbackViewController alloc]init];
        
        [self presentViewController:feedback animated:YES completion:^{
            
        }];
        
        
    }
    

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
