//
//  FDLabelView.m
//  FDLabelView
//
//  Created by magic on 8/8/13.
//  Copyright (c) 2013 Fourdesire. All rights reserved.
//

#import "FDLabelView.h"
#import <QuartzCore/QuartzCore.h>

@implementation FDLabelView

@synthesize fdTextAlignment,
fdLineScaleBaseLine,
fdLabelFitAlignment,
fdAutoFitMode,
fixedLineHeight = _fixedLineHeight,
lineHeightScale = _lineHeightScale,
actualTextHeight,
visualTextHeight,
actualLineNumber,
visualLineNumber,
adjustedFont,
contentInset,
debug,
showLog,
debugFont,
debugParentView,
configController,
outputName,
debugShowLineBreaks,
debugShowFrameBounds,
debugShowCoordinates,
debugShowPaddings,
debugSentences;

- (id)init{
    self = [super init];
    if (self) {
        _fixedLineHeight = 0;
        _lineHeightScale = 1;
        fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
        fdLabelFitAlignment = FDLabelFitAlignmentTop;
        fdTextAlignment = FDTextAlignmentLeft;
        fdAutoFitMode = FDAutoFitModeNone;
        
        debugFont = [UIFont fontWithName:@"HelveticaNeue" size:8];
        contentInset = UIEdgeInsetsZero;
        
        outputName = @"labelView";
        
        debugShowLineBreaks = YES;
        debugShowCoordinates = YES;
        debugShowFrameBounds = YES;
        debugShowPaddings = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _fixedLineHeight = 0;
        _lineHeightScale = 1;
        fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
        fdLabelFitAlignment = FDLabelFitAlignmentTop;
        fdTextAlignment = FDTextAlignmentLeft;
        fdAutoFitMode = FDAutoFitModeNone;
        
        debugFont = [UIFont fontWithName:@"HelveticaNeue" size:8];
        contentInset = UIEdgeInsetsZero;
        
        outputName = @"labelView";
        
        debugShowLineBreaks = YES;
        debugShowCoordinates = YES;
        debugShowFrameBounds = YES;
        debugShowPaddings = YES;
    }
    return self;
}

-(void)enumerateWord:(NSInteger)index{
    _enumerateIndex = index;
}

