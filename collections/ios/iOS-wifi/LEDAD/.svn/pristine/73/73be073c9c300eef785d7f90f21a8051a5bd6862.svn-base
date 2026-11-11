//
//  DetailImageViewController.h
//  云屏
//
//  Created by LDY on 7/21/14.
//  Copyright (c) 2014 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDescriptionEntity.h"

@interface DetailImageViewController : UIViewController<UIAlertViewDelegate>
{
    UIImageView *detailImage;
    UIButton *backToMainButton;
    
    UIView *descriptionView;
    UILabel *label1;//类型
    UILabel *label2;//分辨率
    UILabel *label3;//设计者
    UILabel *label4;//描述
    UILabel *label5;//未用
    
    UILabel *label11;//分辨率
    UILabel *label12;//物理尺寸：长，宽，高
    UILabel *label13;//重量
    UILabel *label14;//亮度
    UILabel *label15;//功耗
    UILabel *label16;//安装方式
    UILabel *label17;//价格
    
    UIButton *jumpToImageButton;//跳转按钮
    UIImageView *aboutButtonCurve;
}

@property (nonatomic, retain) NSString *detailImageName;

//图片描述所需参数
@property (nonatomic, retain) ImageDescriptionEntity *oneImageEntity;

@property (nonatomic, retain) NSString *itemId;//屏体跳转到图片所需id
@property (nonatomic, retain) NSString *parentId;//图片跳转到屏体所需id

@property (nonatomic, retain) NSString *albumName;//创建相册的名称

@property (nonatomic, retain) UIImageView *_detailImage;

@end
