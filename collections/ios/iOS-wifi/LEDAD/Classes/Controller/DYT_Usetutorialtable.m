//
//  DYT_Usetutorialtable.m
//  LEDAD
//
//  Created by laidiya on 15/8/5.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_Usetutorialtable.h"
#import "DYT_userTableViewCell.h"
#import "dyt_projectgroup.h"
#import "Config.h"
@implementation DYT_Usetutorialtable
-(id)initWithFrame:(CGRect)frame anddeleta:(id)deleta
{

    
    self = [super initWithFrame:frame];
    if (self) {
        dataarray = [[NSMutableArray alloc]init];

        self.delegate = self;
        self.dataSource = self;
//        [self remodata];
    }
    return self;

}

-(void)remodata
{
    NSError *Error;
    NSString *Data = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[Config DPLocalizedString:@"adedit_syjc1"] ofType:@"txt"]encoding:4 error:& Error];

    
    NSMutableArray *dataarr = [self setstring:Data];
//    DLog(@"da==%@",Data);
    
    
       NSMutableArray *arr = [[NSMutableArray alloc]init];

    [dataarray removeAllObjects];
    
    
    for (int i=0; i<dataarr.count; i++) {
        if (dataarr[i] !=nil) {
            [arr addObject:dataarr[i]];
        }
    }
    
//
    [dataarray addObjectsFromArray:arr];
    
    [self reloadData];

}


//返回多少段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    DLog(@"duan----%d",dataarray.count);
    return dataarray.count;
    
}

//设置段头长
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    dyt_projectgroup * grop = dataarray[section];
    
        NSString *str = grop.name;
        UIFont *font = [UIFont systemFontOfSize:20];
    
    
    //    UIFont *font =   [UIFont fontWithName:@"Arial" size:13];
    
        CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
        
    DLog(@"----%f",size.height);
    
        return size.height+5;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    dyt_projectgroup *grop = dataarray[section];
    
    NSInteger count = grop.opened?grop.myprjectarray.count : 0;
    return count;


}
//设置段头
-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    
    //    if (tableView.tag==9009) {
    
    dyt_headview *headView = [dyt_headview headViewWithTableView:tableView];
    headView.delegate = self;
    headView.tag = section+9000;
    
    
    
    dyt_projectgroup * grop = dataarray[section];
    
    headView.prjectgroup = grop;
    
    
    return headView;
    
    //    }
    
    
    //    return nil;
    
}
- (void)clickHeadView;
{
 [self reloadData];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = [NSString stringWithFormat:@"cell%ld",indexPath.row];
    
//    static NSString *string = @"cell";
    DYT_userTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (!cell) {
        
        cell = [[DYT_userTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    dyt_projectgroup *model = dataarray[indexPath.section];
    
    cell.datastring = model.ipname;

//    cell.mymodel = model.myprjectarray;

    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    dyt_projectgroup *model = dataarray[indexPath.section];
    NSString *str = model.ipname;
    DLog(@"需要的数据 == %@",str);
    UIFont *font = [UIFont systemFontOfSize:13];
    
    
//    UIFont *font =   [UIFont fontWithName:@"Arial" size:13];
    
    CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    DLog(@"%ld",(long)size.height);
    
    
//    return size.height + (arr.count-1)*100;
    return size.height;
    

}


//获取txt

-(NSMutableArray *)setstring:(NSString *)data
{
//    获取分段
    NSArray *arrar = [data componentsSeparatedByString:@"(分段)"];
    
    NSMutableArray *dataarr = [[NSMutableArray alloc]init];
//    获取标题于正文
    for (int k=0; k<arrar.count; k++) {
        dyt_projectgroup  * dyt= [[dyt_projectgroup alloc]init];
        NSArray *arra = [arrar[k] componentsSeparatedByString:@"(标题)"];
        
        
        //标题  段头

        dyt.name = arra[0];
        
//        单元格 一个  model
        
        dyt.myprjectarray = [[NSMutableArray alloc]initWithObjects:@"段", nil];
        dyt.ipname = arra[1];
        
//
        [dataarr addObject:dyt];
    }
    
    
   DLog(@"---%@",arrar);
    return dataarr;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
