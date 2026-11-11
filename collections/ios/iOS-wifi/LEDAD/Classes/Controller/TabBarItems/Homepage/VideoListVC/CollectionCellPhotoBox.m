//
//  Created by matt on 28/09/12.
//

#import "CollectionCellPhotoBox.h"
#import "Config.h"
#import "DataItems.h"
#import "UIImageView+WebCache.h"

#import "MyTool.h"
#import "FDLabelView.h"

@implementation CollectionCellPhotoBox
@synthesize boxDataItem;
#pragma mark - Init

- (void)setup {
    
    // positioning
    self.topMargin = 8;
    self.leftMargin = 8;
    
    // background
    self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1];
    
    // shadow
    self.layer.shadowColor = [UIColor colorWithWhite:0.12 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 1;
}

#pragma mark - Factories

+ (CollectionCellPhotoBox *)photoBoxFor:(int)i boxData:(DataItems *)oneDataItem size:(CGSize)size {

    CollectionCellPhotoBox *box = [CollectionCellPhotoBox boxWithSize:size];
    box.tag = i;
    box.boxDataItem = oneDataItem;
    [box loadPhoto:oneDataItem];
    return box;
}

#pragma mark - Layout

- (void)layout {
    [super layout];
    
    // speed up shadows
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

#pragma mark - Photo box loading

//- (void)loadPhoto:(DataItems*)oneBoxDataItem{
//    id fullPath = [NSString stringWithFormat:@"%@",oneBoxDataItem.item_img];
//    NSURL *url = [NSURL URLWithString:fullPath];
//    DLog(@"self.boxDataItem.item_img = %@",url);
//    // fetch the remote photo
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    
//    // do UI stuff back in UI land
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        // ditch the spinner
//        UIActivityIndicatorView *spinner = self.subviews.lastObject;
//        [spinner stopAnimating];
//        [spinner removeFromSuperview];
//        
//        // failed to get the photo?
//        if (!data) {
//            self.alpha = 0.3;
//            return;
//        }
//        
//        // got the photo, so lets show it
//        UIImage *image = [UIImage imageWithData:data];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        [self addSubview:imageView];
//        imageView.size = self.size;
//        imageView.alpha = 0;
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth
//        | UIViewAutoresizingFlexibleHeight;
//        //添加标题
//        [self addSubview:[self createTitleLabel:imageView title:oneBoxDataItem.item_title]];
//        // fade the image in
//        [UIView animateWithDuration:0.2 animations:^{
//            imageView.alpha = 1;
//        }];
//    });
//    
//    
//}

- (void)loadPhoto:(DataItems*)oneBoxDataItem{
    id fullPath = [NSString stringWithFormat:@"%@",oneBoxDataItem.item_img];
    NSURL *url = [NSURL URLWithString:fullPath];
    DLog(@"loadPhoto fullPath =%@",url);
    UIImageView *imageView = [[UIImageView alloc]init];

//    [imageView setImageWithURL:url placeholderImage:[MyTool scale:[UIImage imageNamed:@"frontheadbar.png"] toSize:self.size] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//    }];
    [imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
    [self addSubview:imageView];
    imageView.size = self.size;
    imageView.alpha = 1;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleHeight;
    //添加标题
    [self addSubview:[self createTitleLabel:imageView title:oneBoxDataItem.item_title]];
//    // fade the image in
//    [UIView animateWithDuration:0.2 animations:^{
//        imageView.alpha = 1;
//    }];
//    
//    
//    
//    DLog(@"self.boxDataItem.item_img = %@",url);
//    // fetch the remote photo
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    
//    // do UI stuff back in UI land
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        // ditch the spinner
//        
//        
//        // failed to get the photo?
//        if (!data) {
//            self.alpha = 0.3;
//            return;
//        }
//        
//        // got the photo, so lets show it
//        UIImage *image = [UIImage imageWithData:data];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        [self addSubview:imageView];
//        imageView.size = self.size;
//        imageView.alpha = 0;
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth
//        | UIViewAutoresizingFlexibleHeight;
//        //添加标题
//        [self addSubview:[self createTitleLabel:imageView title:oneBoxDataItem.item_title]];
//        // fade the image in
//        [UIView animateWithDuration:0.2 animations:^{
//            imageView.alpha = 1;
//        }];
//    });
}



/**
 *@brief 创建标题容器
 */
-(UIView *)createTitleLabel:(UIView *)containtView title:(NSString *)titleString{
    FDLabelView *cellTitleLabel = [[FDLabelView alloc]initWithFrame:CGRectMake(containtView.frame.origin.x, containtView.frame.origin.y+containtView.frame.size.height-40, containtView.frame.size.width, 40)];
    [cellTitleLabel setText:titleString];
    [cellTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [cellTitleLabel setBackgroundColor:[UIColor grayColor]];
    [cellTitleLabel setAlpha:0.7];
    cellTitleLabel.textAlignment = NSTextAlignmentCenter;
    [cellTitleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    cellTitleLabel.minimumScaleFactor = 0.50;
    [cellTitleLabel setNumberOfLines:0];
    [cellTitleLabel setFont:[UIFont systemFontOfSize:14]];
    cellTitleLabel.lineHeightScale = 1.0;
    cellTitleLabel.fixedLineHeight = 0.0;
    cellTitleLabel.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    cellTitleLabel.fdTextAlignment = FDTextAlignmentCenter;
    cellTitleLabel.fdAutoFitMode = FDAutoFitModeNone;
    cellTitleLabel.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    return cellTitleLabel;
}


@end
