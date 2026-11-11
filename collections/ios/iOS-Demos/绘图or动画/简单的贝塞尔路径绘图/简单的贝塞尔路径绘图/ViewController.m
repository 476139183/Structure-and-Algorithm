//
//  ViewController.m
//  简单的贝塞尔路径绘图
//
//  Created by Yutian Duan on 2018/3/27.
//  Copyright © 2018年 duanyutian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(1, 1, 100, 100)];
  button.backgroundColor = [UIColor redColor];
  [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  // Do any additional setup after loading the view, typically from a nib.
}

#define pi 3.14159265359

#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)


- (void)click:(UIButton *)button {
  NSLog(@"1");
  UIBezierPath *path = [UIBezierPath bezierPath];
  // 首先设置一个起始点
  [path moveToPoint:CGPointMake(self.view.frame.size.width/2, 100)];
  
  // 添加二次曲线
  [path addQuadCurveToPoint:CGPointMake(self.view.frame.size.width/2,300)
               controlPoint:CGPointMake(20, 50)];
  
  path.lineCapStyle = kCGLineCapRound;
  path.lineJoinStyle = kCGLineJoinRound;
  path.lineWidth = 5.0;
  
  // 添加二次曲线
  
  [path addQuadCurveToPoint:CGPointMake(self.view.frame.size.width/2, 100)
               controlPoint:CGPointMake(self.view.frame.size.width-20, 300)];
  
  
  //    UIColor *strokeColor = [UIColor redColor];
  //
  //    [strokeColor set];
  //
  //    [path stroke];
  
  CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
  
  pathAnimation.calculationMode = kCAAnimationPaced;
  pathAnimation.fillMode = kCAFillModeForwards;
  pathAnimation.removedOnCompletion = NO;
  pathAnimation.duration = 10;
  //Lets loop continuously for the demonstration
  pathAnimation.repeatCount = 10;
  
  
  pathAnimation.path = (__bridge CGPathRef _Nullable)(path);
  
  //    CGPathRelease(path);
  
  [button.layer addAnimation:pathAnimation
                      forKey:@"moveTheSquare"];
  
  
  //    return;
  
  //
  
  //    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150)
  //                                                         radius:75
  //                                                     startAngle:0
  //                                                       endAngle:DEGREES_TO_RADIANS(135)
  //                                                      clockwise:YES];
  //
  //    path.lineWidth = 5.0;
  //    path.lineCapStyle = kCGLineCapRound;  //线条拐角
  //    path.lineJoinStyle = kCGLineCapRound;  //终点处理
  //
  
  
  CAShapeLayer *circleLayer = [CAShapeLayer layer];
  
  // 指定frame，只是为了设置宽度和高度
  circleLayer.frame = CGRectMake(0, 0, 200, 200);
  
  // 设置居中显示
  circleLayer.position = self.view.center;
  
  // 设置填充颜色
  circleLayer.fillColor = [UIColor clearColor].CGColor;
  
  // 设置线宽
  circleLayer.lineWidth = 2.0;
  
  // 设置线的颜色
  circleLayer.strokeColor = [UIColor redColor].CGColor;
  
  // 设置CAShapeLayer与UIBezierPath关联
  circleLayer.path = path.CGPath;
  
  // 将CAShaperLayer放到某个层上显示
  [self.view.layer addSublayer:circleLayer];
}


//    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150)
//                                                         radius:75
//                                                     startAngle:0
//                                                       endAngle:DEGREES_TO_RADIANS(135)
//                                                      clockwise:YES];
//
//    path.lineWidth = 5.0;
//    path.lineCapStyle = kCGLineCapRound;  //线条拐角
//    path.lineJoinStyle = kCGLineCapRound;  //终点处理



- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
