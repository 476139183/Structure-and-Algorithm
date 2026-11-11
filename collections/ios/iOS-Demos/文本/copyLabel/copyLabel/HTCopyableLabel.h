//
//  HTCopyableLabel.h
//  HotelTonight
//   
//  Created by laidiya on 15/5/29.
//  Copyright (c) 2015年 LDY. All rights reserved.
//



#import <UIKit/UIKit.h>

@class HTCopyableLabel;

@protocol HTCopyableLabelDelegate <NSObject>

@optional

- (NSString *)stringToCopyForCopyableLabel:(HTCopyableLabel *)copyableLabel;
- (CGRect)copyMenuTargetRectInCopyableLabelCoordinates:(HTCopyableLabel *)copyableLabel;

@end

@interface HTCopyableLabel : UILabel

@property (nonatomic, assign) BOOL copyingEnabled; // Defaults to YES

@property (nonatomic, strong) id<HTCopyableLabelDelegate> copyableLabelDelegate;

@property (nonatomic, assign) UIMenuControllerArrowDirection copyMenuArrowDirection; // Defaults to UIMenuControllerArrowDefault

// You may want to add longPressGestureRecognizer to a container view
@property (nonatomic, strong, readonly) UILongPressGestureRecognizer *longPressGestureRecognizer;

@end
