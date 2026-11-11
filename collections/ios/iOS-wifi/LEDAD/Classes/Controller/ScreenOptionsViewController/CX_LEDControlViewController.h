//
//  CX_LEDControlViewController.h
//  LEDAD
//
//  Created by chengxu on 15/7/29.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"

@interface CX_LEDControlViewController : UIViewController<AsyncSocketDelegate>
{
    //soket连接
    AsyncSocket *_sendPlayerSocket;
    //是否连接中
    BOOL isConnect;

    //当前数据区域的索引
    NSInteger _currentDataAreaIndex;
    //当前数据仓库
    NSMutableArray *_currentDataArray;
}
@end
