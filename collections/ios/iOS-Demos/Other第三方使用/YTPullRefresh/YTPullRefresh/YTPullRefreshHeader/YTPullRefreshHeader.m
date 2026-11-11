//
//  YTPullRefreshHeader.m
//  YTPullRefresh
//
//  Created by 段雨田 on 2020/5/6.
//  Copyright © 2020 段雨田. All rights reserved.
//

#import "YTPullRefreshHeader.h"
#import <CoreText/CoreText.h>

static char PDHeaderRefreshViewHeight;

static const CGFloat PDPullToRefreshViewHeight = 65.0;


@interface YTPullRefreshHeader ()

@property (nonatomic, retain) CALayer *animationLayer;
@property (nonatomic, retain) CAShapeLayer *pathLayer;
@property (nonatomic, assign)CGFloat progress;
@property (nonatomic, assign) BOOL isFlash;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, copy) NSString *animationPacing;

@end

/** 默认光晕循环一次的持续时间 */
static const NSTimeInterval pHaloDuration = 1.5f;

/** 默认光晕宽度 */
static const CGFloat pHaloWidth = 2.5f;

/** 默认字体大小 */
static const double pFontSize = 26.0f;

#define pColor [[UIColor colorWithRed:234.0/255 green:84.0/255 blue:87.0/255 alpha:1] CGColor]

/** 光晕动画ID */
static NSString *const kAnimationKey = @"PDHeaderRefreshViewAnimationKey";

@implementation YTPullRefreshHeader {
  CGFloat originOffset;
  BOOL isStop;
}

#pragma mark - Main
///! 初始化设置
- (void)prepare {
  
  [super prepare];
  
  originOffset = 64;
  
  self.mj_h = PDPullToRefreshViewHeight;
  
  
  self.animationLayer = [CALayer layer];
        
  self.animationLayer.frame = CGRectMake(0.0f,
                                         0.0f,
                                         [UIScreen mainScreen].bounds.size.width,
                                         PDPullToRefreshViewHeight);

  [self.layer addSublayer:self.animationLayer];
  
  
  [self addPullAnimation];
  isStop = YES;
  
}

///! 重绘视图
- (void)placeSubviews {
  [super placeSubviews];
  self.mj_h = PDPullToRefreshViewHeight;
}

- (void)setProgress:(CGFloat)progress {
   
//  self.center = CGPointMake(self.center.x, -fabs(self.scrollView.contentOffset.y+originOffset)/2);

  _progress = progress;
  self.pathLayer.strokeEnd = progress;

}

- (void)beginRefreshing {
  [self addRefreshAnimation];
  [super beginRefreshing];
}

- (void)endRefreshing {
  
  [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    self.alpha = 0.0f;
  } completion:^(BOOL finished) {
    self.alpha = 1.0f;
    [self stopAnimating];
    [self addPullAnimation];
    self.pathLayer.strokeEnd = 0.0;
  }];
  
  [super endRefreshing];
}

#pragma mark - Animation Method

- (CAShapeLayer *)setupDefaultLayer:(NSString *)animationString {
  if (self.pathLayer != nil) {
    [self.pathLayer removeFromSuperlayer];
    self.pathLayer = nil;
  }
    
    CGMutablePathRef letters = CGPathCreateMutable();
    
    CTFontRef font = CTFontCreateWithName(CFSTR("HelveticaNeue-UltraLight"), pFontSize, NULL);
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)font, kCTFontAttributeName,
                           nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:animationString
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    // for each RUN
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        // Get FONT for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        // for each GLYPH in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            // get Glyph & Glyph-data
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            // Get PATH of outline
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                //                CGAffineTransform t = CGAffineTransformIdentity;
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(font);
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.animationLayer.bounds;
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [UIColor colorWithRed:234.0/255 green:84.0/255 blue:87.0/255 alpha:1].CGColor;
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    
    return pathLayer;
}

- (void)addPullAnimation {
  // 这就是生活
  CAShapeLayer *pathLayer = [self setupDefaultLayer:@"C'est La Vie"];
  [self.animationLayer addSublayer:pathLayer];
  self.pathLayer = pathLayer;
  self.isFlash = YES;
}

- (void)addRefreshAnimation {
    _animationPacing = kCAMediaTimingFunctionEaseIn;
    
    // 设置渐变层参数
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.animationLayer.bounds;
    gradientLayer.startPoint       = CGPointMake(- pHaloWidth, 0);
    gradientLayer.endPoint         = CGPointMake(0, 0);
    gradientLayer.colors           = @[(id)pColor,
                                       (id)[[UIColor whiteColor] CGColor],
                                       (id)pColor];
    
    [self.animationLayer addSublayer:gradientLayer];
    self.gradientLayer = gradientLayer;
    
    // 生活是美好的
    CAShapeLayer *pathLayer = [self setupDefaultLayer:@"La Vie est belle"];
    self.gradientLayer.mask = pathLayer;
    
    if (self.pathLayer != nil) {
        [self.pathLayer removeFromSuperlayer];
        self.pathLayer = nil;
    }
    [self startAnimating];
}

/** 开启动画 */
- (void)startAnimating {
    static NSString *gradientStartPointKey = @"startPoint";
    static NSString *gradientEndPointKey = @"endPoint";
    
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.gradientLayer;
    if([gradientLayer animationForKey:kAnimationKey] == nil) {
        // 通过不断改变渐变的起止范围，来实现光晕效果
        CABasicAnimation *startPointAnimation = [CABasicAnimation animationWithKeyPath:gradientStartPointKey];
        startPointAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 0)];
        startPointAnimation.timingFunction = [CAMediaTimingFunction functionWithName:_animationPacing];
        
        CABasicAnimation *endPointAnimation = [CABasicAnimation animationWithKeyPath:gradientEndPointKey];
        endPointAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1 + pHaloWidth, 0)];
        endPointAnimation.timingFunction = [CAMediaTimingFunction functionWithName:_animationPacing];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[startPointAnimation, endPointAnimation];
        group.duration = pHaloDuration;
        group.timingFunction = [CAMediaTimingFunction functionWithName:_animationPacing];
        group.repeatCount = HUGE_VALF;
        
        [gradientLayer addAnimation:group forKey:kAnimationKey];
    }
}

/** 结束动画 */
- (void)stopAnimating {
  [self.gradientLayer removeFromSuperlayer];
  self.gradientLayer = nil;
}

#pragma mark -- KVO

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
  [super scrollViewContentOffsetDidChange:change];

  NSValue *newValue = change[@"new"];
  CGPoint contentOffset = [newValue CGPointValue];
  
  NSLog(@"%f",contentOffset.y);
  if (contentOffset.y + originOffset <= 0) {
    self.progress = MAX(0.0, MIN(fabs(contentOffset.y+originOffset)/PDPullToRefreshViewHeight, 1.0));
  }
  
}

@end
