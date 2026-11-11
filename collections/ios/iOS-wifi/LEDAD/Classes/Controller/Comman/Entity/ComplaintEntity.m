//
//  ComplaintEntity.m
//  ZDEC
//
//  Created by yixingman on 9/7/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import "ComplaintEntity.h"

@implementation ComplaintEntity
@synthesize complaint_id;
@synthesize cus_name;
@synthesize cus_headimg;
@synthesize complaint_date; //(long时间戳)
@synthesize cus_company;
@synthesize cus_position;
@synthesize complaint_inf;
@synthesize salekey;
@synthesize isread;
-(id)init
{
    [super init];
    return self;
}
+(NSString *)forkey
{
    return  @"complaint_list";
}
@end
