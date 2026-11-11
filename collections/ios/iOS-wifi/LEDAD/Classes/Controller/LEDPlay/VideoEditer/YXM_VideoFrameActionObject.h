//
//  YXM_VideoFrameAction.h
//  LEDAD
//
//  Created by yixingman on 14/10/22.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXM_VideoFrameActionObject : NSObject
{
    //帧时间
    NSString *_frameTimeline;
    //取景窗的原点X
    NSInteger _x;
    //取景窗的原点Y
    NSInteger _y;
    //取景窗的宽
    NSInteger _w;
    //取景窗的高
    NSInteger _h;
    //取景时视频原画缩放比例
    float _sw;
    float _sh;
}
/**
 * //帧时间
 */
@property (nonatomic,retain) NSString *frameTimeline;
/**
 *  //取景窗的原点X
 */
@property (nonatomic,assign) NSInteger x;
/**
 *  //取景窗的原点Y
 */
@property (nonatomic,assign) NSInteger y;
/**
 *  //取景窗的宽
 */
@property (nonatomic,assign) NSInteger w;
/**
 *  //取景窗的高
 */
@property (nonatomic,assign) NSInteger h;
/**
 *  //取景时视频原画缩放比例
 */
@property (nonatomic,assign) float sw;
@property (nonatomic,assign) float sh;
@end