-(void)drawTextInRect:(CGRect)rect{
    [self.textColor set];
    
    UIFont* displayFont = [self displayFont];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx,
                          rect.origin.x,
                          rect.origin.y);
    
    CGContextSetShadowWithColor(ctx, self.shadowOffset, 0, self.shadowColor.CGColor);
    
    CGPoint wordOffset = CGPointMake(0, _contentBounds.origin.y);
    CGFloat charOffset = 0;
    
    // Check auto fit alignment
    if (fdAutoFitMode == FDAutoFitModeNone && visualTextHeight < self.frame.size.height) {
        switch (fdLabelFitAlignment) {
            case FDLabelFitAlignmentBottom:
                wordOffset.y += (self.frame.size.height - visualTextHeight);
                break;
            case FDLabelFitAlignmentCenter:
                wordOffset.y += (self.frame.size.height - visualTextHeight) * 0.5;
                break;
            default:
                break;
        }
    }
    
    
    CGSize sSize;
    // Line break positions
    NSMutableArray* linebreaks = [NSMutableArray array];
    
    // Line Height
    CGFloat lineHeight = _fixedLineHeight > 0? _fixedLineHeight : [@" " sizeWithFont:displayFont].height * _lineHeightScale;
    
    NSString* word = nil;
    NSString* s = nil;
    int lineNum = 1;
    
    NSMutableArray* line = [NSMutableArray array];
    BOOL linebreak = NO;
    
    NSArray* words = nil;
    NSMutableArray* mutableWords = nil;
    BOOL paragraphBegin = YES;
    
    for (int l = 0; l < _textLines.count; l++) {
//        words = [textLine componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        words = _textLines[l];
        mutableWords = [NSMutableArray arrayWithArray:words];
        
        paragraphBegin = YES;
        /// Start Drawing
        while (mutableWords.count > 0) {
            
            // Check bottom
            if (wordOffset.y + lineHeight - 1> _contentBounds.origin.y + _contentBounds.size.height) {
                [self drawDebug:linebreaks];
                return;
            }
            
            linebreak = NO;
            
            word = mutableWords[0];
            charOffset = 0;
            
            // Skip empty string
            if (word.length == 0) {
                [mutableWords removeObjectAtIndex:0];
                continue;
            }
            
            // Check need line break;
            for (int i = 0; i < word.length; i++) {
                s = [word substringWithRange:NSMakeRange(i, 1)];
                sSize = [s sizeWithFont:displayFont];
                charOffset += sSize.width;
                
                if (sSize.width > _contentBounds.size.width) {
                    // Not enough space for drawing
                    return;
                }
                
                if (charOffset + wordOffset.x > _contentBounds.size.width && ![s isEqualToString:@" "]) {
                    lineNum++;
                    
                    if ([self needWrapChar:word]) {
                        // Add to draw list
                        [line addObject:[word substringToIndex:i]];
                        word = [word substringFromIndex:i];
                        
                        [mutableWords removeObjectAtIndex:0];
                        // Insert the shorter one
                        [mutableWords insertObject:word atIndex:0];
                        wordOffset.x += charOffset - sSize.width;
//                        - (i > 0? 0 : blankWidth);
                    }
                    
                    [self drawTextLine:[NSArray arrayWithArray:line]
                                offset:CGPointMake(_contentBounds.origin.x, wordOffset.y)
                        paragraphBegin:paragraphBegin
                              lastLine:NO];
                    
                    paragraphBegin = NO;
                    
                    if (self.numberOfLines > 0) {
                        if (lineNum > self.numberOfLines) {
                            [self drawDebug:linebreaks];
                            return;
                        }
                    }
                
                    [line removeAllObjects];
                    
                    wordOffset.y += lineHeight;
                    wordOffset.x = 0;
                    
                    linebreak = YES;
                    break;
                }
            }
            
            if (!linebreak) {
                wordOffset.x += charOffset;
                [line addObject:word];
                [mutableWords removeObjectAtIndex:0];
            }
        }
        
        if (line.count > 0) {
            [self drawTextLine:[NSArray arrayWithArray:line]
                        offset:CGPointMake(_contentBounds.origin.x, wordOffset.y)
                paragraphBegin:paragraphBegin
                      lastLine:YES];
            
            paragraphBegin = NO;
            
            [line removeAllObjects];
        }
        
        if (l < _textLines.count - 1) {
            wordOffset.y += lineHeight;
            wordOffset.x = 0;
            
            [linebreaks addObject:[NSValue valueWithCGPoint:CGPointMake(wordOffset.x, wordOffset.y)]];
            lineNum++;
            
            if (self.numberOfLines > 0) {
                if (lineNum > self.numberOfLines) {
                    [self drawDebug:linebreaks];
                    return;
                }
            }
        }
    }

    [self drawDebug:linebreaks];
}

