//
//  CompanyContactsEntity.m
//  SZLEDIA
//
//  Created by yixingman on 9/26/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import "CompanyContactsEntity.h"

@implementation CompanyContactsEntity
@synthesize con_id;
@synthesize con_headimg;
@synthesize con_name;
@synthesize con_position;//(职位)
@synthesize con_tel;
@synthesize con_office_tel;//(办公室电话)
@synthesize con_email;
@synthesize con_qq;
@synthesize con_dep;//（部门）
@synthesize con_weibo;//(微博)
@synthesize con_company;//（公司或者单位）
@synthesize con_address;
@synthesize con_type;//(联系人类别，详细分类见注释)
@synthesize con_alias;//(对话所使用的别名)

-(id)init
{
    [super init];
    return self;
}
+(NSString *)forkey
{
    return  @"contacts_list";
}
@end
