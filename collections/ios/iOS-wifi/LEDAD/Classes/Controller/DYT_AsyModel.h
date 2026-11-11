//
//  DYT_AsyModel.h
//  LEDAD
//
//  Created by laidiya on 15/7/20.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"
#import "Common.h"
@protocol myasydelete<NSObject>
-(void)returemydata:(NSData *)mydata;
@end
@interface DYT_AsyModel : NSObject
{
    //发送中
    BOOL isSendState;


}
//是否连接中
@property(nonatomic,assign)BOOL isConnect;

@property(nonatomic,strong)id<myasydelete>mydelegate;

//启动连接
-(void)startSocket:(NSString *)string;
-(void)startSockettow:(NSString *)string;

//获取屏幕亮度
-(void)getScreenbrightness;

//修改终端名称
-(void)changeTerminalname;

//重置云屏
-(void)ResetScreen:(NSString *)string;

//重启云屏
-(void)RestartScreen:(NSString *)string;

//安全退出
-(void)SafetySignout:(NSString *)string;

//多屏同步
-(void)moreScreensynchro:(NSData *)mydata;


//取消多连屏同步
-(void)quxiaoduolianpingtongbu:(NSString *)string;


//云屏升级的重置
-(void)Cloudscreenreset:(NSString *)string;


-(void)lianxu:(NSString *)ip;
-(void)fasong:(NSString *)ip;

-(void)commandCompleteWithType:(Byte)commandType andSendType:(Byte)sendType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength andPageNumber:(NSInteger)pageNumber;

-(void)commandResetServerWithType:(Byte)commandType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength;

//设置亮度
-(void)setscreenBrightness:(Byte)commandType andContent:(Byte[])contentBytes andContentLength:(NSInteger)contentLength and:(NSArray *)array;


@end
