//
//  UIView+YTFrame.h
//  YTToolPortal
//  简化布局
//  Created by Yutian Duan on 2019/5/21.
//  Copyright © 2019年 Wanwin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (YTFrame)
/**
 起始值Y
 */
@property (assign, nonatomic, setter=yt_setTop:) CGFloat yt_top;
/**
 起始值X
 */
@property (assign, nonatomic, setter=yt_setLeft:) CGFloat yt_left;
/**
 起始值Y + 高度height
 */
@property (assign, nonatomic, setter=yt_setBottom:) CGFloat yt_bottom;
/**
 起始值X + 宽度width
 */
@property (assign, nonatomic, setter=yt_setRight:) CGFloat yt_right;
/**
 中点X坐标
 */
@property (assign, nonatomic, setter=yt_setCenterX:) CGFloat yt_centerX;
/**
 中点Y坐标
 */
@property (assign, nonatomic, setter=yt_setCenterY:) CGFloat yt_centerY;
/**
 宽度
 */
@property (assign, nonatomic, setter=yt_setWidth:) CGFloat yt_width;
/**
 高度
 */
@property (assign, nonatomic, setter=yt_setHeight:) CGFloat yt_height;

@property (assign, nonatomic, setter=yt_setSize:) CGSize yt_size;

@property (assign, nonatomic, setter=yt_setOrigin:) CGPoint yt_origin;

/**
 起始坐标
 */
//@property (assign, nonatomic, setter=yt_setOrigin:) CGPoint yt_origin;

/**
 移除View上面所有的子视图
 */
- (void)removeAllSubviews;


@end

