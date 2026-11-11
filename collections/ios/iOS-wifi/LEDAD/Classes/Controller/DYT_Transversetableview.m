//
//  DYT_Transversetableview.m
//  段雨田
//
//  Created by 段雨田 on 15/7/18.
//  Copyright (c) 2015年 段雨田. All rights reserved.
//

#import "DYT_Transversetableview.h"
#import "DYT_screenTableViewCell.h"
#import "Config.h"
#import "Common.h"

@implementation DYT_Transversetableview
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
         self.showsVerticalScrollIndicator = NO;
//        self.backgroundColor = [UIColor redColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.editing = NO;
        editState = NO;
        self.souredata = [[NSMutableArray alloc]init];
//        UILongPressGestureRecognizer *longPressGR =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(myhandmove:)];
//        
//        longPressGR.allowableMovement = NO;
//        longPressGR.minimumPressDuration = 0.5;
//        [self addGestureRecognizer:longPressGR];

        
        
        
        
    }
    return self;


}

-(void)replayname:(NSMutableArray *)namearr andip:(NSMutableArray *)iparr
{
    [self.souredata  removeAllObjects];
    
    if (iparr.count!=0) {
        
        for (int i=0; i<iparr.count; i++) {
            
            dyt_projectgroup *pro = [[dyt_projectgroup alloc]init];
            pro.name = namearr[i];
            pro.ipname = iparr[i];
            pro.opened = NO;
            [self.souredata addObject:pro];
        }
        
//        self.namearray = namearr;
//        self.iparray = iparr;
    }
    [self reloadData];

}

//手动刷新
-(void)reloadview
{
    
    for (int i=0; i<ipAddressArr.count; i++) {
        NSIndexPath *indexp = [NSIndexPath indexPathForRow:i inSection:0];
        
        UITableViewCell *cell = (UITableViewCell *)[self cellForRowAtIndexPath:indexp];
         [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
    }
    
    [selectNameArr removeAllObjects];
    [selectIpArr removeAllObjects];
    [ipAddressArr removeAllObjects];
    [ipNameArr removeAllObjects];
    ipAddressString = nil;



}

//广播刷新
-(void)reloadv
{
//        for (int i=0; i<ipAddressArr.count; i++) {
//                NSIndexPath *indexp = [NSIndexPath indexPathForRow:i inSection:0];
//        
//                UITableViewCell *cell = (UITableViewCell *)[self cellForRowAtIndexPath:indexp];
//            
//                
//            }

    
    
    [self reloadData];
}
#pragma mark-单元格

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
       return  self.souredata.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    

//        NSString *string = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
//        DYT_screenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
//        if (!cell) {
//            cell = [[DYT_screenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
//        }
//    
//    
////    [cell.button addTarget:self action:@selector(clcik:) forControlEvents:UIControlEventTouchUpInside];
//    cell.button.tag = indexPath.row*1000;
//    
//     cell.button.userInteractionEnabled = YES;
//    
//    
//    cell.namelabel.text = ipNameArr[indexPath.row];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clcik:)];
//    [cell.button addGestureRecognizer:tap];
//    
//    
//    UILongPressGestureRecognizer *longPressGR =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(myhandmove:)];
//    
//    
//   
//    longPressGR.allowableMovement = NO;
//    longPressGR.minimumPressDuration = 0.5;
//    [cell.button addGestureRecognizer:longPressGR];
//
//    
//    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
//        
//        //    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
//        return cell;
// 
    
    
    static NSString *string = @"cell";
    
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    
//    清空子视图 单元格
   [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    dyt_projectgroup *pro = self.souredata[indexPath.row];
    
    cell.tag = 2000+indexPath.row;
    
    UIButton *sender = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    sender.tag = 3000+indexPath.row;
    sender.userInteractionEnabled = YES;
    [sender setBackgroundImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
    [sender setBackgroundImage:[UIImage imageNamed:@"LEDYES"] forState:UIControlStateSelected];
    sender.selected = pro.opened;
    [cell.contentView addSubview:sender];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, sender.frame.origin.y+70, 70, 20)];
    name.text =   pro.name;

    
    if (self.tag==6000 && [pro.name isEqualToString:[Config DPLocalizedString:@"adedit_jqlp1"]]) {
    name.backgroundColor = [UIColor redColor];
    }
    
    
    [cell.contentView addSubview:name];
    
    UILongPressGestureRecognizer *longPressGR =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(myhandmove:)];
    
    longPressGR.allowableMovement = NO;
    longPressGR.minimumPressDuration = 0.5;
    [cell.contentView addGestureRecognizer:longPressGR];
    
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellclcik:)];
        [sender addGestureRecognizer:tap];
    
    
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    return cell;

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
        return 84;
   
    
}