-(void)drawDebug:(NSArray*)linebreaks{
    UIFont* displayFont = [self displayFont];
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
    if (debug) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetShadow(ctx, CGSizeZero, 0);
        
        if (debugShowLineBreaks) {
            CGContextSetLineWidth(ctx, 2);
            CGContextSetRGBStrokeColor(ctx, 0.98f, 0.58f, 0.09f, 1);
            for (NSValue* v in linebreaks) {
                CGPoint pos = [v CGPointValue];
                CGFloat posY = pos.y + 1;
                CGContextMoveToPoint(ctx, _contentBounds.origin.x + _contentBounds.size.width - 5, posY);
                CGContextAddLineToPoint(ctx, _contentBounds.origin.x + _contentBounds.size.width + 5, posY);
                CGContextClosePath(ctx);
                CGContextStrokePath(ctx);
            }
        }
        
        if (debugShowFrameBounds) {
            // frame
            CGContextSetLineWidth(ctx, 1);
            CGContextSetRGBStrokeColor(ctx, 0.28f, 0.54f, 1, 1);
            CGContextStrokeRect(ctx, CGRectInset(self.bounds, 0.5, 0.5));
            
            CGContextMoveToPoint(ctx, 0, center.y);
            CGContextAddLineToPoint(ctx, self.bounds.size.width, center.y);
            CGContextClosePath(ctx);
            CGContextStrokePath(ctx);
            
            CGContextMoveToPoint(ctx, center.x, 0);
            CGContextAddLineToPoint(ctx, center.x, self.bounds.size.height);
            CGContextClosePath(ctx);
            CGContextStrokePath(ctx);
        }
        
        if (debugShowPaddings){
            // Content area
            CGContextSetLineDash(ctx, 0, nil, 0);
            CGContextSetLineWidth(ctx, 1);
            CGContextSetRGBStrokeColor(ctx, 0.18f, 0.62f, 0.06f, 1);
            CGContextStrokeRect(ctx, _contentBounds);
        }
        
        if (debugShowCoordinates) {
            CGFloat debugHeight = debugFont.pointSize + 2;
            NSString* info = [NSString stringWithFormat:@"%.1f, %.1f", self.frame.origin.x, self.frame.origin.y];
            
            CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.8);
            CGContextFillRect(ctx, CGRectMake(0, 0, [info sizeWithFont:debugFont].width, debugHeight));
            
            CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
            [info drawAtPoint:CGPointZero withFont:debugFont];
            
            // center point
            info = [NSString stringWithFormat:@"%.1f, %.1f", self.frame.origin.x + center.x, self.frame.origin.y + center.y];
            
            CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.8);
            CGContextFillRect(ctx, CGRectMake(center.x, center.y - debugHeight, [info sizeWithFont:debugFont].width, debugHeight));
            
            CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
            [info drawAtPoint:CGPointMake(center.x, center.y - debugHeight) withFont:debugFont];
            
            // size
            info = [NSString stringWithFormat:@"F %.1f W %.1f H %.1f", displayFont.pointSize, self.frame.size.width, self.frame.size.height];
            
            CGFloat infoWidth = [info sizeWithFont:debugFont].width;
            CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.8);
            CGContextFillRect(ctx, CGRectMake(center.x - infoWidth * 0.5, self.bounds.size.height - debugHeight, infoWidth, debugHeight));
            
            CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
            [info drawAtPoint:CGPointMake(center.x - infoWidth * 0.5, self.bounds.size.height - debugHeight) withFont:debugFont];
        }
    }
    
    if(showLog){
        NSLog(@"==== FDLabelView =============");
        NSLog(@"origin:             (%.1f, %.1f)", self.frame.origin.x, self.frame.origin.y);
        NSLog(@"center:             (%.1f, %.1f)", self.frame.origin.x + center.x, self.frame.origin.y + center.y);
        NSLog(@"size:               (%.1f, %.1f)", self.frame.size.width, self.frame.size.height);
        NSLog(@"font-size:           %.1f /%.1f", displayFont.pointSize, self.font.pointSize);
        NSLog(@"==============================");
    }
}

-(BOOL)needWrapChar:(NSString*)word{
    UIFont* displayFont = [self displayFont];
    
    NSString* s = nil;
    CGFloat width = 0;
    for (int i = 0; i < word.length; i++) {
        s = [word substringWithRange:NSMakeRange(i, 1)];
        width += [s sizeWithFont:displayFont].width;
    }
    return width > _contentBounds.size.width;
}

