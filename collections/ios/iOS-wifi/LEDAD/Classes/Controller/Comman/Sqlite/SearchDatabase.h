//
//  SearchDatabase.h
//  LED2Buy
//
//  Created by LDY on 14-7-14.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface SearchDatabase : NSObject
{
    FMDatabase *searchDatabase;
}

/**
 *@brief 保存传入的数据
 */
-(BOOL)saveSearchDataArray:(NSString *)searchContent;

/**
 *@brief 获得所有已保存的数据
 */
-(NSMutableArray *)getAllSearchContents;

/**
 *@brief 删除所有已保存的数据
 */
-(void)deleteAllSearchContents;

@end
