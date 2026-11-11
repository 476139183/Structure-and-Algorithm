//
//  AoutDesignerView.h
//  云屏
//
//  Created by LDY on 7/22/14.
//  Copyright (c) 2014 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLabel.h"

@interface AboutDesignerView : UIView
{
    UIImageView *headImageView;
    MyLabel *nameLabel;
    MyLabel *telLabel;
    MyLabel *qqLabel;
    UITextView *descriptionTextView;
}

@property (nonatomic, retain) UIImageView *headImageView;

@property (nonatomic, retain) MyLabel *nameLabel;
@property (nonatomic, retain) MyLabel *telLabel;
@property (nonatomic, retain) MyLabel *qqLabel;
@property (nonatomic, retain) UITextView *descriptionTextView;
@end
