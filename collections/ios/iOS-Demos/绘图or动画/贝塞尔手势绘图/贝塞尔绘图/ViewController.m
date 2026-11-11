//
//  ViewController.m
//  贝塞尔绘图
//
//  Created by Yutian Duan on 16/1/1.
//  Copyright © 2016年 Yutian Duan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
  UIBezierPath *mypath;
  CAShapeLayer *mymask;
}

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
  
  button.backgroundColor = [UIColor orangeColor];
  
  [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
  
  [self.view addSubview:button];
  
  
  // 手势
  mypath = [UIBezierPath bezierPath];
  
  mypath.lineCapStyle = kCGLineCapRound;  //线条拐角
  mypath.lineJoinStyle = kCGLineCapRound;  //终点处理
  
  mymask = [[CAShapeLayer alloc] init];
  
  mymask.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
  
  
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
  
  CGPoint touchPoint;
  
  UITouch *touch = [touches anyObject];
  
  if (touch) {
    
    touchPoint = [touch locationInView:self.view];
    [mypath moveToPoint:touchPoint];
    NSLog(@"---%f  %f",touchPoint.x,touchPoint.y);
    //        touchPoint = [touch locationInView:self.imageView];
    //        NSLog(@"touchesBegan : %f, %f\n", touchPoint.x, touchPoint.y);
    //
    //        self.lineStartPoint = touchPoint;
    
    
  }
  
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
  CGPoint touchPoint;
  
  UITouch *touch = [touches anyObject];
  
  if (touch) {
    
    touchPoint = [touch locationInView:self.view];
    
    NSLog(@"---%f  %f",touchPoint.x,touchPoint.y);
    
    
    [self setviewwith:touchPoint and:NO];
    
    //        touchPoint = [touch locationInView:self.imageView];
    //        NSLog(@"touchesBegan : %f, %f\n", touchPoint.x, touchPoint.y);
    //
    //        self.lineStartPoint = touchPoint;
    
    
  }
  
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  CGPoint touchPoint;
  UITouch *touch = [touches anyObject];
  if (touch) {
    touchPoint = [touch locationInView:self.view];
    NSLog(@"---%f  %f",touchPoint.x,touchPoint.y);
    [self setviewwith:touchPoint and:YES];
    //        [mypath stroke];
    //        touchPoint = [touch locationInView:self.imageView];
    //        NSLog(@"touchesBegan : %f, %f\n", touchPoint.x, touchPoint.y);
    //
    //        self.lineStartPoint = touchPoint;
    
  }
  
}


- (void)setviewwith:(CGPoint) point and:(BOOL )isok {
  
  [mypath addLineToPoint:point];
  
  
  mymask.lineWidth = 2.0;
  
  
  
  // 设置线的颜色
  
  mymask.strokeColor = [UIColor redColor].CGColor;
  
  
  
  //    mymask.fillColor  = [UIColor orangeColor].CGColor;
  if (isok) {
    //        [mypath closePath];
  }
  
  
  // 设置CAShapeLayer与UIBezierPath关联
  mymask.path = mypath.CGPath;

  // 将CAShaperLayer放到某个层上显示
  [self.view.layer addSublayer:mymask];
  
  
}




static int k = 0;
/**
 *  绘图
 *
 *  @param sender 按钮
 */
- (void)click:(UIButton *)sender {
  if (k == 4) {
    k = 0;
  }
  k ++;
  
  switch (k) {
    case 1: {
      [self setone];
    }
      break;
      
    case 2: {
      [self settwo];
    }
      break;
    default:
      break;
  }
  
  
}


- (void)setone {
  
  UIBezierPath *path = [UIBezierPath bezierPath];
  
  
  // 设置起始端点
  [path moveToPoint:CGPointMake(0, 100)]; //起始端
  
  
  [path addCurveToPoint:CGPointMake(0, 100) // 终端
          controlPoint1:CGPointMake(160, 0)   // 控制点1
          controlPoint2:CGPointMake(160, 250)];  // 控制点2
  
  path.lineCapStyle = kCGLineCapRound;
  
  path.lineJoinStyle = kCGLineJoinRound;
  
  path.lineWidth = 5.0;
  
  UIColor *strokeColor = [UIColor redColor];
  
  [strokeColor set];
  
  [path fill]; // path stoke
  
  CAShapeLayer *circleLayer = [CAShapeLayer layer];
  
  
  // 指定frame，只是为了设置宽度和高度
  circleLayer.frame = CGRectMake(0, 0, 200, 200);
  
  // 设置居中显示
  circleLayer.position = self.view.center;
  
  // 设置填充颜色
  circleLayer.fillColor = [UIColor redColor].CGColor;
  
  
  // 设置线宽
  circleLayer.lineWidth = 2.0;

  
  // 设置线的颜色
  circleLayer.strokeColor = [UIColor redColor].CGColor;
  
  // 设置CAShapeLayer与UIBezierPath关联
  circleLayer.path = path.CGPath;
  
  // 将CAShaperLayer放到某个层上显示
  [self.view.layer addSublayer:circleLayer];
  
}

- (void)settwo {
  UIColor *color = [UIColor redColor];
  [color set];  //设置线条颜色
  
  UIBezierPath* aPath = [UIBezierPath bezierPath];
  aPath.lineWidth = 5.0;
  
  aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
  aPath.lineJoinStyle = kCGLineCapRound;  //终点处理
  
  // Set the starting point of the shape.
  [aPath moveToPoint:CGPointMake(100.0, 0.0)];
  
  // Draw the lines
  [aPath addLineToPoint:CGPointMake(200.0, 40.0)];
  [aPath addLineToPoint:CGPointMake(160, 140)];
  [aPath addLineToPoint:CGPointMake(40.0, 140)];
  [aPath addLineToPoint:CGPointMake(0.0, 40.0)];
  
  [aPath closePath]; //第五条线通过调用closePath方法得到的
  
  [aPath stroke]; //Draws line 根据坐标点连线
  
  CAShapeLayer *circleLayer = [CAShapeLayer layer];

  
  // 指定frame，只是为了设置宽度和高度
  circleLayer.frame = CGRectMake(0, 0, 200, 200);
  
  // 设置居中显示
  circleLayer.position = self.view.center;
  
  // 设置填充颜色
  circleLayer.strokeColor = [UIColor redColor].CGColor;
  
  // 设置线宽
  circleLayer.lineWidth = 2.0;
  
  // 设置线的颜色
  circleLayer.strokeColor = [UIColor redColor].CGColor;
  
  // 设置CAShapeLayer与UIBezierPath关联
  circleLayer.path = aPath.CGPath;
  
  // 将CAShaperLayer放到某个层上显示
  [self.view.layer addSublayer:circleLayer];
  
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end

