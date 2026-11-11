//
//  CustomButton.h
//  Absens
//
//  Created by LDY on 2/21/14.
//  Copyright (c) 2014 com.ledmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

/**
 *@brief  返回按钮 只含图片
 */
- (id)initWithFrame:(CGRect)frame withNormalImage:(NSString *)normalImage withHighImage:(NSString *)highImage;

/**
 *@brief  带标题的图片
 */
- (id)initWithFrame:(CGRect)frame withNormalImage:(NSString *)normalImage withHighImage:(NSString *)highImage withTitle:(NSString *)title;


@end
