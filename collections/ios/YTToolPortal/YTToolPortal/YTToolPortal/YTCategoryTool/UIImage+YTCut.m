//
//  UIImage+YTCut.m
//  YTToolPortal
//
//  Created by Yutian Duan on 2019/5/24.
//  Copyright © 2019年 Wanwin. All rights reserved.
//

#import "UIImage+YTCut.h"
#import "UIImage+YTRoundedCorner.h"

#define SAWTOOTH_COUNT 10
#define SAWTOOTH_WIDTH_FACTOR 20


@implementation UIImage (YTCut)

- (UIImage *)yt_clipImageWithScaleWithsize:(CGSize)asize {
  UIImage *newimage;
  UIImage *image = self;
  if (nil == image) {
    newimage = nil;
  }
  else{
    CGSize oldsize = image.size;
    CGRect rect;
    if (asize.width/asize.height > oldsize.width/oldsize.height) {
      rect.size.width = asize.width;
      rect.size.height = asize.width*oldsize.height/oldsize.width;
      rect.origin.x = 0;
      rect.origin.y = (asize.height - rect.size.height)/2;
    }
    else{
      rect.size.width = asize.height*oldsize.width/oldsize.height;
      rect.size.height = asize.height;
      rect.origin.x = (asize.width - rect.size.width)/2;
      rect.origin.y = 0;
    }
    UIGraphicsBeginImageContext(asize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToRect(context, CGRectMake(0, 0, asize.width, asize.height));
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
    [image drawInRect:rect];
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
  return newimage;
}

- (UIImage *)yt_clipImageWithScaleWithsize:(CGSize)asize roundedCornerImage:(NSInteger)roundedCornerImage borderSize:(NSInteger)borderSize {
  UIImage *image = [self yt_clipImageWithScaleWithsize:asize];
  return [image yt_roundedCornerImage:roundedCornerImage borderSize:borderSize];
}

+ (NSArray *)yt_splitImageIntoTwoParts:(UIImage *)image {
  CGFloat scale = [[UIScreen mainScreen] scale];
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:2];
  CGFloat width,height,widthgap,heightgap;
  int piceCount = SAWTOOTH_COUNT;
  width = image.size.width;
  height = image.size.height;
  widthgap = width/SAWTOOTH_WIDTH_FACTOR;
  heightgap = height/piceCount;
  //    CGRect rect = CGRectMake(0, 0, width, height);
  CGContextRef context;
  CGImageRef imageMasked;
  UIImage *leftImage,*rightImage;
  
  //part one
  UIGraphicsBeginImageContext(CGSizeMake(width*scale, height*scale));
  context = UIGraphicsGetCurrentContext();
  CGContextScaleCTM(context, scale, scale);
  CGContextMoveToPoint(context, 0, 0);
  int a=-1;
  for (int i=0; i<piceCount+1; i++) {
    CGContextAddLineToPoint(context, width/2+(widthgap*a), heightgap*i);
    a= a*-1;
  }
  CGContextAddLineToPoint(context, 0, height);
  CGContextClosePath(context);
  CGContextClip(context);
  [image drawAtPoint:CGPointMake(0, 0)];
  imageMasked = CGBitmapContextCreateImage(context);
  leftImage = [UIImage imageWithCGImage:imageMasked scale:scale orientation:UIImageOrientationUp];
  [array addObject:leftImage];
  UIGraphicsEndImageContext();
  
  //part two
  UIGraphicsBeginImageContext(CGSizeMake(width*scale, height*scale));
  context = UIGraphicsGetCurrentContext();
  CGContextScaleCTM(context, scale, scale);
  CGContextMoveToPoint(context, width, 0);
  a=-1;
  for (int i=0; i<piceCount+1; i++) {
    CGContextAddLineToPoint(context, width/2+(widthgap*a), heightgap*i);
    a= a*-1;
  }
  CGContextAddLineToPoint(context, width, height);
  CGContextClosePath(context);
  CGContextClip(context);
  [image drawAtPoint:CGPointMake(0, 0)];
  imageMasked = CGBitmapContextCreateImage(context);
  rightImage = [UIImage imageWithCGImage:imageMasked scale:scale orientation:UIImageOrientationUp];
  [array addObject:rightImage];
  UIGraphicsEndImageContext();
  
  
  return array;
}

@end
