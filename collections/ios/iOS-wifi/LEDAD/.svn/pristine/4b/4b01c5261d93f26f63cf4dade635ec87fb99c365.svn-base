//
//  NLImageCropperView.m
//  NLImageCropper
//
// Copyright © 2012, Mirza Bilal (bilal@mirzabilal.com)
// All rights reserved.
//  Permission is hereby granted, free of charge, to any person obtaining a copy
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
// 1.	Redistributions of source code must retain the above copyright notice,
//       this list of conditions and the following disclaimer.
// 2.	Redistributions in binary form must reproduce the above copyright notice,
//       this list of conditions and the following disclaimer in the documentation
//       and/or other materials provided with the distribution.
// 3.	Neither the name of Mirza Bilal nor the names of its contributors may be used
//       to endorse or promote products derived from this software without specific
//       prior written permission.
// THIS SOFTWARE IS PROVIDED BY MIRZA BILAL "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL MIRZA BILAL BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
// IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
// ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NLImageCropperView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIButton+Bootstrap.h"
#import "SGInfoAlert.h"

#define MIN_IMG_SIZE 30

@implementation NLImageCropperView

- (void)setCropRegionRect:(CGRect)cropRect
{
    _cropRect = cropRect;
    _translatedCropRect =CGRectMake(cropRect.origin.x/_scalingFactor, cropRect.origin.y/_scalingFactor, cropRect.size.width/_scalingFactor, cropRect.size.height/_scalingFactor);
    [_cropView setCropRegionRect:_translatedCropRect];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _image = nil;
    if (self) {
        // Initialization code
    }
    [self setBackgroundColor:[UIColor whiteColor]];
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _cropView = [[NLCropViewLayer alloc] initWithFrame:CGRectMake(0, 0, SCREEN_CGSIZE_HEIGHT - 70, SCREEN_CGSIZE_WIDTH)];
    [_cropView setBackgroundColor:[UIColor clearColor]];

    [self setAutoresizesSubviews:YES];
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

    
    
    [self addSubview:_imageView];
    [self addSubview:_cropView];
    [self setCropRegionRect:CGRectMake(100, 100, 100, 100)];
    _scalingFactor = 1.0;
    _movePoint = NoPoint;
    _lastMovePoint = CGPointMake(0, 0);
    
    
#ifdef ARC
    [_imageView release];
    [_cropView release];
#endif
    
    
    UIButton *saveImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveImageButton.tag = 2880;
    saveImageButton.frame = CGRectMake(SCREEN_CGSIZE_HEIGHT - 70 - 140, 70, 135, 30);
//    saveImageButton.layer.cornerRadius = 4;
    [saveImageButton setTitle:NSLocalizedString(@"YunPing_Get160", @"生成160*640图片") forState:UIControlStateNormal];
//    [saveImageButton primaryStyle];
    [saveImageButton setBackgroundColor:[UIColor colorWithWhite:0.800 alpha:1.000]];
    [saveImageButton setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
    [saveImageButton addTarget:self action:@selector(getCroppedImage:) forControlEvents:UIControlEventTouchUpInside];
    saveImageButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:saveImageButton];
    
//    UIButton *saveImageButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    saveImageButton1.tag = 2;
//    saveImageButton1.frame = CGRectMake(SCREEN_CGSIZE_HEIGHT - 70 - 140, 110, 135, 30);
////    saveImageButton1.layer.cornerRadius = 4;
//    [saveImageButton1 setTitle:NSLocalizedString(@"YunPing_Get240", @"生成240*800图片") forState:UIControlStateNormal];
////    [saveImageButton1 primaryStyle];
//    [saveImageButton1 setBackgroundColor:[UIColor colorWithWhite:0.800 alpha:1.000]];
//    [saveImageButton1 setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
//    [saveImageButton1 addTarget:self action:@selector(getCroppedImage:) forControlEvents:UIControlEventTouchUpInside];
//    saveImageButton1.titleLabel.font = [UIFont systemFontOfSize:16];
//    saveImageButton1.titleLabel.font = [UIFont systemFontOfSize:16];
//    [self addSubview:saveImageButton1];
//
//    UIButton *saveImageButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    saveImageButton3.tag = 2880;
//    saveImageButton3.frame = CGRectMake(SCREEN_CGSIZE_HEIGHT - 70 - 140, saveImageButton1.frame.size.height + saveImageButton1.frame.origin.y + 10, 135, 30);
//    //    saveImageButton1.layer.cornerRadius = 4;
//    [saveImageButton3 setTitle:NSLocalizedString(@"YunPing_Get240", @"生成240*800图片") forState:UIControlStateNormal];
//    //    [saveImageButton1 primaryStyle];
//    [saveImageButton3 setBackgroundColor:[UIColor colorWithWhite:0.800 alpha:1.000]];
//    [saveImageButton3 setBackgroundImage:[UIImage imageNamed:@"aboutDesigner_bg_pressed"] forState:UIControlStateHighlighted];
//    [saveImageButton3 addTarget:self action:@selector(getCroppedImage:) forControlEvents:UIControlEventTouchUpInside];
//    saveImageButton3.titleLabel.font = [UIFont systemFontOfSize:16];
//    saveImageButton3.titleLabel.font = [UIFont systemFontOfSize:16];
//    [self addSubview:saveImageButton3];

    sliderX = [[UISlider alloc] initWithFrame:CGRectMake(50, SCREEN_CGSIZE_WIDTH - 160, SCREEN_CGSIZE_HEIGHT - 70 - 100, 20)];
    sliderY = [[UISlider alloc] initWithFrame:CGRectMake(50, SCREEN_CGSIZE_WIDTH - 120, SCREEN_CGSIZE_HEIGHT - 70 - 100, 20)];
    sliderW = [[UISlider alloc] initWithFrame:CGRectMake(50, SCREEN_CGSIZE_WIDTH - 80, SCREEN_CGSIZE_HEIGHT - 70 - 100, 20)];
    sliderH = [[UISlider alloc] initWithFrame:CGRectMake(50, SCREEN_CGSIZE_WIDTH - 40, SCREEN_CGSIZE_HEIGHT - 70 - 100, 20)];
    [sliderX addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventValueChanged];
    [sliderY addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventValueChanged];
    [sliderW addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventValueChanged];
    [sliderH addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventValueChanged];
    
    sliderX.maximumValue = SCREEN_CGSIZE_HEIGHT;
    sliderY.maximumValue = SCREEN_CGSIZE_WIDTH;
    sliderW.maximumValue = 1000;
    sliderH.maximumValue = 1000;
    //设置初始值 (512 - 80, 20, 160, 640)
    sliderX.value = 432;
    sliderY.value = 20;
    sliderW.value = 160;
    sliderH.value = 640;
    
    labelX = [[NLLabel alloc] initWithFrame:CGRectMake(15, SCREEN_CGSIZE_WIDTH - 160, 30, 25)];
    labelY = [[NLLabel alloc] initWithFrame:CGRectMake(15, SCREEN_CGSIZE_WIDTH - 120, 30, 25)];
    labelW = [[NLLabel alloc] initWithFrame:CGRectMake(15, SCREEN_CGSIZE_WIDTH - 80, 30, 25)];
    labelH = [[NLLabel alloc] initWithFrame:CGRectMake(15, SCREEN_CGSIZE_WIDTH - 40, 30, 25)];
    labelX.text = @"X:";
    labelY.text = @"Y:";
    labelW.text = @"w:";
    labelH.text = @"H:";
    
    
    labelX1 = [[NLLabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_HEIGHT - 50 - 70, SCREEN_CGSIZE_WIDTH - 160, 40, 25)];
    labelY1 = [[NLLabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_HEIGHT - 50 - 70, SCREEN_CGSIZE_WIDTH - 120, 40, 25)];
    labelW1 = [[NLLabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_HEIGHT - 50 - 70, SCREEN_CGSIZE_WIDTH - 80, 40, 25)];
    labelH1 = [[NLLabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_HEIGHT - 50 - 70, SCREEN_CGSIZE_WIDTH - 40, 40, 25)];
    //设置初始值 (512 - 80, 20, 160, 640)
    labelX1.text = @"432";
    labelY1.text = @"20";
    labelW1.text = @"160";
    labelH1.text = @"640";
    
    [self addSubview:labelX1];
    [self addSubview:labelY1];
    [self addSubview:labelW1];
    [self addSubview:labelH1];
    
    [self addSubview:labelX];
    [self addSubview:labelY];
    [self addSubview:labelW];
    [self addSubview:labelH];
    
    [self addSubview:sliderX];
    [self addSubview:sliderY];
    [self addSubview:sliderW];
    [self addSubview:sliderH];



    return self;
}

