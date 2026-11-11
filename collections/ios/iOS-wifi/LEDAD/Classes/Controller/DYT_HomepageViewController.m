//
//  DYT_HomepageViewController.m
//  LEDAD
//
//  Created by laidiya on 15/7/20.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_HomepageViewController.h"

//#import "DYT_projectview.h"

#import "ChenXuNeedDemos.h"

#import "DYT_titlebut.h"
#import "DYT_CloudupViewController.h"
#import "DYT_screensetViewController.h"
#import "CX_iPhoneWifiViewController.h"
#import "CX_ProgramViewController.h"
#import "CX_LEDControlViewController.h"
#import "CX_SaveViewController.h"
#import "DYT_SourcematerialUploadview.h"
#import "DYT_TheNearFutureViewController.h"
#import "DYT_AstepUploadViewController.h"
#import "DYT_Usetutorialview.h"
#import "DYT_ScreenupgradeViewController.h"
#import "CX_ DetectViewController.h"
#import "VideosCenterCollectionPullViewController.h"
#import "MyButton.h"
#import "DYT_projectViewController.h"

@interface DYT_HomepageViewController ()<projectview>
{
    
//    本地项目
    DYT_projectViewController *dyt_projectview;
//    云备份
    DYT_CloudupViewController *dyt_DYT_Cloud;
    
//    使用教程
    
    VideosCenterCollectionPullViewController *useview;
    
//    设置
    DYT_screensetViewController  *dyt_screenset;
    DYT_ScreenupgradeViewController *cxsj;
    
    
    UIView *footview;
}
@end

@implementation DYT_HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setfootview];

    [self setfirstview];
    
//    [selectPhotoVC.view.superview bringSubviewToFront:selectPhotoVC.view];

    // Do any additional setup after loading the view.
}
-(void)setfirstview
{
    dyt_projectview = [[DYT_projectViewController alloc]init];
    dyt_projectview.mydelegate = self;
    
//    dyt_projectview.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60);
    
    [self.view addSubview:dyt_projectview.view];
    [self.view bringSubviewToFront:footview];
    
}


-(void)setfootview
{
    footview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60)];
    footview.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:footview];
    
    NSArray *titilenomel = [[NSArray alloc]initWithObjects:@"本地项目",@"云备份",@"培训教程",@"更多",nil];
//    NSArray *titilehight = [[NSArray alloc]initWithObjects:@"b_s",@"y_s",@"j_s", nil];

    //  文字
    NSArray *array = [[NSArray alloc]initWithObjects:[Config DPLocalizedString:@"Button_project"],[Config DPLocalizedString:@"Button_yunproject"],[Config DPLocalizedString:@"Button_syproject1"],@"更多",nil];
    
    for (int i=0; i<array.count; i++) {
        
        MyButton *button = [[MyButton alloc]initWithFrame:CGRectMake(10+(footview.frame.size.width/array.count)*i, 10, 40, 40)];
        
        [button setBackgroundImage:[UIImage imageNamed:titilenomel[i]] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:titilehight[i]] forState:UIControlStateSelected];
        [button setTitle:array[i] forState:0];
//        button.namelabel.text = array[i];
        [button addTarget:self action:@selector(showview:) forControlEvents:UIControlEventTouchUpInside];
//        [button.button addTarget:self action:@selector(showview:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 2000+i;
        button.selected = NO;
        if (i==0) {
            button.selected = YES;
        }
        [footview addSubview:button];
    }
    
}



-(void)showview:(UIButton *)sender
{
    
    [self hiddenview];
    

    for (MyButton *but in [footview subviews]) {
        but.selected = NO;
    }
    
    
    sender.selected = YES;
    
//    本地项目
    if (sender.tag==2000) {
        if (dyt_projectview) {
            for (UIView *view in [dyt_projectview.view subviews]) {
                [view removeFromSuperview];
            }

        }
        
        
//        dyt_projectview.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60);

        [dyt_projectview setloadview];
        dyt_projectview.view.hidden = NO;
        
    }
    
    
//    云备份
    if (sender.tag==2001) {
        
        if (!dyt_DYT_Cloud) {
            dyt_DYT_Cloud = [[DYT_CloudupViewController alloc]init];
            dyt_DYT_Cloud.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60);
            [self.view addSubview:dyt_DYT_Cloud.view];
            dyt_DYT_Cloud.view.hidden = YES;
        }
        
        for (UIView *view in [dyt_DYT_Cloud.view subviews]) {
            [view removeFromSuperview];
        }
        
        
        [dyt_DYT_Cloud setbaseview];
        dyt_DYT_Cloud.view.hidden = NO;
        
        
            }
    
