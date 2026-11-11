//
//  CX_SaveViewController.h
//  LEDAD
//
//  Created by chengxu on 15/5/15.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALAsset+isEqual.h"
#import "ALAsset+assetType.h"
#import "ALAssetsGroup+isEqual.h"
#import "ALAsset+accessibilityLabel.h"
typedef void(^ButtonOnClick)(void);

@protocol myprojectloaddata <NSObject>

-(void)selfreloadview;

@end
@interface CX_SaveViewController : UIViewController
{
     
}
@property(nonatomic,strong) ALAsset *asset;
@property(nonatomic,copy) ButtonOnClick buttonOnClick;
@property(nonatomic,assign)id<myprojectloaddata>delegata;
@end
