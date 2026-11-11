//
//  YXM_ClientServerViewController.m
//  LEDAD
//
//  Created by chengxu on 15/3/27.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "YXM_ClientServerViewController.h"
#import "Config.h"
@interface YXM_ClientServerViewController ()<UITableViewDelegate,UITableViewDataSource>{

    UITableView *containerView;
    
}


@end

@implementation YXM_ClientServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect rectContainerView = CGRectMake(0, 0, self.view.frame.size.height - 320,self.view.frame.size.width);
//    if (OS_VERSION_FLOAT>7.9) {
//        rectContainerView = CGRectMake(0, 0, self.view.frame.size.width - 320,self.view.frame.size.height);
//    }
//
//
//
//    containerView = [[UITableView alloc]initWithFrame:rectContainerView];
//
//    NSLog(@"%f",containerView.frame.size.width);
//
//    containerView.delegate = self;
//    containerView.dataSource = self;
//
//    [self.view addSubview:containerView];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 640,  640)];
    img.image = [UIImage imageNamed:[Config DPLocalizedString:@"adedit_png"]];
    [self.view addSubview:img];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//         客服热线
    if(indexPath.row == 0){

        cell.textLabel.text = [Config DPLocalizedString:@"cell_KeFuReXian"];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(150, 38, 300, 20)];
        lab.text = @"0755-83408216";

        [cell addSubview:lab];
//         客服邮箱
    }else if (indexPath.row == 1){

        cell.textLabel.text = [Config DPLocalizedString:@"cell_KeFuE_Mail"];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(150, 38, 300, 20)];
        lab.text = @"sqdeng@zdec.com";
        [cell addSubview:lab];


//         投诉邮箱
    }else if (indexPath.row == 2){

        cell.textLabel.text = [Config DPLocalizedString:@"cell_JianYi"];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(150, 38, 300, 20)];
        lab.text = @"sqdeng@ledmedia.info";

        [cell addSubview:lab];


//         新浪微博
    }else if (indexPath.row == 3){
        

        cell.textLabel.text = [Config DPLocalizedString:@"cell_WeiBo"];

        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(150, 38, 350, 20)];
        lab.text = @"莱帝亚软件 http://weibo.com/u/5198037204";
        [cell addSubview:lab];


//        论坛客服
    }else if (indexPath.row == 4){

        cell.textLabel.text = [Config DPLocalizedString:@"cell_LunTanKeFu"];

        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(150, 38, 300, 20)];

        lab.text = @"LEDMedia";

        [cell addSubview:lab];



    }





    //联系客服

//    "cell_KeFuReXian" = "客服热线";
//    "cell_KeFuE_Mail" = "客服邮箱";
//    "cell_JianYi" = "投诉建议";
//    "cell_WeiBo" = "新浪微博";
//    "cell_LunTanKeFu" = "论坛客服";



    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100.0;
    
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