//  使用教程
    
    if (sender.tag==2002) {
        if (useview) {
            [useview.view removeFromSuperview];
            //            useview.view.hidden = YES;
        }
            useview = [[VideosCenterCollectionPullViewController alloc]init];
            [useview.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60)];
            [self.view addSubview:useview.view];

        
        
        
//        useview.view.hidden = NO;
     
    }
    
    
    
    
//    设置
    if (sender.tag==2003) {
        
        
        
        if (!dyt_screenset) {
            
            dyt_screenset = [[DYT_screensetViewController alloc]init];
            
//            dyt_screenset.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60);
            
            [self.view addSubview:dyt_screenset.view];
            dyt_screenset.view.hidden = YES;
        }
        
            dyt_screenset.view.hidden = NO;
        
        
        
        
        
    }
    
    
    
    
    [self.view bringSubviewToFront:footview];
    
    
    
    
    
    
}



-(void)showmovview:(NSMutableArray *)array
{
    DLog(@"===",array);
    ChenXuNeedDemos *cx = [[ChenXuNeedDemos alloc]init];
    cx.filePath = [array lastObject];
    
    [self presentViewController:cx animated:YES completion:^{
        
    }];
    


}
-(void)showsj{
    UIView *view = [self.view viewWithTag:5000];
    if (view) {
        view.hidden = NO;
    }else{
        cxsj = [[DYT_ScreenupgradeViewController alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        cxsj.tag = 5000;
        [self.view addSubview:cxsj];
    }

}

-(void)showLED{
    CX_LEDControlViewController *cxled = [[CX_LEDControlViewController alloc]init];
    [self presentViewController:cxled animated:YES completion:nil];
}

-(void)showProgram{
    
    CX_ProgramViewController *cxpro = [[CX_ProgramViewController alloc]init];
    [self presentViewController:cxpro animated:YES completion:nil];
}

-(void)showwifl
{
    CX_iPhoneWifiViewController *cxwifi = [[CX_iPhoneWifiViewController alloc]init];
    [self presentViewController:cxwifi animated:YES completion:nil];
}


-(void)showpicview:(ALAsset *)asset;
{

    
    
    CX_SaveViewController *cx_save = [[CX_SaveViewController alloc]init];
    
    cx_save.asset = asset;
    
    
    cx_save.buttonOnClick=^(void){
        
        
        cx_save.view.hidden = YES;
        [dyt_projectview selfreloadview];
        
    };
    
    
    
    [self.view addSubview:cx_save.view];

 
}


//素材上传
-(void)showuploadprojectview
{

    DLog(@"===%d",selectNameArr.count);
    
    DYT_SourcematerialUploadview  *dyt_view = [[DYT_SourcematerialUploadview alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andiparr:selectIpArr andnamearr:selectNameArr];
    
    dyt_view.back = ^(void)
    {
    
        
        [dyt_view removeFromSuperview];
    
    };
    
    [self.view addSubview:dyt_view];
    [self.view bringSubviewToFront:dyt_view];

    

}

-(void)hiddenview
{

    dyt_projectview.view.hidden = YES;
    useview.view.hidden = YES;
    [selectIpArr removeAllObjects];
    [selectNameArr removeAllObjects];
    dyt_DYT_Cloud.view.hidden = YES;
    dyt_screenset.view.hidden = YES;
   

}


//近期连屏
-(void)shownearfutureview:(NSArray *)array andname:(NSArray *)name
{
    
    DYT_TheNearFutureViewController *vc = [[DYT_TheNearFutureViewController alloc]init];
    vc.strl = @"yunsi";
    DLog(@"====%@",ipAddressArr);
    DLog(@"===%@    %@",array,name);
    vc.selectiparray = [[NSMutableArray alloc]initWithArray:array];
    vc.selectnamearray = [[NSMutableArray alloc]initWithArray:name];
    
//    [vc.selectiparray addObjectsFromArray:array];
//    [vc.selectnamearray addObjectsFromArray:name];
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    

    
}

//一键 快速上传
-(void)showAstepUpload:(NSMutableArray *)array
{
    DYT_AstepUploadViewController *vc = [[DYT_AstepUploadViewController alloc]init];
    vc.mydata = array;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    



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
