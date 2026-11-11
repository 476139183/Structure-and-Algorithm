//
//  FDLabelConfigViewController.m
//  FDLabelView
//
//  Created by magic on 8/8/13.
//  Copyright (c) 2013 Fourdesire. All rights reserved.
//

#import "FDLabelConfigViewController.h"
#import "FDLabelView.h"
#import <QuartzCore/QuartzCore.h>


@implementation FDValueInputter

@synthesize valueField, titleView, field;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
        
        valueField = [[UITextField alloc] initWithFrame:CGRectMake(100, 12, 150, 20)];
        valueField.returnKeyType = UIReturnKeyDone;
        valueField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        valueField.textColor = [UIColor lightGrayColor];
        [self addSubview:valueField];
        
        titleView = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 80, 20)];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.textColor = [UIColor whiteColor];
        titleView.adjustsFontSizeToFitWidth = YES;
        titleView.minimumScaleFactor = 0.5;
        [self addSubview:titleView];
    }
    return self;
}

@end

@interface FDLabelConfigViewController ()

@end

@implementation FDLabelConfigViewController
@synthesize labelView, tableView, valueInputter;

-(void)loadView{
    [super loadView];
    
    CGSize screen = [UIScreen mainScreen].bounds.size;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    self.view.frame = CGRectMake(-kEditorWidth, 0, kEditorWidth, screen.height);
    
    UIView* shadowView = [[UIView alloc] initWithFrame:CGRectMake(kEditorWidth, 0, 2, screen.height)];
    shadowView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    [self.view addSubview:shadowView];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kEditorWidth, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundView = [UIView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
    
    [tableView reloadData];
    
    
    UILabel* titleView = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.textColor = [UIColor whiteColor];
    titleView.textAlignment = NSTextAlignmentLeft;
    titleView.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:18];
    titleView.text = @"Editor";
    
    valueInputter = [[FDValueInputter alloc] initWithFrame:CGRectMake(5, 0, kEditorWidth - 10, 44)];
    valueInputter.valueField.delegate = self;
    
    [self.view addSubview:valueInputter];
    
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kEditorWidth, 44)];
    header.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    [header addSubview:titleView];
    
    UIButton* closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEditorWidth - 30, 12, 20, 20)];
    closeBtn.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    closeBtn.layer.cornerRadius = 10;
    closeBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
    [closeBtn setTitle:@"x" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(toggleView) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:closeBtn];
    
    [self.view addSubview:header];
    
    _titleFont = [UIFont fontWithName:@"AvenirNextCondensed-Medium" size:12];
    _valueFont = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:10];
    _valueTextFont = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:14];
}

-(void)showInputter:(NSString*)title value:(NSString*)value field:(FDValueInputterField)field{
    valueInputter.field = field;
    valueInputter.valueField.text = value;
    valueInputter.titleView.text = title;
    
    [valueInputter.layer removeAllAnimations];
    [UIView animateWithDuration:0.3 animations:^{
        valueInputter.frame = CGRectMake(5, 44, valueInputter.frame.size.width, valueInputter.frame.size.height);
    }];
    
    [valueInputter.valueField becomeFirstResponder];
}

-(void)hideInputter{
    [valueInputter.layer removeAllAnimations];
    [UIView animateWithDuration:0.3 animations:^{
        valueInputter.frame = CGRectMake(5, 0, valueInputter.frame.size.width, valueInputter.frame.size.height);
    }];
    
    
    [valueInputter.valueField resignFirstResponder];
}

