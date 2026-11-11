//
//  DYT_AstepUploadViewController.m
//  LEDAD
//
//  Created by laidiya on 15/8/4.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_AstepUploadViewController.h"
#import "DYT_nearscreentableview.h"
#import "ProjectListObject.h"
#import "BaseButton.h"
#import "DYT_progresstableview.h"
#import "Config.h"
#import "DYT_FTPmodel.h"
@interface DYT_AstepUploadViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,dyt_qcheckdelegate,ftpprogressdelegate>
{

    UIView *firestview;
    UICollectionView  *collectview;
    NSMutableArray *ftparray;
    DYT_progresstableview *dytview;
    NSInteger ftpnumb;
    NSString *projectname;

    

}
@end
static NSString *MJCollectionViewCellIdentifier = @"myCollectionCell";

@implementation DYT_AstepUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ftparray = [[NSMutableArray alloc]init];
    
    [self setbackbutton];
    DLog(@"---%@",self.mydata);
    
    [self setcollview];
    
    
    [self setprojectmodel];
    
    
    [self setftpbutton];
    
    // Do any additional setup after loading the view.
}

-(void)setcollview
{

    
    
    NSInteger mywid = (self.view.frame.size.width-20)/3;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //每个格子的大小
    layout.itemSize = CGSizeMake(mywid, mywid);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    collectview = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 40, self.view.frame.size.width-20, self.view.frame.size.width-20) collectionViewLayout:layout];
    collectview.backgroundColor = [UIColor whiteColor];
    
    [collectview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
    collectview.delegate = self;
    collectview.dataSource = self;
    [self.view addSubview:collectview];
    
    


}

//单屏选择素材
-(void)selectproject:(NSMutableArray *)grop andqchex:(BOOL)chexk;
{
    if (chexk==YES) {
        
        [ftparray addObjectsFromArray:grop];
    }else
    {
        
        [self deleteformarr:grop];
    }
    
    DLog(@"====%lu",ftparray.count);
    
}
-(void)selectproject:(NSMutableArray *)array;
{


    
}


//本地项目 列表
-(void)setprojectmodel
{

    NSInteger hei = collectview.frame.size.height+collectview.frame.origin.y+5;
    DYT_nearscreentableview *tableview = [[DYT_nearscreentableview alloc]initWithFrame:CGRectMake(5, hei, self.view.frame.size.width-10, self.view.frame.size.height-hei-50) andtag:9000];
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    //    tableview.backgroundColor = [UIColor redColor];
    tableview.count = 1;
    tableview.mydelegate = self;
    [self.view addSubview:tableview];
    

    
    
    
    
    
}

