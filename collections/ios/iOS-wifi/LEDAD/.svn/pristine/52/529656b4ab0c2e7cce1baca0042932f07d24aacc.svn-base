//
//  dyt_OnefastViewController.m
//  LEDAD
//
//  Created by laidiya on 15/8/1.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "dyt_OnefastViewController.h"
#import "DYT_progresstableview.h"
#import "Config.h"
#import "DYT_FTPmodel.h"
static NSString *MJCollectionViewCellIdentifier = @"myCollectionCell";

@interface dyt_OnefastViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,dyt_qcheckdelegate,ftpprogressdelegate>
{
    UICollectionView *collectview;
    
    NSMutableArray *ftparray;
   
    
    NSString *ipstring;
    UIView *firestview;

    DYT_progresstableview *dytview;

    NSInteger ftpnumb;

    NSString *projectname;
}
@end

@implementation dyt_OnefastViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    

}
-(void)look:(UIButton *)sende
{
    if (ftparray.count==0||ipstring==nil) {
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
        DLog(@"=======%@",pr.project_filename);
        
        [addgruo addObject:[pr.project_filename lastPathComponent]];
        
        
    }

    
     [self setftp:ipstring andgoup:addgruo andtag:0 andnamehoup:projectname];
    
    
    
}

-(void)setftp:(NSString *)ipstr andgoup:(NSMutableArray *)gouparray andtag:(NSInteger)tag andnamehoup:(NSString *)name
{

    DLog(@"===%@",gouparray);
    
    
    
    DYT_FTPmodel *model = [[DYT_FTPmodel alloc]init];
    model.mytag = (tag+1)+11000;
    model.mydelegate = self;
    [model ftp:ipstr and:gouparray];
//    [ftparray addObject:model];

    

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

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ftparray = [[NSMutableArray alloc]init];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(selectLeftAction)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.title = [Config DPLocalizedString:@"adedit_zc17"];
    
    [self _setcolleview];
    
    [self _setbaseview];
    UIButton *look = [[UIButton alloc]initWithFrame:CGRectMake(100, 500, 100, 100)];
    look.backgroundColor = [UIColor redColor];
    [look addTarget:self action:@selector(look:) forControlEvents:UIControlEventTouchUpInside];
    [look setTitle:[Config DPLocalizedString:@"adedit_uploadproject"] forState:UIControlStateNormal];
    [self.view addSubview:look];

    // Do any additional setup after loading the view.
}

-(void)selectLeftAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    

}


-(void)_setbaseview
{
          
    DLog(@"====%@",self.number);
    
     
    //   加载本地列表
    DYT_nearscreentableview *tableview = [[DYT_nearscreentableview alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 40, self.view.frame.size.width/2-20, self.view.frame.size.height-45) andtag:9000];
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
//    tableview.backgroundColor = [UIColor redColor];
    tableview.count = 1;
    tableview.mydelegate = self;
    [self.view addSubview:tableview];
    

    


}

-(void)selectproject:(NSMutableArray *)grop andqchex:(BOOL)chexk;
{
    if (chexk==YES) {
        [ftparray addObjectsFromArray:grop];
    }else
    {
    
        [self deleteformarr:grop];
    }
    
    DLog(@"====%d",ftparray.count);

}

//加载网格
-(void)_setcolleview
{

    NSInteger mywid = self.view.frame.size.width/6;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //每个格子的大小
    layout.itemSize = CGSizeMake(mywid, mywid+20);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    


    
    collectview = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width/2, self.view.frame.size.height-60) collectionViewLayout:layout];
    
    
    collectview.backgroundColor = [UIColor whiteColor];
    
    [collectview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
    collectview.delegate = self;
    collectview.dataSource = self;
    
    [self.view addSubview:collectview];

    

}




#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [self.number count];
    //       return 15;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *myCollectionCell = [NSString stringWithFormat:@"myCollectionCell%d",indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
    
    dyt_projectgroup *project = self.number[indexPath.row];
    
    //    创建一个imageview
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(1, 1, cell.frame.size.width-2, cell.frame.size.height-20)];
    [button setBackgroundImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"LEDYES"] forState:UIControlStateSelected];
    //    button.myname.text = ipNameArr[indexPath.row];
    button.tag = 5000+indexPath.row;
    [button addTarget:self action:@selector(mysele:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //    　接收ip
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-20, cell.frame.size.width, 20)];
    
    label.tag = 6000+indexPath.row;
    
    label.userInteractionEnabled = YES;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mychangename:)];
//    
//    [label addGestureRecognizer:tap];
//    
    label.text = project.name;
    label.textColor = [UIColor lightGrayColor];
    
    //   [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除子视图防止重叠
    [cell.contentView addSubview:button];
    [cell.contentView addSubview:label];
    
    return cell;
    
    
}

-(void)mysele:(UIButton *)sender
{
    
    
    
    sender.selected = YES;
    
    if (sender.selected==YES) {
        
        dyt_projectgroup *projectmodel = self.number[sender.tag-5000];
        ipstring = projectmodel.ipname;
        projectname = projectmodel.name;
       
    }
    
    

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