-(void)drawTextLine:(NSArray*)words offset:(CGPoint)offset paragraphBegin:(bool)paragraphBegin lastLine:(BOOL)lastLine{
    
    UIFont* displayFont = [self displayFont];
    CGFloat lineHeight = [@" " sizeWithFont:displayFont].height;
    CGFloat drawLineHeight = _fixedLineHeight > 0? _fixedLineHeight : [@" " sizeWithFont:displayFont].height * _lineHeightScale;
    
    float offsetY = 0;
    switch (fdLineScaleBaseLine) {
        case FDLineHeightScaleBaseLineBottom:
            offsetY = -(lineHeight - drawLineHeight);
            break;
        case FDLineHeightScaleBaseLineCenter:
            offsetY = -(lineHeight - drawLineHeight) * 0.5;
            break;
        default:
            break;
    }
    
    NSMutableArray* mutableWords = [NSMutableArray arrayWithArray:words];
    while ([[mutableWords lastObject] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]].length == 0 && mutableWords.count > 0) {
        [mutableWords removeObjectAtIndex:mutableWords.count - 1];
    }
    
    if (mutableWords.count == 0) {
        return;
    }
    
    if (!paragraphBegin) {
        NSString* firstWord = mutableWords[0];
        while([firstWord hasPrefix:@" "] && firstWord.length > 1){
            firstWord = [firstWord substringFromIndex:1];
        }
        mutableWords[0] = firstWord;
    }
    
    NSString* lastWord = [mutableWords lastObject];
    while([lastWord hasSuffix:@" "] && lastWord.length > 1){
        lastWord = [lastWord substringToIndex:lastWord.length - 1];
    }
    mutableWords[mutableWords.count - 1] = lastWord;
    
    words = [NSArray arrayWithArray:mutableWords];
    CGFloat usedWidth = [self textLineWidth:words];
    
    switch (fdTextAlignment) {
        case FDTextAlignmentCenter:{
            CGFloat offsetX = _contentBounds.origin.x + (_contentBounds.size.width - usedWidth) * 0.5;
            for (NSString* word in words) {
                offsetX = [self drawWord:word pos:CGPointMake(offsetX, offset.y)];
            }
        }
            break;
        case FDTextAlignmentFill:{
            int count = 0;
            for (NSString* word in words) {
                count += word.length;
            }
            CGFloat space = (_contentBounds.size.width - usedWidth) / (float)(count - 1);
            CGFloat offsetX = _contentBounds.origin.x;
            
            NSString* s = nil;
            for (int j = 0; j < words.count; j++) {
                NSString* word = words[j];
//                [words[j] stringByAppendingString:@" "];
                for (int i = 0; i < word.length; i++) {
                    s = [word substringWithRange:NSMakeRange(i, 1)];
                    [s drawAtPoint:CGPointMake(offsetX, offset.y + offsetY) withFont:displayFont];
                    
                    offsetX += [s sizeWithFont:displayFont].width + space;
                }
            }
        }
            break;
        case FDTextAlignmentRight:{
            CGFloat offsetX = _contentBounds.origin.x + _contentBounds.size.width - usedWidth;
            for (NSString* word in words) {
                offsetX = [self drawWord:word pos:CGPointMake(offsetX, offset.y)];
            }
        }
            break;
        case FDTextAlignmentLeft:{
            CGFloat offsetX = _contentBounds.origin.x;
            for (NSString* word in words) {
                offsetX = [self drawWord:word pos:CGPointMake(offsetX, offset.y)];
            }
        }
            break;
        case FDTextAlignmentJustify:{
            if(lastLine) {
                CGFloat offsetX = _contentBounds.origin.x;
                for (NSString* word in words) {
                    offsetX = [self drawWord:word pos:CGPointMake(offsetX, offset.y)];
                }
            }else{
                CGFloat space = (_contentBounds.size.width - usedWidth) / (float)(words.count - 1);
                CGFloat offsetX = _contentBounds.origin.x;
                for (NSString* word in words) {
                    offsetX = [self drawWord:word pos:CGPointMake(offsetX, offset.y)] + space;
                }
            }
        }
            break;
        default:
            break;
    }
}

-(CGFloat)textLineWidth:(NSArray*)words{
    CGFloat width = 0;
    NSString* s = nil;
    for(NSString* word in words){
        for(int i = 0; i< word.length; i++){
            s = [word substringWithRange:NSMakeRange(i, 1)];
            width += [s sizeWithFont:[self displayFont]].width;
        }
    }
    return width;
}

-(UIFont*)displayFont{
    return self.adjustsFontSizeToFitWidth? adjustedFont : self.font;
}

