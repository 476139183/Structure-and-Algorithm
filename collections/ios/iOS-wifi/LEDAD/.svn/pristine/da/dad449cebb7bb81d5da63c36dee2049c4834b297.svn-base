//
//  GEGifView.h
//
//  Created by godera@yeah.net on 9/14/13.
//  Copyright (c) 2013. All rights reserved.
//
//  QQ: 719181178
/* supports both gif and image, based on SvGifView and OLImageView */
/* MRC */

/*usage:
 GEGifView* gifView = [[[GEGifView alloc] initWithFileName:@"jiafei.gif"] autorelease];
 gifView.frame = CGRectMake(0, 100, 320, 130);
 gifView.repeatCount = 2;
 [self.view addSubview:gifView];
 _gifView = gifView;
 [gifView start];//开始、停止、暂停 都是手动控制的
 */
/* Attention: like UIImageView, its userInteractionEnabled defaults to NO, avoid to intercept touch */

// 0 to close debug, 1 to open
#ifdef DEBUG
#define DEBUG_SWITCH_GIF 0
#else
#define DEBUG_SWITCH_GIF 0
#endif

#if DEBUG_SWITCH_GIF
#define GELOG_GIF NSLog
#else
#define GELOG_GIF(...)
#endif

#import <UIKit/UIKit.h>

@interface GEGifView : UIView

@property (nonatomic, copy) NSString* name; // identifier for gif

@property (nonatomic, assign) NSInteger repeatCount; // defaults to infinite
@property (nonatomic, readonly) CGFloat duration; // the total time

@property (nonatomic, retain) UIImage* image;

/* brief The default mode (NSDefaultRunLoopMode), causes the animation to pauses while it is contained in an actively scrolling `UIScrollView`. 
         Use NSRunLoopCommonModes if you don't want this behavior.
 */
@property (nonatomic, copy) NSString *runLoopMode;

@property (nonatomic, assign) BOOL clearWhenStop; // defaults to YES.
@property (nonatomic, assign, readonly) BOOL isAnimating;

 // data source init methods
- (id)initWithData:(NSData*)data;
- (id)initWithFileName:(NSString*)fileName; // gif file from bundle
- (id)initWithFilePath:(NSString*)filePath; // gif file path
- (id)initWithFrameItems:(NSDictionary*)frameItems; // frameItems contains frame images and frame start times.

-(NSDictionary *)frameItems; // contains frame images and frame start times.

 // data source setters
-(void)setData:(NSData *)data;
-(void)setFileName:(NSString *)fileName;
-(void)setFilePath:(NSString *)filePath;
-(void)setFrameItems:(NSDictionary *)frameItems;

- (void)start;

- (void)stop;

- (void)pause;

@end
