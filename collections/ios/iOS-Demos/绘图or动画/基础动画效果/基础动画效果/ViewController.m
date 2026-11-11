//
//  ViewController.m
//  基础动画效果
//
//  Created by Yutian Duan on 2018/3/27.
//  Copyright © 2018年 duanyutian. All rights reserved.
//

#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIView *springView = [[UIView alloc] initWithFrame:CGRectMake(0, 380, 50, 50)];
  
  [self.view addSubview:springView];
  
  springView.layer.borderColor = [UIColor greenColor].CGColor;
  
  springView.layer.borderWidth = 2;
  
  springView.backgroundColor = [UIColor redColor];
  
  
  //实现平移动画，我们可以通过transform.translation或者水平transform.translation.x或者垂直平移transform.translation.y添加动画
  
  CABasicAnimation  *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
  
  animation.duration = 2;
  
  
  // Z轴旋转180度
  CGFloat width = self.view.frame.size.width;
  
  
  //    toValue这里是指移动的距离而不是移到这个点：
  animation.toValue = [NSValue valueWithCGPoint:CGPointMake(width-100, 0)];
  
  //  指定动画的重复多少圈是累加的
  animation.cumulative = YES;
  
  
  
  // 动画完成是不自动是很危险的:    removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards .
  
  
  animation.removedOnCompletion = NO;
  
  // 设置移动的效果是快入快出
  
  animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  
  
  
  //设置无限循环动画
  
  animation.repeatCount = HUGE_VALF;
  
  
  // 循环的关键语句
  animation.autoreverses = YES;
  
  
  animation.repeatDuration = 100;
  
  //设置动画完成时。自动以动画回到原点
  
  animation.fillMode = kCAFillModeForwards;
  
  [springView.layer addAnimation:animation forKey:@"transform.translation"];
  
  
  
  // Do any additional setup after loading the view, typically from a nib.
  
}


/*
 
 + (void)setAnimationDuration:(NSTimeInterval)duration
 //动画的持续时间，秒为单位
 
 + (void)setAnimationDelay:(NSTimeInterval)delay
 //动画延迟delay秒后再开始
 
 + (void)setAnimationStartDate:(NSDate *)startDate
 //动画的开始时间，默认为now
 
 + (void)setAnimationCurve:(UIViewAnimationCurve)curve
 //动画的节奏控制,具体看下面的”备注”
 
 + (void)setAnimationRepeatCount:(float)repeatCount
 //动画的重复次数
 
 + (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses
 //如果设置为YES,代表动画每次重复执行的效果会跟上一次相反
 
 + (void)setAnimationTransition:(UIViewAnimationTransition)transitionforView:(UIView *)view cache:(BOOL)cache
 //设置视图view的过渡效果, transition指定过渡类型, cache设置YES代表使用视图缓存，性能较好
 
 
 */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end

