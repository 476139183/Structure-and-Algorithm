//
//  LEDJson2Object.m
//  LEDMan
//
//  Created by ledmedia on 13-5-14.
//  Copyright (c) 2013年 ledmedia. All rights reserved.
//

#import "Json2Analysis.h"
#import "MyTool.h"
#import "NSString+SBJSON.h"

@implementation Json2Analysis
+(NSData*)getJsonfromZDECUrl:(NSString *)urlstr
{
    @try {

        NSData *reponseData;
        if ([MyTool isExistsCacheFile:urlstr]) {
            reponseData=[MyTool readCacheData:urlstr];
        }else{
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlstr] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:10];
            reponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            if ([[[NSString alloc]initWithData:reponseData encoding:NSUTF8StringEncoding] length]==0) {
                return nil;
            }else{
                [MyTool writeCache:[[NSString alloc]initWithData:reponseData encoding:NSUTF8StringEncoding] requestUrl:urlstr];
            }
        }
        
        return reponseData;
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    @finally {
        
    }
}

+(NSDictionary*)getNSDictionaryFromZDECUrl:(NSString *)urlstr
{
    @try {
        NSData *jsonFromZdecData = [self getJsonfromZDECUrl:urlstr];
        if (jsonFromZdecData==nil) {
            return nil;
        }
//        JSONKit
//        JSONDecoder  * jsondecoder=[[JSONDecoder alloc]init];
//
//        NSDictionary * listDictionary = [jsondecoder objectWithData:jsonFromZdecData];
        
//        SBJSON
        NSString *tempString = [[NSString alloc] initWithData:jsonFromZdecData encoding:NSUTF8StringEncoding];
        tempString = [MyTool filterResponseString:tempString];
        NSDictionary * listDictionary = [tempString JSONValue];
        
        if (listDictionary==nil||(![listDictionary isKindOfClass:[NSDictionary class]])) {
//            DLog(@"ret listDictionary = %@",listDictionary);
            return nil;
        }
//        DLog(@"ret listDictionary 2 = %@",listDictionary);
        return listDictionary;
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    @finally {
        
    }
    
}
@end   
