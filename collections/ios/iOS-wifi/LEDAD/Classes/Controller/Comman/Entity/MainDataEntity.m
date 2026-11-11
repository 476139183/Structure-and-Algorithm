//
//  MainDataEntity.m
//  ZDEC
//
//  Created by yixingman on 11/7/13.
//  Copyright (c) 2013 Yixingman. All rights reserved.
//

#import "MainDataEntity.h"

@implementation MainDataEntity
@synthesize item_id;
@synthesize item_imgurl;
@synthesize item_title;
@synthesize item_link;
@synthesize item_type;
-(id)init
{
    [super init];
    return self;
}
+(NSString *)forkey
{
    return  @"list";
}
@end
