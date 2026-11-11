//
//  YTColorfulItem.h
//  YTColorfulRefresh
//
//  Created by 段雨田 on 2020/4/27.
//  Copyright © 2020 段雨田. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kColorfulRefreshWidth = 35.0;

typedef NS_ENUM(NSInteger,YTColorfulItemPosition) {
  YTColorfulItemPositionRightBottom,
  YTColorfulItemPositionLeftBottom,
  YTColorfulItemPositionRightCenter,
  YTColorfulItemPositionLeftCenter,
  YTColorfulItemPositionRightTop,
  YTColorfulItemPositionLeftTop,
};


@interface NSTimer (SafeTimer)

+ (NSTimer *)safe_timerWithTimeInterval:(NSTimeInterval)ti
                                  block:(void(^)(void))block
                                repeats:(BOOL)bo;

@end



@interface YTColorfulItem : UIView

@property (nonatomic,strong) UIColor *color;
@property (nonatomic,assign,readonly) CGFloat originalCenterY;
@property (nonatomic,assign) float offYChangeSpeed;
@property (nonatomic,assign) NSInteger currentColorIndex;
@property (nonatomic,assign,readonly) YTColorfulItemPosition position;

- (instancetype)initWithCenter:(CGPoint)point originalColor:(UIColor *)color position:(YTColorfulItemPosition)position;

@end


