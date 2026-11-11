//
//  DYT_TheNearFutureViewController.m
//  LEDAD
//  近期连屏设置
//  Created by laidiya on 15/7/30.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_TheNearFutureViewController.h"
#import "DYT_Transversetableview.h"
#import "BFPaperButton.h"
#import "DYT_nearscreentableview.h"
#import "ProjectListObject.h"
#import "dyt_nearscreenCollectionViewCell.h"
#import "DYT_progresstableview.h"
#import "Config.h"
#import "DYT_FTPmodel.h"
#import "LayoutYXMViewController.h"
#import "DYT_AsyModel.h"
static NSString *MJCollectionViewCellIdentifier = @"myCollectionCell";

@interface DYT_TheNearFutureViewController ()<dyt_qcheckdelegate,UICollectionViewDelegate,UICollectionViewDataSource,ftpprogressdelegate,choosemiandelete,myasydelete>
{
    dyt_projectgroup *mailgruop;
    
    LayoutYXMViewController *lay;

    DYT_Transversetableview *dyt_tableview;
    
    UIView *tablebaseview;
    UIView *projectbaseview;
    UICollectionView  *collectview;
    
    NSMutableArray *titlearray;
    
    NSMutableArray *ftparray;
    
    DYT_progresstableview *dytview;

    UIView *firestview;
    
    
    NSInteger ftpnumb;
}
@end

@implementation DYT_TheNearFutureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (DEVICE_IS_IPAD) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSDictionary *dic = [ud objectForKey:@"Recent"];
        DLog(@"%@",dic);
        DLog(@"%@",[[dic objectForKey:@"numberip"] objectForKey:@"name"]);

        _selectiparray = [[NSMutableArray alloc]init];
        _selectnamearray = [[NSMutableArray alloc]init];

        for (int i=0; i<[dic[@"play"] count]; i++) {
            [_selectiparray addObject:[[dic[@"play"] objectAtIndex:i] objectForKey:@"dataledip"]];
            [_selectnamearray addObject:[[dic[@"play"] objectAtIndex:i] objectForKey:@"dataname"]];
            
        }
    }
    
    lay = [[LayoutYXMViewController alloc]init];
    ftparray = [[NSMutableArray alloc]init];
    
    titlearray = [[NSMutableArray alloc]init];
    
//    获取
    for (int i=0; i<self.selectiparray.count; i++) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        [titlearray addObject:arr];
    }
    

//    加载头部
    [self setbaseview];
    
//    加载横向tableview
    [self settableview];
    
//  加载按钮 素材
    
    [self setprojectview];
    
//    加载网格
    
    [self setcollview];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//     DLog(@"=即将==%@    %@",self.selectiparray,self.selectnamearray);
   
}

