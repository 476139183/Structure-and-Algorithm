//
//  EScrollerView.h
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//
//

#import <UIKit/UIKit.h>

@protocol EScrollerViewDelegate <NSObject>
@optional
-(void)EScrollerViewDidClicked:(NSUInteger)index;
@end

@interface EScrollerView : UIView<UIScrollViewDelegate> {
    CGRect viewSize;
    UIScrollView *myScrollView;
    NSArray *imageArray;
    NSArray *titleArray;
    UIPageControl *pageControl;
    id<EScrollerViewDelegate> delegate;
    int currentPageIndex;
    UILabel *noteTitle;
    NSTimer *animationTimer;
}
@property(nonatomic,retain)id<EScrollerViewDelegate> delegate;
//-(id)initWithFrameRect:(CGRect)rect dataArray:(NSArray *)dataArray;
-(id)initWithFrameRect:(CGRect)rect dataArray:(NSArray *)dataArray introduceArray:(NSArray *)introduceArray;
@end
