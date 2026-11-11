//
//  DYT_progresstableview.h
//  LEDAD
//
//  Created by laidiya on 15/7/16.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYT_progresstableview : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *data;
-(void)changeview:(NSInteger )row andtext:(NSString *)text andgress:(float)gress;
@end
