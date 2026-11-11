//
//  ProgressView.m
//  CustomProgress
//
//  Created by duanyutian on 2017/6/11.
//  Copyright © 2017年 duanyutian. All rights reserved.
//

#import "ProgressView.h"

#define defaultColor [UIColor colorWithRed:35/255.0f green:135/255.0 blue:255/255.0f alpha:1.0f]

static CGFloat margin = 10;

@interface ProgressView () {
  /// 未完成视图
  UIView *lineUndoV;
  /// 已完成视图
  UIView *lineDoneV;
  //! 圆点
  NSMutableArray <UIView *>*undoArr;
  //! title
  NSArray <NSString *>*dataArr;
  //! 当前进度标识
  UILabel *markI;
}



@end

@implementation ProgressView

- (instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)data {
  self = [super initWithFrame:frame];
  if (self) {
    
    _index = 0;
    dataArr = data;
    
    self.backgroundColor = [UIColor greenColor];
    
    CGFloat line_W = frame.size.width - frame.size.width / (CGFloat)dataArr.count;
    lineUndoV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, line_W, 3)];
    lineUndoV.center = CGPointMake(self.center.x, self.frame.size.height / 2);
    lineUndoV.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineUndoV];

    CGFloat start_X = lineUndoV.frame.origin.x;
    CGFloat Per_W = self.frame.size.width / (CGFloat) dataArr.count;

    undoArr = [[NSMutableArray alloc] init];
    //! 创建进度点
    for (NSInteger i = 0; i < dataArr.count; i ++) {
      // (13 - 1.5 ) / 2 因为是 中心点  所以  center_y = 3/2 = 1.5  往上移 5.75位
      UIView *circleV = [[UIView alloc] initWithFrame:CGRectMake(start_X + Per_W * i, lineUndoV.center.y -  5.75, 13, 13)];
      circleV.backgroundColor = [UIColor lightGrayColor];
      circleV.layer.cornerRadius = 13 / 2;
      [self addSubview:circleV];
      [undoArr addObject:circleV];
    }
    
    //! 创建标志位
    markI = [[UILabel alloc] initWithFrame:CGRectMake(start_X, lineUndoV.center.y - 11.75, 25, 25)];
    markI.backgroundColor = defaultColor;
    markI.text = @"1";
    markI.textAlignment = NSTextAlignmentCenter;
    markI.textColor = [UIColor whiteColor];
    markI.layer.masksToBounds = YES;
    markI.layer.cornerRadius = 25 / 2;
    [self addSubview:markI];
    
    lineDoneV = [[UIView alloc] initWithFrame:CGRectZero];
    lineDoneV.backgroundColor = defaultColor;
    [self addSubview:lineDoneV];
    
  }
  return self;
}

- (void)setIndex:(NSInteger)index {
  
  if (_index < 0 || _index >= dataArr.count) {
    return;
  }
  
  _index = index;

  //每个的宽度
  CGFloat per_W = self.frame.size.width / (CGFloat)dataArr.count;
  //重新设置 完成视图的frame
  lineDoneV.frame = CGRectMake(lineUndoV.frame.origin.x, lineUndoV.frame.origin.y, per_W * _index, lineUndoV.frame.size.height);
  
  UIView *circleVx = undoArr[index];
  ///设置标志位的位置
  markI.center = CGPointMake(circleVx.center.x, circleVx.center.y);
  markI.text = [NSString stringWithFormat:@"%zd",_index+1];
  [self addAnimation:markI];
  
  //设置 圆点的颜色
  for (NSInteger i = 0; i < undoArr.count; i++) {
    UIView *circleV = undoArr[i];
    if (i <= _index) {
      circleV.backgroundColor = defaultColor;
    } else {
      circleV.backgroundColor = [UIColor lightGrayColor];
    }
  }
  
}

- (void)addAnimation:(UILabel *)sender {
  
  CABasicAnimation *scaleAnimate = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  scaleAnimate.fromValue = [NSNumber numberWithFloat:1.0f];
  scaleAnimate.toValue = [NSNumber numberWithFloat:1.5f];
  scaleAnimate.autoreverses = YES;
  scaleAnimate.repeatCount = 1;
  scaleAnimate.duration = 0.5;
  [sender.layer addAnimation:scaleAnimate forKey:@"scaleXAnimation"];
  
}

@end
