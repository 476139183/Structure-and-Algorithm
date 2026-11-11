//
//  DYT_asimodel.m
//  LEDAD
//
//  Created by laidiya on 15/7/29.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_asimodel.h"
#import "LayoutYXMViewController.h"
#import "XMLDictionary.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AFHTTPRequestOperation.h"
#import "ForumWXDataServer.h"
#import "Config.h"
#import "NSString+MD5.h"


@implementation DYT_asimodel

-(instancetype)initwith:(id)delegate
{
    
//    self = [[DYT_asimodel alloc]init];
//    
////    self = [super init];
//    
//    if (self) {
//        
//        self.delegate = delegate;
//        
//    }
//    
//    return self;
    
    return  [self initwithmydelegate:delegate];
}

-(instancetype)initwithmydelegate:(id)delegate
{
    DYT_asimodel *mymodel = [self init];
    mymodel.delegate = delegate;
    return mymodel;
    

}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
    
}


//上传文件
-(void)uploadRequstMovPath:(NSString *)movPath movName:(NSString *)movName xmlPath:(NSString *)xmlPath xmlName:(NSString *)xmlName Material:(NSString *)materialName andgourpid:(NSString *)mygroupid
{

       __block long long zsize = 0;
    

    NSString *str1 = [NSString stringWithFormat:@"http://www.ledmediasz.com/Ledad/FileUpload/%@",[movPath lastPathComponent]];
    NSString *str2 = [NSString stringWithFormat:@"http://www.ledmediasz.com/Ledad/FileUpload/%@",[xmlPath lastPathComponent]];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         mygroupid,@"GroupingID",
                         materialName,@"Material_Name",
                         str1,@"Video_url",
                         str2,@"Xml_url",
                         movName,@"VideoName",
                         xmlName,@"XmlName",
                         @"",@"Note",
                         nil];
    
    //    _alertViewWithProgressbar = [[AGAlertViewWithProgressbar alloc] initWithTitle:nil message:@"请稍等..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    //    [_alertViewWithProgressbar show];
    
    
    
    //    上传文件 路径 和素材
    ASIFormDataRequest *request_xml=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://www.ledmediasz.com/Ledad/Handler/UploadFiles.ashx"]];
    
    [request_xml setRequestMethod:@"POST"];
    [request_xml setTimeOutSeconds:60];
    [request_xml setFile:xmlPath forKey:@"Filedata"];
    request_xml.tag = 2;
    [request_xml setDelegate:self];
    [request_xml startAsynchronous];
    
    
    //    [request_xml setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
    //
    //          DLog(@"第一个=====%lld    %lld",size,total);
    //
    //    }];
    
    //
//    if ([str1 isEqualToString:str2]) {
//        <#statements#>
//    }
    
    //上传文件 素材
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://www.ledmediasz.com/Ledad/Handler/UploadFiles.ashx"]];
    //    UIProgressView *pro = [[UIProgressView alloc]init];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:60];
    request.mydic = dic;
    //    [request addFilearray:array forKey:@"Filedata"];
    [request setFile:movPath forKey:@"Filedata"];
    request.tag = 1;
    
    [request setUploadProgressDelegate:self];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    [request setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
        
        zsize += size;
        [self setgress:zsize andtotal:total andtext:materialName];
        
    }];

}

//上传到云端
- (void)requestFinished:(ASIHTTPRequest *)request{
    DLog(@"requesttag====%ld",request.tag);
    if (request.tag == 1) {
        
               if ([request.responseString isEqualToString:@"0"]) {
            
            
            [NSThread sleepForTimeInterval:1];
            
//            [self.delegate showAlertView:@"上传视频成功" andtag:self.mytag];
            
            //请求参数
            NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:request.mydic];;
//            [progressview removeFromSuperview];
            
            [ForumWXDataServer POSTrequestURL:@"Ledad/Ledad_MaterialAdd_api.aspx" params:params success:^(id data) {
                
                
                
                
                DLog(@"===data＝＝＝%@",data);
                if ([data[@"msg"] isEqualToString:@"0"]) {
                    
                    [self.delegate showAlertView:[Config DPLocalizedString:@"adedit_zc21"] andtag:self.mytag];
                    
                }else if([data[@"msg"] isEqualToString:@"2"])
                {
                    
                    [self.delegate showAlertView:data[[Config DPLocalizedString:@"adedit_zc22"]] andtag:self.mytag];
                    
                }
                
                
            } fail:^(NSError *error) {
                DLog(@"===%@",error);
                
//                [_alertViewWithProgressbar hide];
                
            }];
            
            //            ASIFormDataRequest *requestnext = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://www.ledmediasz.com/Ledad/Ledad_MaterialAdd_api.aspx"]];
            //            //构造请求头
            //            [requestnext addRequestHeader:@"Content-Type" value:@"Application/Json"];
            //            [requestnext addRequestHeader:@"charset" value:@"utf-8"];
            //            requestnext.delegate = self;
            //            requestnext.tag = 3;
            //            [requestnext setRequestMethod:@"POST"];
            //
            //            DLog(@"======%@",request.mydic);
            //
            //            if ([NSJSONSerialization isValidJSONObject:request.mydic])
            //            {
            //
            //                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:request.mydic options:NSJSONWritingPrettyPrinted error: nil];
            //
            //                NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
            //
            //                [requestnext setPostBody:tempJsonData];
            //                [requestnext startAsynchronous];
            //
            //            }
            
            
            
        }else {
            
            [self.delegate showAlertView:[Config DPLocalizedString:@"adedit_zc23"] andtag:self.mytag];
            
        }
        
    }else if(request.tag==2)
    {
        //        id data = request.responseString;
        //        NSDictionary *dict =   [self dictionaryWithJsonString: request.responseString];
        
        if ([request.responseString isEqualToString:@"0"]) {
            
//            [self.delegate showAlertView:@"上传xml成功" andtag:self.mytag];
            
        }else {
            
            [self.delegate showAlertView:[Config DPLocalizedString:@"adedit_zc24"] andtag:self.mytag];
            
        }
        
    }else if(request.tag==3)
    {
        
        
        DLog(@"=====%@",request.responseString);
        
        
    }
    
    
}



- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"%@   ====%ld",request.error,request.tag);
    
    
    [self.delegate showAlertView:[Config DPLocalizedString:@"NSString25"] andtag:self.mytag];
    
}


-(void)setgress:(long long)siez andtotal:(long long)total andtext:(NSString *)string;
{
    
       
    
    [self.delegate returegress:siez andtotal:total andtext:string andtag:self.mytag];

    

}


@end