- (void)changeValue
{
    
    labelX1.text = [NSString stringWithFormat:@"%d", (int)[sliderX value]];
    labelY1.text = [NSString stringWithFormat:@"%d", (int)[sliderY value]];
    labelW1.text = [NSString stringWithFormat:@"%d", (int)[sliderW value]];
    labelH1.text = [NSString stringWithFormat:@"%d", (int)[sliderH value]];
    
    [_cropView setNeedsDisplay];
    _cropRect = CGRectMake(sliderX.value *_scalingFactor, sliderY.value *_scalingFactor, sliderW.value *_scalingFactor, sliderH.value *_scalingFactor);
    [self setCropRegionRect:_cropRect];

    float labelw1 = [labelW1.text floatValue];
    float labelh1 = [labelH1.text floatValue];
    UIButton *b = (UIButton *)[self viewWithTag:2880];
    [b setTitle:[[NSString alloc] initWithFormat:@"%0.0lf*%0.0lf截图",labelw1,labelh1] forState:UIControlStateNormal];
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (_image != nil) {
        [self reLayoutView];
    }
    NSLog(@"Set Frame Called");
}
- (void) setImage:(UIImage*)image
{
    _image = image;

    [self reLayoutView];
    
    [_imageView setImage:_image];    
}

- (void) reLayoutView
{
    float imgWidth = _image.size.width;
    float imgHeight = _image.size.height;
    float viewWidth = self.bounds.size.width - 2*IMAGE_BOUNDRY_SPACE;
    float viewHeight = self.bounds.size.height - 2*IMAGE_BOUNDRY_SPACE;
    
    float widthRatio = imgWidth / viewWidth;
    float heightRatio = imgHeight / viewHeight;
    _scalingFactor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    _imageView.bounds = CGRectMake(0, 0, imgWidth / _scalingFactor, imgHeight/_scalingFactor);
    _imageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    _imageView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    _imageView.layer.shadowOffset = CGSizeMake(3, 3);
    _imageView.layer.shadowOpacity = 0.6;
    _imageView.layer.shadowRadius = 1.0;
    
    _cropView.bounds = _imageView.bounds;
    _cropView.frame = _imageView.frame;
    
    [self setCropRegionRect:_cropRect];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        NSLog(@"Touch Begins");
    [super touchesBegan:touches withEvent:event];

    CGPoint locationPoint = [[touches anyObject] locationInView:_imageView];
    if(locationPoint.x < 0 || locationPoint.y < 0 || locationPoint.x > _imageView.bounds.size.width || locationPoint.y > _imageView.bounds.size.height)
    {
        _movePoint = NoPoint;
        return;
    }
    _lastMovePoint = locationPoint;
    
    if(((locationPoint.x - 5) <= _translatedCropRect.origin.x) &&
       ((locationPoint.x + 5) >= _translatedCropRect.origin.x))
    {
        if(((locationPoint.y - 5) <= _translatedCropRect.origin.y) &&
           ((locationPoint.y + 5) >= _translatedCropRect.origin.y))
            _movePoint = LeftTop;
        else if ((locationPoint.y - 5) <= (_translatedCropRect.origin.y + _translatedCropRect.size.height) &&
                 (locationPoint.y + 5) >= (_translatedCropRect.origin.y + _translatedCropRect.size.height))
            _movePoint = LeftBottom;
        else
            _movePoint = NoPoint;
    }
    else if(((locationPoint.x - 5) <= (_translatedCropRect.origin.x + _translatedCropRect.size.width)) &&
            ((locationPoint.x + 5) >= (_translatedCropRect.origin.x + _translatedCropRect.size.width)))
    {
        if(((locationPoint.y - 5) <= _translatedCropRect.origin.y) &&
           ((locationPoint.y + 5) >= _translatedCropRect.origin.y))
            _movePoint = RightTop;
        else if ((locationPoint.y - 5) <= (_translatedCropRect.origin.y + _translatedCropRect.size.height) &&
                 (locationPoint.y + 5) >= (_translatedCropRect.origin.y + _translatedCropRect.size.height))
            _movePoint = RightBottom;
        else
            _movePoint = NoPoint;
    }
    else if ((locationPoint.x > _translatedCropRect.origin.x) && (locationPoint.x < (_translatedCropRect.origin.x + _translatedCropRect.size.width)) &&
             (locationPoint.y > _translatedCropRect.origin.y) && (locationPoint.y < (_translatedCropRect.origin.y + _translatedCropRect.size.height)))
    {
        _movePoint = MoveCenter;
    }
    else
        _movePoint = NoPoint;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];

    CGPoint locationPoint = [[touches anyObject] locationInView:_imageView];

    NSLog(@"Location Point: (%f,%f)", locationPoint.x, locationPoint.y);
    if(locationPoint.x < 0 || locationPoint.y < 0 || locationPoint.x > _imageView.bounds.size.width || locationPoint.y > _imageView.bounds.size.height)
    {
        _movePoint = NoPoint;
        return;
    }
    float x,y;
    switch (_movePoint) {
        case LeftTop:
            if(((locationPoint.x + MIN_IMG_SIZE) >= (_translatedCropRect.origin.x + _translatedCropRect.size.width)) ||
               ((locationPoint.y + MIN_IMG_SIZE)>= (_translatedCropRect.origin.y + _translatedCropRect.size.height)))
                return;
            _translatedCropRect = CGRectMake(locationPoint.x, locationPoint.y,
                                   _translatedCropRect.size.width + (_translatedCropRect.origin.x - locationPoint.x),
                                   _translatedCropRect.size.height + (_translatedCropRect.origin.y - locationPoint.y));
            break;
        case LeftBottom:
            if(((locationPoint.x + MIN_IMG_SIZE) >= (_cropRect.origin.x + _translatedCropRect.size.width)) ||
               ((locationPoint.y - _translatedCropRect.origin.y) <= MIN_IMG_SIZE))
                return;
            _translatedCropRect = CGRectMake(locationPoint.x, _translatedCropRect.origin.y,
                                   _translatedCropRect.size.width + (_translatedCropRect.origin.x - locationPoint.x),
                                   locationPoint.y - _translatedCropRect.origin.y);
            break;
        case RightTop:
            if(((locationPoint.x - _translatedCropRect.origin.x) <= MIN_IMG_SIZE) ||
               ((locationPoint.y + MIN_IMG_SIZE)>= (_translatedCropRect.origin.y + _translatedCropRect.size.height)))
                return;
            _translatedCropRect = CGRectMake(_translatedCropRect.origin.x, locationPoint.y,
                                   locationPoint.x - _cropRect.origin.x,
                                   _translatedCropRect.size.height + (_translatedCropRect.origin.y - locationPoint.y));
            break;
        case RightBottom:
            if(((locationPoint.x - _translatedCropRect.origin.x) <= MIN_IMG_SIZE) ||
               ((locationPoint.y - _translatedCropRect.origin.y) <= MIN_IMG_SIZE))
                return;
            _translatedCropRect = CGRectMake(_translatedCropRect.origin.x, _translatedCropRect.origin.y,
                                   locationPoint.x - _translatedCropRect.origin.x,
                                   locationPoint.y - _translatedCropRect.origin.y);
            break;
        case MoveCenter:

            x = _lastMovePoint.x - locationPoint.x;
            y = _lastMovePoint.y - locationPoint.y;
            if(((_translatedCropRect.origin.x-x) > 0) && ((_translatedCropRect.origin.x + _translatedCropRect.size.width - x) <
                                                          _cropView.bounds.size.width) &&
               ((_translatedCropRect.origin.y-y) > 0) && ((_translatedCropRect.origin.y + _translatedCropRect.size.height - y) < _cropView.bounds.size.height))
            {
                
                _translatedCropRect = CGRectMake(_translatedCropRect.origin.x - x, _translatedCropRect.origin.y - y, _translatedCropRect.size.width, _translatedCropRect.size.height);

            }
            _lastMovePoint = locationPoint;
            break;
        default: //NO Point
            return;
            break;
    }
    [_cropView setNeedsDisplay];
    _cropRect = CGRectMake(_translatedCropRect.origin.x*_scalingFactor, _translatedCropRect.origin.y*_scalingFactor, _translatedCropRect.size.width*_scalingFactor, _translatedCropRect.size.height*_scalingFactor);
    [self setCropRegionRect:_cropRect];
    
}

