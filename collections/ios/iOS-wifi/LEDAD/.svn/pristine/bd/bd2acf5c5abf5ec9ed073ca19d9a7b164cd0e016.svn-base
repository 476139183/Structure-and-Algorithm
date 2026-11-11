//
//  WXDataServer.m
//  8.AFN
//
//  Created by elite on 14-9-20.
//  Copyright (c) 2014年  All rights reserved.
//

#import "ForumWXDataServer.h"
#import "AFNetworking.h"
//#import "MyMD5.h"
//#import "LoginOrRegisterModel.h"
@implementation ForumWXDataServer

+ (void)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)parmas
              file:(NSMutableDictionary *)files
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail
{
    [YueLoadingView showWithInfo:@"加载中..."];
    
    // 1. 拼接地址
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", kBaseURL, urlstring];
    
    DLog(@"%@",requestURL);
    
    
    
    // 2. 编码
     NSString *encodeURL = [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    // 3. 构造一个操作对象的管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    // 3.1
    // 设置解析格式JSON，默认JSON
    // 设置解析XML [AFXMLParserResponseSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
       //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //请求方式
    if ([[method uppercaseString] isEqualToString:@"GET"]) {
        

        
       /* NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
       NSString *str =  [defaults objectForKey:@"userNamed"];
        [defaults synchronize];
        
        NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
        NSString *str2 = [defaults1 objectForKey:@"password"];
        [defaults1 synchronize];
        
        if (str != nil && str2 != nil) {
            
            NSString *str4 = [MyMD5 md5:str2];
            
            [parmas setObject:str forKey:@"dfdsjgdjlk43590435OUEIRIEWITP"];
            
            [parmas setObject:str4 forKey:@"RGJREGJOREJ435fjgj0436j54ojty"];
        }*/
        

        // 4. GET请求
        [manager GET:encodeURL
          parameters:parmas
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 [YueLoadingView dismiss];
                 NSLog(@"移除加载");
                 
                 if (success != nil) {
                     
//                     responseObject = [responseObject JSONString:responseObject];
//                     NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                   //  NSLog(@"zhaowei===%@",result);
                     success(responseObject);
                     
//                     NSLog(@"%@",operation.responseString);
//                     NSLog(@"%@",responseObject);
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
//                 NSLog(@"%@",operation.responseString);
                 
                 [YueLoadingView dismiss];
                 
                 if (fail) {
                     fail(error);
                 }
             }];
        
    }else if ([[method uppercaseString] isEqualToString:@"POST"]){
        
        if (files == nil) {
            
            [manager POST:encodeURL
               parameters:parmas
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      if (success) {
                          
                          [YueLoadingView dismiss];
                          
                          success(responseObject);
                      }
                      
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      
                      if (fail) {
                          
                          [YueLoadingView dismiss];
                          
                          fail(error);
                      }
                  }];
        }else {
            
            [manager  POST:encodeURL
                parameters:parmas
 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
     
     for (id key in files) {
         
         id value = files[key];
         
         [formData appendPartWithFileData:value
                                     name:key
                                 fileName:@"header.pang"
                                 mimeType:@"image/pang"];
         
     }
 }
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       
                       
                       [YueLoadingView dismiss];
                       
                       if (success) {
                           
                           success(responseObject);
                       }
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       
                       [YueLoadingView dismiss];
                       
                       if (fail) {
                           fail(error);
                       }
                   }];
        }
        
        
    }
   
}//数据请求


+(void)GetrequestURL:(NSString *)urlstring
              params:(NSDictionary *)parmas
             success:(void (^)(id data))success
                fail:(void (^)(NSError *error))fail;
{


    // 1. 拼接地址
    // 1. 拼接地址
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", kBaseURL, urlstring];
    NSLog(@"=======%@",requestURL);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];

    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    
    AFHTTPRequestOperation *oper = [manager GET:requestURL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    
//        NSLog(@"--------%@",responseObject);NSJSONReadingAllowFragments
        
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        

        NSString *result1 = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    
        
        NSData *JSONData = [result1 dataUsingEncoding:NSUTF8StringEncoding];
        
        
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        
//        NSDictionary *dic1111 = [result1 JSONValue] ;
        
        NSLog(@"dongdomng=====%@",responseJSON);
        NSLog(@"========%@",result1);
        success(dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"fffshujucuowu");
    }];
    
    oper.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    [oper start];

//
    
    
    
    
    
}



+(void)POSTrequestURL:(NSString *)urlstring
               params:(NSDictionary *)parmas
              success:(void (^)(id data))success
                 fail:(void (^)(NSError *error))fail;
{

  //  #define kBaseURL  @"http://192.168.1.15/"
    
    // 1. 拼接地址
    // 1. 拼接地址

    NSString *requestURL = [NSString stringWithFormat:@"%@%@", kBaseURL, urlstring];
    NSString *encodeURL = [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    DLog(@"我要的json请求＝＝＝＝%@",requestURL);

    //1.管理器
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];

    
    AFHTTPRequestOperation *oper = [manager POST:encodeURL parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //        r->block_requestSuccessful(dict);
        
        success(dict);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"shibai=====%@",error);
        fail(error);

//        r->block_requestError(error);
    }];
    oper.responseSerializer = [AFCompoundResponseSerializer serializer];
    [oper start];

    
  
    
    
