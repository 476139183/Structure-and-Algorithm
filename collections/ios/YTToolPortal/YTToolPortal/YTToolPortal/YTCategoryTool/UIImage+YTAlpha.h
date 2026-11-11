//
//  UIImage+YTAlpha.h
//  YTToolPortal
//  用于向图像添加alpha层的辅助方法
//  Created by Yutian Duan on 2019/5/24.
//  Copyright © 2019年 Wanwin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YTAlpha)
///! 如果图像有alpha层，则返回 YES
- (BOOL)yt_hasAlpha;
///! 返回给定图像的副本，如果还没有alpha通道，则添加一个alpha通道
- (UIImage *)yt_imageWithAlpha;
///! 返回具有给定大小的透明边框的图像的副本
- (UIImage *)yt_transparentBorderImage:(NSUInteger)borderSize;
/* 创建一个蒙版，使外部边缘透明，其他所有东西都不透明
 * 尺寸必须包含整个遮罩(不透明部分+透明边框)
 * !!!!:调用者负责通过调用CGImageRelease来释放返回的引用
 */
- (CGImageRef)yt_newBorderMask:(NSUInteger)borderSize size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
