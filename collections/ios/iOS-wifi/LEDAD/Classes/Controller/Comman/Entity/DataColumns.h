//
//  NewsCenterItem.h
//  LEDMan
//
//  Created by ledmedia on 13-5-14.
//  Copyright (c) 2013年 ledmedia. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface DataColumns : NSObject
{
    NSString *column_id;
    NSString *column_category_id;
    NSString *column_name;
    NSString *column_url;
    NSString *column_structure;
}
@property(nonatomic,strong) NSString *column_id;
@property(nonatomic,strong) NSString *column_category_id;
@property(nonatomic,strong) NSString *column_name;
@property(nonatomic,strong) NSString *column_url;
@property(nonatomic,strong) NSString *column_structure;
+(NSString *)forkey;


@end
