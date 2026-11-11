//
//  NewsCenterItem.m
//  LEDMan
//
//  Created by ledmedia on 13-5-14.
//  Copyright (c) 2013年 ledmedia. All rights reserved.
//

#import "DataColumns.h"


@implementation DataColumns
@synthesize column_id;
@synthesize column_category_id;
@synthesize column_name;
@synthesize column_url;
@synthesize column_structure;

-(id)init
{
    self=[super init];
    return self;
}
+(NSString *)forkey
{
   return  @"columns";
}
@end
