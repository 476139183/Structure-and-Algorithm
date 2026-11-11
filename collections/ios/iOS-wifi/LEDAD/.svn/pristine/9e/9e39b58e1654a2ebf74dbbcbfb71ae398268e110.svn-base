//
//  DYT_progresstableview.m
//  LEDAD
//
//  Created by laidiya on 15/7/16.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_progresstableview.h"
#import "DYT_prgressTableViewCell.h"
@implementation DYT_progresstableview
-(id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return self.data.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *indefi = @"cell";
    DYT_prgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indefi];
    
    if (!cell) {
       cell = [[DYT_prgressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indefi];
        cell.wid = self.frame.size.width;

    }

    cell.projectnamelabel.text = self.data[indexPath.row];
    cell.progresslabel.text = @"0.00M/0.00M";
    
    
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    return 80;
}

-(void)changeview:(NSInteger )row andtext:(NSString *)text andgress:(float)gress;
{
    DYT_prgressTableViewCell *dyt = (DYT_prgressTableViewCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:0]];
//    DLog(@"WODE进度是 =====%@",dyt.progresslabel.text);
    dyt.progressview.progress = gress;
    dyt.progresslabel.text = text;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