-(void)determineHeight{
    UIFont* displayFont = [self displayFont];
    
    CGPoint wordOffset = CGPointZero;
    CGFloat charOffset = 0;
    
    CGSize sSize;
    CGFloat blankWidth = [@" " sizeWithFont:displayFont].width;
    
    // Line break positions
    NSMutableArray* linebreaks = [NSMutableArray array];
    
    // Line Height
    CGFloat lineHeight = _fixedLineHeight > 0? _fixedLineHeight : [@" " sizeWithFont:displayFont].height * _lineHeightScale;
    CGFloat paddingVertical = contentInset.top + contentInset.bottom;
    
    NSString* word = nil;
    NSString* s = nil;
    int lineNum = 1;
    
    BOOL linebreak = NO;
    BOOL reachLineLimit = NO;
    
    NSArray* words = nil;
    NSMutableArray* mutableWords = nil;
    
    for (int l = 0; l < _textLines.count; l++) {
        words = _textLines[l];
        mutableWords = [NSMutableArray arrayWithArray:words];
        
        /// Start Drawing
        while (mutableWords.count > 0) {
            linebreak = NO;
            
            word = mutableWords[0];
            charOffset = 0;
            
            // Skip empty string
            if (word.length == 0) {
                [mutableWords removeObjectAtIndex:0];
                continue;
            }
            
            // Check need line break;
            for (int i = 0; i < word.length; i++) {
                s = [word substringWithRange:NSMakeRange(i, 1)];
                sSize = [s sizeWithFont:displayFont];
                charOffset += sSize.width;
                
                if (sSize.width > _contentBounds.size.width) {
                    actualTextHeight = 0;
                    actualLineNumber = 0;
                    visualLineNumber = 0;
                    visualTextHeight = 0;
                    return;
                }
                
                
                if (charOffset + wordOffset.x > _contentBounds.size.width && ![s isEqualToString:@" "]) {
                    lineNum++;
                    
                    if ([self needWrapChar:word]) {
                        // Add to draw list
                        word = [word substringFromIndex:i];
                        
                        [mutableWords removeObjectAtIndex:0];
                        // Insert the shorter one
                        [mutableWords insertObject:word atIndex:0];
                        wordOffset.x += charOffset - sSize.width - (i > 0? 0 : blankWidth);
                    }
                    
                    if (self.numberOfLines > 0 && !reachLineLimit) {
                        if (lineNum > self.numberOfLines) {
                            reachLineLimit = YES;
                            visualLineNumber = lineNum - 1;
                            visualTextHeight = visualLineNumber * lineHeight + paddingVertical;
                        }
                    }
                    
                    wordOffset.y += lineHeight;
                    wordOffset.x = 0;
                    
                    linebreak = YES;
                    break;
                }
            }
            
            if (!linebreak) {
                wordOffset.x += charOffset;
                [mutableWords removeObjectAtIndex:0];
            }
        }
        
        if (l < _textLines.count - 1) {
            wordOffset.y += lineHeight;
            wordOffset.x = 0;
            
            [linebreaks addObject:[NSValue valueWithCGPoint:CGPointMake(wordOffset.x, wordOffset.y)]];
            lineNum++;
            
            if (self.numberOfLines > 0 && !reachLineLimit) {
                if (lineNum > self.numberOfLines) {
                    reachLineLimit = YES;
                    visualLineNumber = lineNum - 1;
                    visualTextHeight = visualLineNumber * lineHeight + paddingVertical;
                }
            }
        }
    }
    
    actualLineNumber = lineNum;
    actualTextHeight = lineNum * lineHeight + paddingVertical;
    
    if (!reachLineLimit) {
        visualTextHeight = actualTextHeight;
        visualLineNumber = actualLineNumber;
    }
}

-(CGFloat)drawWord:(NSString*)word pos:(CGPoint)pos{
    UIFont* displayFont = [self displayFont];
    
    float width = 0;
    NSString* s = nil;
    
    CGFloat lineHeight = [@" " sizeWithFont:displayFont].height;
    
    float offsetY = 0;
    switch (fdLineScaleBaseLine) {
        case FDLineHeightScaleBaseLineBottom:
            offsetY = -lineHeight * (1 - _lineHeightScale);
            break;
        case FDLineHeightScaleBaseLineCenter:
            offsetY = -lineHeight * (1 - _lineHeightScale) * 0.5;
            break;
        default:
            break;
    }
    
    CGFloat testW = 0;
    for (int i = 0; i < word.length; i++) {
        s = [word substringWithRange:NSMakeRange(i, 1)];
        width = [s sizeWithFont:displayFont].width;
        [s drawAtPoint:CGPointMake(pos.x, pos.y + offsetY) withFont:displayFont];
        pos.x += width;
        
        testW += width;
    }
    return pos.x;
}

-(void)contrainedToSize:(CGSize)size{
    adjustedFont = [self.font copy];
    
    [self determineHeight];

    CGFloat minimumSize = self.font.pointSize;
    CGFloat originalMinimumSize = self.font.pointSize * self.minimumScaleFactor;
    
    while ((actualTextHeight > size.height || (actualLineNumber > self.numberOfLines && self.numberOfLines > 0)) && minimumSize > originalMinimumSize) {
        minimumSize -= 0.5;
        adjustedFont = [UIFont fontWithName:self.font.fontName
                                       size:minimumSize * self.layer.contentsScale];
        [self determineHeight];
    }
    
    if (visualTextHeight > size.height) {
        visualTextHeight = size.height;
    }
}

-(void)updateFrame:(CGRect)frame{
    [super setFrame:frame];
    
    _contentBounds = CGRectMake(contentInset.left, contentInset.top, self.bounds.size.width - contentInset.left - contentInset.right, self.bounds.size.height - contentInset.top - contentInset.bottom);
    
    _debugMenu.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - 10, self.frame.origin.y + self.frame.size.height - 10, 20, 20);
    
    [self setNeedsDisplay];
}

