//
//  CX_MACViewController.m
//  LEDAD
//
//  Created by chengxu on 15/5/21.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "CX_MACViewController.h"
#import "ASIFormDataRequest.h"
#import "Config.h"
#import "NSString+SBJSON.h"

@interface CX_MACViewController ()

@end

@implementation CX_MACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initasi];
    // Do any additional setup after loading the view.
}
//asi请求
-(void)initasi{
    
    ASIHTTPRequest *myRquest = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.ledmediasz.com/api_LED/LEDFourthStepAPI.aspx?itemid=52430"]];
    
    [myRquest setCompletionBlock:^{
        
        DLog(@"url = %@,获取项目列表请求成功 = %@",myRquest.url,[myRquest responseString]);
        
        [self initviewshow:[myRquest responseString]];
    }];
    [myRquest setFailedBlock:^{
        DLog(@"获取项目请求失败");
        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_downloadisfailed"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:nil, nil];
        [myAlertView show];
    }];
    [myRquest startAsynchronous];
}
//界面布局
-(void)initviewshow:(NSString*)jsonString{
    NSDictionary *projectDict = [jsonString JSONValue];
    DLog(@"%@",projectDict);
}

//异步请求网络数据
-(void)sendAsynchronous:(NSString*)urlStr{
    DLog(@"urlStr = %@",urlStr)
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",urlStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIHTTPRequest *asiHttp = [[ASIHTTPRequest alloc]initWithURL:url];
    asiHttp.delegate = self;
    [asiHttp startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    DLog(@"数据加载完成");
    [self parseDataItemsJsonString:request];
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    DLog(@"加载数据失败，检查网络");
    [self parseDataItemsJsonString:request];
}
-(void)parseDataItemsJsonString:(ASIHTTPRequest *)request{

    NSString *jsonString = [request responseString];
    DLog(@"222222%@",jsonString);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
