//
//  YXM_VideoEditerViewController.h
//  LEDAD
//
//  Created by yixingman on 14-10-14.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSVideoScrubber.h"
#import "ALAsset+isEqual.h"
#import "ALAsset+assetType.h"
#import "ALAssetsGroup+isEqual.h"
#import "ALAsset+accessibilityLabel.h"
#import <QuartzCore/QuartzCore.h>

//多线程输入多个参数的类别
#import "NSObject+NSObject_detachNewThreadSelectorWithObjs.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "KVNProgress.h"
#import "HSCButton.h"
#import "UIGestureRecognizer+DraggingAdditions.h"
#import <QuartzCore/QuartzCore.h>


@interface YXM_VideoEditerViewController : UIViewController<UIPopoverControllerDelegate,XValueChangeDelegate>
{
    CGFloat _originViedoWidth;//原视频图像的宽
    CGFloat _originViedoHeight;//原视频图像的高
    CGFloat _originViedoFPS;//原视频的频率
    CGFloat _originDuration;//原视频的长度
    
    NSTimeInterval _frameDuration;

    //视频帧的图像
    UIImageView *_frameImageView;

    //视频的总帧数
    UILabel *_lblFrames;
    //视频的时间长度
    UILabel *_lblVideoLength;
    //视频的帧率
    UILabel *_lblFPS;

    //是否已经画了矩形框
    BOOL _isAlready;
    //视频文件的路径
    NSString *_sVideoPathString;


    //进度条的值
    float _progressValue;

    //视频帧截取器
    AVAssetImageGenerator *_myImageGenerator;

    //帧画面截取信息列表
    NSMutableDictionary *_dictFramesSubRectInfo;

    //视频播放器
    AVPlayer *_myVideoPlayer;
    AVPlayerLayer *_playerLayer;
    //视频解析指示器
    KVNProgress *_myVideoLoadProgress;
    //是否隐藏指示器
    BOOL _isHiddenHUD;

    NSTimer *moveFrameTimer;
    NSInteger iSecond1;
    NSInteger iSecond2;

    NSInteger iSecond3;
    NSInteger iSecond4;

    float fVideoTime;

    UIScrollView *_frameContainerScrollView;

    ALAsset *_myAsset;

    float _videoShowScale;
    //取景窗的宽和高
    float _viewfinderWidth;
    float _viewfinderHeight;
}

@property (nonatomic) float viewfinderWidth;
@property (nonatomic) float viewfinderHeight;
/**
 *  帧拾取器
 */
@property (nonatomic, strong) JSVideoScrubber *jsVideoScrubber;
//照片选取窗
@property (nonatomic, retain) UIPopoverController *popover;
//视频asset对象
@property (nonatomic,retain) ALAsset *myAsset;


/**
 *  将相册内的资源写入到沙盒中
 *
 *  @param videoAsset 传入系统的资源对象
 *  @return 素材在沙盒中的路径
 */
-(NSString *)handleWrittenFileWithSourceAsset:(ALAsset*)sourceAsset AndMatrialName:(NSString *)sRandom;


/**
 *  初始化预览画面刷
 *
 *  @param asset 对应的视频Asset对象
 */
-(void)initVideoScrubberAndExtractFrames:(ALAsset *)myasset;
@end