- (UIImage *)getCroppedImage:(UIButton *)button{
    
    NSLog(@"_image.scale = %f",_image.scale);
    if (_image == nil) {
        UIAlertView *noImageAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Yunping_NOImage", @"还没选取图片") message:NSLocalizedString(@"Yunping_SelectImageFirst", @"请先选择完图片后在进行截图操作") delegate:self cancelButtonTitle:NSLocalizedString(@"NSStringOKButtonTitle", @"确定") otherButtonTitles:nil, nil];
        [noImageAlert show];
        return nil;
    }
    CGRect imageRect = CGRectMake(_cropRect.origin.x*_image.scale,
                      _cropRect.origin.y*_image.scale,
                      _cropRect.size.width*_image.scale,
                      _cropRect.size.height*_image.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([_image CGImage], imageRect);
    UIImage *result = [UIImage imageWithCGImage:imageRef
                                          scale:_image.scale
                                    orientation:_image.imageOrientation];
//    CIImage *imageCI = [[CIImage alloc] initWithCGImage:imageRef options:nil];
//    UIImage *result1 = [UIImage imageWithCIImage:imageCI scale:_image.scale orientation:_image.imageOrientation];
//    UIImageWriteToSavedPhotosAlbum(result1, nil, nil, nil);

    NSLog(@"_image.size.width = %f\n_image.size.height = %f\nresult.size.width = %f\nresult.size.height = %f",_image.size.width, _image.size.height, result.size.width, result.size.height);
//    UIImageWriteToSavedPhotosAlbum(result, nil, nil, nil);
    CGImageRelease(imageRef);
    float labelw1 = [labelW1.text floatValue];
    float labelh1 = [labelH1.text floatValue];

//测试调整像素测试
    switch (button.tag) {
        case 1:
            newSize = CGSizeMake(160, 640);
            albumName = [[NSString alloc] initWithString:@"160*640截图"];
            break;
        case 2:
            newSize = CGSizeMake(240, 800);
            albumName = [[NSString alloc] initWithString:@"240*800截图"];
            break;
        case 2880:
            newSize = CGSizeMake(labelw1, labelh1);
            albumName = [[NSString alloc] initWithFormat:@"%0.0lf*%0.0lf截图",labelw1,labelh1];
            break;
        default:
            newSize = CGSizeMake(160, 640);
            break;
    }
    UIGraphicsBeginImageContext(newSize);
    [result drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //保存图片到指定相册
    [self saveImage:newImage];
//    [self saveImage:result];
    UIGraphicsEndImageContext();
    
    return result;
}

- (void)saveImage:(UIImage *)image
{
    myLibrary = [[ALAssetsLibrary alloc] init];
    [myLibrary writeImageDataToSavedPhotosAlbum:UIImagePNGRepresentation(image)
                                       metadata:nil
                                completionBlock:^(NSURL *assetURL, NSError *error) {
                                    if (error != nil) {
                                        //show error message
                                        NSLog(@"take picture failed");
                                    }else
                                    {
                                        //show message image successfully saved
                                        //show message image successfully saved
                                        UIAlertView *noImageAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"YunPing_ImageSaved", @"图片已保存") message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"NSStringOKButtonTitle", @"确定") otherButtonTitles:nil, nil];
                                        [noImageAlert show];
//                                        [SGInfoAlert showInfo:NSLocalizedString(@"YunPing_ImageSaved", @"图片已保存")
//                                                      bgColor:[[UIColor darkGrayColor] CGColor]
//                                                       inView:self
//                                                     vertical:0.5];
                                        //2014年09月03日17:39:12（新增功能：保存图片到自建相簿）
                                        __block BOOL albumWasFound = NO;
                                        [myLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum
                                                                 usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                                                     NSLog(@"albumName = %@",[group valueForProperty:ALAssetsGroupPropertyName]);
                                                                     if ([albumName compare: [group valueForProperty:ALAssetsGroupPropertyName]]==NSOrderedSame) {
                                                                         albumWasFound = YES;
                                                                         [myLibrary assetForURL: assetURL
                                                                                    resultBlock:^(ALAsset *asset) {
                                                                                        [group addAsset: asset];
                                                                                    } failureBlock: nil];
                                                                         return;
                                                                     }
                                                                     if (group==nil && albumWasFound==NO) {
                                                                         ALAssetsLibrary *weakSelf = myLibrary;
                                                                         [myLibrary addAssetsGroupAlbumWithName:albumName
                                                                                                    resultBlock:^(ALAssetsGroup *group) {
                                                                                                        [weakSelf assetForURL: assetURL
                                                                                                                  resultBlock:^(ALAsset *asset) {
                                                                                                                      [group addAsset: asset];
                                                                                                                  } failureBlock: nil];
                                                                                                    } failureBlock: nil];
                                                                         return;
                                                                     }
                                                                 } failureBlock: nil];
                                    }
                                }];
}


@end
