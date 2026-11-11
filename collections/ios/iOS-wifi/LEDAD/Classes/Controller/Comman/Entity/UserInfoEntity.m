//
//  UserInfoEntity.m
//  ZDEC
//  用户信息
//  Created by yixingman on 9/11/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import "UserInfoEntity.h"

@implementation UserInfoEntity
@synthesize user_sid;
@synthesize user_name;
@synthesize user_headimg;
@synthesize user_position;
@synthesize user_email;
@synthesize user_phone;
@synthesize user_company;
@synthesize user_sign;
@synthesize user_alias;
@synthesize user_qq;
@synthesize content_isread;
@synthesize qr_code;
@synthesize is_salesman;
@synthesize cus_is_active;
@synthesize cus_headimage;
-(id)init
{
    [super init];
    return self;
}
+(NSString *)forkey
{
    return  @"user_list";
}
@end
