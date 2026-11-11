//
//  YXM_MasterTableViewCell.m
//  LEDAD
//
//  Created by yixingman on 14-9-24.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import "YXM_MasterTableViewCell.h"
#import <ImageIO/ImageIO.h>

@implementation YXM_MasterTableViewCell
@synthesize myALAsset = _MyALAsset;

-(ALAsset *)myALAsset{
    return _MyALAsset;
}

-(void)setMyALAsset:(ALAsset *)myALAsset{
    @try {
        if (myALAsset != _MyALAsset) {
            [_MyALAsset release],_MyALAsset = nil;
            _MyALAsset = [myALAsset retain];

//            ALAssetRepresentation *rep = [_MyALAsset defaultRepresentation];
            [_MyThumbnailImageView setImage:[UIImage imageWithCGImage:[_MyALAsset thumbnail]]];

            [_MyTypeImageView setImage:[UIImage imageNamed:[_MyALAsset valueForProperty:ALAssetPropertyType]]];

            //
//            CGSize sizeOfImage = [YXM_MasterTableViewCell sizeOfAsset:_MyALAsset];
//            [_PixelLabel setText:[NSString stringWithFormat:@"%0.0lfX%0.0lf",sizeOfImage.width,sizeOfImage.height]];
        }
    }
    @catch (NSException *exception) {
        DLog(@"项目列表项数据设置时出错 = %@",exception);
    }
    @finally {

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *cellView = [self getCellView];
        [self.contentView addSubview:cellView];
    }
    return self;
}

-(UIView*)getCellView{
    NSInteger cellWidth = 320;
    NSInteger cellHeight = 80;
    CGRect rectCellView = CGRectMake(0, 0, cellWidth, cellHeight);
    UIView *cellView = [[[UIView alloc]initWithFrame:rectCellView] autorelease];

    //缩略图
    _MyThumbnailImageView = [[UIImageView alloc]initWithFrame:CGRectMake(6, 3, cellHeight-6, cellHeight-6)];
    [_MyThumbnailImageView setContentMode:UIViewContentModeScaleAspectFit];
    [cellView addSubview:_MyThumbnailImageView];

    //素材类型
    _MyTypeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(cellWidth - 140, 25, 30, 30)];
    [cellView addSubview:_MyTypeImageView];

    //像素标签
    _PixelLabel = [[UILabel alloc]initWithFrame:CGRectMake(cellWidth - 100, 25, 100, 30)];
    [_PixelLabel setFont:[UIFont systemFontOfSize:14]];
    [_PixelLabel setBackgroundColor:[UIColor clearColor]];
    [cellView addSubview:_PixelLabel];

    return cellView;
}


// This method requires the ImageIO.framework
// This requires memory for the size of the image in bytes, but does not decompress it.
+ (CGSize)sizeOfImageWithData:(NSData*) data;
{
    CGSize imageSize = CGSizeZero;
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef) data, NULL);
    if (source)
    {
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCGImageSourceShouldCache];

        NSDictionary *properties = (__bridge_transfer NSDictionary*) CGImageSourceCopyPropertiesAtIndex(source, 0, (__bridge CFDictionaryRef) options);

        if (properties)
        {
            NSNumber *width = [properties objectForKey:(NSString *)kCGImagePropertyPixelWidth];
            NSNumber *height = [properties objectForKey:(NSString *)kCGImagePropertyPixelHeight];
            if ((width != nil) && (height != nil))
                imageSize = CGSizeMake(width.floatValue, height.floatValue);
        }
        CFRelease(source);
    }
    return imageSize;
}

+ (CGSize)sizeOfAssetRepresentation:(ALAssetRepresentation*) assetRepresentation;
{
    // It may be more efficient to read the [[[assetRepresentation] metadata] objectForKey:@"PixelWidth"] integerValue] and corresponding height instead.
    // Read all the bytes for the image into NSData.
    long long imageDataSize = [assetRepresentation size];
    uint8_t* imageDataBytes = malloc(imageDataSize);
    [assetRepresentation getBytes:imageDataBytes fromOffset:0 length:imageDataSize error:nil];
    NSData *data = [NSData dataWithBytesNoCopy:imageDataBytes length:imageDataSize freeWhenDone:YES];

    return [YXM_MasterTableViewCell sizeOfImageWithData:data];
}

+ (CGSize)sizeOfAsset:(ALAsset*) asset;
{
    return [YXM_MasterTableViewCell sizeOfAssetRepresentation:[asset defaultRepresentation]];
}
@end
