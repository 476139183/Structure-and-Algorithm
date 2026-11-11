//
//  NewsCenterItem.m
//  LEDMan
//
//  Created by ledmedia on 13-5-14.
//  Copyright (c) 2013年 ledmedia. All rights reserved.
//

#import "DataItems.h"

@implementation DataItems
@synthesize item_id;
@synthesize item_title;
@synthesize item_img;
@synthesize item_url;
@synthesize item_time;
@synthesize item_column_id;
@synthesize item_share_url;
@synthesize item_column_structure;
@synthesize item_iscollect;
@synthesize item_isdownload;
@synthesize item_introduce;
@synthesize item_project_path;
-(id)init
{
    self=[super init];
    return self;
}
+(NSString *)forkey
{
   return  @"items";
}
-(NSString *)description{
    return [[NSString alloc]initWithFormat:@"\nDataItems.item_id = %@\nDataItems.item_title = %@\nDataItems.item_img = %@\nDataItems.item_url = %@\nDataItems.item_time = %@\nDataItems.item_column_id = %@\nDataItems.item_share_url = %@\nDataItems.item_column_structure = %@\nDataItems.item_introduce = %@\nitem_project_path=%@",item_id,item_title,item_img,item_url,item_time,item_column_id,item_share_url,item_column_structure,item_introduce,item_project_path];
}
@end
