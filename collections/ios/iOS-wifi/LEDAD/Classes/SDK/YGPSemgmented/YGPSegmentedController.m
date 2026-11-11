//
//  YGPSegmentedController.m
//  YGPSegmentedSwitch
//   导航栏
//  Created by yang on 13-6-27.
//  Copyright (c) 2013年 yang. All rights reserved.
//

#import "YGPSegmentedController.h"
#import "Globle.h"
#import "YGPConstKEY.h"

#import "Config.h"
//按钮空隙
#define BUTTONGAP 10
//按钮长度
#define BUTTONWIDTH 70
//按钮宽度
#define BUTTONHEIGHT 30
//滑条CONTENTSIZEX
#define CONTENTSIZEX 320

//偏移量
#define Off [[UIScreen mainScreen]bounds].size.width-80
//选择显示区域（view）
#define SelectVisible (sender.tag-100)
#define initselectedIndex 0

@implementation YGPSegmentedController
{
    
    int ButtonWidthBackg;
    
    NSMutableArray * _Buutonimage;
    BOOL titles;
    
    
}
@synthesize TitleArray;
@synthesize SegmentedButton;
@synthesize Delegate=_delegate;
@synthesize Textleng;
@synthesize YGPScrollView;
@synthesize TEXTLENGARRAY;
@synthesize buttonBackgroundImage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        /**
         *@brief  标题数组
         */
        TitleArray = [[NSMutableArray alloc] initWithCapacity:1];
        
        
        
        self.frame =CGRectZero;
        YGPScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        SelectedTagChang = 1;
        
        [self SetScrollview];     //setup
        [self setSelectedIndex:0];
        
    }
    return self;
}

//初始化框架数据
-(id)initContentTitle:(NSMutableArray*)Title CGRect:(CGRect)Frame
{
    if (self = [super init])
    {
        [self addSubview:YGPScrollView];
        if (TitleArray == nil) {
            TitleArray = [[NSMutableArray alloc] initWithCapacity:1];
        }
        
        
        [TitleArray setArray:Title];
        [self setFrame:Frame];
        [YGPScrollView setFrame:Frame];
        [self setBackgroundColor];
        YGPScrollView.contentSize = CGSizeMake((BUTTONWIDTH+BUTTONGAP)*[self.TitleArray count]+BUTTONGAP, 40);
        TEXTLENGARRAY = [[NSMutableArray alloc]init];
    }
    return self;
}
- (CGFloat) getCellHeight:(NSString *)titleString
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];
    NSString *content = titleString;
    CGFloat maxHeight = [font lineHeight]*1;
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(1000000, maxHeight) lineBreakMode:NSLineBreakByWordWrapping];
    return size.width+50;
}

-(id)initContentTitleContaintFrame:(NSMutableArray*)Title CGRect:(CGRect)Frame ContaintFrame:(CGRect)ContaintFrame
{
    if (self = [super init])
    {
        
        DLog(@"Frame.size.width = %lf",Frame.size.width);
        DLog(@"ContaintFrame.size.width = %lf",ContaintFrame.size.width);
        [self addSubview:YGPScrollView];
        self.userInteractionEnabled = YES;
        TitleArray = Title ;
        [self setFrame:ContaintFrame];
        [YGPScrollView setFrame:Frame];
        CGFloat titleWidth = 0;
        for (int i=0; i<[Title count]; i++) {
            titleWidth += [self getCellHeight:[Title objectAtIndex:i]];
        }
        DLog(@"titleWidth1 = %lf",titleWidth);
        if (titleWidth<SCREEN_CGSIZE_2WIDTH) {
            titleWidth=SCREEN_CGSIZE_2WIDTH;
        }
        DLog(@"titleWidth2 = %lf",titleWidth);
        [self setBackgroundColor];

        YGPScrollView.contentSize = CGSizeMake(titleWidth, 40);
        TEXTLENGARRAY = [[NSMutableArray alloc]init];
        
        DLog(@"YGPScrollView.frame.size.width = %lf,YGPScrollView.frame.size.height = %lf,YGPScrollView.contentSize.width = %lf",Frame.size.width,Frame.size.height,YGPScrollView.contentSize.width);
    }
    //初始化button
    [self  initWithButton];
    
    return self;
}

//设置滚动视图
-(void)SetScrollview
{
    
    YGPScrollView.backgroundColor = [UIColor grayColor];
    YGPScrollView.pagingEnabled = NO;
    YGPScrollView.scrollEnabled=YES;
    YGPScrollView.showsHorizontalScrollIndicator = NO;
    YGPScrollView.showsVerticalScrollIndicator = NO;
    //    [YGPScrollView setScrollsToTop:YES];
    [YGPScrollView setUserInteractionEnabled:YES];
}

