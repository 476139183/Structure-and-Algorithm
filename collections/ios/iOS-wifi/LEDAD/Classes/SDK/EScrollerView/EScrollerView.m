//
//  EScrollerView.m
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//  modify yxm 2013年11月06日09:36:38
//  左右滑动广告栏，需要使用SDWebImage
//

#import "EScrollerView.h"
// modify yxm 2013年11月06日09:38:35
#import "UIImageView+WebCache.h"
// modify yxm 2014年03月22日18:00:54
#import "MainDataEntity.h"

#import "MyLabel.h"
#import "NSTimer+Addition.h"

#define pageWidthRate (DEVICE_IS_IPAD == 0 ?  1: 0.5296610169)

@implementation EScrollerView

@synthesize delegate;


- (void)dealloc {
    [myScrollView release];
    [noteTitle release];
    delegate=nil;
    if (pageControl) {
        [pageControl release];
    }
    if (imageArray) {
        [imageArray release];
        imageArray=nil;
    }
    if (titleArray) {
        [titleArray release];
        titleArray=nil;
    }
    [super dealloc];
}
-(id)initWithFrameRect:(CGRect)rect dataArray:(NSArray *)dataArray introduceArray:(NSArray *)introduceArray
{

    DLog(@"introduceArray = %@",introduceArray);
    if ((self=[super initWithFrame:rect])) {
        self.userInteractionEnabled = YES;
        if (dataArray && ([dataArray count]>0)) {
            NSMutableArray *tempArray=[NSMutableArray arrayWithArray:dataArray];
            [tempArray insertObject:[dataArray objectAtIndex:([dataArray count]-1)] atIndex:0];
            [tempArray addObject:[dataArray objectAtIndex:0]];
            imageArray=[[NSArray arrayWithArray:tempArray] retain];

            NSMutableArray *tempArray2=[NSMutableArray arrayWithArray:introduceArray];
            [tempArray2 insertObject:[introduceArray objectAtIndex:([introduceArray count]-1)] atIndex:0];
            [tempArray2 addObject:[introduceArray objectAtIndex:0]];
            titleArray=[[NSArray arrayWithArray:tempArray2] retain];
        }
        viewSize=rect;
        NSUInteger pageCount=[imageArray count];
        RELEASE_SAFELY(myScrollView);
        if (myScrollView == nil) {
            myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
            [self addSubview:myScrollView];
        }
        if (!DEVICE_IS_IPAD) {
            myScrollView.pagingEnabled = YES;
            myScrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
        }
        myScrollView.contentSize = CGSizeMake(viewSize.size.width * (pageCount + 1) * pageWidthRate, viewSize.size.height);
        myScrollView.showsHorizontalScrollIndicator = NO;
        myScrollView.showsVerticalScrollIndicator = NO;
        myScrollView.scrollsToTop = NO;
        myScrollView.delegate = self;
        for (int i=0; i<pageCount; i++) {
            //            NSString *imgURL = ((MainDataEntity*)[imageArray objectAtIndex:i]).item_imgurl;
            MyLabel *introduceLabel = [[MyLabel alloc] init];
            introduceLabel.textAlignment = NSTextAlignmentCenter;
            introduceLabel.text = [titleArray objectAtIndex:i];
            introduceLabel.font = [UIFont systemFontOfSize:20];

            NSString *imgURL = [imageArray objectAtIndex:i];
            UIImageView *imgView=[[[UIImageView alloc] init] autorelease];
            imgView.contentMode = UIViewContentModeScaleAspectFit;//使图片按原始比例显示
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:@"AD" forKey:@"From"];
            if ([imgURL hasPrefix:@"http://"]) {
                //如果是网络图片
                [imgView setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@""]];
            }
            else
            {
                //无网络图片则使用本地图片
                UIImage *img=[UIImage imageNamed:[imageArray objectAtIndex:i]];
                [imgView setImage:img];
            }
            //2014年10月11日13:30:07
            //            [imgView setFrame:CGRectMake(viewSize.size.width*i, 0,viewSize.size.width - 40, viewSize.size.height - 70)];
            //            [introduceLabel setFrame:CGRectMake(viewSize.size.width*i +60, viewSize.size.height - 70,viewSize.size.width - 100, 40)];
            if (DEVICE_IS_IPAD) {
                [imgView setFrame:CGRectMake(viewSize.size.width*i * pageWidthRate + viewSize.size.width * 222/944, 0, (viewSize.size.width - 40) * pageWidthRate, viewSize.size.height - 70)];
                [introduceLabel setFrame:CGRectMake(viewSize.size.width*i * pageWidthRate + viewSize.size.width * 222/944, viewSize.size.height - 70, (viewSize.size.width - 40) * pageWidthRate, 40)];
            }else {
                [imgView setFrame:CGRectMake(viewSize.size.width*i * pageWidthRate, 0, viewSize.size.width * pageWidthRate, viewSize.size.height - 70)];
                [introduceLabel setFrame:CGRectMake(viewSize.size.width*i * pageWidthRate, viewSize.size.height - 70, viewSize.size.width * pageWidthRate, 40)];
            }
            imgView.tag=i;
            UITapGestureRecognizer *Tap =[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)] autorelease];
            [Tap setNumberOfTapsRequired:1];
            [Tap setNumberOfTouchesRequired:1];
            imgView.userInteractionEnabled=YES;
            [imgView addGestureRecognizer:Tap];
            myScrollView.backgroundColor = [UIColor whiteColor];
            [myScrollView addSubview:imgView];
            [myScrollView addSubview:introduceLabel];
        }
        [myScrollView setContentOffset:CGPointMake(viewSize.size.width * pageWidthRate, 0)];

        //页码标示层
        float pageControlWidth=(pageCount-2)*10.0f+40.f;
        UIView *noteView=[[UIView alloc] init];
        if (DEVICE_IS_IPAD) {
            noteView.frame = CGRectMake(viewSize.size.width/2 - pageControlWidth/2 - 10, self.bounds.size.height - 30, pageControlWidth, 30);
        }else {
            noteView.frame = CGRectMake(viewSize.size.width/2 - pageControlWidth/2, self.bounds.size.height - 30, pageControlWidth, 30);
        }

        [noteView setBackgroundColor:[UIColor clearColor]];


        float pagecontrolHeight=15.0f;
        pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0,6, pageControlWidth, pagecontrolHeight)];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
        pageControl.currentPage=0;
        pageControl.numberOfPages=(pageCount-2);
        [noteView addSubview:pageControl];

        //加入页码层上的标题
        //        noteTitle=[[UILabel alloc] initWithFrame:CGRectMake(5, 6, self.frame.size.width-pageControlWidth-15, 40)];
        ////        [noteTitle setText:[titleArray objectAtIndex:0]];
        //        noteTitle.text = @"0";
        //        [noteTitle setBackgroundColor:[UIColor clearColor]];
        //        [noteTitle setFont:[UIFont systemFontOfSize:20]];
        //        [noteView addSubview:noteTitle];

        [self addSubview:noteView];
        [noteView release];
    }

    //自动循环
