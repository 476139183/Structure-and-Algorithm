//
//  WXDataServer.h
//  8.AFN
//
//  Created by elite on 14-9-20.
//  Copyright (c) 2014年  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YueLoadingView.h"



//#define kBaseURL @"http://192.168.1.164:8080/HouseCommunity/"


//#define kBaseURL @"http://192.168.1.201:8080/"


//#define kBaseURL  @"http://114.215.111.56:8180/ykm/"


#define kBaseURL  @"http://www.ledmediasz.com/"





@interface ForumWXDataServer : NSObject

+ (void)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)parmas
              file:(NSMutableDictionary *)files
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail;










+ (void)requestURLs:(NSString *)urlstring
        httpMethods:(NSString *)method
            params:(NSMutableDictionary *)parmas
              files:(NSMutableDictionary *)files
           success:(void (^)(id data))success
              fails:(void (^)(NSError *error))fail;








+(void)GetrequestURL:(NSString *)urlstring
              params:(NSDictionary *)parmas
             success:(void (^)(id data))success
                fail:(void (^)(NSError *error))fail;

+(void)POSTrequestURL:(NSString *)urlstring
               params:(NSDictionary *)parmas
              success:(void (^)(id data))success
                 fail:(void (^)(NSError *error))fail;


//用户一直在线
//+ (void)userOnLine;






@end
