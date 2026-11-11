//
//  UIView+saveImageWithScale.m
//  CropImageRealSize
//
//  Created by LingYunfenghan on 12/6/13.
//  Copyright (c) 2013 LingYunfenghan. All rights reserved.
//

#import "UIView+saveImageWithScale.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (saveImageWithScale)

- (UIImage *)saveImageWithScale:(float)scale
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self.layer renderInContext:context];
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return theImage;
}
@end
