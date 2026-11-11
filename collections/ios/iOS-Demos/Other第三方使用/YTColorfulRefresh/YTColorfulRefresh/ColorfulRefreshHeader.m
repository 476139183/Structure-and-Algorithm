//
//  ColorfulRefreshHeader.m
//  YTColorfulRefresh
//
//  Created by 段雨田 on 2020/4/27.
//  Copyright © 2020 段雨田. All rights reserved.
//

#import "ColorfulRefreshHeader.h"
#import "YTColorfulItem.h"

static const NSInteger kColorfulItemBaseTag = 10000;
static const NSTimeInterval kColorfulRefreshUpdateTimeInterval = 0.15;
static const CGFloat kPullToRefreshViewHeight = 65.0;

@interface ColorfulRefreshHeader () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *originalColors;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSArray *originalItems;
@property (nonatomic, strong) NSMutableArray *originalPositions;
@property (nonatomic, strong) NSArray *speeds;
///! 定时动画
@property (nonatomic, strong) NSTimer *timer;
///! 用于动画更新颜色
@property (nonatomic, assign) NSInteger flagCount;

@end

@implementation ColorfulRefreshHeader


+ (NSArray *)defaultColors {
    
  return @[
    [UIColor colorWithRed:230/255.0 green:155/255.0 blue:3/255.0 alpha:1],
    [UIColor colorWithRed:175/255.0 green:18/255.0 blue:88/255.0 alpha:1],
    [UIColor colorWithRed:244/255.0 green:13/255.0 blue:100/255.0 alpha:1],
    [UIColor colorWithRed:137/255.0 green:157/255.0 blue:192/255.0 alpha:1],
    [UIColor colorWithRed:179/255.0 green:197/255.0 blue:135/255.0 alpha:1],
    [UIColor colorWithRed:250/255.0 green:227/255.0 blue:113/255.0 alpha:1]
  ];
  
}

- (NSTimer *)timer {
  if (_timer == nil) {
    __weak ColorfulRefreshHeader *weakSelf = self;
    _timer = [NSTimer safe_timerWithTimeInterval:kColorfulRefreshUpdateTimeInterval block:^{
      [weakSelf updateColors];
    } repeats:YES];

    [_timer setFireDate:[NSDate distantFuture]];
  }
   
  return _timer;
}

- (void)startRunloop {
  NSRunLoop *loop = [NSRunLoop currentRunLoop];
  [loop addTimer:self.timer forMode:NSDefaultRunLoopMode];
  [loop run];
}

#pragma mark - Main

- (void)prepare {
  [super prepare];
  self.mj_h = kPullToRefreshViewHeight;
  
  _originalColors = [[self class] defaultColors];
  _originalPositions = [[NSMutableArray alloc]initWithCapacity:6];
       
  _items = [[NSMutableArray alloc]initWithCapacity:6];
      
  _colors = @[_originalColors[2],
              _originalColors[3],
              _originalColors[1],
              _originalColors[4],
              _originalColors[0],
              _originalColors[5]];
      
  [_colors enumerateObjectsUsingBlock:^(UIColor *color, NSUInteger idx, BOOL *stop) {
    YTColorfulItemPosition position = (YTColorfulItemPosition)idx;
    
    CGPoint centerPoint = CGPointMake([UIScreen mainScreen].bounds.size.width/2, -kColorfulRefreshWidth/2-30*idx);
          
    YTColorfulItem *item = [[YTColorfulItem alloc] initWithCenter:centerPoint originalColor:color position:position];
           
    item.tag = idx+kColorfulItemBaseTag;
    [self addSubview:item];
    [_items addObject:item];
          
    
    [_originalPositions addObject:@(-kColorfulRefreshWidth/2-30*idx)];
  }];
       
  _speeds = @[@(55.0/75.0),
              @(85.0/80.0),
              @(115.0/85.0),
              @(145.0/90.0),
              @(175.0/95.0),
              @(205.0/100.0)];
       
  _originalItems = @[_items[4],_items[2],_items[0],_items[1],_items[3],_items[5]];
      
  [self performSelectorInBackground:@selector(startRunloop) withObject:nil];
  
}

///! 重绘视图
- (void)placeSubviews {
  [super placeSubviews];
  self.mj_h = kPullToRefreshViewHeight;
  

}

///! 监听滚动
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
  [super scrollViewContentOffsetDidChange:change];

  NSValue *newValue = change[@"new"];
  CGPoint contentOffset = [newValue CGPointValue];

  CGFloat offsetY = contentOffset.y;

  
  if (!self.refreshing) {
         
    if (offsetY <= 0) {
      
      for (NSInteger i = 0; i<self.colors.count; i++) {
        
        YTColorfulItem *item = [self viewWithTag:i+10000];
               
        CGFloat p = [self.originalPositions[i] doubleValue];
        CGFloat s = [self.speeds[i] doubleValue];
                
        if (p+s*fabs(offsetY) >= kPullToRefreshViewHeight-20-35.0/2) {
          item.center = CGPointMake(item.center.x, kPullToRefreshViewHeight-20-35.0/2);
        } else {
          item.center = CGPointMake(item.center.x, p+s*fabs(offsetY));
        }
              
      }
    
    }
    
  }
     
  if (offsetY <= -95) {
    if (!self.scrollView.dragging && self.scrollView.decelerating) {
      if (!self.refreshing) {
        [self.timer setFireDate:[NSDate distantPast]];
      }

    }
 
  }
  
}


- (void)updateColors {
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.originalItems enumerateObjectsUsingBlock:^(YTColorfulItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
      item.color = self.originalColors[(self.flagCount+idx)%6];
    }];
    self.flagCount++;
  });
}

///! 重写刷新
- (void)beginRefreshing {
 
  for (NSInteger i = 0; i < self.colors.count; i++) {
    YTColorfulItem *item = [self viewWithTag:kColorfulItemBaseTag+i];
    item.center = CGPointMake(CGRectGetWidth(self.frame)/2, kPullToRefreshViewHeight-20-35.0/2);
  }
  
  [self.timer setFireDate:[NSDate distantPast]];
  
  [super beginRefreshing];
  
}

///! 重写结束
- (void)endRefreshing {
  
  self.flagCount = 0;
  [self.timer setFireDate:[NSDate distantFuture]];

  for (NSInteger i = self.colors.count-1; i >= 0; i--) {
     
    YTColorfulItem *item = [self viewWithTag:i+10000];
     
    [UIView animateWithDuration:0.75 delay:0.05*(self.colors.count-i-1) options:UIViewAnimationOptionCurveLinear animations:^{
      item.center = CGPointMake(item.center.x, item.originalCenterY);
    } completion:nil];
  }
  
  [super endRefreshing];

}

@end
