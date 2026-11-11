//
//  DYT_SourcematerialUploadview.h
//  LEDAD
//
//  Created by laidiya on 15/7/24.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYT_progresstableview.h"
typedef void(^backBlockButton)(void);
@interface DYT_SourcematerialUploadview : UIView
{

    //萌版
    
    UIView *firestview;
    // 计数器
    
    NSInteger ftpnumb;

    NSMutableArray *ftparray;
    
    DYT_progresstableview *dytview;

    
}
-(id)initWithFrame:(CGRect)frame andiparr:(NSArray *)iparray andnamearr:(NSArray *)namearray;
@property(nonatomic,strong)NSArray *namearray;
@property(nonatomic,strong)NSArray *iparray;
@property(nonatomic,copy)backBlockButton back;
@end
