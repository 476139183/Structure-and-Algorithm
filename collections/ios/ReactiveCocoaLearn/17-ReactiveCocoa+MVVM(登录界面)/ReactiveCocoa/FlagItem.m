//
//  FlagItem.m
//  ReactiveCocoa
//
//  Created by yz on 15/9/25.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "FlagItem.h"

@implementation FlagItem


+ (instancetype)flagWithDict:(NSDictionary *)dict
{
    FlagItem *item = [[self alloc] init];
    
    [item setValuesForKeysWithDictionary:dict];
    
    return item;
}

@end
