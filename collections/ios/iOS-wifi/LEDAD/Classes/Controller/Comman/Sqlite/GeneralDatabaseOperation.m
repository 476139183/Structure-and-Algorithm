//
//  GeneralDatabaseOperation.m
//  iLEDSIGN
//
//  Created by LDY on 14/10/23.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "GeneralDatabaseOperation.h"

@implementation GeneralDatabaseOperation

-(id)init{
    self = [super init];
    if (self) {
        /*根据路径创建数据库和表*/
        NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * path = [arr objectAtIndex:0];
        
        path = [path stringByAppendingPathComponent:@"GeneralDatabaseOperation.db"];
        dataBase = [FMDatabase databaseWithPath:path];
        DLog(@"%@",path);
    }
    return self;
}

/**
 *@brief 保存视频播放的状态
 */
-(BOOL)saveVideoPlayState:(NSString*)videoID videoIndex:(NSString*)videoIndex videoState:(NSString*)videoState{
    if (![dataBase open]) {
        DLog(@"can not open dataBase!");
        return NO;
    }
    
    [dataBase executeUpdate:@"CREATE TABLE if not exists VideoPlayState(videoID TEXT(100) DEFAULT NULL,videoIndex TEXT(100) DEFAULT NULL,videoState TEXT(100) DEFAULT NULL)"];
    NSString *selectSqlStr = @"";
    selectSqlStr = [[NSString alloc]initWithFormat:@"select videoState from VideoPlayState where videoID = '%@' and videoIndex = '%@'",videoID,videoIndex];
    DLog(@"selectSqlStr = %@",selectSqlStr);
    FMResultSet *result = [dataBase executeQuery:selectSqlStr];
    NSString *resultVideoState = @"";
    if ([result next]) {
        resultVideoState = [result objectForColumnName:@"videoState"];
        DLog(@"resultVideoState =%@",resultVideoState);
        if ([resultVideoState isEqualToString:@"video_noread"]||[resultVideoState isEqualToString:@"video_read"]) {
            ;
            return [dataBase executeUpdate:@"UPDATE VideoPlayState SET videoState=? where videoID=? and videoIndex=?",videoState,videoID,videoIndex];
        }
    }else{
        return [dataBase executeUpdate:@"INSERT INTO VideoPlayState(videoID,videoIndex,videoState) VALUES(?,?,?)",videoID,videoIndex,videoState];
    }
    return YES;
}


/**
 *@brief 查询视频播放的状态
 */
-(NSString*)selectVideoPlayState:(NSString*)videoID videoIndex:(NSString*)videoIndex{
    if (![dataBase open]) {
        DLog(@"can not open dataBase!");
        return NO;
    }
    
    NSString *selectSqlStr = @"";
    selectSqlStr = [[NSString alloc]initWithFormat:@"select videoState from VideoPlayState where videoID = '%@' and videoIndex = '%@'",videoID,videoIndex];
    DLog(@"selectSqlStr = %@",selectSqlStr);
    FMResultSet *result = [dataBase executeQuery:selectSqlStr];
    NSString *resultVideoState = @"";
    while ([result next]) {
        resultVideoState = [result objectForColumnName:@"videoState"];
    }
    DLog(@"resultVideoState =%@",resultVideoState);
    if (resultVideoState==nil) {
        resultVideoState = @"video_noread";
    }
    return resultVideoState;
}


@end