//初始化button
-(void)initWithButton
{
    int contentSizeWidth = 0;
    int buttonPadding = 18;
    int xPos =10;
    
    //  导航条上的button
    SegmentedButton.titleLabel.text=nil;
    NSMutableArray * array2 = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<[self.TitleArray count]; i++)
    {
        
        NSString *title = [TitleArray objectAtIndex:i];
        SegmentedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [SegmentedButton setTitle:[NSString stringWithFormat:@"%@",[self.TitleArray objectAtIndex:i]] forState:UIControlStateNormal];
        if (![[UIDevice currentDevice].model isEqualToString:@"iPad"]) {
            SegmentedButton.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        
        int buttonWidth = [title sizeWithFont:SegmentedButton.titleLabel.font
                            constrainedToSize:CGSizeMake(320, 28)
                                lineBreakMode:NSLineBreakByClipping].width;
        
        contentSizeWidth = contentSizeWidth + buttonWidth+buttonPadding;
        DLog(@"buttonWidth = %d",buttonWidth);
        DLog(@"contentSizeWidth = %d",contentSizeWidth);
        
        [SegmentedButton setFrame:CGRectMake(xPos, 9, buttonWidth+buttonPadding, BUTTONHEIGHT)];
        SegmentedButton.tag=i+100;
        if (i==0)
        {
            SegmentedButton.selected=NO;
        }
        
//        [SegmentedButton setTitleColor:[Globle colorFromHexRGB:@"868686"] forState:UIControlStateNormal];
        [SegmentedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [SegmentedButton setTitleColor:[Globle colorFromHexRGB:@"bb0b15"] forState:UIControlStateSelected];
        [SegmentedButton addTarget:self action:@selector(SelectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        xPos += buttonWidth+buttonPadding;
        
        _Buutonimage = [[NSMutableArray alloc]init];
        ButtonWidthBackg=buttonWidth+buttonPadding;
        
        NSString * strings;
        strings = nil;
        strings = [NSString stringWithFormat:@"%f",SegmentedButton.frame.size.width];
        
        [_Buutonimage removeAllObjects];
        [array2 addObject:strings];
        for (NSMutableArray * array3 in array2) {
            [_Buutonimage addObject:array3];
        }
        
        //加入button
        if ([self.TitleArray[0] isEqualToString:[Config DPLocalizedString:@"adedit_localProjects"]]) {
            [SegmentedButton setFrame:CGRectMake(10+40, 9, buttonWidth+buttonPadding, BUTTONHEIGHT)];
        }
        [YGPScrollView addSubview:SegmentedButton];
        DLog(@"SegmentedButton.frame.size.width = %lf",SegmentedButton.frame.size.width);
    }
    if (DEVICE_IS_IPAD) {
        if (contentSizeWidth < 1024-72)
        {
            YGPScrollView.frame = CGRectMake(0, 0, contentSizeWidth + 80, 44);
        }
    }

    YGPScrollView.contentSize = CGSizeMake(contentSizeWidth, 40);
    
    
    
    
    //设置选中背景 下方的线条
    buttonBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(SegmentedButton.frame.origin.x+5, 0, [[_Buutonimage objectAtIndex:0]floatValue], 40)];
    [buttonBackgroundImage setImage:[UIImage imageNamed:@"red_background.png"]];
    [YGPScrollView addSubview:buttonBackgroundImage];
    
    
   // 增加左滑的按钮
//    letf = NO;
//    _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(4, 5, 40, 40)];
//    [_leftButton setImage:[UIImage imageNamed:@"mynextviewleft"] forState:UIControlStateNormal];
//    [_leftButton addTarget:self action:@selector(viewformleft) forControlEvents:UIControlEventTouchUpInside ];
//    
//    [YGPScrollView addSubview:_leftButton];

    
}


////左滑动画
//-(void)viewformleft
//{
//    if (_delegate&&[_delegate respondsToSelector:@selector(nextleftcontroller:)])
//     {
//        
//    
//    [_delegate nextleftcontroller:letf];
//    letf = !letf;
//    _leftButton.imageView.transform = letf ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
//    }
//}

/**
 *@brief  点击button调用方法
 */
- (void)segmentedButton:(UIButton *)sender
{
    /**
     *@brief  取消当前选择
     */
    if (sender.tag != SelectedTagChang) {
        UIButton *allButton = (UIButton *)[self viewWithTag:SelectedTagChang];
        allButton.selected = NO;
        SelectedTagChang = sender.tag;
    }
    
    sender.selected = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        [buttonBackgroundImage setFrame:CGRectMake(sender.frame.origin.x, 5, BUTTONWIDTH-10, 40-5)];
    }completion:^(BOOL finished){
        [self setSelectedIndex:SelectVisible];
    }];
}


//点击button调用方法
-(void)SelectButton:(UIButton*)sender
{
    //取消当前选择
    if (sender.tag!=SelectedTagChang)
    {
        UIButton * ALLButton = (UIButton*)[self viewWithTag:SelectedTagChang];
        ALLButton.selected=NO;
        SelectedTagChang = sender.tag;
    }
    
    sender.selected=YES;
    
    //button 背景图片
    [UIView animateWithDuration:0.25 animations:^{
        [buttonBackgroundImage setFrame:CGRectMake(sender.frame.origin.x, 0,[[_Buutonimage objectAtIndex:SelectVisible]floatValue] , 40)];
    } completion:^(BOOL finished){
        [self setSelectedIndex:SelectVisible];
        
    }];
    
    NSLog(@"%f",sender.frame.origin.x);
    //      [YGPScrollView setContentOffset:CGPointMake(sender.frame.origin.x, 0)];
    float x = YGPScrollView.contentOffset.x;
    [YGPScrollView setContentOffset:CGPointMake(x, 0)];
    
    //设置居中
    if (sender.frame.origin.x>Off)
    {
        [YGPScrollView setContentOffset:CGPointMake(sender.frame.origin.x-SCREEN_CGSIZE_WIDTH/3, 0) animated:YES];
    }
    DLog(@"sender.frame.origin.x-SCREEN_CGSIZE_WIDTH/3=%f,%f,%f",sender.frame.origin.x-SCREEN_CGSIZE_WIDTH/3,self.frame.size.width,Off);
}

//选择index
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    
    if ([_delegate respondsToSelector:@selector(segmentedViewController:touchedAtIndex:)])
        [_delegate segmentedViewController:self touchedAtIndex:selectedIndex];
}

-(NSInteger)initselectedSegmentIndex
{
    //初始化为（0）
    return initselectedIndex;
}

-(void)setBackgroundColor
{
    //为了区别Tab和View的颜色
    self.backgroundColor = [UIColor whiteColor];
    YGPScrollView.alpha = 0.9;
    
}


@end
