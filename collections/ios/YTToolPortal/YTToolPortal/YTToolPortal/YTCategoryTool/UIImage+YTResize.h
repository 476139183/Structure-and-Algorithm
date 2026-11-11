//
//  UIImage+YTResize.h
//  YTToolPortal
//  扩展UIImage类来支持调整大小/裁剪
//  Created by Yutian Duan on 2019/5/24.
//  Copyright © 2019年 Wanwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YTResize)

///!
- (UIImage *)yt_croppedImage:(CGRect)bounds;

- (UIImage *)yt_thumbnailImage:(NSInteger)thumbnailSize
             transparentBorder:(NSUInteger)borderSize
                  cornerRadius:(NSUInteger)cornerRadius
          interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)yt_resizedImage:(CGSize)newSize
        interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)yt_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                     bounds:(CGSize)bounds
                       interpolationQuality:(CGInterpolationQuality)quality;


- (UIImage *)yt_resizedImage:(CGSize)newSize
                   transform:(CGAffineTransform)transform
              drawTransposed:(BOOL)transpose
        interpolationQuality:(CGInterpolationQuality)quality;

- (CGAffineTransform)yt_transformForOrientation:(CGSize)newSize;

@end



