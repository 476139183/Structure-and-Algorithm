//
//  UIView+YTFrame.m
//  YTToolPortal
//
//  Created by Yutian Duan on 2019/5/21.
//  Copyright © 2019年 Wanwin. All rights reserved.
//

#import "UIView+YTFrame.h"

@implementation UIView (YTFrame)


// 上边坐标
- (CGFloat)yt_top {
  return self.frame.origin.y;
}

- (void)yt_setTop:(CGFloat)aTop {
  CGRect frame = self.frame;
  frame.origin.y = aTop;
  self.frame = frame;
}

// 左边坐标
- (CGFloat)yt_left {
  return self.frame.origin.x;
}

- (void)yt_setLeft:(CGFloat)aLeft {
  CGRect frame = self.frame;
  frame.origin.x = aLeft;
  self.frame = frame;
}

// 下边坐标
- (CGFloat)yt_bottom {
  return self.frame.origin.y + self.frame.size.height;
}

- (void)yt_setBottom:(CGFloat)aBottom {
  CGRect frame = self.frame;
  frame.origin.y = aBottom - self.frame.size.height;
  self.frame = frame;
}

// 右边坐标
- (CGFloat)yt_right {
  return self.frame.origin.x + self.frame.size.width;
}

- (void)yt_setRight:(CGFloat)aRight {
  CGRect frame = self.frame;
  frame.origin.x = aRight - self.frame.size.width;
  self.frame = frame;
}

// 中心位置
- (CGFloat)yt_centerX {
  return self.center.x;
}

- (void)yt_setCenterX:(CGFloat)aCenterX {
  CGPoint center = self.center;
  center.x = aCenterX;
  self.center = center;
}

- (CGFloat)yt_centerY {
  return self.center.y;
}

- (void)yt_setCenterY:(CGFloat)aCenterY {
  CGPoint center = self.center;
  center.y = aCenterY;
  self.center = center;
}

// 宽度
- (CGFloat)yt_width {
  return self.frame.size.width;
}

- (void)yt_setWidth:(CGFloat)aWidth {
  CGRect frame = self.frame;
  frame.size.width = aWidth;
  self.frame = frame;
}

// 高度
- (CGFloat)yt_height {
  return self.frame.size.height;
}

- (void)yt_setHeight:(CGFloat)aHeight {
  CGRect frame = self.frame;
  frame.size.height = aHeight;
  self.frame = frame;
}

- (CGSize)yt_size {
  return self.frame.size;
}

- (void)yt_setSize:(CGSize)a_size {
  CGRect frame = self.frame;
  frame.size = a_size;
  self.frame = frame;
}

- (CGPoint)yt_origin {
  return self.frame.origin;
}

- (void)yt_setOrigin:(CGPoint)a_origin {
  CGRect frame = self.frame;
  frame.origin = a_origin;
  self.frame = frame;
  return;
}

/** 移除此view上的所有子视图 */
- (void)removeAllSubviews {
  for (UIView *view in self.subviews) {
    [view removeFromSuperview];
  }
  return;
}
@end
