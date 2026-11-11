//
//  PlayView.h
//  LEDAD
//
//  Created by duanyutian on 15/2/5.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface PlayView : UIView
@property(nonatomic,strong)AVPlayer *player;
@property (assign,nonatomic) int *avPlayerTag;
@end