-(void)toggleView{
    _open = !_open;
    [self.view.layer removeAllAnimations];
    
    CGSize screen = [UIScreen mainScreen].bounds.size;
    if (_open) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }else{
        [self hideInputter];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(-kEditorWidth, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

-(NSString*)getUIColorCode:(UIColor*)color{
    CGFloat r = 0;
    CGFloat g = 0;
    CGFloat b = 0;
    CGFloat a = 0;
    CGFloat w = 0;
    CGFloat h = 0;
    CGFloat s = 0;
    CGFloat bright = 0;
    
    if ([color getHue:&h saturation:&s brightness:&bright alpha:&a]) {
        return [NSString stringWithFormat:@"[UIColor colorWithHue:%.2f saturation:%.2f brightness:%.2f alpha:%.2f];",
                h, s, bright, a];
    }
    
    if ([color getRed:&r green:&g blue:&b alpha:&a]) {
        return [NSString stringWithFormat:@"[UIColor colorWithRed:%.2f green:%.2f blue:%.2f alpha:%.2f];",
                r, g, b, a];
    }
    
    if ([color getWhite:&w alpha:&a]){
        return [NSString stringWithFormat:@"[UIColor colorWithWhite:%.2f alpha:%.2f];",
                w, a];
    }
    
    return @"nil; // fill your color here";
}

-(void)updateCodes{
    NSMutableString* codes = [NSMutableString stringWithFormat:@"FDLabelView* %@ = [[FDLabelView alloc] initWithFrame:CGRectMake(%.1f, %.1f, %.1f, %.1f)];\n", labelView.outputName, labelView.frame.origin.x, labelView.frame.origin.y, labelView.frame.size.width, labelView.frame.size.height];
    
    [codes appendFormat:@"%@.backgroundColor = %@\n", labelView.outputName, [self getUIColorCode:labelView.backgroundColor]];
    [codes appendFormat:@"%@.textColor = %@\n", labelView.outputName, [self getUIColorCode:labelView.textColor]];
    [codes appendFormat:@"%@.font = [UIFont fontWithName:@\"%@\" size:%.1f];\n", labelView.outputName, labelView.font.fontName, labelView.font.pointSize];
    [codes appendFormat:@"%@.minimumScaleFactor = %.2f;\n", labelView.outputName, labelView.minimumScaleFactor];
    [codes appendFormat:@"%@.numberOfLines = %d;\n", labelView.outputName, labelView.numberOfLines];
    
    [codes appendFormat:@"%@.text = @\"%@\";\n", labelView.outputName, [labelView.text stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]];
    
    [codes appendFormat:@"%@.shadowColor = %@\n", labelView.outputName, [self getUIColorCode:labelView.shadowColor]];
    [codes appendFormat:@"%@.shadowOffset = CGSizeMake(%.1f, %.1f);\n", labelView.outputName, labelView.shadowOffset.width, labelView.shadowOffset.height];
    
    [codes appendFormat:@"%@.lineHeightScale = %.2f;\n", labelView.outputName, labelView.lineHeightScale];
    [codes appendFormat:@"%@.fixedLineHeight = %.2f;\n", labelView.outputName, labelView.fixedLineHeight];
    switch (labelView.fdLineScaleBaseLine) {
        case FDLineHeightScaleBaseLineBottom:
            [codes appendFormat:@"%@.fdLineScaleBaseLine = FDLineHeightScaleBaseLineBottom;\n", labelView.outputName];
            break;
        case FDLineHeightScaleBaseLineCenter:
            [codes appendFormat:@"%@.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;\n", labelView.outputName];
            break;
        case FDLineHeightScaleBaseLineTop:
            [codes appendFormat:@"%@.fdLineScaleBaseLine = FDLineHeightScaleBaseLineTop;\n", labelView.outputName];
            break;
        default:
            break;
    }
    
    switch (labelView.fdTextAlignment) {
        case FDTextAlignmentCenter:
            [codes appendFormat:@"%@.fdTextAlignment = FDTextAlignmentCenter;\n", labelView.outputName];
            break;
        case FDTextAlignmentFill:
            [codes appendFormat:@"%@.fdTextAlignment = FDTextAlignmentFill;\n", labelView.outputName];
            break;
        case FDTextAlignmentJustify:
            [codes appendFormat:@"%@.fdTextAlignment = FDTextAlignmentJustify;\n", labelView.outputName];
            break;
        case FDTextAlignmentLeft:
            [codes appendFormat:@"%@.fdTextAlignment = FDTextAlignmentLeft;\n", labelView.outputName];
            break;
        case FDTextAlignmentRight:
            [codes appendFormat:@"%@.fdTextAlignment = FDTextAlignmentRight;\n", labelView.outputName];
            break;
        default:
            break;
    }
    
    switch (labelView.fdAutoFitMode) {
        case FDAutoFitModeAutoHeight:
            [codes appendFormat:@"%@.fdAutoFitMode = FDAutoFitModeAutoHeight;\n", labelView.outputName];
            break;
        case FDAutoFitModeContrainedFrame:
            [codes appendFormat:@"%@.fdAutoFitMode = FDAutoFitModeContrainedFrame;\n", labelView.outputName];
            break;
        case FDAutoFitModeNone:
            [codes appendFormat:@"%@.fdAutoFitMode = FDAutoFitModeNone;\n", labelView.outputName];
            break;
        default:
            break;
    }
    
    switch (labelView.fdLabelFitAlignment) {
        case FDLabelFitAlignmentBottom:
            [codes appendFormat:@"%@.fdLabelFitAlignment = FDLabelFitAlignmentBottom;\n", labelView.outputName];
            break;
        case FDLabelFitAlignmentCenter:
            [codes appendFormat:@"%@.fdLabelFitAlignment = FDLabelFitAlignmentCenter;\n", labelView.outputName];
            break;
        case FDLabelFitAlignmentTop:
            [codes appendFormat:@"%@.fdLabelFitAlignment = FDLabelFitAlignmentTop;\n", labelView.outputName];
            break;
        default:
            break;
    }
    
    [codes appendFormat:@"%@.contentInset = UIEdgeInsetsMake(%.1f, %.1f, %.1f, %.1f);\n", labelView.outputName,
     labelView.contentInset.top, labelView.contentInset.left, labelView.contentInset.bottom, labelView.contentInset.right];
    [codes appendFormat:@"[someView addSubview:%@]; // Attach your view here\n", labelView.outputName];

    // Debug properties
    [codes appendString:@"// Debug properties\n"];
    [codes appendFormat:@"%@.outputName = @\"%@\";\n", labelView.outputName, labelView.outputName];
    [codes appendFormat:@"%@.debugShowLineBreaks = %@;\n", labelView.outputName, labelView.debugShowLineBreaks? @"YES" : @"NO"];
    [codes appendFormat:@"%@.debugShowCoordinates = %@;\n", labelView.outputName, labelView.debugShowCoordinates? @"YES" : @"NO"];
    [codes appendFormat:@"%@.debugShowFrameBounds = %@;\n", labelView.outputName, labelView.debugShowFrameBounds? @"YES" : @"NO"];
    [codes appendFormat:@"%@.debugShowPaddings = %@;\n", labelView.outputName, labelView.debugShowPaddings? @"YES" : @"NO"];

    [codes appendFormat:@"%@.debugParentView = nil; // specify view for debug panel here. \n", labelView.outputName];
    
    [codes appendFormat:@"%@.debugSentences = @[\n", labelView.outputName];
    for (int i = 0; i < labelView.debugSentences.count; i++) {
        if (i == 0) {
            [codes appendFormat:@"  @\"%@\"", [labelView.debugSentences[i] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]];
        }else{
            [codes appendFormat:@",\n @\"%@\"", [labelView.debugSentences[i] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]];
        }
    }
    [codes appendString:@"                  ];\n"];
    [codes appendFormat:@"%@.debug = %@;\n", labelView.outputName, labelView.debug? @"YES" : @"NO"];
    
    _outputCodes = [NSString stringWithString:codes];
    if(_outputLabel) _outputLabel.text = _outputCodes;
}

-(void)numberOfLinesChanged:(UISlider*)slider{
    int convertedValue = (int)(slider.value);
    slider.value = convertedValue;
    labelView.numberOfLines = convertedValue;
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%d", convertedValue];
}

-(void)lineHeightScaleChanged:(UISlider*)slider{
    float convertedValue = (int)(slider.value * 100) / 100.0;
    slider.value = convertedValue;
    labelView.lineHeightScale = convertedValue;
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%.2f", labelView.lineHeightScale];
}

-(void)lineHeightChanged:(UISlider*)slider{
    float convertedValue = (int)(slider.value * 2) / 2.0;
    slider.value = convertedValue;
    
    labelView.fixedLineHeight = convertedValue;
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%.1f", labelView.fixedLineHeight];
}

-(void)paddingLeftChange:(UISlider*)slider{
    float convertedValue = (int)(slider.value * 2) / 2.0;
    slider.value = convertedValue;
    
    labelView.contentInset = UIEdgeInsetsMake(labelView.contentInset.top, convertedValue, labelView.contentInset.bottom, labelView.contentInset.right);
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%.1f", convertedValue];
}

-(void)paddingRightChange:(UISlider*)slider{
    float convertedValue = (int)(slider.value * 2) / 2.0;
    slider.value = convertedValue;
    
    labelView.contentInset = UIEdgeInsetsMake(labelView.contentInset.top, labelView.contentInset.left, labelView.contentInset.bottom, convertedValue);
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%.1f", convertedValue];
}

-(void)paddingTopChange:(UISlider*)slider{
    float convertedValue = (int)(slider.value * 2) / 2.0;
    slider.value = convertedValue;
    
    labelView.contentInset = UIEdgeInsetsMake(convertedValue, labelView.contentInset.left, labelView.contentInset.bottom, labelView.contentInset.right);
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%.1f", convertedValue];
}

-(void)paddingBottomChange:(UISlider*)slider{
    float convertedValue = (int)(slider.value * 2) / 2.0;
    slider.value = convertedValue;
    
    labelView.contentInset = UIEdgeInsetsMake(labelView.contentInset.top, labelView.contentInset.left, convertedValue, labelView.contentInset.right);
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%.1f", convertedValue];
}

-(void)targetFontSizeChanged:(UISlider*)slider{
    float convertedValue = (int)(slider.value * 2) / 2.0;
    slider.value = convertedValue;
    
    labelView.font = [UIFont fontWithName:labelView.font.fontName size:convertedValue];
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%.1f", convertedValue];
}

-(void)minimumScaleFactorChanged:(UISlider*)slider{
    float convertedValue = (int)(slider.value * 100) / 100.0;
    slider.value = convertedValue;
    
    labelView.minimumScaleFactor = convertedValue;
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%.2f", convertedValue];
}

-(void)originXChanged:(UISlider*)slider{
    float convertedValue = (int)(slider.value * 2) / 2.0;
    slider.value = convertedValue;
    
    labelView.frame = CGRectMake(convertedValue, labelView.frame.origin.y, labelView.frame.size.width, labelView.frame.size.height);
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%.1f", convertedValue];
}

-(void)originYChanged:(UISlider*)slider{
    float convertedValue = (int)(slider.value * 2) / 2.0;
    slider.value = convertedValue;
    
    labelView.frame = CGRectMake(labelView.frame.origin.x, convertedValue, labelView.frame.size.width, labelView.frame.size.height);
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%.1f", convertedValue];
}

-(void)sizeWidthChanged:(UISlider*)slider{
    float convertedValue = (int)(slider.value * 2) / 2.0;
    slider.value = convertedValue;
    
    labelView.frame = CGRectMake(labelView.frame.origin.x, labelView.frame.origin.y, convertedValue, labelView.frame.size.height);
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%.1f", convertedValue];
}

-(void)sizeHeightChanged:(UISlider*)slider{
    float convertedValue = (int)(slider.value * 2) / 2.0;
    slider.value = convertedValue;
    
    labelView.frame = CGRectMake(labelView.frame.origin.x, labelView.frame.origin.y, labelView.frame.size.width, convertedValue);
    UILabel* value = [slider.superview subviews][1];
    value.text = [NSString stringWithFormat:@"%.1f", convertedValue];
}

#pragma mark - Table view data source

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
    header.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    UILabel* titleView = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 30)];
    
    titleView.backgroundColor = [UIColor clearColor];
    titleView.textColor = [UIColor colorWithRed:0.30f green:0.30f blue:0.30f alpha:1.00f];
    titleView.font = [UIFont fontWithName:@"AvenirNextCondensed-DemiBold" size:14];
    titleView.text = [self tableView:self.tableView titleForHeaderInSection:section];
    [header addSubview:titleView];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 1:
            return 70;
        case 2:
            switch (indexPath.row) {
                case 2:
                case 3:
                    return 44;
                    break;
                    
                default:
                    return 70;
            }
            break;
        case 3:
        case 4:
            return 70;
        case 6:
            return 100;
        default:
            return 44;
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
        case 1:
            return 3;
        case 2:
        case 3:
        case 4:
            return 4;
        case 5:
            return labelView.debugSentences.count;
        case 6:
            return 1;
        case 7:
            return 4;
        case 8:
            return 6;
        default:
            break;
    }
    return 1;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Alignment";
        case 1:
            return @"Line";
        case 2:
            return @"Font";
        case 3:
            return @"Paddings";
        case 4:
            return @"Frames";
        case 5:
            return @"Debug Sentences";
        case 6:
            return @"Copy Codes to Clipboard";
        case 7:
            return @"Debug Rendering";
        case 8:
            return @"Other Methods";
        default:
            break;
    }
    
    return @"Others";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.minimumScaleFactor = 0.5;
        cell.textLabel.font = _titleFont;
        cell.textLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1];
    }
    
    switch (indexPath.section) {
        case 0: {
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithRed:0.11f green:0.53f blue:0.82f alpha:1.00f];
            label.textAlignment = NSTextAlignmentRight;
            label.font = _valueTextFont;
            cell.accessoryView = label;
            
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Text";
                    switch (labelView.fdTextAlignment) {
                        case FDTextAlignmentCenter:
                            label.text = @"Center";
                            break;
                        case FDTextAlignmentFill:
                            label.text = @"Fill";
                            break;
                        case FDTextAlignmentRight:
                            label.text = @"Right";
                            break;
                        case FDTextAlignmentLeft:
                            label.text = @"Left";
                            break;
                        case FDTextAlignmentJustify:
                            label.text = @"Justify";
                            break;
                        default:
                            break;
                    }
                    break;
                case 1:
                    cell.textLabel.text = @"Base";
                    switch (labelView.fdLineScaleBaseLine) {
                        case FDLineHeightScaleBaseLineTop:
                            label.text = @"Scale Top";
                            break;
                        case FDLineHeightScaleBaseLineCenter:
                            label.text = @"Scale Center";
                            break;
                        case FDLineHeightScaleBaseLineBottom:
                            label.text = @"Scale Bottom";
                            break;
                        default:
                            break;
                    }
                    break;
                case 2:{
                    cell.textLabel.text = @"Label Alignment";
                    switch (labelView.fdLabelFitAlignment) {
                        case FDLabelFitAlignmentTop:
                            label.text = @"Top";
                            break;
                        case FDLabelFitAlignmentCenter:
                            label.text = @"Center";
                            break;
                        case FDLabelFitAlignmentBottom:
                            label.text = @"Bottom";
                            break;
                        default:
                            break;
                    }
                }
                    break;
                case 3:{
                    cell.textLabel.text = @"Auto Fit";
                    switch (labelView.fdAutoFitMode) {
                        case FDAutoFitModeNone:
                            label.text = @"None";
                            break;
                        case FDAutoFitModeContrainedFrame:
                            label.text = @"Frame";
                            break;
                        case FDAutoFitModeAutoHeight:
                            label.text = @"Auto Height";
                            break;
                        default:
                            break;
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(40, 26, kEditorWidth - 45, 44)];
            slider.maximumValue = kFDLabelMaximumLineHeightScale;
            slider.minimumValue = 0;
            [cell.contentView addSubview:slider];
            
            UILabel* value = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, 20, 44)];
            value.backgroundColor = [UIColor clearColor];
            value.textColor = [UIColor colorWithRed:0.11f green:0.53f blue:0.82f alpha:1.00f];
            value.font = _valueFont;
            [cell.contentView addSubview:value];
            
            UILabel* titleView = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kEditorWidth - 20, 20)];
            titleView.backgroundColor = [UIColor clearColor];
            titleView.textColor = [UIColor colorWithWhite:0.2 alpha:1];
            titleView.font = _titleFont;
            titleView.numberOfLines = 2;
            [cell.contentView addSubview:titleView];
            
            switch (indexPath.row) {
                case 0:{
                    slider.maximumValue = kFDLabelMaximumLineHeightScale;
                    slider.minimumValue = 0;
                    slider.value = labelView.lineHeightScale;
                    [slider addTarget:self action:@selector(lineHeightScaleChanged:) forControlEvents:UIControlEventValueChanged];

                    value.text = [NSString stringWithFormat:@"%.2f", labelView.lineHeightScale];
                    titleView.text = @"Line Height Scale";
                    
                }
                    break;
                case 1:{
                    slider.maximumValue = kFDLabelMaximumFixedLineHeight;
                    slider.minimumValue = 0;
                    slider.value = labelView.fixedLineHeight;
                    [slider addTarget:self action:@selector(lineHeightChanged:) forControlEvents:UIControlEventValueChanged];
                  
                    value.text = [NSString stringWithFormat:@"%.1f", labelView.fixedLineHeight];
                    titleView.text = @"Fixed Line Height";
                }
                    break;
                case 2:{
                    slider.maximumValue = kFDLabelMaximumNumberOfLine;
                    slider.minimumValue = 0;
                    slider.value = labelView.numberOfLines;
                    [slider addTarget:self action:@selector(numberOfLinesChanged:) forControlEvents:UIControlEventValueChanged];

                    value.text = [NSString stringWithFormat:@"%d", labelView.numberOfLines];
                    titleView.text = @"Number of Line";
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                    
                    UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(40, 26, kEditorWidth - 45, 44)];
                    slider.maximumValue = kFDLabelMaximumTargetFontSize;
                    slider.minimumValue = 0;
                    
                    slider.value = labelView.font.pointSize;
                    [slider addTarget:self action:@selector(targetFontSizeChanged:) forControlEvents:UIControlEventValueChanged];
                    [cell.contentView addSubview:slider];
                    UILabel* value = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, 20, 44)];
                    value.backgroundColor = [UIColor clearColor];
                    value.textColor = [UIColor colorWithRed:0.11f green:0.53f blue:0.82f alpha:1.00f];
                    value.text = [NSString stringWithFormat:@"%.1f", labelView.font.pointSize];
                    value.font = _valueFont;
                    [cell.contentView addSubview:value];
                    
                    value = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 280, 20)];
                    value.backgroundColor = [UIColor clearColor];
                    value.textColor = [UIColor colorWithWhite:0.2 alpha:1];
                    value.text = @"Target Font Size";
                    value.font = _titleFont;
                    [cell.contentView addSubview:value];
                    
                }
                    break;
                case 1:{
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                    
                    UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(40, 26, kEditorWidth - 45, 44)];
                    slider.maximumValue = 1;
                    slider.minimumValue = 0;
                    slider.value = labelView.minimumScaleFactor;
                    [slider addTarget:self action:@selector(minimumScaleFactorChanged:) forControlEvents:UIControlEventValueChanged];
                    [cell.contentView addSubview:slider];
                    UILabel* value = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, 20, 44)];
                    value.backgroundColor = [UIColor clearColor];
                    value.textColor = [UIColor colorWithRed:0.11f green:0.53f blue:0.82f alpha:1.00f];
                    value.text = [NSString stringWithFormat:@"%.2f", labelView.minimumScaleFactor];
                    value.font = _valueFont;
                    value.adjustsFontSizeToFitWidth = YES;
                    value.minimumScaleFactor = 0.5;
                    [cell.contentView addSubview:value];
                    
                    value = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 20)];
                    value.backgroundColor = [UIColor clearColor];
                    value.textColor = [UIColor colorWithWhite:0.2 alpha:1];
                    value.text = @"Minimum Scale Factor";
                    value.font = _titleFont;
                    [cell.contentView addSubview:value];
                }
                    break;
                case 2:{
                    cell.textLabel.text = @"Adjust Font Size to Fit";
                    
                    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor colorWithRed:0.11f green:0.53f blue:0.82f alpha:1.00f];
                    label.textAlignment = NSTextAlignmentRight;
                    label.font = _valueTextFont;
                    cell.accessoryView = label;
                    
                    label.text = labelView.adjustsFontSizeToFitWidth? @"ON" : @"OFF";
                }
                    break;
                case 3:{
                    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor colorWithRed:0.11f green:0.53f blue:0.82f alpha:1.00f];
                    label.textAlignment = NSTextAlignmentRight;
                    label.adjustsFontSizeToFitWidth = YES;
                    label.minimumScaleFactor = 0.5;
                    label.font = _valueTextFont;
                    
                    cell.accessoryView = label;
                    cell.textLabel.text = @"Font Name";
                    
                    label.text = labelView.font.fontName;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(40, 26, kEditorWidth - 45, 44)];
            slider.minimumValue = 0;
            
            [cell.contentView addSubview:slider];
            UILabel* value = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, 20, 44)];
            value.backgroundColor = [UIColor clearColor];
            value.textColor = [UIColor colorWithRed:0.11f green:0.53f blue:0.82f alpha:1.00f];
            value.adjustsFontSizeToFitWidth = YES;
            value.minimumScaleFactor = 0.5;
            value.font = _valueFont;
            [cell.contentView addSubview:value];
            
            UILabel* titleView = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 280, 20)];
            titleView.backgroundColor = [UIColor clearColor];
            titleView.textColor = [UIColor colorWithWhite:0.2 alpha:1];
            titleView.font = _titleFont;
            [cell.contentView addSubview:titleView];
            
            switch (indexPath.row) {
                case 0:{
                    slider.maximumValue = labelView.frame.size.width / 2;
                    slider.value = labelView.contentInset.left;
                    [slider addTarget:self action:@selector(paddingLeftChange:) forControlEvents:UIControlEventValueChanged];
                    titleView.text = @"Left";
                    value.text = [NSString stringWithFormat:@"%.1f", labelView.contentInset.left];
                }
                    break;
                case 1:{
                    slider.maximumValue = labelView.frame.size.width / 2;
                    slider.value = labelView.contentInset.right;
                    [slider addTarget:self action:@selector(paddingRightChange:) forControlEvents:UIControlEventValueChanged];
                    titleView.text = @"Right";
                    value.text = [NSString stringWithFormat:@"%.1f", labelView.contentInset.right];
                }
                    break;
                case 2:{
                    slider.maximumValue = labelView.frame.size.height / 2;
                    slider.value = labelView.contentInset.top;
                    [slider addTarget:self action:@selector(paddingTopChange:) forControlEvents:UIControlEventValueChanged];
                    titleView.text = @"Top";
                    value.text = [NSString stringWithFormat:@"%.1f", labelView.contentInset.top];
                }
                    break;
                case 3:{
                    slider.maximumValue = labelView.frame.size.height / 2;
                    slider.value = labelView.contentInset.bottom;
                    [slider addTarget:self action:@selector(paddingBottomChange:) forControlEvents:UIControlEventValueChanged];
                    titleView.text = @"Bottom";
                    value.text = [NSString stringWithFormat:@"%.1f", labelView.contentInset.bottom];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 4:{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            
            UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(40, 26, kEditorWidth - 45, 44)];
//            slider.continuous = NO;
            slider.minimumValue = 0;
            
            [cell.contentView addSubview:slider];
            UILabel* value = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, 20, 44)];
            value.backgroundColor = [UIColor clearColor];
            value.textColor = [UIColor colorWithRed:0.11f green:0.53f blue:0.82f alpha:1.00f];
            value.adjustsFontSizeToFitWidth = YES;
            value.minimumScaleFactor = 0.5;
            value.font = _valueFont;
            [cell.contentView addSubview:value];
            
            UILabel* titleView = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 280, 20)];
            titleView.backgroundColor = [UIColor clearColor];
            titleView.textColor = [UIColor colorWithWhite:0.2 alpha:1];
            titleView.font = _titleFont;
            [cell.contentView addSubview:titleView];
            
            switch (indexPath.row) {
                case 0:{
                    slider.maximumValue = kFDLabelMaximumOriginX;
                    titleView.text = @"X";
                    slider.value = labelView.frame.origin.x;
                    [slider addTarget:self action:@selector(originXChanged:) forControlEvents:UIControlEventValueChanged];
                    value.text = [NSString stringWithFormat:@"%.1f", labelView.frame.origin.x];
                }
                    break;
                case 1:{
                    slider.maximumValue = kFDLabelMaximumOriginY;
                    slider.value = labelView.frame.origin.y;
                    [slider addTarget:self action:@selector(originYChanged:) forControlEvents:UIControlEventValueChanged];
                    titleView.text = @"Y";
                    value.text = [NSString stringWithFormat:@"%.1f", labelView.frame.origin.y];
                }
                    break;
                case 2:{
                    slider.maximumValue = kFDLabelMaximumSizeWidth;
                    slider.value = labelView.frame.size.width;
                    [slider addTarget:self action:@selector(sizeWidthChanged:) forControlEvents:UIControlEventValueChanged];
                    titleView.text = @"Width";
                    value.text = [NSString stringWithFormat:@"%.1f", labelView.frame.size.width];
                }
                    break;
                case 3:{
                    slider.maximumValue = kFDLabelMaximumSizeHeight;
                    slider.value = labelView.frame.size.height;
                    [slider addTarget:self action:@selector(sizeHeightChanged:) forControlEvents:UIControlEventValueChanged];
                    titleView.text = @"Height";
                    value.text = [NSString stringWithFormat:@"%.1f", labelView.frame.size.height];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 5:
            cell.textLabel.text = labelView.debugSentences[indexPath.row];
            cell.textLabel.numberOfLines = 2;
            cell.accessoryView = nil;
            break;
        case 6:{
            switch (indexPath.row) {
                case 0:{
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                    
                    UILabel* result = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kEditorWidth - 20, 80)];
                    result.backgroundColor = [UIColor clearColor];
                    result.textColor = [UIColor colorWithRed:0.11f green:0.53f blue:0.82f alpha:1.00f];
                    result.font = [UIFont fontWithName:@"HelveticaNeue" size:8];
                    result.text = _outputCodes;
                    result.numberOfLines = 0;
                    [cell.contentView addSubview:result];
                    
                    _outputLabel = result;
                    
                    UILabel* hint = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kEditorWidth - 20, 15)];
                    hint.backgroundColor = [UIColor clearColor];
                    hint.textColor = [UIColor colorWithWhite:0.2 alpha:1];
                    hint.font = _titleFont;
                    hint.text = @"1. Click me  2. Cmd+C ";
                    [cell.contentView addSubview:hint];
                }
                    break;
                case 1:{
                    cell.accessoryView = nil;
                    cell.textLabel.text = @"Duplicate";
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case 7:{
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithRed:0.11f green:0.53f blue:0.82f alpha:1.00f];
            label.textAlignment = NSTextAlignmentRight;
            label.font = _valueTextFont;
            cell.accessoryView = label;
            
            switch (indexPath.row) {
                case 0:{
                    cell.textLabel.text = @"Frames";
                    label.text = labelView.debugShowFrameBounds? @"Shown" : @"Hidden";
                }
                    break;
                case 1:{
                    cell.textLabel.text = @"Paddings";
                    label.text = labelView.debugShowPaddings? @"Shown" : @"Hidden";
                }
                    break;
                case 2:{
                    cell.textLabel.text = @"Coordinates";
                    label.text = labelView.debugShowCoordinates? @"Shown" : @"Hidden";
                }
                    break;
                case 3:{
                    cell.textLabel.text = @"Line Breaks";
                    label.text = labelView.debugShowLineBreaks? @"Shown" : @"Hidden";
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 8:{
            cell.accessoryView = nil;
            switch (indexPath.row) {
                case 0:{
                    cell.textLabel.text = @"Center Horizontal";
                }
                    break;
                case 1:{
                    cell.textLabel.text = @"Align Left";
                }
                    break;
                case 2:{
                    cell.textLabel.text = @"Align Right";
                }
                    break;
                case 3:{
                    cell.textLabel.text = @"Center Vertical";
                }
                    break;
                case 4:{
                    cell.textLabel.text = @"Align Top";
                }
                    break;
                case 5:{
                    cell.textLabel.text = @"Align Bottom";
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
    [self updateCodes];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: {
            UILabel* label = (UILabel*)[tableView cellForRowAtIndexPath:indexPath].accessoryView;
            switch (indexPath.row) {
                case 0:
                    labelView.fdTextAlignment++;
                    if (labelView.fdTextAlignment > FDTextAlignmentFill) labelView.fdTextAlignment = FDTextAlignmentLeft;
                    switch (labelView.fdTextAlignment) {
                        case FDTextAlignmentCenter:
                            label.text = @"Center";
                            break;
                        case FDTextAlignmentFill:
                            label.text = @"Fill";
                            break;
                        case FDTextAlignmentRight:
                            label.text = @"Right";
                            break;
                        case FDTextAlignmentLeft:
                            label.text = @"Left";
                            break;
                        case FDTextAlignmentJustify:
                            label.text = @"Justify";
                            break;
                        default:
                            break;
                    }
                    break;
                case 1:
                    labelView.fdLineScaleBaseLine++;
                    if (labelView.fdLineScaleBaseLine > FDLineHeightScaleBaseLineBottom) labelView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineTop;
                    switch (labelView.fdLineScaleBaseLine) {
                        case FDLineHeightScaleBaseLineTop:
                            label.text = @"Scale Top";
                            break;
                        case FDLineHeightScaleBaseLineCenter:
                            label.text = @"Scale Center";
                            break;
                        case FDLineHeightScaleBaseLineBottom:
                            label.text = @"Scale Bottom";
                            break;
                        default:
                            break;
                    }
                    break;
                case 2:
                    labelView.fdLabelFitAlignment++;
                    if (labelView.fdLabelFitAlignment > FDLabelFitAlignmentBottom) labelView.fdLabelFitAlignment = FDLabelFitAlignmentTop;
                    switch (labelView.fdLabelFitAlignment) {
                        case FDLabelFitAlignmentTop:
                            label.text = @"Top";
                            break;
                        case FDLabelFitAlignmentCenter:
                            label.text = @"Center";
                            break;
                        case FDLabelFitAlignmentBottom:
                            label.text = @"Bottom";
                            break;
                        default:
                            break;
                    }
                    break;
                case 3:
                    labelView.fdAutoFitMode++;
                    if (labelView.fdAutoFitMode > FDAutoFitModeAutoHeight) labelView.fdAutoFitMode = FDAutoFitModeNone;
                    switch (labelView.fdAutoFitMode) {
                        case FDAutoFitModeNone:
                            label.text = @"None";
                            break;
                        case FDAutoFitModeContrainedFrame:
                            label.text = @"Frame";
                            break;
                        case FDAutoFitModeAutoHeight:
                            label.text = @"Auto Height";
                            break;
                        default:
                            break;
                    }
                    break;
                default:
                    break;
            }
            
            
        }
            break;
        case 2:{
            switch (indexPath.row) {
                case 2:{
                    UILabel* label = (UILabel*)[self.tableView cellForRowAtIndexPath:indexPath].accessoryView;
                    labelView.adjustsFontSizeToFitWidth = !labelView.adjustsFontSizeToFitWidth;
                    label.text = labelView.adjustsFontSizeToFitWidth? @"ON" : @"OFF";
                }
                    break;
                case 3:{
                    if (!_fontPicker) {
                        _fontPicker = [[FDFontPickerViewController alloc] initWithNibName:nil bundle:nil];
                        _fontPicker.delegate = self;
                    }

                    _fontPicker.fontName = labelView.font.fontName;
                    [self.view addSubview:_fontPicker.view];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:{
            switch (indexPath.row) {
                case 0:
                    [self showInputter:@"Padding Left" value:[NSString stringWithFormat:@"%.1f", labelView.contentInset.left] field:FDValueInputterFieldPaddingLeft];
                    break;
                case 1:
                    [self showInputter:@"Padding Right" value:[NSString stringWithFormat:@"%.1f", labelView.contentInset.right] field:FDValueInputterFieldPaddingRight];
                    break;
                case 2:
                    [self showInputter:@"Padding Top" value:[NSString stringWithFormat:@"%.1f", labelView.contentInset.top] field:FDValueInputterFieldPaddingTop];
                    break;
                case 3:
                    [self showInputter:@"Padding Bottom" value:[NSString stringWithFormat:@"%.1f", labelView.contentInset.bottom] field:FDValueInputterFieldPaddingBottom];
                    break;
                default:
                    break;
            }
            
        }
            break;
        case 4:{
            switch (indexPath.row) {
                case 0:
                    [self showInputter:@"X" value:[NSString stringWithFormat:@"%.1f", labelView.frame.origin.x] field:FDValueInputterFieldFrameX];
                    break;
                case 1:
                    [self showInputter:@"Y" value:[NSString stringWithFormat:@"%.1f", labelView.frame.origin.y] field:FDValueInputterFieldFrameY];
                    break;
                case 2:
                    [self showInputter:@"Width" value:[NSString stringWithFormat:@"%.1f", labelView.frame.size.width] field:FDValueInputterFieldFrameW];
                    break;
                case 3:
                    [self showInputter:@"Height" value:[NSString stringWithFormat:@"%.1f", labelView.frame.size.height] field:FDValueInputterFieldFrameH];
                    break;
                default:
                    break;
            }
            
        }
            break;
        case 5:{
            labelView.text = labelView.debugSentences[indexPath.row];
        }
            break;
        case 6:{
            switch (indexPath.row) {
                case 0:
                    [[UIPasteboard generalPasteboard] setString:_outputCodes];
                    break;
                default:
                    break;
            }
        }
            break;
        case 7:{
            UILabel* label = (UILabel*)[tableView cellForRowAtIndexPath:indexPath].accessoryView;
            switch (indexPath.row) {
                case 0:
                    labelView.debugShowFrameBounds = !labelView.debugShowFrameBounds;
                    label.text = labelView.debugShowFrameBounds? @"Shown" : @"Hidden";
                    break;
                case 1:
                    labelView.debugShowPaddings = !labelView.debugShowPaddings;
                    label.text = labelView.debugShowPaddings? @"Shown" : @"Hidden";
                    break;
                case 2:
                    labelView.debugShowCoordinates = !labelView.debugShowCoordinates;
                    label.text = labelView.debugShowCoordinates? @"Shown" : @"Hidden";
                    break;
                case 3:
                    labelView.debugShowLineBreaks = !labelView.debugShowLineBreaks;
                    label.text = labelView.debugShowLineBreaks? @"Shown" : @"Hidden";
                    break;
                default:
                    break;
            }
        }
            break;
        case 8:{
            switch (indexPath.row) {
                case 0:
                    [labelView alignParentHorizontalCenter:0];
                    break;
                case 1:
                    [labelView alignParentLeft:0];
                    break;
                case 2:
                    [labelView alignParentRight:0];
                    break;
                case 3:
                    [labelView alignParentVerticalCenter:0];
                    break;
                case 4:
                    [labelView alignParentTop:0];
                    break;
                case 5:
                    [labelView alignParentBottom:0];
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }

    [self updateCodes];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - FDFontPickerDelegate

-(void)fontDidSelect:(NSString *)fontName{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:2]];
    UILabel* label = (UILabel*)cell.accessoryView;
    label.text = fontName;
    labelView.font = [UIFont fontWithName:fontName size:labelView.font.pointSize];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    switch (valueInputter.field) {
        case FDValueInputterFieldFrameX:
            labelView.frame = CGRectMake([textField.text floatValue], labelView.frame.origin.y, labelView.frame.size.width, labelView.frame.size.height);
            break;
        case FDValueInputterFieldFrameY:
            labelView.frame = CGRectMake(labelView.frame.origin.x, [textField.text floatValue], labelView.frame.size.width, labelView.frame.size.height);
            break;
        case FDValueInputterFieldFrameW:
            labelView.frame = CGRectMake(labelView.frame.origin.x, labelView.frame.origin.y, [textField.text floatValue], labelView.frame.size.height);
            break;
        case FDValueInputterFieldFrameH:
            labelView.frame = CGRectMake(labelView.frame.origin.x, labelView.frame.origin.y, labelView.frame.size.width, [textField.text floatValue]);
            break;
        case FDValueInputterFieldPaddingLeft:
            labelView.contentInset = UIEdgeInsetsMake(labelView.contentInset.top, [textField.text floatValue], labelView.contentInset.bottom, labelView.contentInset.right);
            break;
        case FDValueInputterFieldPaddingRight:
            labelView.contentInset = UIEdgeInsetsMake(labelView.contentInset.top, labelView.contentInset.left, labelView.contentInset.bottom, [textField.text floatValue]);
            break;
        case FDValueInputterFieldPaddingTop:
            labelView.contentInset = UIEdgeInsetsMake([textField.text floatValue], labelView.contentInset.left, labelView.contentInset.bottom, labelView.contentInset.right);
            break;
        case FDValueInputterFieldPaddingBottom:
            labelView.contentInset = UIEdgeInsetsMake(labelView.contentInset.top, labelView.contentInset.left, [textField.text floatValue], labelView.contentInset.right);
            break;
            /* Diasble 
        case FDValueInputterFieldLineHeightScale:
            labelView.lineHeightScale = [textField.text floatValue];
            break;
        case FDValueInputterFieldFixedLineHeight:
            labelView.fixedLineHeight = [textField.text floatValue];
            break;
        case FDValueInputterFieldTargetFontSize:
            labelView.font = [UIFont fontWithName:labelView.font.fontName size:[textField.text floatValue]];
            break;
        case FDValueInputterFieldNumberOfLine:
            labelView.numberOfLines = [textField.text floatValue];
            break;*/
        default:
            break;
    }
    
    [tableView reloadData];
    
    [self hideInputter];
    
    return YES;
}

@end
