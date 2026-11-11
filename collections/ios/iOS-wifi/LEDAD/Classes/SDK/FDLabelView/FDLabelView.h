//
//  FDLabelView.h
//  FDLabelView
//
//  Created by magic on 8/8/13.
//  Copyright (c) 2013 Fourdesire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDLabelConfigViewController.h"

typedef enum {
    FDAutoFitModeNone = 0,
    FDAutoFitModeContrainedFrame = 1,
    FDAutoFitModeAutoHeight = 2
} FDAutoFitMode;

typedef enum {
    FDLabelFitAlignmentTop = 0,
    FDLabelFitAlignmentCenter = 1,
    FDLabelFitAlignmentBottom = 2
} FDLabelFitAlignment;

typedef enum {
    FDTextAlignmentLeft = 0,
    FDTextAlignmentCenter = 1,
    FDTextAlignmentRight = 2,
    FDTextAlignmentJustify = 3,
    FDTextAlignmentFill = 4
} FDTextAlignment;

typedef enum {
    FDLineHeightScaleBaseLineTop = 0,
    FDLineHeightScaleBaseLineCenter = 1,
    FDLineHeightScaleBaseLineBottom = 2
} FDLineHeightScaleBaseLine;

@interface FDLabelView : UILabel {
    CGFloat _fixedLineHeight;
    CGFloat _lineHeightScale;
    CGRect _contentBounds;
    NSArray* _textLines;
    
    // Drawing
    int _enumerateIndex;
    
    // For debug mode
    CGPoint _lastTouchPoint;
    UIButton* _debugMenu;
    UITapGestureRecognizer* _gestureRecognizer;
}


// Methods for fast adjustment
-(void)alignParentHorizontalCenter:(CGFloat)offset;
-(void)alignParentLeft:(CGFloat)offset;
-(void)alignParentRight:(CGFloat)offset;
-(void)alignParentVerticalCenter:(CGFloat)offset;
-(void)alignParentTop:(CGFloat)offset;
-(void)alignParentBottom:(CGFloat)offset;
-(void)contrainedToFrame:(CGRect)frame;

@property(nonatomic) BOOL debug;
@property(nonatomic) BOOL showLog;
@property(nonatomic) FDTextAlignment fdTextAlignment;
@property(nonatomic) FDLineHeightScaleBaseLine fdLineScaleBaseLine;
@property(nonatomic) FDLabelFitAlignment fdLabelFitAlignment;
@property(nonatomic) FDAutoFitMode fdAutoFitMode;
@property(nonatomic) CGFloat lineHeightScale;
@property(nonatomic) CGFloat fixedLineHeight;
@property(nonatomic) CGFloat actualTextHeight;
@property(nonatomic) CGFloat visualTextHeight;
@property(nonatomic) NSUInteger actualLineNumber;
@property(nonatomic) NSUInteger visualLineNumber;
@property(nonatomic) UIEdgeInsets contentInset;
@property(nonatomic, retain) UIFont* adjustedFont;
// For debug mode
@property(nonatomic) BOOL debugShowLineBreaks;
@property(nonatomic) BOOL debugShowFrameBounds;
@property(nonatomic) BOOL debugShowPaddings;
@property(nonatomic) BOOL debugShowCoordinates;

@property(nonatomic, retain) NSArray* debugSentences;
@property(nonatomic, retain) NSString* outputName;
@property(nonatomic, retain) UIFont* debugFont;
@property(nonatomic, retain) UIView* debugParentView;
@property(nonatomic, retain) FDLabelConfigViewController* configController;

@end

