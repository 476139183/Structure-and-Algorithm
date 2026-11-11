//
//  DYT_nearscreentableview.h
//  LEDAD
//  近期连屏的tableview
//  Created by laidiya on 15/7/30.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
#import "Group.h"

@protocol dyt_qcheckdelegate <NSObject>

-(void)selectproject:(NSMutableArray *)array;
-(void)selectproject:(NSMutableArray *)grop andqchex:(BOOL)chexk;
@end

@interface DYT_nearscreentableview : UITableView<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate>

{
    NSArray *filenameArray;

}
-(id)initWithFrame:(CGRect)frame andtag:(NSInteger)tag;

@property(nonatomic,strong)id<dyt_qcheckdelegate>mydelegate;
@property(nonatomic,assign)NSInteger count;
@end