-(void)setftpbutton
{
    
    BaseButton *ftpbutton = [[BaseButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 45, self.view.frame.size.height-35, 90, 30)];
    [ftpbutton setTitle:[Config DPLocalizedString:@"adedit_fb"] forState:UIControlStateNormal];
    ftpbutton.backgroundColor = [UIColor cyanColor];
    [ftpbutton addTarget:self action:@selector(sendproject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ftpbutton];
    

}

-(void)sendproject
{
    
    
    if (ftparray.count==0||asystring==nil) {
        UIAlertView *aletview= [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_shoose"] delegate:nil cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles: nil];
        [aletview show];
        return;
    }

    
    //  萌版
    firestview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    firestview.backgroundColor = [UIColor whiteColor];
    firestview.alpha = 0.8;
    [self.view addSubview:firestview];
    
    
    
    
    DLog(@"tfo=======%d",ftparray.count);
    
    
    
    dytview = [[DYT_progresstableview alloc]initWithFrame:CGRectMake(100, 100, 200, 300)];
    dytview.data = [[NSArray alloc]initWithObjects:@"1", nil];
    [firestview addSubview:dytview];
    
    ftpnumb = 1;
    
    
    
    //    取消按钮
    
    UIButton *canle = [[UIButton alloc]initWithFrame:CGRectMake(0, firestview.frame.size.height-50, firestview.frame.size.width, 50)];
    [canle addTarget:self action:@selector(canleftp) forControlEvents:UIControlEventTouchUpInside];
    
    [canle setBackgroundColor:[UIColor grayColor]];
    [canle setTitle:[Config DPLocalizedString:@"adedit_CancelPublish"] forState:UIControlStateNormal];
    [canle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    canle.layer.borderWidth = 1;
    canle.layer.borderColor = [UIColor blackColor].CGColor;
    //    [canle addTarget:self action:@selector(cancelPublishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [canle setAlpha:1];
    
    [firestview addSubview:canle];
    
    NSMutableArray *addgruo = [[NSMutableArray alloc]init];
    
    for (int k=0; k<ftparray.count ; k++) {
        ProjectListObject *pr = ftparray[k];
        DLog(@"项目名字=======%@",pr.project_filename);
        
        [addgruo addObject:[pr.project_filename lastPathComponent]];
        
        
    }
    
    
    [self setftp:asystring andgoup:addgruo andtag:0 andnamehoup:projectname];
    

    
    
    

}


-(void)canleftp
{
    
//    for (int i=0; i<ftparray.count; i++) {
//        DYT_FTPmodel *demo = ftparray[i];
//        [demo cancle];
//        demo = nil;
//    }
    
    [ftparray removeAllObjects];
    ftpnumb = 0;
    [dytview removeFromSuperview];
    [firestview removeFromSuperview];
    
    

}
-(void)setftp:(NSString *)ipstr andgoup:(NSMutableArray *)gouparray andtag:(NSInteger)tag andnamehoup:(NSString *)name
{
    
    DLog(@"得到的东西===%@",gouparray);
    
    
    
    DYT_FTPmodel *model = [[DYT_FTPmodel alloc]init];
    model.mytag = (tag+1)+11000;
    model.mydelegate = self;
    [model ftp:ipstr and:gouparray];
    
//    [ftparray addObject:model];
    
    
    
}
//反馈 进度条消失
-(void)returemytag:(NSInteger )tag;
{
    
    DLog(@"进度消失");
    
    ftpnumb--;
    if (ftpnumb == 0)
    {
        [dytview removeFromSuperview];
        
        [firestview removeFromSuperview];
        
        
    }
    
}
-(void)returegress:(float)flo andtag:(NSInteger)tag andstr:(NSString *)str;
{
    [dytview changeview:tag-11000 andtext:str andgress:flo];
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.mydata.count;
    //       return 15;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    NSString *myCollectionCell = [NSString stringWithFormat:@"myCollectionCell%d",indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
    
    CX_MODEL *mode = self.mydata[indexPath.row];
    
    UIButton *selebutton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, cell.frame.size.width-20, cell.frame.size.height-20)];
    selebutton.tag = 1000+indexPath.row;
    [selebutton setBackgroundImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
    [selebutton setBackgroundImage:[UIImage imageNamed:@"LEDYES"] forState:UIControlStateSelected];
    [selebutton addTarget:self action:@selector(mycellselect:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, selebutton.frame.size.height, cell.frame.size.width, 20)];
    namelabel.text = mode.name;
    
    
    [cell.contentView addSubview:selebutton];
    [cell.contentView addSubview:namelabel];
    
    
      return cell;
    
    
}

-(void)mycellselect:(UIButton *)sender
{

    
    for (int i=0; i<self.mydata.count; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i+1000];
        [button setBackgroundImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"LEDYES"] forState:UIControlStateSelected];
        button.selected = NO;
    }

    
    sender.selected = YES;
    CX_MODEL *model = self.mydata[sender.tag-1000];
    
    asystring = model.ipname;
    projectname = model.name;

    DLog(@"---%@   %@",asystring,projectname);

}



-(void)setbackbutton
{
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [back setImage:[UIImage imageNamed:@"dyt_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(bavkview) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    


}

-(void)deleteformarr:(NSMutableArray *)array
{
    
    
    
    //删除
    
    
    
    NSMutableArray *title = [[NSMutableArray alloc]initWithArray:ftparray];
    for (int i=0; i<title.count; i++) {
        
        ProjectListObject *pro = title[i];
        for (int k=0; k<array.count; k++) {
            ProjectListObject *delepro = array[k];
            if ([pro.project_filename isEqual:delepro.project_filename]) {
                [title removeObject:pro];
            }
            
        }
        
        
    }
    
    [ftparray removeAllObjects];
    [ftparray addObjectsFromArray:title];
    //        for (int i=0; i<self.selectiparray.count; i++) {
    //
    //            NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:titlearray[i]];
    //            DLog(@"===%@",arr);
    //            DLog(@"好的===%@",deletearr[i]);
    //            ProjectListObject *pro = deletearr[i];
    //            for (int k=0; k<arr.count; k++) {
    //                ProjectListObject *pro1 = arr[k];
    //                if ([pro1.project_filename isEqualToString:pro.project_filename]) {
    //                    [arr removeObject:pro1];
    //                }
    //
    //            }
    //
    //            DLog(@"====%d",arr.count);
    //            [title addObject:arr];
    //        }
    //        DLog(@"====%@",title[0]);
    //        [titlearray removeAllObjects];
    //
    //        [titlearray addObjectsFromArray:title];
    
    
    
    
    
    
    
}

-(void)showAlertView:(NSString *)title andtag:(NSInteger)tag;
{

}

-(void)bavkview
{

    
     [self dismissViewControllerAnimated:YES completion:^{
         
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
