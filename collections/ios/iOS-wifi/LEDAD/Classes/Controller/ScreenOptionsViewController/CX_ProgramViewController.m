//
//  CX_ProgramViewController.m
//  LEDAD
//
//  Created by chengxu on 15/7/22.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "CX_ProgramViewController.h"
#import "LayoutYXMViewController.h"
#import "CX_MODEL.h"
#import "CX_LYmodel.h"
#import "XMLDictionary.h"
#import "Config.h"


@interface CX_ProgramViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataArr;
    NSMutableArray *modelArr;
    UITableView *Programtable;
    UITableView *xqtable;
    NSInteger cellindex;

}
@end

@implementation CX_ProgramViewController

- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    cellindex = 0;
    dataArr = [[NSMutableArray alloc]init];
    modelArr = [[NSMutableArray alloc]init];
    [self xml];
    [self viewload];
    // Do any additional setup after loading the view.
}


-(void)viewload{
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    UIButton *fhbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 2, 40, 40)];
    [fhbtn setTitle:[Config DPLocalizedString:@"adedit_back"] forState:0];
    [fhbtn setTitleColor:[UIColor blueColor] forState:0];
    [fhbtn addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:fhbtn];
    UILabel *toptitle = [[UILabel alloc]initWithFrame:CGRectMake(fhbtn.frame.origin.x + fhbtn.frame.size.width, fhbtn.frame.origin.y, topview.frame.size.width - 100, topview.frame.size.height)];
    toptitle.text = [Config DPLocalizedString:@"adedit_ypfa1"];
    toptitle.font = [UIFont systemFontOfSize:20];
    toptitle.textAlignment = NSTextAlignmentCenter;
    topview.backgroundColor =[UIColor cyanColor];
    [topview addSubview:toptitle];
    [self.view addSubview:topview];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(topview.frame.origin.x + 1, topview.frame.size.height + 1, self.view.frame.size.width - 2, 150)];
    [image setImage:[UIImage imageNamed:@"kk"]];
    [self.view addSubview:image];
    UIView *showview = [[UIView alloc]initWithFrame:CGRectMake(topview.frame.origin.x + 1, topview.frame.size.height + 1, self.view.frame.size.width - 2, 148)];

    Programtable = [[UITableView alloc]initWithFrame:CGRectMake(1, 1, showview.frame.size.width-2, showview.frame.size.height - 2)];
    Programtable.tag = 5000;
    Programtable.delegate = self;
    Programtable.dataSource = self;
    [showview addSubview:Programtable];
    [self.view addSubview:showview];
    UILabel *mylab = [[UILabel alloc]initWithFrame:CGRectMake(10, showview.frame.origin.y + showview.frame.size.height + 10, self.view.frame.size.width - 20, 44)];
    mylab.text = [Config DPLocalizedString:@"adedit_ypfa2"];
    [self.view addSubview:mylab];
    xqtable = [[UITableView alloc]initWithFrame:CGRectMake(0, mylab.frame.origin.y + mylab.frame.size.height + 5, self.view.frame.size.width, self.view.frame.size.height - mylab.frame.origin.y - mylab.frame.size.height - 5)];
    xqtable.tag = 5001;
    xqtable.separatorStyle = UITableViewCellSelectionStyleNone;
    xqtable.delegate = self;
    xqtable.dataSource = self;
    [self.view addSubview:xqtable];
}

-(void)duoCZ:(UIButton*)sender{
    if (cellindex == 0) {

    }
}

//获取xml
-(void)xml{
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    NSArray *filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
                                                                fromDirPath:documentsDirectory AndIsGroupDir:YES];
    DLog(@"%@",filenameArray);
    for (int i = 0; i<filenameArray.count; i ++) {
        if (![[filenameArray[i] lastPathComponent] isEqualToString:@"ip.xml"]) {
            [self xmljx:filenameArray[i]];
        }
    }

}

//xml解析
-(void)xmljx:(NSString*)mypath{
    CX_MODEL *model = [[CX_MODEL alloc]init];
    NSDictionary *dataDictionary = [NSDictionary dictionaryWithXMLFile:mypath];
    DLog(@"%@",dataDictionary);
    NSDictionary *dic = [dataDictionary objectForKey:@"numberip"];
    DLog(@"%@,%@",[dic objectForKey:@"name"],[dic objectForKey:@"num"]);
    model.name = [dic objectForKey:@"name"];
    model.num = [[dic objectForKey:@"num"] integerValue];
    NSArray *arr1 = [dataDictionary objectForKey:@"play"];
    model.lyarr = [[NSMutableArray alloc]init];
    DLog(@"%@",arr1);
    for (int i = 0; i<arr1.count; i ++) {
        CX_LYmodel *lymodel = [[CX_LYmodel alloc]init];
        NSDictionary *lydic = arr1[i];
        DLog(@"===%@",lydic);
        lymodel.lytype = [[lydic objectForKey:@"dataid"] integerValue];
        lymodel.lyip = [lydic objectForKey:@"dataip"];
        lymodel.lyname = [lydic objectForKey:@"dataname"];
        [model.lyarr addObject:lymodel];
    }
    [dataArr addObject:model];
    [Programtable reloadData];
    [self data];
}



-(void)data{
    DLog(@"%@",dataArr);
    CX_MODEL *model = [[CX_MODEL alloc]init];
    model = dataArr[0];
//    CX_LYmodel *lymodel = [[CX_LYmodel alloc]init];
    modelArr = model.lyarr;
    DLog(@"%@,%@,%@",modelArr,model.lyarr,dataArr[0]);
    [xqtable reloadData];
    DLog(@"====%ld",(long)dataArr.count)
}

-(void)fanhui:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 5000) {
        return dataArr.count;
    }else{
        CX_MODEL *model = [[CX_MODEL alloc]init];
        model = dataArr[cellindex];
        return model.num;
    }

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    CX_MODEL *model = [[CX_MODEL alloc]init];
    if (tableView.tag == 5000) {
        model = dataArr[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",model.name];
    }else{
        [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        CX_LYmodel *lymodel = [[CX_LYmodel alloc]init];
        lymodel = modelArr[indexPath.row];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        [image setImage:[UIImage imageNamed:@"LEDYES"]];
        [cell addSubview:image];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 120, 50)];
        lab.text = [NSString stringWithFormat:@"%@",lymodel.lyname];
        [cell addSubview:lab];
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(120, 50, 120, 50)];
        lab1.text = [NSString stringWithFormat:@"%@",lymodel.lyip];
        [cell addSubview:lab1];
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(lab1.frame.origin.x + lab1.frame.size.width + 20, 0, cell.frame.size.width - (lab1.frame.origin.x + lab1.frame.size.width + 20) , 100)];
        lab2.text = [NSString stringWithFormat:@"%ld",(long)lymodel.lytype];
        lab2.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lab2];
    }

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 5000) {
        return 50;
    }else{
        return 100;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 5000) {
        cellindex = indexPath.row;
        CX_MODEL *model = [[CX_MODEL alloc]init];
        model = dataArr[indexPath.row];
        modelArr = model.lyarr;
        [xqtable reloadData];
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
