//
//  NewsCenterItemList.h
//  LEDMan
//
//  Created by ledmedia on 13-5-14.
//  Copyright (c) 2013年 ledmedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface DataCategoriesList : NSObject

+(NSMutableArray *)getDataCategoriesListList:(NSString *)urlstr;
+(void)refreshFirstMenuData:(ASIHTTPRequest *)request;
@end
