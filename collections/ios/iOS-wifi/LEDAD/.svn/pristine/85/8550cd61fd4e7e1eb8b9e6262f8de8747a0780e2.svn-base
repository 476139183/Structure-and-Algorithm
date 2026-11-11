//
//  DYT_Transversetableview.h
//  段雨田
//   横向tableview
//  Created by 段雨田 on 15/7/18.
//  Copyright (c) 2015年 段雨田. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dyt_projectgroup.h"
@protocol choosemiandelete<NSObject>
-(void)returemailview:(dyt_projectgroup *)grop;
@end


@interface DYT_Transversetableview : UITableView<UITableViewDelegate,UITableViewDataSource>
{
 BOOL editState;//  能移动就不能删除

}
@property(nonatomic,strong)NSMutableArray *souredata;
@property(nonatomic,assign)NSMutableArray *namearray;
@property(nonatomic,assign)NSMutableArray *iparray;
@property(nonatomic,assign)id<choosemiandelete>mydele;
-(void)replayname:(NSMutableArray *)namearr andip:(NSMutableArray *)iparr;
-(void)reloadv;
-(void)reloadview;

@end