-(void)sizeToFit{
    CGFloat height = self.frame.size.height;
    
    switch (fdAutoFitMode) {
        case FDAutoFitModeNone:
            if(self.adjustsFontSizeToFitWidth){
                [self contrainedToSize:self.frame.size];
            }else{
                [self determineHeight];
            }
            break;
        case FDAutoFitModeContrainedFrame:
            [self contrainedToSize:self.frame.size];
            height = visualTextHeight;
            break;
        case FDAutoFitModeAutoHeight:{
            [self determineHeight];
            height = visualTextHeight;
        }
            break;
        default:
            break;
    }
    
    switch (fdLabelFitAlignment) {
        case FDLabelFitAlignmentTop:
            [self updateFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height)];
            break;
        case FDLabelFitAlignmentCenter:
            [self updateFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + (self.frame.size.height - height) * 0.5, self.frame.size.width, height)];
            break;
        case FDLabelFitAlignmentBottom:
             [self updateFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height - height, self.frame.size.width, height)];
            break;
        default:
            break;
    }
}

-(NSArray*)processTextLineToWords:(NSString*)textLine{
    NSMutableArray* words = [NSMutableArray array];
    _enumerateIndex = 0;
    
    [textLine enumerateSubstringsInRange:NSMakeRange(0, textLine.length)
                                 options:NSStringEnumerationByWords
                              usingBlock:^(NSString *word,
                                           NSRange wordRange,
                                           NSRange enclosingRange,
                                           BOOL *stop){
                
                                  NSRange range = NSMakeRange(0, 0);
                                  range.location = enclosingRange.location > _enumerateIndex? _enumerateIndex : enclosingRange.location;
                                  range.length = enclosingRange.location + enclosingRange.length - range.location;
                                  /*
                                  NSString* checkWord = [textLine substringWithRange:range];
                                  
                                  int enclosingIndex = enclosingRange.length + enclosingRange.location;
                                  int wrapWordIndex = wordRange.location + wordRange.length;
                                  
                                  NSString* enclosingWord = [textLine substringWithRange:enclosingRange];
                                  
                                  if([enclosingWord canBeConvertedToEncoding:NSASCIIStringEncoding]){
                                      if([enclosingWord hasSuffix:@" "]) {
                                          range.length = enclosingRange.location + enclosingRange.length - range.location - 1;
                                      }else{
                                          range.length = enclosingRange.location + enclosingRange.length - range.location;
                                      }
                                      [words addObject:[textLine substringWithRange:range]];
                                      
                                      NSLog(@"add word [%@]", [textLine substringWithRange:range]);
                                  }else{
                                      // Check wordRange only
                                      NSString* wordWord = [textLine substringWithRange:wordRange];
                                      if ([wordWord canBeConvertedToEncoding:NSASCIIStringEncoding]) {
                                          [words addObject:wordWord];
                                           NSLog(@"add word [%@]", wordWord);
                                          NSString* remained = [textLine substringWithRange:NSMakeRange(wrapWordIndex, enclosingIndex - wrapWordIndex)];
                                          if (![remained isEqualToString:@" "]) {
                                             [words addObject:remained];
                                              NSLog(@"add word [%@]", remained);
                                          }
                                          // Check back
                                      }else{
                                          for (int i = 0; i < enclosingWord.length; i++) {
                                              [words addObject:[enclosingWord substringWithRange:NSMakeRange(i, 1)]];
                                               NSLog(@"add word [%@]", [enclosingWord substringWithRange:NSMakeRange(i, 1)]);
                                          }
                                      }                            
                                  }*/
                                  
                                  [self enumerateWord:range.location + range.length];
                                  
                                  NSString* finalWord = [textLine substringWithRange:range];
                                  
                                  BOOL hasFullWidth = NO;
                                  for (int i = 0; i < finalWord.length; i++) {
                                      unichar c = [finalWord characterAtIndex:i];
                                      
                                      if([self fullCharacter:c]){
                                          hasFullWidth = YES;
                                          break;
                                      }
                                  }
                                  
                                  if (hasFullWidth) {
                                      for (int i = 0; i < finalWord.length; i++) {
                                          [words addObject:[finalWord substringWithRange:NSMakeRange(i, 1)]];
                                      }
                                  }else{
                                      [words addObject:finalWord];
                                  }
                              }];
    
    return [NSArray arrayWithArray:words];
}

