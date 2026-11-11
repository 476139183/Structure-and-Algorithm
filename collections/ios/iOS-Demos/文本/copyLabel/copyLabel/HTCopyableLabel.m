//
//  HTCopyableLabel.m
//  HotelTonight
//
//  Created by laidiya on 15/5/29.
//  Copyright (c) 2015年 LDY. All rights reserved.
//

#import "HTCopyableLabel.h"

@interface HTCopyableLabel ()

@end

@implementation HTCopyableLabel

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setup];
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setup];
}

- (void)setup {
  _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
  _longPressGestureRecognizer.minimumPressDuration = 0.5;
  _longPressGestureRecognizer.numberOfTouchesRequired = 1;
  [self addGestureRecognizer:_longPressGestureRecognizer];
  
  _copyMenuArrowDirection = UIMenuControllerArrowDefault;
  
  _copyingEnabled = YES;
  self.userInteractionEnabled = YES;
}

#pragma mark - Public

- (void)setCopyingEnabled:(BOOL)copyingEnabled {
  if (_copyingEnabled != copyingEnabled) {
    [self willChangeValueForKey:@"copyingEnabled"];
    _copyingEnabled = copyingEnabled;
    [self didChangeValueForKey:@"copyingEnabled"];
    self.userInteractionEnabled = copyingEnabled;
    self.longPressGestureRecognizer.enabled = copyingEnabled;
  }
}

#pragma mark - Callbacks
// 出现的功能
- (void)longPressGestureRecognized:(UILongPressGestureRecognizer *)gestureRecognizer {
  if (gestureRecognizer == self.longPressGestureRecognizer) {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
      NSAssert([self becomeFirstResponder], @"Sorry, UIMenuController will not work with %@ since it cannot become first responder", self);
      
      UIMenuController *copyMenu = [UIMenuController sharedMenuController];
      
      UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"不同意" action:@selector(bad:)];
      UIMenuItem *item3 = [[UIMenuItem alloc] initWithTitle:@"我不说话" action:@selector(good:)];
      UIMenuItem *item4 = [[UIMenuItem alloc] initWithTitle:@"同意" action:@selector(great:)];
      NSArray *menuItems = [NSArray arrayWithObjects:item2,item3,item4,nil];
      
      
      [copyMenu setMenuItems:menuItems];
      
      if ([self.copyableLabelDelegate respondsToSelector:@selector(copyMenuTargetRectInCopyableLabelCoordinates:)]) {
        [copyMenu setTargetRect:[self.copyableLabelDelegate copyMenuTargetRectInCopyableLabelCoordinates:self] inView:self];
      } else {
        [copyMenu setTargetRect:self.bounds inView:self];
      }
      
      copyMenu.arrowDirection = self.copyMenuArrowDirection;
      
      [copyMenu setMenuVisible:YES animated:YES];
      
    }
  }
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder {
  return self.copyingEnabled;
}


//是否允许
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
  BOOL retValue = NO;
  
  if (action == @selector(copy:)
      ||action==@selector(bad:)
      ||action==@selector(good:)
      ||action==@selector(great:)) {
    if (self.copyingEnabled) {
      retValue = YES;
    }
  } else {
    // Pass the canPerformAction:withSender: message to the superclass
    // and possibly up the responder chain.
    retValue = [super canPerformAction:action withSender:sender];
  }
  
  return retValue;
}

// copy 方法
- (void)copy:(id)sender {
  if (self.copyingEnabled) {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSString *stringToCopy;

    if ([self.copyableLabelDelegate respondsToSelector:@selector(stringToCopyForCopyableLabel:)]) {
      stringToCopy = [self.copyableLabelDelegate stringToCopyForCopyableLabel:self];
    } else {
      stringToCopy = self.text;
    }
    NSArray *array = [stringToCopy componentsSeparatedByString:@":"]; //从字符:中分隔成2个元素的数组
    [pasteboard setString:array.lastObject];
    
    // NSLog(@"段雨田复制成功＝＝＝＝%@",array.lastObject);
  }
}

- (void)bad:(id)sender {
  UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的选择有误" delegate:nil cancelButtonTitle:@"好吧" otherButtonTitles:@"胖子是猪", nil];
  [view show];
}

- (void)good:(id)sender {
  NSLog(@"1111");
  UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"算你有良心" delegate:nil cancelButtonTitle:@"好吧" otherButtonTitles:@"胖子还是猪", nil];
  [view show];
}

- (void)great:(id)sender {
  UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"算你有眼光" delegate:nil cancelButtonTitle:@"当然" otherButtonTitles:@"胖子仍然是猪", nil];
  [view show];
  
}

@end

