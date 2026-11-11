//
//  dyt_headview.h
//  LEDAD
//
//  Created by laidiya on 15/6/30.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dyt_projectgroup.h"

@protocol HeadViewDelegate <NSObject>

@optional


- (void)clickHeadView;
- (void)makesure:(NSString *)text andtag:(NSInteger)tag;
//修改添加分组为删除分组
-(void)changedeleta:(NSInteger )tag;

@end



@interface dyt_headview : UITableViewHeaderFooterView<UITextFieldDelegate>

@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)dyt_projectgroup *prjectgroup;
@property(nonatomic,strong)id<HeadViewDelegate>delegate;
@property(nonatomic,strong)UITextField *mytext;
@property(nonatomic,strong)UIButton *makesure;
+ (instancetype)headViewWithTableView:(UITableView *)tableView;

//显示我的textview
-(void)showtext:(NSInteger)tag;
@end
