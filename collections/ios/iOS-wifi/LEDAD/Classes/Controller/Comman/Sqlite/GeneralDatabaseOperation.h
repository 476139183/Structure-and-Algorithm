//
//  GeneralDatabaseOperation.h
//  iLEDSIGN
//
//  Created by LDY on 14/10/23.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface GeneralDatabaseOperation : NSObject{
    FMDatabase *dataBase;
}

/**
 *@brief 保存视频播放的状态
 */
-(BOOL)saveVideoPlayState:(NSString*)videoID videoIndex:(NSString*)videoIndex videoState:(NSString*)videoState;
/**
 *@brief 查询视频播放的状态
 */
-(NSString*)selectVideoPlayState:(NSString*)videoID videoIndex:(NSString*)videoIndex;

@end
