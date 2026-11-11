//
//  LDProgressView.h
//  LDProgressView
//
//  Created by Christian Di Lorenzo on 9/27/13.
//  Copyright (c) 2013 Light Design. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDProgressView;
// 接收卡设置进度条
extern LDProgressView *receiveCardLDProgressView;
//瓶体连接进度条
extern LDProgressView *screenLinkingLDProgressView;
//逐点校正
extern LDProgressView *PWALDProgressView;
//在线升级
extern LDProgressView *onlineUpgradeLDProgressView;


@protocol LDProgressDelegate <NSObject>

//1代表接收卡设置进度条 2瓶体连接进度条 3逐点校正 4在线升级
- (void)currentProgress:(int)aValue type:(int)typeValue;

@end

typedef enum {
    LDProgressStripes,
    LDProgressGradient,
    LDProgressSolid
} LDProgressType;

@interface LDProgressView : UIView
{
    id<LDProgressDelegate>delegate;
}

@property (strong,nonatomic) id <LDProgressDelegate> delegate;

@property (nonatomic) CGFloat progress;

@property (nonatomic, strong) UIColor *color UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *flat UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *animate UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *showText UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *borderRadius UI_APPEARANCE_SELECTOR;

// Animation of progress
@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic) CGFloat progressToAnimateTo;

@property (nonatomic) LDProgressType type;

@end
