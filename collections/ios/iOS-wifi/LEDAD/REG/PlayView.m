//
//  PlayView.m
//  LEDAD
//
//  Created by duanyutian on 15/2/5.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "PlayView.h"

@implementation PlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(Class)layerClass
{
    return [AVPlayerLayer class];
    
}
-(void)setPlayer:(AVPlayer *)player
{
    //播放器只能安置在 类型为AVPlayerLayer的layer上
    AVPlayerLayer *layer=(AVPlayerLayer *)self.layer;
    layer.player=player;
    
}
-(AVPlayer *)player
{
    AVPlayerLayer *layer=(AVPlayerLayer*)self.layer;
    return layer.player;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
