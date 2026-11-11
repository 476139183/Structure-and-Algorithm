//
//  UINavigationController+DismissKeyboard.h
//  云屏
//
//  Created by LDY on 14-7-25.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>

//解决UIModalPresentationFormSheet模式下resignFirstResponder无法隐藏键盘
@interface UINavigationController (DismissKeyboard)

- (BOOL)disablesAutomaticKeyboardDismissal;

@end
