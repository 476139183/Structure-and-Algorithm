//
//  NewsCenterItemList.m
//  LEDMan
//
//  Created by ledmedia on 13-5-14.
//  Copyright (c) 2013年 ledmedia. All rights reserved.
//

#import "LEDVideoItemsList.h"
#import "Json2Analysis.h"
#import "LEDVideoItem.h"
static NSMutableArray *ledvideolist;

@implementation LEDVideoItemsList

+(NSMutableArray *)getLEDVideoList:(NSString *)urlstr;
{
    if (ledvideolist==nil) {
        ledvideolist=[[NSMutableArray alloc]init];
    }
    if (ledvideolist.count>0) {
        [ledvideolist removeAllObjects];
    }
    
    [self getLEDVideoNSDictionaryFromUrl:urlstr];
    return ledvideolist;
}

+(void)getLEDVideoNSDictionaryFromUrl:(NSString *)urlstr
{
    NSDictionary *dataitemsarray=[Json2Analysis getNSDictionaryFromZDECUrl:urlstr];
    DLog(@"dataitemsarray=%@",dataitemsarray);
    if (dataitemsarray==nil||(![dataitemsarray isKindOfClass:[NSDictionary class]])) {
        DLog(@"ret listDictionary 6 = %@",dataitemsarray);
        return;
    }
    NSArray* URLdataitemsdictionary =[dataitemsarray objectForKey:[LEDVideoItem forkey]];
    
    DLog(@"URLdataitemsdictionary=%@",URLdataitemsdictionary);
    
    NSDictionary *dataitemsdictionary =[URLdataitemsdictionary objectAtIndex:0];
    
    DLog(@"dataitemsdictionary=%@",dataitemsdictionary);
    
    LEDVideoItem *videoitem        =[[LEDVideoItem alloc]init];
    videoitem.video_id             =[dataitemsdictionary objectForKey:@"id"];
    videoitem.video_title          =[dataitemsdictionary objectForKey:@"title"];
    videoitem.video_length         =[dataitemsdictionary objectForKey:@"length"];
    videoitem.video_Description    =[dataitemsdictionary objectForKey:@"description"];
    videoitem.video_size           =[dataitemsdictionary objectForKey:@"size"];
    videoitem.video_image          =[dataitemsdictionary objectForKey:@"image"];
    videoitem.video_video          =[dataitemsdictionary objectForKey:@"video"];
    videoitem.video_h              =[dataitemsdictionary objectForKey:@"video_h"];
    [ledvideolist             addObject:videoitem];
}
@end