#ifdef AUTOSCROLL
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:4.0
                                                      target:self
                                                    selector:@selector(animationTimerDidFired:)
                                                    userInfo:nil
                                                     repeats:YES];
    [animationTimer pauseTimer];
    [animationTimer resumeTimerAfterTimeInterval:4.0];
#endif
    return self;
}




#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{

    CGFloat pageWidth = myScrollView.frame.size.width * pageWidthRate;
    int page = floor((myScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;

    //    DLog(@"currentPageIndex = %d",currentPageIndex);
    if (currentPageIndex == [imageArray count] - 1) {
        pageControl.currentPage = 0;
    }
    else
    {
        pageControl.currentPage=currentPageIndex - 1;
    }
    int titleIndex=page-1;
    if (titleIndex==[titleArray count]) {
        titleIndex=0;
    }
    if (titleIndex<0) {
        titleIndex=[titleArray count]-1;
    }
    //    [noteTitle setText:[titleArray objectAtIndex:titleIndex]];
    [noteTitle setText:[NSString stringWithFormat:@"%d",titleIndex]];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    //    DLog(@"currentPageIndex = %d",currentPageIndex);
    if (currentPageIndex==0) {

        [_scrollView setContentOffset:CGPointMake(([imageArray count]-2)*viewSize.size.width * pageWidthRate, 0)];
    }
    else if (currentPageIndex==([imageArray count]-1))
    {

        [_scrollView setContentOffset:CGPointMake(viewSize.size.width * pageWidthRate, 0)];
    }
    else
    {
        [_scrollView setContentOffset:CGPointMake(viewSize.size.width * pageWidthRate * currentPageIndex, 0)];
    }

}

- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud integerForKey:@"SideBarShowDirection"] == 0) {
        if ([delegate respondsToSelector:@selector(EScrollerViewDidClicked:)]) {
            [delegate EScrollerViewDidClicked:sender.view.tag];
        }
    }
}

#pragma mark - 自动滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [animationTimer resumeTimerAfterTimeInterval:4.0];
}
- (void)animationTimerDidFired:(NSTimer *)timer
{
    //    DLog(@"currentPageIndex = %d",currentPageIndex);
    CGPoint newOffset = CGPointMake(myScrollView.contentOffset.x + CGRectGetWidth(myScrollView.frame) * pageWidthRate, myScrollView.contentOffset.y);
    if (currentPageIndex==0) {

        [myScrollView setContentOffset:CGPointMake(([imageArray count]-2)*viewSize.size.width * pageWidthRate, 0)];
    }
    if (currentPageIndex==([imageArray count]-1)) {

        [myScrollView setContentOffset:CGPointMake(viewSize.size.width * pageWidthRate, 0)];
    }
    else
    {
        [myScrollView setContentOffset:newOffset animated:YES];
    }
}




@end
