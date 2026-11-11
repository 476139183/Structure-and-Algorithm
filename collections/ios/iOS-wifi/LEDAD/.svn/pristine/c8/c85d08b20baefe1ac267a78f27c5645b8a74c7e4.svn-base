//
//  DYT_myuserScrollView.m
//  LEDAD
//
//  Created by laidiya on 15/8/5.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_myuserScrollView.h"
#import "MyImageView.h"

#define INT32_MAX        2147483647

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define PAGE_CONTROL_HEIGHT 20
#define IMAGE_COUNT 8

@implementation DYT_myuserScrollView
-(id)initWithFrame:(CGRect)frame
{


    self = [super initWithFrame:frame];
    if (self) {
        
        [self _setload:frame];
        
    }
    
    return self;
    

}

-(void)_setload:(CGRect)myframe
{

    
    self.imageArray = [[NSMutableArray alloc] init];
    NSArray *title = [[NSArray alloc]initWithObjects:@"删除素材-1", @"删除素材-2", @"删除素材-3", @"删除素材组-1", @"删除素材组-2", @"上传素材-1", @"下载素材-1", @"新建云素材-1", @"新建云素材-2", nil];

    
    for (int i=0; i<title.count; i++) {
        
//        NSString *fileName = [NSString stringWithFormat:@"%i", i];
        UIImage *image = [UIImage imageNamed:title[i]];
        if (nil != image) {
            [self.imageArray addObject:image];
        }
        else {
            NSLog(@"image is nil");
        }
    }

    
    
    
    
    
    self.contentSize = CGSizeMake(INT32_MAX, myframe.size.height);
    self.delegate = self;
    self.bounces = YES;
    self.pagingEnabled = YES;
    self.userInteractionEnabled = YES;

    
    
    self.visiblePages = [[NSMutableDictionary alloc] init];
    self.recyledPages = [[NSMutableSet alloc] init];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, myframe.size.height - PAGE_CONTROL_HEIGHT - 20, SCREEN_WIDTH, PAGE_CONTROL_HEIGHT)];
    pageControl.numberOfPages = IMAGE_COUNT;
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
    
    lastPage = 0;
    
    [self tilesPage];

    
    

}
-(void)tilesPage {
    
    int currentPage = floor(self.contentOffset.x / SCREEN_WIDTH);
    if (currentPage == 0 && lastPage == 0) {
        MyImageView *firstImageView = [[MyImageView alloc] initWithImage:[self.imageArray objectAtIndex:0]];
        firstImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height);
        [self addSubview:firstImageView];
        [self.visiblePages setValue:firstImageView forKey:[NSString stringWithFormat:@"%i", 0]];
        
        MyImageView *secondImageView = [[MyImageView alloc] initWithImage:[self.imageArray objectAtIndex:1]];
        secondImageView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.frame.size.height);
        [self addSubview:secondImageView];
        [self.visiblePages setValue:secondImageView forKey:[NSString stringWithFormat:@"%i", 1]];
//        [secondImageView release];
    }
    else {
        if (currentPage == lastPage) {
            return;
        }
        if (currentPage > lastPage) {
            //forward
            if (currentPage * SCREEN_WIDTH < INT32_MAX) {
                UIImage *image = [self.imageArray objectAtIndex:(currentPage + 1)% IMAGE_COUNT];
                MyImageView *imageView = [self getRecyledImageView:image];
                if (nil == imageView) {
                    imageView = [[MyImageView alloc] initWithImage:image] ;
                }
                imageView.frame = CGRectMake((currentPage + 1) * SCREEN_WIDTH, 0, SCREEN_WIDTH, self.frame.size.height);
                [self addSubview:imageView];
                [self.visiblePages setValue:imageView forKey:[NSString stringWithFormat:@"%i", currentPage + 1]];
            }
            
            NSString *key = [NSString stringWithFormat:@"%i", currentPage - 2];
            MyImageView *recyledImageView = [self.visiblePages objectForKey:key];
            if (nil != recyledImageView) {
                [self.recyledPages addObject:recyledImageView];
                [recyledImageView removeFromSuperview];
                [self.visiblePages removeObjectForKey:key];
            }
        }
        else {
            //backward
            if (currentPage > 0) {
                UIImage *image = [self.imageArray objectAtIndex:(currentPage - 1) % IMAGE_COUNT];
                MyImageView *imageView = [self getRecyledImageView:image];
                if (nil == imageView) {
                    imageView = [[MyImageView alloc] initWithImage:image];
                }
                imageView.frame = CGRectMake((currentPage - 1) * SCREEN_WIDTH, 0, SCREEN_WIDTH, self.frame.size.height);
                [self addSubview:imageView];
                [self.visiblePages setValue:imageView forKey:[NSString stringWithFormat:@"%i", currentPage - 1]];
            }
            
            NSString *key = [NSString stringWithFormat:@"%i", currentPage + 2];
            MyImageView *recyledImageView = [self.visiblePages objectForKey:key];
            if (nil != recyledImageView) {
                [self.recyledPages addObject:recyledImageView];
                [recyledImageView removeFromSuperview];
                [self.visiblePages removeObjectForKey:key];
            }
        }
    }
    
    lastPage = currentPage;
    NSLog(@"visible count is %i and recyle count is %i", self.visiblePages.count, self.recyledPages.count);
    [pageControl setCurrentPage:currentPage % IMAGE_COUNT];
}


-(MyImageView*)getRecyledImageView:(UIImage*)image {
    MyImageView *imageView = [self.recyledPages anyObject];
    if (nil != imageView) {
//        [[imageView retain] autorelease];
        imageView.image = image;
        [self.recyledPages removeObject:imageView];
    }
    return imageView;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self tilesPage];
}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
