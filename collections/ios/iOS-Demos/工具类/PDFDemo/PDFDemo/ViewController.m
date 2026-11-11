//
//  ViewController.m
//  PDFDemo
//
//  Created by Yutian Duan on 2018/7/27.
//  Copyright © 2018年 huangpanpan. All rights reserved.
//

/*
 在IOS中预览pdf文件，显示pdf文件一般使用两种方式，
 
 一种是UIWebView，这种方式怎么说呢优点就是除了简单还是简单，直接显示pdf文件；

 另外的一种是自定义UIView，配合CGPDFDocumentRef读取pdf文件里面的内容，在自定义的drawRect方法中描绘获取的pdf内容；
 其实还有一种的方式，就是苹果在IOS4.0后，apple推出新的文件预览控件：QLPreveiewController,支持pdf文件阅读。今天我主要写的是自定义View+CGPDFDocumentRef显示pdf文件；
 
 */

#import "ViewController.h"
#import "PDFView.h"

@interface ViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) NSMutableArray *pdfArr;
@property (nonatomic, strong) UIPageViewController *pageVC;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self actionTwo];
}

#pragma action first
//! 使用 webview 读取 pdf
- (void)actionFirst {
  UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
  [self.view addSubview:webView];
  
  [self loadDocument:@"Reader.pdf" inView:webView];
}

- (void)loadDocument:(NSString *)documentName inView:(UIWebView *)webView {
  NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
  NSURL *url = [NSURL fileURLWithPath:path];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [webView loadRequest:request];
}


#pragma action two
//！使用CGContextDrawPDFPage
- (void)actionTwo {
  self.pdfArr = [NSMutableArray array];
  NSDictionary *options = [NSDictionary  dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
  
  self.pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
  _pageVC.view.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
  _pageVC.delegate = self;
  _pageVC.dataSource = self;
  [self addChildViewController:_pageVC];
  
  //! 单纯用来调用方法
  PDFView *testPdf = [[PDFView alloc] initWithFrame:_pageVC.view.bounds atPage:1 andFileName:@"Reader"];
  
  CGPDFDocumentRef pdfRef = [testPdf createPDFFromExistFile];
  //这个位置主要是获取pdf页码数；
  size_t count = CGPDFDocumentGetNumberOfPages(pdfRef);
  
  for (int i = 0; i < count; i++) {
    UIViewController *pdfVC = [[UIViewController alloc] init];
    PDFView *pdfView = [[PDFView alloc] initWithFrame:_pageVC.view.bounds atPage:(i+1) andFileName:@"Reader"];
    [pdfVC.view addSubview:pdfView];
    [_pdfArr addObject:pdfVC];
  }
  
  
  [_pageVC setViewControllers:[NSArray arrayWithObject:_pdfArr[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
  [self.view addSubview:_pageVC.view];

}

//委托方法；
- (UIViewController *)viewControllerAtIndex:(NSInteger)index {
  //Create a new view controller and pass suitable data.
  
  if (([_pdfArr count] == 0 )|| (index > [_pdfArr count]) ) {
    return nil;
  }
  
  NSLog(@"index = %ld",(long)index);
  
  return (UIViewController *)_pdfArr[index];
}


- (NSUInteger) indexOfViewController:(UIViewController *)viewController {
  return [self.pdfArr indexOfObject:viewController];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
  NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
  if (index == NSNotFound) {
    return nil;
  }
  
  index++;
  
  if (index == [_pdfArr count]){
    return  nil;
  }
  
  return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
  NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
  if ((index == 0 ) || (index == NSNotFound)){
    return nil;
  }
  index--;
  return [self viewControllerAtIndex:index];
}



@end
