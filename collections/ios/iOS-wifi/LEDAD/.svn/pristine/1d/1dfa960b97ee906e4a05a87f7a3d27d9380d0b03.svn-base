//
//  MainDataJTOA.m
//  ZDEC
//
//  Created by yixingman on 11/7/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import "MainDataJTOA.h"
#import "MainDataEntity.h"
#import "NSString+SBJSON.h"


@implementation MainDataJTOA



+(NSArray*)adlistJsonToObject:(NSString *)jsonStr{

 
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:1];
    if (jsonStr==nil) {
        return arr;
    }
    jsonStr =[jsonStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
    NSDictionary *jsonDict = [jsonStr JSONValue];
    if (![jsonDict isKindOfClass:[NSDictionary class]]) {
        return arr;
    }
    NSArray *cus_list_Array = [jsonDict objectForKey:[MainDataEntity forkey]];
 

//    DLog(@"cus_list_Array=%@",cus_list_Array);
    if (![cus_list_Array isKindOfClass:[NSArray class]]) {
        return arr;
    }else{
        [arr removeAllObjects];
        for (NSDictionary *one_cus in cus_list_Array) {
            MainDataEntity *come = [[MainDataEntity alloc]init];
            come.item_id = [one_cus objectForKey:@"ad_id"];
            come.item_imgurl = [one_cus objectForKey:@"ad_imgurl"];
            come.item_title = [one_cus objectForKey:@"ad_title"];
            come.item_link = [one_cus objectForKey:@"ad_link"];
            come.item_type = [one_cus objectForKey:@"ad_type"];
            [arr addObject:come];
        }
        return arr;
    }
}

+(NSArray*)graidlistJsonToObject:(NSString*)jsonStr{

    
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:1];
    if (jsonStr==nil) {
        return arr;
    }
//    DLog(@"json1-=-= %@",jsonStr);
    jsonStr =[jsonStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
//    DLog(@"json2-=-= %@",jsonStr);
    NSDictionary *jsonDict = [jsonStr JSONValue];
    if (![jsonDict isKindOfClass:[NSDictionary class]]) {
        return arr;
    }
    NSArray *cus_list_Array = [jsonDict objectForKey:[MainDataEntity forkey]];
   
    
 
    
    //DLog(@"graidlist=%@",cus_list_Array);
    if (![cus_list_Array isKindOfClass:[NSArray class]]) {
        return arr;
    }else{
        [arr removeAllObjects];
        for (NSDictionary *one_cus in cus_list_Array) {
            MainDataEntity *come = [[MainDataEntity alloc]init];
            come.item_id = [NSString stringWithFormat:@"%@",[one_cus objectForKey:@"menu_id"]];
            come.item_imgurl = [one_cus objectForKey:@"menu_imgurl"];
            come.item_title = [one_cus objectForKey:@"menu_title"];
            come.item_link = [one_cus objectForKey:@"menu_link"];
            come.item_type = [one_cus objectForKey:@"menu_type"];
            [arr addObject:come];
        }
        return arr;
    }
}

@end
