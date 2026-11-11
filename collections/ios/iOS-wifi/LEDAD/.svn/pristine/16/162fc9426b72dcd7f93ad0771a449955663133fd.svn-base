//
//  YXM_PlayerListObject.m
//  LEDAD
//
//  Created by yixingman on 14-10-11.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import "YXM_PlayerListObject.h"

@implementation YXM_PlayerListObject
@synthesize player_ip = _player_ip;
@synthesize player_name = _player_name;

-(NSString *)player_ip{
    return _player_ip;
}

-(void)setPlayer_ip:(NSString *)player_ip{
    if (_player_ip != player_ip) {
        [_player_ip release];
        _player_ip = [[player_ip stringByReplacingOccurrencesOfString:@"::ffff:" withString:@""] retain];
    }
}
@end