//点击按钮
-(void)cellclcik:(UITapGestureRecognizer *)tap
{
    
    
    if (self.tag==6000) {
        for (int i=0; i<self.souredata.count; i++) {
            UIButton *button = (UIButton *)[self viewWithTag:i+3000];
            [button setBackgroundImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"LEDYES"] forState:UIControlStateSelected];
            button.selected = NO;
        }
        
        UIButton *sender = (UIButton *)tap.view;

        sender.selected = YES;
     
        dyt_projectgroup *pro = self.souredata[sender.tag-3000];
        
        if (self.mydele &&[self.mydele respondsToSelector:@selector(returemailview:)]) {
            [self.mydele returemailview:pro];
        }
        

        
        return;
    }
    
    
    
    
    
    [selectIpArr removeAllObjects];
    [selectNameArr removeAllObjects];
        UIButton *sender = (UIButton *)tap.view;
    
    [sender setBackgroundImage:[UIImage imageNamed:@"LEDNO"] forState:UIControlStateNormal];
    [sender setBackgroundImage:[UIImage imageNamed:@"LEDYES"] forState:UIControlStateSelected];

    
    sender.selected = !sender.selected;
    
    
    
//    UITableViewCell *cell = (UITableViewCell *)tap.view;
    DLog(@"cell===%d   %d",sender.tag,sender.selected);
    
    
    for (int i=0; i<ipAddressArr.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+3000];
        if (button.selected ==YES) {
            dyt_projectgroup *pro = self.souredata[button.tag-3000];
            pro.opened = YES;
            [selectIpArr addObject:ipAddressArr[button.tag-3000]];
            [selectNameArr addObject:ipNameArr[button.tag-3000]];
            ipAddressString = ipAddressArr[button.tag-3000];

            
        }
    }
    
//
//    
//     sender.selected = !sender.selected;
    
//    for (int i=0; i<ipAddressArr.count; i++) {
//        NSIndexPath *indexp = [NSIndexPath indexPathForRow:i inSection:0];
//        
//        DYT_screenTableViewCell *cell = (DYT_screenTableViewCell *)[self cellForRowAtIndexPath:indexp];
//        if (cell.button.selected==YES) {
//            [selectIpArr addObject:ipAddressArr[cell.button.tag/1000]];
//            [selectNameArr addObject:ipNameArr[cell.button.tag/1000]];
//            ipAddressString = ipAddressArr[cell.button.tag/1000];
//
//        }
//        
//        
//    }
    
    
    
    
    
//    for (UIView *view in [self subviews]) {
//        if (![view isKindOfClass:[UIImageView class]]) {
//            for (DYT_screenTableViewCell *cell in [view subviews]) {
//                for (UIButton *button in [cell.contentView subviews]) {
//                    if ([button isKindOfClass:[UIButton class]]) {
//                        if (button.selected==YES) {
//                            //
//                            
//                        }
//                    }
//                  
//
//                }
//                
//
//            }
//            
//            
//           
//        }
//        
////        DLog(@"===%@",NSStringFromClass(cell.class));
//    }
    
//    for (int i=0; i<1000+ipAddressArr.count; i++) {
//        UIButton *button = (UIButton *)[self viewWithTag:i];
//        if (button.selected==YES) {
//            //        }
//        
//    }
    
//    if (sender.selected == NO) {
//        [selectIpArr addObject:ipAddressArr[sender.tag/1000]];
//        ipAddressString = ipAddressArr[sender.tag/1000];
//        [selectNameArr addObject:ipNameArr[sender.tag/1000]];
//    }else
//    {
//    
//        [selectIpArr removeObject:ipAddressArr[sender.tag/1000]];
//    }
    
    
    
   
    
    
    
}
#pragma mark-移动

-(void)myhandmove:(UILongPressGestureRecognizer *)gestureRecognizer
{
    
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        
        if (editState==NO) {
            
            DLog(@"keyi编辑");
            editState = YES;
            [self setEditing:!self.editing animated:YES];
        }else
        {
            DLog(@"可以取消移动编辑");
            
        }
        
        
        
    }
    
    
    
    
}


//返回编辑状态的style
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (!editState) {
            
            return UITableViewCellEditingStyleDelete;
            
        }else{
            
            return UITableViewCellEditingStyleNone;
        }
        
    
    
    
   
}



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    
    if (self.tag==6000) {
        
        DLog(@"====%ld  to   %ld",sourceIndexPath.row,destinationIndexPath.row);
        
        dyt_projectgroup *formgro = self.souredata[sourceIndexPath.row];
        dyt_projectgroup  *togro = self.souredata [destinationIndexPath.row];
        
        [self.souredata replaceObjectAtIndex:sourceIndexPath.row withObject:togro];
        
        [self.souredata replaceObjectAtIndex:destinationIndexPath.row withObject:formgro];
        
        
//        self.souredata repla
        
    }
    
    
    
    
    [self reloadData];
    
     [self mynoteMove];
    
   
    
    
    
}


//指定该行能够移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(editState)
        return YES;
    else
        return NO;  //如果点了删除行不能移动
}
-(void)mynoteMove
{
    DLog(@"取消移动");
    editState = NO;
    [self setEditing:!self.editing animated:YES];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
