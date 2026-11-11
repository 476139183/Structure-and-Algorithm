//
//  ProductionsViewController.h
//  云屏
//
//  Created by LDY on 7/22/14.
//  Copyright (c) 2014 LDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "KKProgressTimer.h"
#import "EScrollerView.h"
#import "ImageListViewController.h"
#import "AboutDesignerView.h"

@interface ProductionsViewController : UIViewController<ASIHTTPRequestDelegate, EScrollerViewDelegate, KKProgressTimerDelegate>
{
    UIButton *backToMainButton;
    //语言环境
    NSString* strLanguage;
    //刷新按钮
    UIButton *refreshButton;
    
    //2014年07月19日17:44:45云屏项目
    //广告链接数据
    NSMutableArray *adDataArray;
    NSMutableArray *adIntroduceArray;

    NSString *_firstPageUrl;
    //下一页的URL
    NSMutableString *_nextPageUrl;
    NSMutableArray *_newsList;
    ImageListViewController *imageListVC;
    
    //设计师详细信息页面
    UIScrollView *containerView;
    AboutDesignerView *aboutDesignerView;
    BOOL designerViewHidden;
    UIButton *showDesignerButton;
    NSUserDefaults *ud;
    
    EScrollerView *adEScrollerView;//滚动页面
}

@property (nonatomic, retain) NSString *requestUrl;
//- (void)loadData:(NSString *)requestUrl;

@property (nonatomic, retain) NSString *telString;
@property (nonatomic, retain) NSString *nameString;
@property (nonatomic, retain) NSString *qqString;
@property (nonatomic, retain) NSString *descriptionString;
@property (nonatomic, retain) NSString *photoUrl;


@end
