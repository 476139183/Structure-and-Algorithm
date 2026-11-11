//
//  YTColorfulItem.m
//  YTColorfulRefresh
//
//  Created by 段雨田 on 2020/4/27.
//  Copyright © 2020 段雨田. All rights reserved.
//

#import "YTColorfulItem.h"

typedef struct {
    CGFloat minBorderLen;
    CGFloat middleBorderLen;
    CGFloat maxBorderLen;
} TriangleBorder;


@implementation NSTimer (SafeTimer)

+ (NSTimer *)safe_timerWithTimeInterval:(NSTimeInterval)ti block:(void (^)(void))block repeats:(BOOL)bo {
    return [self timerWithTimeInterval:ti target:self selector:@selector(safe_timerBlock:) userInfo:[block copy] repeats:bo];
}

+ (void)safe_timerBlock:(NSTimer *)timer {
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}

@end

@implementation YTColorfulItem {
  TriangleBorder _border;
}

- (instancetype)initWithCenter:(CGPoint)point originalColor:(UIColor *)color position:(YTColorfulItemPosition)position {
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, kColorfulRefreshWidth, kColorfulRefreshWidth);
        self.center = point;
        _color = color;
        _position = position;
        _border.middleBorderLen = kColorfulRefreshWidth/2;
        _border.minBorderLen = _border.middleBorderLen*tan(M_PI/6);
        _border.maxBorderLen = 2*_border.minBorderLen;
        _originalCenterY = point.y;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGPoint center = CGPointMake(kColorfulRefreshWidth/2, kColorfulRefreshWidth/2);
    CGPoint minPoint,middlePoint,maxPoint;
    switch (self.position) {
        case YTColorfulItemPositionLeftBottom: {
            minPoint = CGPointMake(kColorfulRefreshWidth/2, kColorfulRefreshWidth);
            middlePoint = CGPointMake(center.x-_border.middleBorderLen*cos(M_PI/6), 3/4.0*kColorfulRefreshWidth);
            maxPoint = CGPointMake(center.x-_border.maxBorderLen*sin(M_PI/6), center.y);
        }
            break;
        case YTColorfulItemPositionLeftCenter: {
            minPoint = CGPointMake(center.x-_border.middleBorderLen*cos(M_PI/6), 3/4.0*kColorfulRefreshWidth);
            middlePoint = CGPointMake(center.x-_border.middleBorderLen*cos(M_PI/6), kColorfulRefreshWidth/4);
            maxPoint = CGPointMake(center.x-_border.minBorderLen*sin(M_PI/6), kColorfulRefreshWidth/4);
        }
            break;
        case YTColorfulItemPositionLeftTop: {
            minPoint = CGPointMake(center.x-_border.middleBorderLen*cos(M_PI/6), kColorfulRefreshWidth/4);
            middlePoint = CGPointMake(center.x, 0);
            maxPoint = CGPointMake(center.x+_border.minBorderLen*sin(M_PI/6),kColorfulRefreshWidth/4);
        }
            break;
        case YTColorfulItemPositionRightBottom: {
            minPoint = CGPointMake(center.x+_border.middleBorderLen*cos(M_PI/6),3/4.0*kColorfulRefreshWidth);
            middlePoint = CGPointMake(kColorfulRefreshWidth/2, kColorfulRefreshWidth);
            maxPoint = CGPointMake(center.x-_border.minBorderLen*sin(M_PI/6), 3/4.0*kColorfulRefreshWidth);
        }
            break;
        case YTColorfulItemPositionRightCenter: {
            minPoint = CGPointMake(center.x+_border.middleBorderLen*cos(M_PI/6), kColorfulRefreshWidth/4);
            middlePoint = CGPointMake(center.x+_border.middleBorderLen*cos(M_PI/6),3/4.0*kColorfulRefreshWidth);
            maxPoint = CGPointMake(center.x+_border.minBorderLen*sin(M_PI/6),3/4.0*kColorfulRefreshWidth);
        }
            break;
        case YTColorfulItemPositionRightTop: {
            minPoint = CGPointMake(center.x ,0);
            middlePoint = CGPointMake(center.x+_border.middleBorderLen*cos(M_PI/6), kColorfulRefreshWidth/4);
            maxPoint = CGPointMake(center.x+_border.maxBorderLen*sin(M_PI/6), center.y);
        }
            break;
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, minPoint.x, minPoint.y);
    CGContextAddLineToPoint(ctx, middlePoint.x, middlePoint.y);
    CGContextAddLineToPoint(ctx, maxPoint.x, maxPoint.y);
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    CGContextFillPath(ctx);
}

@end
