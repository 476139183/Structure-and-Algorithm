//
//  NewsCenterItemList.m
//  LEDMan
//
//  Created by ledmedia on 13-5-14.
//  Copyright (c) 2013年 ledmedia. All rights reserved.
//

#import "DataItemsList.h"
#import "Json2Analysis.h"
#import "DataItems.h"
static NSMutableArray *dataitemslist;
static NSString *nextpageurl;

@implementation DataItemsList

+(NSString *)getNextPageURL
{
    if (nextpageurl==nil) {
        nextpageurl=[[NSString alloc]initWithString:@""];
    }

    return nextpageurl;
}

+(NSMutableArray *)getDataItemsList:(NSString *)urlstr
{
    if (dataitemslist==nil) {
        dataitemslist=[[NSMutableArray alloc]init];
    }
    
    if (dataitemslist.count>0) {
        [dataitemslist removeAllObjects];
    }
    [self getDataItemsNSDictionaryFromUrl:urlstr];
    NSMutableArray *dataitemslistswp=[[NSMutableArray alloc]initWithArray:dataitemslist];
    return dataitemslistswp;
}

+(void)getDataItemsNSDictionaryFromUrl:(NSString *)urlstr
{
    NSDictionary *dataitemsarray=[Json2Analysis getNSDictionaryFromZDECUrl:urlstr];
//    DLog(@"dataitemsarray 7%@",dataitemsarray);
    NSArray* URLdataitemsdictionary =[dataitemsarray objectForKey:[DataItems forkey]];
    if (URLdataitemsdictionary==nil||(![URLdataitemsdictionary isKindOfClass:[NSArray class]])) {
        return;
    }
    for (NSDictionary *dataitemsdictionary in URLdataitemsdictionary) {
//        static int i=0;
//        NSLog(@"-------------------------%d",i);
//        i++;
        DataItems *dataitems      =[[DataItems alloc]init];
        dataitems.item_id         =[dataitemsdictionary objectForKey:@"item_id"];
        dataitems.item_title      =[dataitemsdictionary objectForKey:@"item_title"];
        dataitems.item_img        =[dataitemsdictionary objectForKey:@"item_img"];
        dataitems.item_url        =[dataitemsdictionary objectForKey:@"item_url"];
        dataitems.item_time       =[dataitemsdictionary objectForKey:@"item_time"];
        dataitems.item_column_id  =[dataitemsdictionary objectForKey:@"item_column_id"];
        dataitems.item_introduce  =[dataitemsdictionary objectForKey:@"item_introduce"];
        dataitems.item_column_structure = [dataitemsdictionary objectForKey:@"item_column_structure"];
        dataitems.item_share_url = [dataitemsdictionary objectForKey:@"item_share"];
        [dataitemslist             addObject:dataitems];
    }
    DLog(@"dataitemslist =%@",dataitemslist);
    if (nextpageurl==nil) {
        nextpageurl=[[NSString alloc]initWithFormat:@""];
    }
    
    NSArray *nextpageurlARRAY=[dataitemsarray objectForKey:@"page"];
    if (nextpageurlARRAY != nil) {
        for (NSDictionary *nextpageurldictionary in nextpageurlARRAY) {
            nextpageurl=[nextpageurldictionary objectForKey:@"page_url"];
        }
        if (nextpageurl.length==0) {
            nextpageurl=@"end";
        }
        DLog(@"nextpageurl=%@",nextpageurl);
    }
}
@end
