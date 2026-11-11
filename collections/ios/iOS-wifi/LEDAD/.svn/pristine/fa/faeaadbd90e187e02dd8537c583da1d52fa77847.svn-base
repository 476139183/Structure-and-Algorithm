//
//  SearchDatabase.m
//  LED2Buy
//
//  Created by LDY on 14-7-14.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "SearchDatabase.h"

@implementation SearchDatabase

-(id)init{
    self = [super init];
    if (self) {
        /*根据路径创建数据库和表*/
        NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * path = [arr objectAtIndex:0];
        
        path = [path stringByAppendingPathComponent:@"SearchData.db"];
        searchDatabase = [FMDatabase databaseWithPath:path];
        DLog(@"%@",path);
    }
    return self;
}

-(BOOL)saveSearchDataArray:(NSString *)searchContent
{
    if (![searchDatabase open]) {
        NSLog(@"can not open dataBase!");
        return NO;
    }
    [searchDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS SearchDataArray(SearchContents TEXT(1024))"];
    [searchDatabase executeUpdate:@"INSERT INTO SearchDataArray(SearchContents) VALUES(?)",searchContent];
    
    return YES;
}

-(NSMutableArray *)getAllSearchContents
{
    if (![searchDatabase open]) {
        DLog(@"can not open dataBase!");
        return nil;
    }
    FMResultSet *result = [searchDatabase executeQuery:@"select * from SearchDataArray"];
    NSMutableArray *searchDataArray = [[NSMutableArray alloc] init];
    while ([result next]) {
        [searchDataArray addObject:[result stringForColumn:@"SearchContents"]];
    }
    return searchDataArray;
}

-(void)deleteAllSearchContents
{
    if (![searchDatabase open]) {
        NSLog(@"can not open dataBase!");
        return ;
    }
    [searchDatabase executeUpdate:@"DELETE FROM SearchDataArray"];
}

@end
