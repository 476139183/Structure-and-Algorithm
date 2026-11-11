//
//  YXM_MasterTableViewCell.h
//  LEDAD
//
//  Created by yixingman on 14-9-24.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface YXM_MasterTableViewCell : UITableViewCell
{
    //缩略图
    UIImageView *_MyThumbnailImageView;
    UIImageView *_MyTypeImageView;
    UILabel *_PixelLabel;

    ALAsset *_MyALAsset;
}
@property (nonatomic,retain) ALAsset *myALAsset;
-(UIView*)getCellView;
+ (CGSize)sizeOfAsset:(ALAsset*) asset;
@end
