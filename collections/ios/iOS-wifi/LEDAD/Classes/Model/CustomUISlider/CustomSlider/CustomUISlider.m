//
//  CustomUISlider.m
//  XCloudManager
//
//  Created by LDY on 13-9-18.
//
//

#import "CustomUISlider.h"

@implementation CustomUISlider

- (id)initWithFrame:(CGRect)frame minImage:(NSString *)minImage maxImage:(NSString *)maxImage thumbImage:(NSString *)thumbImage
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImage *stetchTrack = [[UIImage imageNamed:minImage]
                                stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
        UIImage *stetchTrack1 = [[UIImage imageNamed:maxImage]
                                 stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
        [self setThumbImage:[UIImage imageNamed:thumbImage] forState:UIControlStateNormal];
        [self setMinimumTrackImage:stetchTrack1 forState:UIControlStateNormal];
        [self setMaximumTrackImage:stetchTrack forState:UIControlStateNormal];
;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