-(BOOL)fullCharacter:(unichar)unicode
{
    if ((unicode >= 0x1100 && unicode <= 0x115f) ||
        unicode == 0x2329 ||
        unicode == 0x232a ||
        (unicode >= 0x2500 && unicode <= 0x267f) ||
        (unicode >= 0x2e80 && unicode <= 0x2fff) ||
        (unicode >= 0x3001 && unicode <= 0x33ff) ||
        (unicode >= 0x3400 && unicode <= 0x4db5) ||
        (unicode >= 0x4e00 && unicode <= 0x9fa5) ||
        (unicode >= 0xa000 && unicode <= 0xa4c6) ||
        (unicode >= 0xac00 && unicode <= 0xd7a3) ||
        (unicode >= 0xf900 && unicode <= 0xfa6a) ||
        (unicode >= 0xfe30 && unicode <= 0xfe6b) ||
        (unicode >= 0xff01 && unicode <= 0xff60) ||
        (unicode >= 0xffe0 && unicode <= 0xffe6))
    {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - Setter

-(void)setNumberOfLines:(NSInteger)numberOfLines{
    [super setNumberOfLines:numberOfLines];
    [self sizeToFit];
}

-(void)setFont:(UIFont*)font{
    [super setFont:font];
    adjustedFont = [font copy];
    
    [self sizeToFit];
}

-(void)setFrame:(CGRect)frame{
    CGSize size = self.frame.size;
    [super setFrame:frame];
    
    _contentBounds = CGRectMake(contentInset.left, contentInset.top, self.bounds.size.width - contentInset.left - contentInset.right, self.bounds.size.height - contentInset.top - contentInset.bottom);
    
    if (size.height != self.frame.size.height || size.width != self.frame.size.width) {
        [self sizeToFit];
    }
    
    _debugMenu.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - 10, self.frame.origin.y + self.frame.size.height - 10, 20, 20);
    
    [self setNeedsDisplay];
}

-(void)setContentInset:(UIEdgeInsets)vContentInset{
    if (contentInset.bottom != vContentInset.bottom || contentInset.top != vContentInset.top ||
        contentInset.left != vContentInset.left || contentInset.right != vContentInset.right) {

        contentInset = vContentInset;        
        [self sizeToFit];
    }
}

-(void)setFdTextAlignment:(FDTextAlignment)vFdTextAlignment{
    fdTextAlignment = vFdTextAlignment;
    [self sizeToFit];
}

-(void)setFdLineScaleBaseLine:(FDLineHeightScaleBaseLine)vFdLineScaleBaseLine{
    fdLineScaleBaseLine = vFdLineScaleBaseLine;
    [self sizeToFit];
}

-(void)setFdLabelFitAlignment:(FDLabelFitAlignment)vFdLabelFitAlignment{
    fdLabelFitAlignment = vFdLabelFitAlignment;
    [self sizeToFit];
}

-(void)setLineHeightScale:(CGFloat)vLineHeightScale{
    _lineHeightScale = vLineHeightScale;
    [self sizeToFit];
}

-(void)setFixedLineHeight:(CGFloat)vFixedLineHeight{
    _fixedLineHeight = vFixedLineHeight;
    [self sizeToFit];
}

-(void)setFdAutoFitMode:(FDAutoFitMode)vFdAutoFitMode{
    fdAutoFitMode = vFdAutoFitMode;
    [self sizeToFit];
}

-(void)setAdjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth{
    [super setAdjustsFontSizeToFitWidth:adjustsFontSizeToFitWidth];
    [self sizeToFit];
}

-(BOOL)adjustsFontSizeToFitWidth{
    return (fdAutoFitMode == FDAutoFitModeContrainedFrame) || [super adjustsFontSizeToFitWidth];
}

-(void)setText:(NSString*)text{
    NSString* originalText = self.text;
    [super setText:text];
    
    if (![text isEqualToString:originalText]) {
        NSMutableArray* lines = [NSMutableArray array];
        
        [self.text enumerateSubstringsInRange:NSMakeRange(0, self.text.length)
                                      options:NSStringEnumerationByLines
                                   usingBlock:^(NSString *word,
                                                NSRange wordRange,
                                                NSRange enclosingRange,
                                                BOOL *stop){
                                       [lines addObject:[self processTextLineToWords:word]];
                                   }];
        
        _textLines = [NSArray arrayWithArray:lines];
        
        [self sizeToFit];
    }
}

-(void)setDebugShowCoordinates:(BOOL)vDebugShowCoordinates{
    debugShowCoordinates = vDebugShowCoordinates;
    [self setNeedsDisplay];
}

-(void)setDebugShowFrameBounds:(BOOL)vDebugShowFrameBounds{
    debugShowFrameBounds = vDebugShowFrameBounds;
    [self setNeedsDisplay];
}

-(void)setDebugShowLineBreaks:(BOOL)vDebugShowLineBreaks{
    debugShowLineBreaks = vDebugShowLineBreaks;
    [self setNeedsDisplay];
}

-(void)setDebugShowPaddings:(BOOL)vDebugShowPaddings{
    debugShowPaddings = vDebugShowPaddings;
    [self setNeedsDisplay];
}

#pragma mark - Debug

-(void)setDebug:(BOOL)vDebug{
    debug = vDebug;
    self.userInteractionEnabled = debug;
    
    [self setNeedsDisplay];
    
    if (debug) {
        if (!_gestureRecognizer) {
            _gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showConfig)];
            _gestureRecognizer.numberOfTapsRequired = 2;
        }
        
        [self addGestureRecognizer:_gestureRecognizer];
        
        /*if (!_debugMenu) {
            _debugMenu = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.origin.x + self.frame.size.width - 10, self.frame.origin.y + self.frame.size.height - 10, 20, 20)];
            _debugMenu.layer.cornerRadius = 10;
            [_debugMenu setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.8]];
            [_debugMenu addTarget:self action:@selector(showConfig) forControlEvents:UIControlEventTouchUpInside];
            [self.superview addSubview:_debugMenu];
        }*/
    }else{
        /*if (_debugMenu) {
            [_debugMenu removeFromSuperview];
            _debugMenu = nil;
        }*/
        [self removeGestureRecognizer:_gestureRecognizer];
    }
}

