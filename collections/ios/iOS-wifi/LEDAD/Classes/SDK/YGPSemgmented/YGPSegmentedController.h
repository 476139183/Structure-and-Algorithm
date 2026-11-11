//
//  YGPSegmentedController.h
//  YGPSegmentedSwitch
//
//  Created by yang on 13-6-27.
//  Copyright (c) 2013年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YGPSegmentedController;
@protocol YGPSegmentedControllerDelegate <NSObject>
@optional
- (void)segmentedViewController:(YGPSegmentedController *)segmentedControl touchedAtIndex:(NSUInteger)index;
-(void)nextleftcontroller:(BOOL)letf;//左滑
@end



@interface YGPSegmentedController : UIView

{
    
    UIImageView *buttonBackgroundImage;    //选中时背景视图
    NSInteger    SelectedTagChang;              //选择tag
    
    /**
     *@brief  标题数组
     */
    NSMutableArray *TitleArray;
    
    BOOL letf;
    
}
@property (assign, nonatomic) id<YGPSegmentedControllerDelegate>Delegate;

@property (strong, nonatomic) NSMutableArray  * TitleArray;     //按钮title
@property (strong, nonatomic) UIButton * SegmentedButton;       //button
@property (strong, nonatomic) UIScrollView * YGPScrollView;     //滚动视图
@property (assign, nonatomic) NSUInteger  Textleng;
@property (strong, nonatomic) NSMutableArray * TEXTLENGARRAY;
@property (nonatomic,retain) UIImageView *buttonBackgroundImage;

@property(nonatomic,strong)UIButton *leftButton;//左滑的按钮
/*
 初始化方法
 title 传入button的title（NSArray）
 Frame 设置view的框架
 */
-(id)initContentTitle:(NSMutableArray*)Title CGRect:(CGRect)Frame;
-(id)initContentTitleContaintFrame:(NSMutableArray*)Title CGRect:(CGRect)Frame ContaintFrame:(CGRect)ContaintFrame;

//初始化选择indx （0）
/*由于技术原因在初始选择时请调用次方法
 此方法初始值为0*/
-(NSInteger)initselectedSegmentIndex;

//设置背景颜色
-(void)setBackgroundColor;

@end
