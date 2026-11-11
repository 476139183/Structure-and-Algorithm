//
//  UIImage+YTCut.h
//  YTToolPortal
//  图片裁剪
//  Created by Yutian Duan on 2019/5/24.
//  Copyright © 2019年 Wanwin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (YTCut)

- (UIImage *)yt_clipImageWithScaleWithsize:(CGSize)asize;

- (UIImage *)yt_clipImageWithScaleWithsize:(CGSize)asize roundedCornerImage:(NSInteger)roundedCornerImage borderSize:(NSInteger)borderSize;

///!
+ (NSArray*)yt_splitImageIntoTwoParts:(UIImage*)image;


@end

