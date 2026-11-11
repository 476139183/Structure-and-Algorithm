//
//  UIImagePickerController+Nonrotating.m
//  云屏
//
//  Created by LDY on 14-7-31.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import "UIImagePickerController+Nonrotating.h"

@implementation UIImagePickerController (Nonrotating)

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger) supportedInterfaceOrientations
{
    //Because your app is only landscape, your view controller for the view in your
    // popover needs to support only landscape
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

@end
