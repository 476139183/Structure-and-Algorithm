//
//  UIImage+YTRoundedCorner.h
//  YTToolPortal
//  扩展UIImage类，以支持生成圆角
//  Created by Yutian Duan on 2019/5/24.
//  Copyright © 2019年 Wanwin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (YTRoundedCorner)

- (UIImage *)yt_roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

- (void)yt_addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight;


@end