-(void)setbaseview
{

    self.view.backgroundColor = [UIColor whiteColor];
    
//    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    title.text = [Config DPLocalizedString:@"adedit_jqlp"];
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
    UIButton *backbut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backbut setBackgroundImage:[UIImage imageNamed:@"dyt_back"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(clickback:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbut];
    
    
    
    

}



//设置横向
-(void)settableview
{
    
    tablebaseview = [[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 100)];
//    baseview.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:tablebaseview];
    
    
    dyt_tableview = [[DYT_Transversetableview alloc]initWithFrame:CGRectMake(10, 10, 100,self.view.frame.size.width-60)];
    dyt_tableview.mydele = self;
    [tablebaseview addSubview:dyt_tableview];
    dyt_tableview.tag = 6000;
    dyt_tableview.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    dyt_tableview.center = CGPointMake(self.view.frame.size.width/2-22, 50);
    
    NSMutableArray *namearray = [[NSMutableArray alloc]init];
    for (int i=0; i<self.selectiparray.count; i++) {
        [namearray addObject:[Config DPLocalizedString:@"adedit_jqlp1"]];
    }
    
    
    for (int i=0; i<self.selectiparray.count; i++) {
        for (int k=0; k < ipAddressArr.count; k++) {
            DLog(@"===%@",ipNameArr[k]);
            DLog(@"????====%@",self.selectiparray[i]);
            if ([ipAddressArr[k] isEqualToString:self.selectiparray[i]]) {
                [namearray replaceObjectAtIndex:i withObject:ipNameArr[k]];
//                [namearray addObject:ipNameArr[k]];
//                break;
            }else
            {
                
                
            }
        }
        
        
    }
    
    
    
    [dyt_tableview replayname:namearray andip:self.selectiparray];
    
     DLog(@"===%@    %@",self.selectiparray,self.selectnamearray);

}



//加载本地项目
-(void)setprojectview
{

    
    projectbaseview = [[UIView alloc]initWithFrame:CGRectMake(5, 200, self.view.frame.size.width-10, self.view.frame.size.height-205)];
//    projectbaseview.backgroundColor = [UIColor redColor];
    [self.view addSubview:projectbaseview];
    
//    加载按钮
    NSArray *title = [[NSArray alloc]initWithObjects:[Config DPLocalizedString:@"adedit_jqlp2"],[Config DPLocalizedString:@"adedit_jqlp3"],[Config DPLocalizedString:@"adedit_jqlp4"], nil];
    NSInteger wid = projectbaseview.frame.size.width/title.count;
    for (int i=0; i<title.count; i++) {
        BFPaperButton *buton = [[BFPaperButton alloc]initWithFrame:CGRectMake(0+wid*i, 0, wid, 30)];
        [buton setTitle:title[i] forState:UIControlStateNormal];
        buton.tag = 7200+i;
        [buton addTarget:self action:@selector(clickbutton:) forControlEvents:UIControlEventTouchUpInside];
        [projectbaseview addSubview:buton];
        
    }
    
//   加载本地列表
    DYT_nearscreentableview *tableview = [[DYT_nearscreentableview alloc]initWithFrame:CGRectMake(0, 40, projectbaseview.frame.size.width, projectbaseview.frame.size.height-45) andtag:8000];
    tableview.count = self.selectiparray.count;
    tableview.mydelegate = self;
    [projectbaseview addSubview:tableview];
    
    
    
    


}
-(void)setcollview
{

    //    加载数据
    
    
    
    
    NSInteger mywid = 50;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //每个格子的大小
    layout.itemSize = CGSizeMake(mywid, mywid);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
   

    collectview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, tablebaseview.frame.origin.y+100, self.view.frame.size.width-10, mywid) collectionViewLayout:layout];
    
     collectview.showsVerticalScrollIndicator = NO;
    collectview.showsHorizontalScrollIndicator = NO;

    collectview.backgroundColor = [UIColor whiteColor];
    
    
    [collectview registerClass:[dyt_nearscreenCollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
    
    collectview.delegate = self;
    collectview.dataSource = self;
    
    [self.view addSubview:collectview];



}





-(void)selectproject:(NSMutableArray *)grop andqchex:(BOOL)chexk
{
    
    
    
    
    
   
    
    
//    
//    for (int i=0; i<grop.count; i++) {
//        
//        ProjectListObject *pro = grop[i];
//        
//      
//        
//    }
    
    if (chexk==YES) {
//        添加项目
        [self addprojecttoarray:grop];
    }else
    {
        [self deleteprojectfromarr:grop];
        
    }
    
    DLog(@"东西-------%@",titlearray[0]);
    
    [collectview reloadData];

}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return titlearray.count;
    //       return 15;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    NSString *myCollectionCell = [NSString stringWithFormat:@"myCollectionCell%d",indexPath.row];
    dyt_nearscreenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
    
    
    cell.dataarray = titlearray[indexPath.row];
    
    [cell review];
    
    //    创建一个imageview
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(1, 1, cell.frame.size.width-2, cell.frame.size.height-20)];
//    [button setBackgroundImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"LEDYES"] forState:UIControlStateSelected];
//    //    button.myname.text = ipNameArr[indexPath.row];
//    button.tag = 5000+indexPath.row;
//    [button addTarget:self action:@selector(mysele:) forControlEvents:UIControlEventTouchUpInside];
//    
    
    
//    　接收ip
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-20, cell.frame.size.width, 20)];
//    label.tag = 6000+indexPath.row;
//    label.userInteractionEnabled = YES;
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mychangename:)];
//    
//    [label addGestureRecognizer:tap];
//    
//    label.text = ipNameArr[indexPath.row];
//    label.textColor = [UIColor lightGrayColor];
//    
    //   [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除子视图防止重叠
//    [cell.contentView addSubview:button];
//    [cell.contentView addSubview:label];
    return cell;
    
    
}



//返回
-(void)clickback:(UIButton *)sender
{

    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addprojecttoarray:(NSMutableArray *)addarray;
{
    
    for (int i=0; i<self.selectiparray.count; i++) {
        
        NSMutableArray *arr = titlearray[i];
        
        [arr addObject:addarray[i]];
    }
    


}

//删除
-(void)deleteprojectfromarr:(NSMutableArray *)deletearr
{
    
    NSMutableArray *title = [[NSMutableArray alloc]init];
    
    for (int i=0; i<self.selectiparray.count; i++) {
        
        NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:titlearray[i]];
        DLog(@"===%@",arr);
        DLog(@"好的===%@",deletearr[i]);
        ProjectListObject *pro = deletearr[i];
        for (int k=0; k<arr.count; k++) {
            ProjectListObject *pro1 = arr[k];
            if ([pro1.project_filename isEqualToString:pro.project_filename]) {
                [arr removeObject:pro1];
            }

        }
        
        DLog(@"====%d",arr.count);
        [title addObject:arr];
    }
    DLog(@"====%@",title[0]);
    [titlearray removeAllObjects];
    
    [titlearray addObjectsFromArray:title];
    
}

