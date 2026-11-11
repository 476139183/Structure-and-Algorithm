//
//  YXM_PlayerListObject.h
//  LEDAD
//
//  Created by yixingman on 14-10-11.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXM_PlayerListObject : NSObject
{
    NSString *_player_name;
    NSString *_player_ip;
}
@property (nonatomic,retain) NSString *player_name;
@property (nonatomic,retain) NSString *player_ip;
@end
