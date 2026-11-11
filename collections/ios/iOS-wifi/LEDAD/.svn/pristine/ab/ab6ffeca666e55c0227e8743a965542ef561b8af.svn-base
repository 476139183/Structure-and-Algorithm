//
//  FirstMenuDataFilter.m
//  ZDEC
//
//  Created by ledmedia on 14-3-26.
//  Copyright (c) 2014年 Yixingman. All rights reserved.
//

#import "FirstMenuDataFilter.h"

@implementation FirstMenuDataFilter

/**
 *@brief 解析以及目录的数据
 */
+(void)refreshFirstMenuData:(ASIHTTPRequest *)request{
    NSString *responseString = [request responseString];
    //返回的字符串使用过滤器过滤非法字符
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
    if (dataDictionary==nil||(![dataDictionary isKindOfClass:[NSDictionary class]])) {
        DLog(@"返回的数据非法,不是一个字典 = %@",responseString);
        return;
    }
    
    NSArray* dataArray =[dataDictionary objectForKey:[DataCategories forkey]];
    if (dataArray==nil||(![dataArray isKindOfClass:[NSArray class]])) {
        DLog(@"返回的数据非法,%@解析出来的数据不是一个数组或为空 = %@",[DataCategories forkey],responseString);
        return;
    }
    
    //解析一级目录JSON数据,生成DataCategories对象的数组
    if (!firstMenuArray) {
        firstMenuArray = [[NSMutableArray alloc]init];
    }else{
        [firstMenuArray removeAllObjects];
    }
    for (NSDictionary *oneCategoriesDict in dataArray) {
        DataCategories *oneCategories = [[DataCategories alloc]init];
        oneCategories.category_id         =[oneCategoriesDict objectForKey:@"category_id"];
        oneCategories.category_name       =[oneCategoriesDict objectForKey:@"category_name"];
        oneCategories.category_url        =[oneCategoriesDict objectForKey:@"category_url"];
        oneCategories.category_img        =[oneCategoriesDict objectForKey:@"category_img"];
        [firstMenuArray addObject:oneCategories];
        DLog(@"一级栏目数据");
        [oneCategories description];
    }
}
@end
