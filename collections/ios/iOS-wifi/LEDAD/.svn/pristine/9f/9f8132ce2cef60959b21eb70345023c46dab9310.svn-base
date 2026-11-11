//
//  YueLoadingView.m
//  yuexianghui
//
//  Created by cherish on 15/3/9.
//  Copyright (c) 2015年 悦客盟. All rights reserved.
//


//获得物理屏幕的宽
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
//获得物理屏幕的高
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#import "YueLoadingView.h"
#import "UIViewExt.h"
@interface YueLoadingView ()
{
    //overlayWindow
    UIWindow *overlayWindow;
    
    //loading 视图
    UIActivityIndicatorView *_myActivityIndicatorView;
    
    //loading 提示信息
    UILabel *_myInfoLable;
}



//展示消息
- (void)showWithInfo:(NSString*)info;

//移除
- (void)dismiss;

@end



@implementation YueLoadingView



#pragma mark - sharedLoadingView
+ (YueLoadingView*)sharedLoadingView
{
    static dispatch_once_t once;
    
    static YueLoadingView *sharedLoadingView;
    
    dispatch_once(&once, ^ {
        sharedLoadingView = [[YueLoadingView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    
    sharedLoadingView.userInteractionEnabled = YES;
    
    return sharedLoadingView;
}//实现单例模式



#pragma mark -  展示，移除
+ (void)showWithInfo:(NSString*)info
{
    DLog(@"用了堵车");
    [[YueLoadingView sharedLoadingView] showWithInfo:info];
}//展示消息


+ (void)dismiss
{
    [[YueLoadingView sharedLoadingView] dismiss];
    
    NSLog(@"dismiss Action");
    
}//移除


#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{
    
    if ((self = [super initWithFrame:frame]))
    {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.75];
        
        self.alpha = 1.0;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //旋转屏幕，但是只旋转当前的View
//        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    }
    
    [self addMyLoadingView];
    
    
    return self;
}//初始化



-(void)addMyLoadingView
{
    float loadViewWidth      = 90.0;//宽度
    float indicatorViewWidth = 38.0;//宽度
    
    CGRect loadFram = CGRectMake((kScreenWidth-loadViewWidth)/2.0, (kScreenHeight-loadViewWidth)/2.0-20, loadViewWidth, loadViewWidth);
    
    UIView *loadView = [[UIView alloc] initWithFrame:loadFram];
    
    NSLog(@"=====%@",NSStringFromCGRect(self.frame));
    loadView.center = CGPointMake(768/2, 1024/2);
    
    loadView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
    
    loadView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    //圆角处理
    loadView.layer.cornerRadius = 10;
    loadView.layer.masksToBounds = YES;
    loadView.tag = 122;
    [self addSubview:loadView];
    
    
    //旋转视图
    _myActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    _myActivityIndicatorView.hidesWhenStopped = YES;
    
    NSLog(@"loadViewWidth-indicatorViewWidth = %f",(loadViewWidth-indicatorViewWidth)/2.0);
    
    _myActivityIndicatorView.frame = CGRectMake((loadViewWidth-indicatorViewWidth)/2.0, 12, indicatorViewWidth, indicatorViewWidth);
    
    [loadView addSubview:_myActivityIndicatorView];
    
    
    //展示消息
    _myInfoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, _myActivityIndicatorView.bottom+10, loadViewWidth, 21)];
    
    _myInfoLable.textAlignment = NSTextAlignmentCenter;
    
    _myInfoLable.font = [UIFont systemFontOfSize:14.0];
    
    _myInfoLable.textColor = [UIColor whiteColor];
    
    _myInfoLable.text = @"加载中.....";
    
    [loadView addSubview:_myInfoLable];
    
}//初始化，加视图

//允许界面旋转
//- (BOOL)shouldAutorotate{
//    return YES;
//}

//屏幕旋转操作
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"fffff");
    //只响应横板旋转
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        //      return YES;
        
    }
    //只响应竖版旋转
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        //      return YES;
        
    }
    return NO;
    
}

#pragma mark - Getters
- (UIWindow *)overlayWindowInit {
    if(!overlayWindow) {
//        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];

        
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.backgroundColor = [UIColor clearColor];
        overlayWindow.userInteractionEnabled = NO;
        

    }
    return overlayWindow;
}




#pragma mark - Method
//展示消息
- (void)showWithInfo:(NSString*)info
{
    if(!self.superview)
    {
        overlayWindow = [self overlayWindowInit];
        
        [overlayWindow addSubview:self];
    }
    
    overlayWindow.userInteractionEnabled = YES;
    
    //显示
    [overlayWindow makeKeyAndVisible];

    _myInfoLable.text = info;

    
    [_myActivityIndicatorView startAnimating];
}



//移除
- (void)dismiss
{
    [_myActivityIndicatorView stopAnimating];
    
    
    // before trying to find the key window in that same list
    NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
    [windows removeObject:overlayWindow];
    overlayWindow = nil;
    
    [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
        if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal)
        {
            [window makeKeyWindow];
            *stop = YES;
        }
    }];

    
}




#pragma mark - touch method

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesBegan:touches withEvent:event];
//
//    //[self dismiss];
//}
//
//
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesEnded:touches withEvent:event];
//}
//
//
//



@end
