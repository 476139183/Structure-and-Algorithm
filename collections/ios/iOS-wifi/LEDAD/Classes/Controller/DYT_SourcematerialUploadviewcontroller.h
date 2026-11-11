//
//  DYT_SourcematerialUploadviewcontroller.h
//  LEDAD
//   素材上传
//  Created by laidiya on 15/9/10.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYT_progresstableview.h"

@interface DYT_SourcematerialUploadviewcontroller : UIViewController
{
    //萌版
    
    UIView *firestview;
    // 计数器
    
    NSInteger ftpnumb;
    
    NSMutableArray *ftparray;
    
    DYT_progresstableview *dytview;

}
@property(nonatomic,strong)NSArray *myiparray;
@property(nonatomic,strong)NSArray *myipnamearray;
@end
