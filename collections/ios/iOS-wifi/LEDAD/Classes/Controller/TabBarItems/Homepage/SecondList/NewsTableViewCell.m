// TweetTableViewCell.m
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NewsTableViewCell.h"
#import "DataItems.h"
#import "UIImageView+WebCache.h"
@implementation NewsTableViewCell
@synthesize datalab;
@synthesize leftimageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withdataNewsLeditem:(DataItems *)newsleditem  {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ];
    if (!self) {
        return nil;
    }
    self.frame=CGRectMake(0, 0, self.frame.size.width, 100);
    self.textLabel.adjustsFontSizeToFitWidth=NO;
    
    if (![[UIDevice currentDevice].model isEqualToString:@"iPad"]) {
        self.textLabel.font = [UIFont systemFontOfSize:14];
    }
    self.textLabel.text                         =newsleditem.item_title;
    self.textLabel.textColor                    =[UIColor darkGrayColor];
    self.detailTextLabel.font                   =[UIFont systemFontOfSize:12.0f];
    self.detailTextLabel.lineBreakMode          =NSLineBreakByCharWrapping;
    self.detailTextLabel.numberOfLines          =0;
    self.detailTextLabel.text = newsleditem.item_introduce;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    
    NSTimeInterval time1=[newsleditem.item_time doubleValue];
    NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:time1];
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    [form setDateFormat:NSLocalizedString(@"PerformDates", @"")];//@"yyyy年MM月dd日(EEE) K:mm:ss"
    NSString *strdate=[form stringFromDate:date];
    //DLog(@"time1%@",date);
    
    self.datalab                                =[[UILabel alloc]init];
    self.datalab.text                           =strdate;
    self.datalab.textColor                      =[UIColor darkGrayColor];
    self.datalab.font                           =[UIFont systemFontOfSize:12.0f];
    
    self.leftimageView                          =[[UIImageView alloc]init];
    NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@",newsleditem.item_img];
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches/"];
    imageUrl =[imageUrl stringByReplacingOccurrencesOfString:URL_FOR_IP_OR_DOMAIN withString:documentsDirectory];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"NewsTableViewCell" forKey:@"From"];
    if ([fm fileExistsAtPath:imageUrl]) {
        [leftimageView setImageWithURL:[NSURL URLWithString:newsleditem.item_img] placeholderImage:[UIImage imageWithContentsOfFile:imageUrl]];
    }else{
        [leftimageView setImageWithURL:[NSURL URLWithString:newsleditem.item_img] placeholderImage:[UIImage imageNamed:@"frontheadbar.png"]];
    }
//    DLog(@"imageUrl=%@",imageUrl);

    //@"frontheadbar.png"
    
//    DLog(@"newsleditem.item_img=%@",newsleditem.item_img);
    
    
    [self addSubview:datalab];
    [self addSubview:leftimageView];
    [self.datalab   release];
    [leftimageView  release];
    
    return self;
}


#pragma mark - UIView


-(bool)checkDevice:(NSString*)name
{
    NSString* deviceType = [UIDevice currentDevice].model;
    DLog(@"deviceType = %@", deviceType);
    
    NSRange range = [deviceType rangeOfString:name];
    return range.location != NSNotFound;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *  nsStrIphone=@"iPhone";
    NSString *  nsStrIpod=@"iPod";
    NSString *  nsStrIpad=@"iPad";
    bool  bIsiPhone=false;
    bool  bIsiPod=false;
    bool  bIsiPad=false;
    bIsiPhone=[self  checkDevice:nsStrIphone];
    bIsiPod=[self checkDevice:nsStrIpod];
    bIsiPad=[self checkDevice:nsStrIpad];
    
    
    if (bIsiPad == false) {
        self.leftimageView.frame    = CGRectMake(5.0f, 5.0f, 90.0f, 90.0f);
        self.textLabel.frame        = CGRectMake(100.0f, 5.0f, 220.0f, 20.0f);
        self.detailTextLabel.frame  = CGRectMake(100.0f, 25.0f, 220.0f, 40.0f);
        self.datalab.frame          = CGRectMake(100.0f, 70.0f, 220, 20);
    }else if (bIsiPad == true) {
        self.leftimageView.frame    = CGRectMake(5.0f, 5.0f, 90.0f, 90.0f);
        self.textLabel.frame        = CGRectMake(100.0f, 5.0f, SCREEN_CGSIZE_WIDTH-100.0f, 20.0f);
        self.detailTextLabel.frame  = CGRectMake(100.0f, 25.0f, SCREEN_CGSIZE_WIDTH-100.0f, 40.0f);
        self.datalab.frame          = CGRectMake(100.0f, 70.0f, SCREEN_CGSIZE_WIDTH-100.0f, 20);
    }
    
}

@end
