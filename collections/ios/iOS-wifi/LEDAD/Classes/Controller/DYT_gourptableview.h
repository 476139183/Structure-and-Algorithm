//
//  DYT_gourptableview.h
//  LEDAD
//
//  Created by laidiya on 15/7/24.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"


typedef void (^makesurebutton)(NSMutableArray *myselect);//确定按钮
typedef void(^cancelBlockButton)(NSString *str);

@interface DYT_gourptableview : UIView<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate>
{
    UITableView *_mytableview;
    NSArray *filenameArray;

}
@property(nonatomic,strong)UILabel *namelabel;
@property(nonatomic,copy)makesurebutton addpro;
@property(nonatomic,copy)cancelBlockButton cancel;
@property(nonatomic,strong)NSMutableArray *grouparray;
-(id)initWithFrame:(CGRect)frame andtag:(NSInteger)tag;
-(void)replayview:(NSArray *)array;

@end