-(void)clickbutton:(BFPaperButton *)sender
{

    if (sender.tag==7200) {
        
        if (mailgruop==nil) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_shoose"] delegate:nil cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles: nil];
            [alert show];
            return;
        }
        

//        [lay qxzp:self.selectiparray];
        [lay tongBu_buttonOnClick:mailgruop.ipname andarr:self.selectiparray];

        
        
    }
    
//    取消多连屏同步
    
    if (sender.tag==7201) {
        [lay qxzp:self.selectiparray];
        ftpnumb = self.selectiparray.count;
        for (int i=0; i<self.selectiparray.count; i++) {
            DYT_AsyModel *dyt = [[DYT_AsyModel alloc]init];
            dyt.mydelegate = self;
            [dyt quxiaoduolianpingtongbu:self.selectiparray[i]];
        }
        
    }
    
    if (sender.tag==7202) {
        
        [self upshangc];
        
    }
    

}


-(void)upshangc
{


    [ftparray removeAllObjects];
    
    
    //  萌版
    firestview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    firestview.backgroundColor = [UIColor whiteColor];
    firestview.alpha = 0.8;
    [self.view addSubview:firestview];


    dytview = [[DYT_progresstableview alloc]initWithFrame:CGRectMake(100, 100, 200, 300)];
    dytview.data = self.selectnamearray;
    [firestview addSubview:dytview];

     ftpnumb = self.selectnamearray.count;
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

    
    
    //    ftp  创建
    for (int i=0; i<self.selectiparray.count; i++) {
        
        NSString *strip = self.selectiparray[i];
        
        NSMutableArray *arraygoup = titlearray[i];
        NSMutableArray *addgruo = [[NSMutableArray alloc]init];
        DLog(@"获取要的ip＝＝＝%@",arraygoup);
        
        for (int k=0; k<arraygoup.count ; k++) {
            ProjectListObject *pr = arraygoup[k];
            DLog(@"=======%@",pr.project_filename);
            
            [addgruo addObject:[pr.project_filename lastPathComponent]];
        }
//        for (UICollectionViewCell *cell in [screennumCV subviews]) {
//            if ([cell isKindOfClass:[UICollectionViewCell class]]) {
//                
//                UIView *headview = (UIView *)[cell.contentView viewWithTag:10000*(i+1)];
//                for (dyt_projbyt *button  in [headview subviews]) {
//                    if ([button isKindOfClass:[dyt_projbyt class]]) {
//                        DLog(@"项目名字===%@和＝＝＝%@",button.titleLabel.text,button.filename);
//                        [arraygoup addObject:button.filename];
//                        
//                    }
//                }
//                
//            }
//        }
//        
        //      获取所有信息 进行上传
        
        [self setftp:strip andgoup:addgruo andtag:i andnamehoup:self.selectnamearray[i]];
        
        
    }

    
    
}

#pragma mark-ftp上传
-(void)setftp:(NSString *)ipstr andgoup:(NSMutableArray *)gouparray andtag:(NSInteger)tag andnamehoup:(NSString *)name
{
    
    DLog(@"===%@",gouparray);
    
    DYT_FTPmodel *model = [[DYT_FTPmodel alloc]init];
    model.mytag = (tag+1)+11000;
    model.mydelegate = self;
    [model ftp:ipstr and:gouparray];
    [ftparray addObject:model];
    //    [self chuanjian:tag andnamehoup:name];
}



-(void)canleftp
{
    
    for (int i=0; i<ftparray.count; i++) {
        DYT_FTPmodel *demo = ftparray[i];
        [demo cancle];
        demo = nil;
    }
    
    [ftparray removeAllObjects];
    ftpnumb = 0;
    [dytview removeFromSuperview];
    [firestview removeFromSuperview];
    
    
}


//反馈 进度条消失
-(void)returemytag:(NSInteger )tag;
{
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

//选择主屏
-(void)returemailview:(dyt_projectgroup *)grop
{

    
    mailgruop = grop;
    
    DLog(@"----%@",mailgruop);

}

-(void)returemydata:(NSData *)mydata;
{
    ftpnumb--;
    if (ftpnumb==0) {
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_cg"] delegate:nil cancelButtonTitle:[Config DPLocalizedString:@"adedit_Done"] otherButtonTitles: nil];
        [aler show];
    }
    
    

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