//    //2.设定类型. (这里要设置request-response的类型)
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; //这个决定了下面responseObject返回的类型
////        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    //  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
//    
//    //2.设置登录参数
//    NSDictionary *dict = parmas;
//    
//    //3.发送请求
//    [manager POST:requestURL parameters:dict success: ^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        //      NSLog(@"postjson--> %@", responseObject);  //这样显示JSON的话需要设置text/plain
//        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"-----00000----%@",result);
//    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"99999999%@", error);
//    }];  
//
//


}







-(NSString *)JSONString:(NSString *)aString {
    NSMutableString *s = [NSMutableString stringWithString:aString];
    //[s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //[s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}



+ (void)requestURLs:(NSString *)urlstring
        httpMethods:(NSString *)method
             params:(NSMutableDictionary *)parmas
              files:(NSDictionary *)files
            success:(void (^)(id data))success
              fails:(void (^)(NSError *error))fail
{
    
    // 1. 拼接地址
//    NSString *requestURL = [NSString stringWithFormat:@"%@%@", kBaseURL, urlstring];
    
    // 2. 编码
    NSString *encodeURL = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 3. 构造一个操作对象的管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 3.1
    // 设置解析格式JSON，默认JSON
    // 设置解析XML [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    if ([[method uppercaseString] isEqualToString:@"GET"]) {
        
        
        
        // 4. GET请求
        [manager GET:encodeURL
          parameters:parmas
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 if (success != nil) {
                     success(responseObject);
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
                 if (fail) {
                     fail(error);
                 }
             }];
    }else if ([[method uppercaseString] isEqualToString:@"POST"]){
        
        if (files == nil) {
            
            [manager POST:encodeURL
               parameters:parmas
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      if (success != nil) {
                          
                          success(responseObject);
                      }
                      
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      
                      if (fail) {
                          
                          fail(error);
                      }
                  }];
        }else if (files != nil){
            
            [manager  POST:encodeURL
                parameters:parmas
 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
     
     for (id key in files) {
         
         id value = files[key];
         [formData appendPartWithFileData:value
                                     name:key
                                 fileName:@"header.png"
                                 mimeType:@"image/png"];
         
     }
 }
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       
                       if (success) {
                           
                           success(responseObject);
                       }
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       
                       if (fail) {
                           fail(error);
                       }
                   }];
        }
        
        
    }
    

}//版本信息


/*
+ (void)userOnLine
{
    
    //提取用户名
    NSUserDefaults *userNamed = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userNamed objectForKey:@"userNamed"];
    [userNamed synchronize];
    
    //提取用户密码
    NSUserDefaults *passWord1 = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [passWord1 objectForKey:@"password"];
    [passWord1 synchronize];
    
    //加密
    NSString *password12 = [MyMD5 md5:passWord];
    
    NSMutableDictionary *file = [@{@"mpNumber":userName,@"password":password12}mutableCopy];
    [WXDataServer requestURL:@"homeforwap/phonelogin.action"
                  httpMethod:@"GET"
                      params:file
                        file:nil
                     success:^(id data) {
                         
                         
                         
                         for (id value in data[@"result"]) {
                             
                             LoginOrRegisterModel *model = [[LoginOrRegisterModel alloc]initWithJSONDic:value];
                             
                             
                             
                             if ([model.flag isEqualToString:@"1" ]) {
                                 
                                 
                                 //持久化用户的id
                                 NSUserDefaults *usersid = [NSUserDefaults standardUserDefaults];
                                 [usersid setObject:model.usersid forKey:@"usersid"];
                                 [usersid synchronize];
                                 
                                 
                                 //登录成功后修改值
                                 NSUserDefaults *userDefault1 = [NSUserDefaults standardUserDefaults];
                                 [userDefault1 setObject:@"1" forKey:@"isStatus"];
                                 [userDefault1 synchronize];
                                 
                                 //创建单例
                                 NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                                 //存放
                                 [userDefault setObject:userName forKey:@"userNamed"];
                                 //数据持久化
                                 [userDefault synchronize];
                                 
                                 
                                 //持久化密码
                                 NSUserDefaults *userPassWord = [NSUserDefaults standardUserDefaults];
                                 [userPassWord setObject:passWord forKey:@"password"];
                                 [userPassWord synchronize];
                                 
                                 
                          
                                 
                                 
                             }else if([model.flag isEqualToString:@"0"]){
                                 
                                 
                                 
                                 NSLog(@"登录失败");
                                 
                             }
                             
                         }
                     }
                        fail:^(NSError *error) {
                            
                            
                            NSLog(@"%@",error);

                            
                        }];
    
    
    

}//用户在线
*/

@end







