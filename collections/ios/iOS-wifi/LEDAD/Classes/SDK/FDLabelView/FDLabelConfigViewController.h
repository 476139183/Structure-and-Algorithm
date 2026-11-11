//
//  FDLabelConfigViewController.h
//  FDLabelView
//
//  Created by magic on 8/8/13.
//  Copyright (c) 2013 Fourdesire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDFontPickerViewController.h"

#define kFDLabelMaximumLineHeightScale 2
#define kFDLabelMaximumFixedLineHeight 100
#define kFDLabelMaximumNumberOfLine 10
#define kFDLabelMaximumTargetFontSize 100
#define kFDLabelMaximumOriginX 320
#define kFDLabelMaximumOriginY 568
#define kFDLabelMaximumSizeWidth 320
#define kFDLabelMaximumSizeHeight 568

#define kConfigViewHeight 300
#define kEditorWidth 200

@class FDLabelView;

typedef enum {
    FDValueInputterFieldFrameX = 1,
    FDValueInputterFieldFrameY = 2,
    FDValueInputterFieldFrameW = 3,
    FDValueInputterFieldFrameH = 4,
    FDValueInputterFieldPaddingLeft = 5,
    FDValueInputterFieldPaddingRight = 6,
    FDValueInputterFieldPaddingTop = 7,
    FDValueInputterFieldPaddingBottom = 8,
    FDValueInputterFieldLineHeightScale = 9,
    FDValueInputterFieldFixedLineHeight = 10,
    FDValueInputterFieldNumberOfLine = 11,
    FDValueInputterFieldTargetFontSize = 12
} FDValueInputterField;

@interface FDValueInputter : UIView

@property(nonatomic) FDValueInputterField field;
@property(nonatomic, strong) UITextField* valueField;
@property(nonatomic, strong) UILabel* titleView;

@end

@interface FDLabelConfigViewController : UIViewController <FDFontPickerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>{
    NSString* _outputCodes;
    UILabel* _outputLabel;
    BOOL _open;
    
    FDFontPickerViewController* _fontPicker;
    UIFont* _titleFont;
    UIFont* _valueTextFont;
    UIFont* _valueFont;
}

-(void)updateCodes;
-(void)toggleView;

@property(nonatomic, retain) FDValueInputter* valueInputter;
@property(nonatomic, retain) FDLabelView* labelView;
@property(nonatomic, retain) UITableView* tableView;

@end
