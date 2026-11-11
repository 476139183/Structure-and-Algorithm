//
//  AoutDesignerView.m
//  云屏
//
//  Created by LDY on 7/22/14.
//  Copyright (c) 2014 LDY. All rights reserved.
//

//Viewd的宽度设为400，高度为屏幕的宽度-768
#import "AboutDesignerView.h"

@implementation AboutDesignerView
@synthesize headImageView;
@synthesize nameLabel;
@synthesize telLabel;
@synthesize qqLabel;
@synthesize descriptionTextView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(75, 50, 250, 250)];
        nameLabel  = [[MyLabel alloc] initWithFrame:CGRectMake(30, 320, 350, 40)];
        telLabel = [[MyLabel alloc] initWithFrame:CGRectMake(30, 370, 350, 20)];
        qqLabel = [[MyLabel alloc] initWithFrame:CGRectMake(30, 400, 350, 20)];
        descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(30, 450, 350, SCREEN_CGSIZE_WIDTH - 500)];
        
        nameLabel.font = [UIFont systemFontOfSize:35];
        
        if (!DEVICE_IS_IPAD) {
            headImageView.frame = CGRectMake((SCREEN_CGSIZE_WIDTH - 200)/2, 30, 200, 200);
            nameLabel.frame = CGRectMake(30, headImageView.frame.origin.y + 220, SCREEN_CGSIZE_WIDTH - 60, 30);
            nameLabel.font = [UIFont systemFontOfSize:25];
            telLabel.frame = CGRectMake(30, headImageView.frame.origin.y + 250, SCREEN_CGSIZE_WIDTH - 60, 20);
            qqLabel.frame = CGRectMake(30, headImageView.frame.origin.y + 270, SCREEN_CGSIZE_WIDTH - 60, 20);
            descriptionTextView.frame = CGRectMake(30, headImageView.frame.origin.y + 290, SCREEN_CGSIZE_WIDTH - 60, SCREEN_CGSIZE_HEIGHT - qqLabel.frame.origin.y - qqLabel.frame.size.height - 170);
            if (SCREEN_CGSIZE_HEIGHT<500) {
                headImageView.frame = CGRectMake((SCREEN_CGSIZE_WIDTH - 180)/2, 10, 180, 180);
                nameLabel.frame = CGRectMake(30, headImageView.frame.origin.y + 180, SCREEN_CGSIZE_WIDTH - 60, 30);
                nameLabel.font = [UIFont systemFontOfSize:25];
                telLabel.frame = CGRectMake(30, headImageView.frame.origin.y + 210, SCREEN_CGSIZE_WIDTH - 60, 20);
                qqLabel.frame = CGRectMake(30, headImageView.frame.origin.y + 230, SCREEN_CGSIZE_WIDTH - 60, 20);
                descriptionTextView.frame = CGRectMake(30, qqLabel.frame.origin.y + 20, SCREEN_CGSIZE_WIDTH - 60, SCREEN_CGSIZE_HEIGHT - qqLabel.frame.origin.y - qqLabel.frame.size.height - 160);
            }
        }
        
        //设置图层阴影
        [self.layer setShadowOffset:CGSizeMake(5, 0)];
        [self.layer setShadowOpacity:0.6f];
        [self.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
        
        [self addSubview:headImageView];
        [self addSubview:nameLabel];
        [self addSubview:telLabel];
        [self addSubview:qqLabel];
        [self addSubview:descriptionTextView];
    }
    return self;
}

- (void)dealloc
{
    DLog(@"%@进行了释放！！！",[self class]);
    RELEASE_SAFELY(headImageView);
    RELEASE_SAFELY(nameLabel);
    RELEASE_SAFELY(telLabel);
    RELEASE_SAFELY(qqLabel);
    RELEASE_SAFELY(descriptionTextView);
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        if (CGRectContainsPoint(headImageView.frame, [touch locationInView:self])) {
            DLog(@"测试一下！！！");
        }
    }
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
