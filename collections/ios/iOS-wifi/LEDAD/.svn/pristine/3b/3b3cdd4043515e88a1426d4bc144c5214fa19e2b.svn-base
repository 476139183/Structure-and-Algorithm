//
//  NewsCenterItemList.m
//  LEDMan
//
//  Created by ledmedia on 13-5-14.
//  Copyright (c) 2013年 ledmedia. All rights reserved.
//

#import "DataColumnsList.h"
#import "Json2Analysis.h"
#import "DataColumns.h"
static NSMutableArray *datacolumnslist;

@implementation DataColumnsList


+(NSMutableArray *)getDataColumnsList:(NSString *)urlstr
{
    if (datacolumnslist==nil) {
        datacolumnslist=[[NSMutableArray alloc]init];
    }
    if (datacolumnslist.count>0) {
        [datacolumnslist removeAllObjects];
    }
    [self getDataColumnsNSDictionaryFromUrl:urlstr];
    NSMutableArray *datacolumnslistarray=[[NSMutableArray alloc]initWithArray:datacolumnslist];
    return datacolumnslistarray;
}

+(void)getDataColumnsNSDictionaryFromUrl:(NSString *)urlstr
{
    NSDictionary *datacolumnsarray = [Json2Analysis getNSDictionaryFromZDECUrl:urlstr];
    //DLog(@" datacolumnsarray %@",datacolumnsarray);
    if (datacolumnsarray==nil||(![datacolumnsarray isKindOfClass:[NSDictionary class]])) {

        return;
    }

    NSArray* URLdatacolumnsdictionary =[datacolumnsarray objectForKey:[DataColumns forkey]];
    
    if (URLdatacolumnsdictionary==nil||(![URLdatacolumnsdictionary isKindOfClass:[NSArray class]])) {
        
        return;
    }
    
    for (NSDictionary *datacolumnsdictionary in URLdatacolumnsdictionary) {
//        static int i=0;
//        NSLog(@"DataColumns-------------------------%@",[datacolumnsdictionary objectForKey:@"column_name"]);
//        i++;
        DataColumns *datacolumns        =[[DataColumns alloc]init];
        datacolumns.column_id           =[datacolumnsdictionary objectForKey:@"column_id"];
        datacolumns.column_category_id  =[datacolumnsdictionary objectForKey:@"column_category_id"];
        datacolumns.column_name         =[datacolumnsdictionary objectForKey:@"column_name"];
        datacolumns.column_url          =[datacolumnsdictionary objectForKey:@"column_url"];
        datacolumns.column_structure    =[datacolumnsdictionary objectForKey:@"column_structure"]; 
        [datacolumnslist             addObject:datacolumns];
    }
}
@end
