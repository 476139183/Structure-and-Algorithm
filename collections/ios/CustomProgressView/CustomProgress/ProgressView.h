//
//  ProgressView.h
//  CustomProgress
//
//  Created by duanyutian on 2017/6/11.
//  Copyright © 2017年 duanyutian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

@property (nonatomic, assign) NSInteger index;

- (instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)data;

@end
