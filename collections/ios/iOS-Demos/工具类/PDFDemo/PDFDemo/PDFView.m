//
//  PDFView.m
//  PDFDemo
//
//  Created by Yutian Duan on 2018/7/27.
//  Copyright © 2018年 huangpanpan. All rights reserved.
//

#import "PDFView.h"

@implementation PDFView

- (instancetype)initWithFrame:(CGRect)frame atPage:(NSInteger)page andFileName:(NSString *)fileName {
 self =  [super initWithFrame:frame];
  if (self) {
    _pageNumber = page;
    _fileName = fileName;
  }
  return self;
  
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGPDFPageRef pageRef = CGPDFDocumentGetPage([self createPDFFromExistFile], _pageNumber);//获取指定页的内容如_pageNumber=1，获取的是pdf第一页的内容
  CGRect mediaRect = CGPDFPageGetBoxRect(pageRef, kCGPDFCropBox);//pdf内容的rect
  
  CGContextRetain(context);
  CGContextSaveGState(context);
  
  [[UIColor whiteColor] set];
  CGContextFillRect(context, rect);//填充背景色，否则为全黑色；
  
  CGContextTranslateCTM(context, 0, rect.size.height);//设置位移，x，y；
  
  CGFloat under_bar_height = 64.0f;
  CGContextScaleCTM(context, rect.size.width / mediaRect.size.width, -(rect.size.height + under_bar_height) / mediaRect.size.height);
  
  CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
  CGContextSetRenderingIntent(context, kCGRenderingIntentDefault);
  CGContextDrawPDFPage(context, pageRef);//绘制pdf
  
  CGContextRestoreGState(context);
  CGContextRelease(context);
}

- (CGPDFDocumentRef)createPDFFromExistFile {
  return [self pdfRefByFilePath:[self getPdfPathByFile:_fileName]];
}

//用于本地pdf文件
- (CGPDFDocumentRef)pdfRefByFilePath:(NSString *)aFilePath {
  CFStringRef path;
  CFURLRef url;
  CGPDFDocumentRef document;
  
  path = CFStringCreateWithCString(NULL, [aFilePath UTF8String], kCFStringEncodingUTF8);
  url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, NO);
  document = CGPDFDocumentCreateWithURL(url);
  
  CFRelease(path);
  CFRelease(url);
  
  return document;
}

- (NSString *)getPdfPathByFile:(NSString *)fileName {
  return [[NSBundle mainBundle] pathForResource:fileName ofType:@".pdf"];
}

//用于网络pdf文件
- (CGPDFDocumentRef)pdfRefByDataByUrl:(NSString *)aFileUrl {
  NSData *pdfData = [NSData dataWithContentsOfFile:aFileUrl];
  CFDataRef dataRef = (__bridge_retained CFDataRef)(pdfData);
  
  CGDataProviderRef proRef = CGDataProviderCreateWithCFData(dataRef);
  CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithProvider(proRef);
  
  CGDataProviderRelease(proRef);
  CFRelease(dataRef);
  
  return pdfRef;
}


@end