-(void)showConfig{
    if (!configController) {
        configController = [[FDLabelConfigViewController alloc] init];
        configController.labelView = self;
    }
    
    if(debugParentView) {
        [debugParentView addSubview:configController.view];
        [configController toggleView];
    }
}


#pragma mark - UIResponder

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    _lastTouchPoint = [[touches allObjects][0] locationInView:self.superview];
    UIView* superView = self;
    while (superView.superview) {
        superView = superView.superview;
        if ([superView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView*)superView setScrollEnabled:NO];
            break;
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint currentPoint = [[touches allObjects][0] locationInView:self.superview];
    self.frame = CGRectOffset(self.frame, currentPoint.x - _lastTouchPoint.x, currentPoint.y - _lastTouchPoint.y);
    
    _debugMenu.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - 10, self.frame.origin.y + self.frame.size.height - 10, 20, 20);
    
    _lastTouchPoint = currentPoint;    
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    if (configController) {
        [configController.tableView reloadData];
        [configController updateCodes];
    }
    
    UIView* superView = self;
    while (superView.superview) {
        superView = superView.superview;
        if ([superView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView*)superView setScrollEnabled:YES];
            break;
        }
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    UIView* superView = self;
    while (superView.superview) {
        superView = superView.superview;
        if ([superView isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView*)superView setScrollEnabled:YES];
            break;
        }
    }
}
#pragma mark - Adjustment

-(void)alignParentHorizontalCenter:(CGFloat)offset{
    self.frame = CGRectMake(0.5 * (self.superview.frame.size.width - self.frame.size.width) + offset, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)alignParentLeft:(CGFloat)offset{
    self.frame = CGRectMake(offset, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)alignParentRight:(CGFloat)offset{
    self.frame = CGRectMake(self.superview.frame.size.width - self.frame.size.width + offset, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)alignParentVerticalCenter:(CGFloat)offset{
    self.frame = CGRectMake(self.frame.origin.x, 0.5 * (self.superview.frame.size.height - self.frame.size.height) + offset, self.frame.size.width, self.frame.size.height);
}

-(void)alignParentTop:(CGFloat)offset{
    self.frame = CGRectMake(self.frame.origin.x, offset, self.frame.size.width, self.frame.size.height);
}

-(void)alignParentBottom:(CGFloat)offset{
    self.frame = CGRectMake(self.frame.origin.x, self.superview.frame.size.height - self.frame.size.height + offset, self.frame.size.width, self.frame.size.height);
}

-(void)contrainedToFrame:(CGRect)frame{
    self.fdAutoFitMode = FDAutoFitModeContrainedFrame;
    self.frame = frame;
}

@end
