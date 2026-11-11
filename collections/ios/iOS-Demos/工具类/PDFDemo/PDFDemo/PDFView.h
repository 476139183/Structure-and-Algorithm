//
//  PDFView.h
//  PDFDemo
//
//  Created by Yutian Duan on 2018/7/27.
//  Copyright © 2018年 huangpanpan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFView : UIView

@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, copy) NSString *fileName;

- (CGPDFDocumentRef)createPDFFromExistFile;

- (instancetype)initWithFrame:(CGRect)frame atPage:(NSInteger)page andFileName:(NSString *)fileName;

@end
