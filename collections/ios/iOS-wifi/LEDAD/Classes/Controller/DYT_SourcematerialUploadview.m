//
//  DYT_SourcematerialUploadview.m
//  LEDAD
//
//  Created by laidiya on 15/7/24.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_SourcematerialUploadview.h"
#import "DYT_soureCollectionViewCell.h"
#import "DYT_gourptableview.h"
#import "Config.h"
#import "DYT_FTPmodel.h"
static NSString *MJCollectionViewCellIdentifier = @"myCollectionCell";

@interface DYT_SourcematerialUploadview ()<UICollectionViewDelegate,UICollectionViewDataSource,ftpprogressdelegate>
{
  
    UICollectionView *collnailCV;
    
}

@end




@implementation DYT_SourcematerialUploadview

-(id)initWithFrame:(CGRect)frame andiparr:(NSArray *)iparray andnamearr:(NSArray *)namearray;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        self.iparray = iparray;
        self.namearray = namearray;
        [self _setview];

    }
    
    return self;

}


- (void)_setview
{

    
    UIButton *backbutton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 35, 35)];
    [backbutton setBackgroundImage:[UIImage imageNamed:@"dyt_back"] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(backview:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backbutton];
    
    [self _setcollview];
    
    
    
    UIButton *Uploadbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 50)];
    [Uploadbutton setTitle:[Config DPLocalizedString:@"adedit_uploadproject"] forState:UIControlStateNormal];
    [Uploadbutton addTarget:self action:@selector(myuploadproject:) forControlEvents:UIControlEventTouchUpInside];
    Uploadbutton.backgroundColor = [UIColor redColor];
    [self addSubview:Uploadbutton];
    
    



}

-(void)backview:(UIButton *)sender
{
    
    self.back();
    
}



-(void)_setcollview
{
    NSInteger mywid = (self.frame.size.width-30)/3;

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //每个格子的大小
    layout.itemSize = CGSizeMake(mywid, mywid+50);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    collnailCV = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 60, self.frame.size.width  - 30, self.frame.size.height/3*2 - 30) collectionViewLayout:layout];
    collnailCV.backgroundColor = [UIColor whiteColor];
    
    [collnailCV registerClass:[DYT_soureCollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
    
    collnailCV.delegate = self;
    collnailCV.dataSource = self;
    [self addSubview:collnailCV];

  

    


}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [self.iparray count];
    //       return 15;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *myCollectionCell = [NSString stringWithFormat:@"myCollectionCell%d",indexPath.row];
    DYT_soureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.title.text = self.namearray[indexPath.row];
    cell.myip = self.iparray[indexPath.row];
    cell.mytag = indexPath.row;
    cell.backgroundColor = [UIColor orangeColor];
    
//    添加项目
    [cell addButtonAction:^(NSString *str) {
        
        [self addgoup:cell];
        
        DLog(@"==%@",str);
        
    }];
    
//    查看项目
    [cell lookButtonAction:^(NSString *str) {
        DLog(@"====%@",str);
        [self lookgoup:cell];
        
    }];
    
    
    
    
    
    return cell;
    
    
}



//查看项目
-(void)lookgoup:(DYT_soureCollectionViewCell*)cell
{

    DLog(@"查看=======%@",cell.sourearray);
    
    DYT_gourptableview *tableview = [[DYT_gourptableview alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andtag:1];
    tableview.namelabel.text = cell.title.text;
    [tableview replayview:cell.sourearray];
    [self addSubview:tableview];

    tableview.cancel = ^(NSString *str)
    {
        
        [tableview removeFromSuperview];
        
    };

    tableview.addpro = ^(NSMutableArray *myselect)
    {
    
        cell.sourearray = myselect;
    
    };

}


//添加项目
-(void)addgoup:(DYT_soureCollectionViewCell *)cell
{

       
    
    DYT_gourptableview *tableview = [[DYT_gourptableview alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) andtag:2];
    tableview.namelabel.text = cell.title.text;
    [tableview replayview:nil];
    [self addSubview:tableview];
    
    tableview.addpro = ^(NSMutableArray *myselect)
    {
    
        [cell.sourearray addObjectsFromArray:myselect];
        
        DLog(@"====%@",cell.sourearray);
        [tableview removeFromSuperview];

        
    };
    tableview.cancel = ^(NSString *str)
    {
    
        [tableview removeFromSuperview];

    };

}

//上传
-(void)myuploadproject:(UIButton *)sender
{

    
    ftparray = [[NSMutableArray alloc]init];
    //  萌版
    firestview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    firestview.backgroundColor = [UIColor clearColor];
    
    [self addSubview:firestview];

    
    UIView *nextview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, firestview.frame.size.width, firestview.frame.size.height)];
    nextview.backgroundColor = [UIColor whiteColor];
    nextview.alpha = 0.8;
    [firestview addSubview:nextview];

     ftpnumb = selectIpArr.count;
    
    
    if (dytview) {
        [dytview  removeFromSuperview];
    }
    
    dytview = [[DYT_progresstableview alloc]initWithFrame:CGRectMake(100, 100, 200, 300)];
    dytview.data = selectNameArr;
    [firestview addSubview:dytview];

    
    
    
    
    //    取消按钮
    
    UIButton *canle = [[UIButton alloc]initWithFrame:CGRectMake(0, firestview.frame.size.height-50, firestview.frame.size.width, 50)];
    [canle addTarget:self action:@selector(stopftp) forControlEvents:UIControlEventTouchUpInside];

    [canle setBackgroundColor:[UIColor grayColor]];
    [canle setTitle:[Config DPLocalizedString:@"adedit_CancelPublish"] forState:UIControlStateNormal];
    [canle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    canle.layer.borderWidth = 1;
    canle.layer.borderColor = [UIColor blackColor].CGColor;
    //    [canle addTarget:self action:@selector(cancelPublishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [canle setAlpha:1];
    
    [firestview addSubview:canle];


    for (DYT_soureCollectionViewCell *dyt_cell in [collnailCV subviews]) {
       
        if ([dyt_cell isKindOfClass:[DYT_soureCollectionViewCell class]]) {
            DLog(@"====== %@",NSStringFromClass(dyt_cell.class));

            
            
            
            
            //      获取所有信息 进行上传
            
            [self setftp:dyt_cell.myip andgoup:dyt_cell.sourearray andtag:dyt_cell.mytag andnamehoup:selectNameArr[dyt_cell.mytag]];

            
        }
        
            
            
            
            
            
        
    }
    
    

}


#pragma mark-ftp上传
-(void)setftp:(NSString *)ipstr andgoup:(NSMutableArray *)gouparray andtag:(NSInteger)tag andnamehoup:(NSString *)name
{
    
    DYT_FTPmodel *model = [[DYT_FTPmodel alloc]init];
    
    model.mytag = (tag+1)+11000;
    model.mydelegate = self;
    [model ftp:ipstr and:gouparray];
    
   [ftparray addObject:model];
    
    //    [self chuanjian:tag andnamehoup:name];
}


//反馈进度条
-(void)returegress:(float)flo andtag:(NSInteger)tag andstr:(NSString *)str
{
    
    
    [dytview changeview:tag-11000 andtext:str andgress:flo];
    
    
}



//停止进度条
-(void)returemytag:(NSInteger)tag
{
    
    ftpnumb--;
    DLog(@"===%d",ftpnumb);
    if (ftpnumb == 0)
    {
        
        
        [dytview removeFromSuperview];
        
        [firestview removeFromSuperview];
    }
    
}

-(void)stopftp
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
