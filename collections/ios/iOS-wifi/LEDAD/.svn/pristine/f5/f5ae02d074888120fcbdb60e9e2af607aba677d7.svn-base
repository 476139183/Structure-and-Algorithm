//
//  VideoDataFilter.m
//  ZDEC
//
//  Created by ledmedia on 14-3-27.
//  Copyright (c) 2014年 JianYe. All rights reserved.
//

#import "VideoDataFilter.h"

@implementation VideoDataFilter

/**
 *@brief 解析视频详细页面的JSON数据,返回包含LEDVideoItem对象的数组
 */
+(NSArray *)refreshVideoData:(ASIHTTPRequest *)request{
    NSString *responseString = [request responseString];
    //过滤非法字符串
    responseString = [MyTool filterResponseString:responseString];
    
    //网络未读取到数据的时候，判断缓存是否存在，存在则读取缓存，有网络则写缓存
    NSString *urlStr = [[NSString alloc]initWithFormat:@"%@",[request url]];
    //缓存数据
    if ([responseString length]==0) {
        if ([MyTool isExistsCacheFile:urlStr]) {
            responseString=[MyTool readCacheString:urlStr];
        }
    }else{
        [MyTool writeCache:responseString requestUrl:urlStr];
    }
    
    NSDictionary *dataDictionary = [responseString JSONValue];
    if ((dataDictionary == nil) || (![dataDictionary isKindOfClass:[NSDictionary class]])) {
        DLog(@"返回数据非法,不是一个字典");
        return nil;
    }
    
    NSArray *dataArray =[dataDictionary objectForKey:[LEDVideoItem forkey]];
//    if ((dataArray == nil) || (![dataArray isKindOfClass:[NSArray class]])) {
//        DLog(@"返回数据非法,字典内不是包含的数组");
//        return nil;
//    }

    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    for (NSDictionary *oneDataDict in dataArray) {
        LEDVideoItem *oneVideoItem = [[LEDVideoItem alloc]init];
        oneVideoItem.video_id = [oneDataDict objectForKey:@"id"];
        oneVideoItem.video_title = [oneDataDict objectForKey:@"title"];
        oneVideoItem.video_length = [oneDataDict objectForKey:@"length"];
        oneVideoItem.video_Description = [oneDataDict objectForKey:@"description"];
        oneVideoItem.video_size = [oneDataDict objectForKey:@"size"];
        oneVideoItem.video_image = [oneDataDict objectForKey:@"image"];
        oneVideoItem.video_video = [oneDataDict objectForKey:@"video"];
        oneVideoItem.video_h = [oneDataDict objectForKey:@"video_h"];
        if (![oneVideoItem.video_video isKindOfClass:[NSArray class]]) {
            oneVideoItem.video_video = nil;
        }
        [tempArray addObject:oneVideoItem];
    }
    return tempArray;
}
@end
