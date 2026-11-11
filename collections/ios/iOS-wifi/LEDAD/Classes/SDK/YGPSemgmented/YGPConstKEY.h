//
//  constant.h
//  demoxkb
//
//  Created by yang on 13-3-27.
//  Copyright (c) 2013年 yang. All rights reserved.
//

#ifndef demoxkb_constant_h
#define demoxkb_constant_h



#endif

#define KName @"admin"
#define KPass @"123456"
#pragma mark - device size

//计算设备物理宽度
#define Kdevicewidth [UIScreen mainScreen].bounds.size.width
//计算设备物理高度
#define Kdeviceheight [UIScreen mainScreen].bounds.size.height

//判断设备是iphone 或ipad
#define KINTEFACEIPAD ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad)
#define INTERFACE_IS_PHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 


///////////////////////
#pragma mark - - Epaper
///////////////////////

//电子报XML(日期选择)

#define KXKBHome(Column) [NSString stringWithFormat:@"http://g.xkb.com.cn/ep/%@.xml",Column]
#define KXKBNews(id) [NSString stringWithFormat:@"http://g.xkb.com.cn/news_%@.xml",id]


//电子报最新一起杂志
#define KXKBMastDate [NSString stringWithFormat:@"http://192.168.200.100/plate/index.php?c=main&a=getjson"]

#define KLog [NSString stringWithFormat:@"http://192.168.200.100/plate/index.php?c=main&a=ajaxlogin"]