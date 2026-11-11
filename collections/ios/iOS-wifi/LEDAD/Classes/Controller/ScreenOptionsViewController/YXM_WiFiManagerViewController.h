//
//  YXM_WiFiManagerViewController.h
//  LEDAD
//
//  Created by yixingman on 14/12/30.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextField.h"
#import "BFPaperButton.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "KKProgressTimer.h"
#import "YGPSegmentedController.h"


#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>




//修改ipblock
typedef void(^edingip) (void);
//绑定block
typedef void(^bangding) (void);
//打开dhcpblick
typedef void(^xiugaidhcp) (void);


//主屏修改信道blcok
typedef void(^xiugaixindao) (void);

//主屏修改mima
typedef void(^Changepassword) (void);

//子屏打开dhcp
typedef void(^OPENDHCP) (void);

@interface YXM_WiFiManagerViewController : UIViewController<UITextFieldDelegate,ASIHTTPRequestDelegate,KKProgressTimerDelegate,UIAlertViewDelegate>
{
    BaseTextField *wifiNameTextField;
    BaseTextField *wifiPasswordField;
    BaseTextField *wifiIptextField;
    BFPaperButton *confirmButton;
    UIButton *confirmButton1;
    UILabel *promptLabel;
    NSMutableArray *secondMenuArray;
    NSString *currentColumId;

    //2014年07月19日17:44:45云屏项目
    NSInteger admoduleHeight;
    //横向侧滑菜单
    YGPSegmentedController * _ygp;
    NSMutableArray *YGPtitleArray;
    NSString *_firstPageUrl;
    
    
    
    //表单提交的列表
//    NSMutableString *liststring;
    
    
}
extern  NSMutableString *liststring;
@property(nonatomic,copy)edingip edingip;
@property(nonatomic,copy)bangding bangding;
@property(nonatomic,copy)xiugaidhcp xiugaidhcp;
@property(nonatomic,copy)xiugaixindao xinguaixindao;
@property(nonatomic,copy)Changepassword changepassword;

@property(nonatomic,copy)OPENDHCP Opengdhcp;

@property (nonatomic, strong) NSString *lyIPdhpc;
-(void)submitButtonClicked:(NSString *)ssid;
-(void)editIP:(NSString *)ip;
-(void)editPassword;

-(void)WANsub:(NSString *)name lyid:(NSString *)Id wifipwd:(NSString *)pwd andnum:(NSInteger)num;

-(void)dhpc:(NSString *)IP1 IP2:(NSString *)IP2;
-(void)dhpcnum:(NSString *)ipnum;

-(void)dhcpipbangding:(NSMutableArray *)iparray andtag:(NSInteger )tag;

-(void)dhcpList:(NSMutableArray *)macarr;
-(void)rest;
//  恢复设置
-(void)hf;
-(void)alert:(NSString*)str alertMsg:(NSString *)msg;
- (NSString *)routerIp;
@end
