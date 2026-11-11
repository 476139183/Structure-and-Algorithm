//
//  NewsCenterItem.m
//  LEDMan
//
//  Created by ledmedia on 13-5-14.
//  Copyright (c) 2013年 ledmedia. All rights reserved.
//

#import "DataCategories.h"

@implementation DataCategories

NSString *category_id;
NSString *category_name;
NSString *category_url;
NSString *category_img;

@synthesize category_id;
@synthesize category_name;
@synthesize category_url;
@synthesize category_img;

-(id)init
{
    self=[super init];
    return self;
}
+(NSString *)forkey
{
   return  @"categories";
}
-(NSString *)description{
    DLog(@"\nDataCategories.description:\n DataCategories.category_id = %@,\n DataCategories.category_name = %@,\n DataCategories.category_url = %@,\n DataCategories.category_img = %@",category_id,category_name,category_url,category_img);
    return @"Please Search DataCategories.description";
}
@end
