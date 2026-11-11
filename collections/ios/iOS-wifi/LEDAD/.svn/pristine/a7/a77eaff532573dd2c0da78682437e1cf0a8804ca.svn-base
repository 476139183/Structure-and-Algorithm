//
//  SecondMenuDataFilter.m
//  ZDEC
//
//  Created by ledmedia on 14-3-26.
//  Copyright (c) 2014年 Yixingman. All rights reserved.
//

#import "SecondMenuDataFilter.h"

@implementation SecondMenuDataFilter

/**
 *@brief 解析一个二级目录
 */
+(void)refreshSecondMenuData:(ASIHTTPRequest *)request{
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
        return;
    }
    
    NSArray *dataArray =[dataDictionary objectForKey:[DataColumns forkey]];
    if ((dataArray == nil) || (![dataArray isKindOfClass:[NSArray class]])) {
        DLog(@"返回数据非法,字典内不是包含的数组");
        return;
    }
    if (!_ColumnsDataArray) {
        _ColumnsDataArray = [[NSMutableArray alloc]init];
    }
    [_ColumnsDataArray removeAllObjects];
    for (NSDictionary *oneDataDict in dataArray) {
        DataColumns *oneDataColumns = [[DataColumns alloc]init];
        oneDataColumns.column_id = [oneDataDict objectForKey:@"column_id"];
        oneDataColumns.column_category_id = [oneDataDict objectForKey:@"column_category_id"];
        oneDataColumns.column_name = [oneDataDict objectForKey:@"column_name"];
        oneDataColumns.column_url = [oneDataDict objectForKey:@"column_url"];
        oneDataColumns.column_structure = [oneDataDict objectForKey:@"column_structure"];
        [_ColumnsDataArray addObject:oneDataColumns];
    }
    DLog(@"二级目录 = %@",_ColumnsDataArray);
}
@end
