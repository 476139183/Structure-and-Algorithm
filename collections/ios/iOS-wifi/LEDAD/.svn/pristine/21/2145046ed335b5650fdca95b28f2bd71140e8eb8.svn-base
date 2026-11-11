//
//  dyt_nearscreenCollectionViewCell.m
//  LEDAD
//
//  Created by laidiya on 15/7/31.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "dyt_nearscreenCollectionViewCell.h"
#import "ProjectListObject.h"
@implementation dyt_nearscreenCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self set_tableview];
        
    }
    return self;

}
-(void)review;
{
    [self.tableview reloadData];

}

-(void)set_tableview
{

    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(5, 5, 70, 40)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.contentView addSubview:self.tableview];

    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{

    if (tableView==self.tableview) {
        return self.dataarray.count;
    }else
    {
        return 0;
    }
    
    


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView==self.tableview) {
        return 20;
    }else
    {
        return 0;
    }
    

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView==self.tableview) {
        
        static  NSString *mycellname = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycellname];
        if (!cell) {
           
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycellname];
        }
        
        ProjectListObject *pro  = self.dataarray[indexPath.row];
        cell.textLabel.text = pro.project_name;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
         cell.backgroundColor = [UIColor redColor];
        return cell;
        
        
    }else
    {
        return nil;
    }

}


@end
