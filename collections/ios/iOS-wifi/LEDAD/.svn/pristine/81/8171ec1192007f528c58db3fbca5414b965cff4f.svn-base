//
//  NSString+MD5.h
//  DianXiaoEr
//
//  Created by 兴满 易 on 13-6-26.
//  Copyright (c) 2013年 YiXingMan. All rights reserved.
//

#import "MyTool.h"
#import "NSString+MD5.h"
#import "ASIHTTPRequest.h"
#import "Reachability.h"
#import "ASINetworkQueue.h"
#import "DataCategories.h"
#import "SecondMenuDataFilter.h"

////#import "MTStatusBarOverlay.h"
////#import "YXMAppDelegate.h"
////#import "NSString+SBJSON.h"
////#import "MyToolBar.h"
////#import "AGApiViewControllers.h"
////#import "EScrollerView.h"
////#import "AHAlertView.h"
////#import "MainDataEntity.h"
////#import "FirstMenuDataFilter.h"
////#import "KKProgressTimer.h"
////#import "NameCardSecondMenuDataFilter.h"
//////弹出框
#import "AHAlertView.h"
////#import "LoginViewController.h"
//
//static CGRect oldframe;
@implementation MyTool

/**
 *@brief 重新设置图片的大小
 */
+(UIImage *)scale:(UIImage *)image toSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}

///**
// *@brief 设置导航栏上的文字
// */
//+(UILabel *)titleView:(NSString *)titleName font:(UIFont *)myFont{
//    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 90, 44)];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.text = titleName;
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.font = myFont;
//    return titleLabel;
//}
//
///**
// *@brief 根据两个点的经纬度计算两个点距离
// */
//+(double)distanceBetweenOrderByLat1:(double)lat1 Andlng1:(double)lng1 Lat2:(double)lat2 Lng2:(double)lng2{
//    double dd = M_PI/180;
//    double x1=lat1*dd,x2=lat2*dd;
//    double y1=lng1*dd,y2=lng2*dd;
//    double R = 6371004;
//    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
//    return   distance;
//}

/**
 *@brief 根据时间戳计算出时间
 */
+(NSString*)TimestampToDate:(NSString*)timestamp
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:NSLocalizedString(@"PerformDates", @"")];//@"yyyy年MM月dd日"
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datestamp = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]];
    return [formatter stringFromDate:datestamp];
}

///**
// *@brief 根据时间戳计算出日期加时间,返回日期对象
// */
//+(NSDate*)TimestampToDateAndTime:(NSString*)timestamp{
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:NSLocalizedString(@"PerformDateAndTime", @"")];    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];
//    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:[timestamp integerValue]];
//    return d;
//}
///**
// *@brief 角度转换为弧度
// */
//+(double)radians:(float)degrees{
//    return (degrees*3.14159265)/180.0;
//}
/**
 *@brief 写入JSON和Html文件，存储在Documents/LedCaches目录下
 */
+(void)writeCacheRequestUrl:(NSString*)url{
    NetworkStatus netStatus = [Reachability GobalcurrentReachabilityStatus];
    if (netStatus == NotReachable) {
        DLog(@"无网络时直接返回");
        return;
    }
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    //缓存文件假的路径
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches/"];
    //创建缓存文件夹路径
    
    [fileMgr createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    //缓存文件的路径      
    NSString *filePath = [documentsDirectory
                         stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[url md5Encrypt]]];
    
    if ([fileMgr fileExistsAtPath:filePath]) {
        //需要判断文件存在的时间,如果超过7天则删除
//        NSDictionary *fileInfoDict = [fileMgr attributesOfItemAtPath:filePath error:&error];
//        if (fileInfoDict) {
//            DLog(@"存储的文件信息 = %@",fileInfoDict);
//            DLog(@"文件创建的时间 = %@",[fileInfoDict objectForKey:NSFileCreationDate]);
//            NSDateFormatter *df=[[NSDateFormatter alloc] init];
//            [df setDateFormat:@"yyyy-MM-dd"];
//            
//            NSDate *date1=[df dateFromString:@"2013-09-11"];
//            NSLog(@"dateDay =%@",date1);
//            
//            NSDate *date2=[df dateFromString:@"2013-09-10"];
//            
//            NSLog(@"mydate =%@",date2);
//            switch ([date1 compare:date2]) {
//                case NSOrderedSame:
//                    NSLog(@"相等");
//                    break;
//                case NSOrderedAscending:
//                    NSLog(@"date1比date2小");
//                    break;
//                case NSOrderedDescending:
//                    NSLog(@"date1比date2大");
//                    break;
//                default:
//                    NSLog(@"非法时间");
//                    break;
//            }
//        }
        [fileMgr removeItemAtPath:filePath error:&error];
    }
    DLog(@"下载的url=%@",url);
    if (url!=nil) {
        if ([url length]>0) {
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
            [request setCompletionBlock:^{
                NSData *responseData = [request responseData];
                [responseData writeToFile:filePath atomically:YES];
            }];
            [request setFailedBlock:^{
                NSError *error = [request error];
                DLog(@"Error:%@",error.userInfo);
            }];
            [request startAsynchronous];
        }
    }
}
/**
 *@brief 读取JSON和Html文件，存储在Documents/LedCaches，返回NSdata类型
 */
+(NSData*)readCacheData:(NSString*)urlStr{
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches/"];
    NSString *filePath = [documentsDirectory
                          stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[urlStr md5Encrypt]]];
    DLog(@"filePath= %@",filePath);
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSData *fileContentData = [fileMgr contentsAtPath:filePath];
    
    return fileContentData;
}

/**
 *@brief 读取JSON和Html文件，存储在Documents/LedCaches，返回NSString类型
 */
+(NSString*)readCacheString:(NSString*)urlStr{
    
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches/"];
    
    NSString *filePath = [documentsDirectory
                          stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[urlStr md5Encrypt]]];
    DLog(@"filePath= %@",filePath);
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    NSData *fileContentData = [fileMgr contentsAtPath:filePath];
    
    NSString *fileContentStr = [[NSString alloc]initWithData:fileContentData encoding:NSUTF8StringEncoding];
    
    return fileContentStr;
}

+(BOOL)isExistsCacheFile:(NSString*)urlStr{
    
    NetworkStatus networkstatus = [Reachability GobalcurrentReachabilityStatus];
    if (networkstatus==ReachableViaWiFi) {
        DLog(@"WiFi状态下不读取本地缓存");
        return NO;
    }else{
        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches/"];
        
        NSString *filePath = [documentsDirectory
                              stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[urlStr md5Encrypt]]];
        DLog(@"url=%@,urlstrmd5=%@",urlStr,[urlStr md5Encrypt]);
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        DLog(@"filePath=%@",filePath);
        if ([fileMgr fileExistsAtPath:filePath]) {
            DLog(@"本地有缓存=%@",filePath);
        }
        return [fileMgr fileExistsAtPath:filePath isDirectory:NO];
    }
}
//+(NSString*)fileExistsCacheFile:(NSString*)urlStr
//{
//    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches/"];
//    NSString *filePath = [documentsDirectory
//                          stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[urlStr md5Encrypt]]];
//    DLog(@"filePath= %@",filePath);
//    return filePath;
//}

/**
 *@判断视频的文件路径是否有视频
 */
+(BOOL)isExistsVideoFile:(NSString*)urlStr{
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/VideoFile/"];
    [fileMgr createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    urlStr =[urlStr stringByReplacingOccurrencesOfString:@".mp4" withString:@""];
    NSString *filePath = [documentsDirectory
                          stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[urlStr md5Encrypt]]];
    DLog(@"filePath= %@",filePath);
    if ([fileMgr fileExistsAtPath:filePath]) {
        DLog(@"本地有下载的视频 = %@",filePath);
    }
    return [fileMgr fileExistsAtPath:filePath];
}

/**
 *@返回视频的文件路径
 */
+(NSString *)getVideoFilePath:(NSString*)urlStr
{
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/VideoFile/"];
    urlStr =[urlStr stringByReplacingOccurrencesOfString:@".mp4" withString:@""];
    NSString *filePath = [documentsDirectory
                          stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[urlStr md5Encrypt]]];
    DLog(@"filePath= %@",filePath);
    return filePath;
}


///**
// *@brief 获得SDWebImage的图片存储路径
// */
//+(NSString*)getSDWebImageFilePath:(NSString*)filepath{
//    if (!filepath) {
//        return nil;
//    }
//    if ([filepath length]<1) {
//        return nil;
//    }
//    NSString *diskCachePath;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    diskCachePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ImageCache"];
//    const char *str = [filepath UTF8String];
//    unsigned char r[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(str, (CC_LONG)strlen(str), r);
//    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
//    return [diskCachePath stringByAppendingPathComponent:filename];
//}
///**
// *@brief 根据图片数据写入图片到SDWebImage的图片存储目录下
// */
//+(void)writeImageCache:(NSData*)imageData requestUrl:(NSString*)url{
//    
//    [imageData writeToFile:[self getSDWebImageFilePath:url] atomically:YES];
//    
//}

/**
 *@brief 根据图片网络路径写入图片到SDWebImage的图片存储目录下
 */
+(void)writeImageCacheRequestUrl:(NSString*)url{
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setCompletionBlock:^{
        NSData *responsedata = [request responseData];
        NSString *filePath = [self getSDWebImageFilePath:url];
        [responsedata writeToFile:filePath atomically:YES];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        DLog(@"Error:%@",error.userInfo);
    }];
    [request startAsynchronous];
}

///**
// *@brief 读取SDWebImage的缓存文件，存储在Library/Caches/ImageCache，返回NSdata类型
// */
//+(NSData*)readImageCache:(NSString*)urlStr{
//    
//    NSString *filePath = [self getSDWebImageFilePath:urlStr];
//    
//    NSFileManager *fileMgr = [NSFileManager defaultManager];
//    
//    NSData *fileContentData = [fileMgr contentsAtPath:filePath];
//    
//    return fileContentData;
//}
/**
 *@brief 获得当前的时间，例如2013-08-11 16:05:03
 */
+(NSString*)getCurrentDateString{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd-HH:mm:ss"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    return morelocationString;
}


//+(void)writeCalculImageCache:(NSData*)imageData requestUrl:(NSString*)url{
//    if (url==nil) {
//        return;
//    }
//    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCalculCaches/"];
//    
//    NSString *filePath = [documentsDirectory
//                          stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[url md5Encrypt]]];
//    //    DLog(@"%@",filePath);
//    [imageData writeToFile:filePath atomically:YES];
//}
//
///**
// *@brief 根据图片的URL地址返回图片UIImage对象
// */
//+(UIImage*)readCalculImageCache:(NSString*)urlStr{
//    if (urlStr==nil) {
//        return nil;
//    }
//    NSString *filePath = [self getSDWebImageFilePath:urlStr];
//    
//    NSFileManager *fileMgr = [NSFileManager defaultManager];
//    
//    NSData *fileContentData = [fileMgr contentsAtPath:filePath];
//    
//    UIImage *image = [[UIImage alloc]initWithData:fileContentData];
//    
//    return image;
//}
//
//
///**
// *@brief 判断输入的email是否正确
// */
//- (BOOL)CheckInputIsEmail:(NSString *)inputStr
//{
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9._]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
//    return [emailTest evaluateWithObject:inputStr];
//}
//
//
///**
// *@brief 判断输入的手机号码是否正确
// */
//-(BOOL)CheckInputIsTelNum:(NSString *)_text
//{
//    NSString *Regex = @"1\\d{10}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
//    return [emailTest evaluateWithObject:_text];
//}

/**
 *@brief 判断用户的key是否存在，存在则表示登陆成功
 */
+(BOOL)CheckIsLogin{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *user_alias = [ud objectForKey:@"user_alias"];
    if ((user_alias==nil)||([user_alias length]==0)) {
        return NO;
    }else{
        return YES;
    }
}

/**
 *@brief 写入JSON和Html文件，存储在Documents/LedCaches
 */
+(void)writeCache:(NSString *)responseStr requestUrl:(NSString*)url{
    
    if (responseStr==nil) {
        //DLog(@"responseStr 为空");
        return;
    }
    if (![responseStr isKindOfClass:[NSString class]]) {
        //DLog(@"responseStr 不是一个字符串");
        return;
    }
    if ([responseStr length]==0) {
        //DLog(@"responseStr 的长度为零");
        return;
    }
    NSError *error;
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LedCaches/"];
    
    [fileMgr createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSString *filePath= [documentsDirectory
                         stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[url md5Encrypt]]];
    
    if ([fileMgr fileExistsAtPath:filePath]) {
        [fileMgr removeItemAtPath:filePath error:&error];
    }
    
    
    [responseStr writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
}



/**
 *@brief 到appStore更新app版本的方法;需要传入是否是手动更新
 */
+(BOOL)updateApp
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString * appleID = APPID;
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appleID]]];
    
    [request setHTTPMethod:@"GET"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (returnData==nil) {
        return NO;
    }

    NSString *tmpString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    if (!tmpString) {
        return NO;
    }
    if (![tmpString isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([tmpString length]<1) {
        return NO;
    }

    NSDictionary *jsonData = [tmpString JSONValue];
    if (jsonData==nil) {
        return NO;
    }
    if (![jsonData isKindOfClass:[NSDictionary class]]) {
        return NO;
    }

    NSArray *results = [jsonData objectForKey:@"results"];
    if (results==nil) {
        return NO;
    }
    if (![results isKindOfClass:[NSArray class]]) {
        return NO;
    }

    NSString *latestVersion = nil;
    NSString *trackName = nil ;
    
    
    for (NSDictionary *dic in results) {
        latestVersion = [dic objectForKey:@"version"];
        trackViewUrl = [dic objectForKey:@"trackViewUrl"];
        trackName = [dic objectForKey:@"trackName"];
    }
    if (latestVersion==nil||trackViewUrl==nil||trackName==nil) {
        return NO;
    }
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    if (!currentVersion) {
        return NO;
    }
    if ([currentVersion isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    NSRange range1 =NSMakeRange(0, 1);
    NSRange range2 =NSMakeRange(2, 1);
    NSRange range3 =NSMakeRange(4, 1);

    //网络的版本
    NSInteger latestbaiwei = [[latestVersion substringWithRange:range1] intValue]*100;
    NSInteger latestshiwei = [[latestVersion substringWithRange:range2] intValue]*10;
    NSInteger latestgewei = [[latestVersion substringWithRange:range3] intValue];
    //网络版本和
    NSInteger latestbanbenhe = latestbaiwei + latestshiwei + latestgewei;
    
    //本地的版本
    NSInteger currentbaiwei = [[currentVersion substringWithRange:range1] intValue]*100;
    NSInteger currentshiwei = [[currentVersion substringWithRange:range2] intValue]*10;
    NSInteger currentgewei = [[currentVersion substringWithRange:range3] intValue];
    //本地版本和
    NSInteger currentbanbenhe = currentbaiwei + currentshiwei + currentgewei;
    
    //如果本地版本小于网络版本
    if (currentbanbenhe<latestbanbenhe) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:trackName forKey:@"trackName"];
        [ud setObject:trackViewUrl forKey:@"trackViewUrl"];
        return YES;
    }else{
        return NO;
    }
}




///*
// *在状态栏提示网络连接错误
// */
//+(void)onStatusBarAlertNetError{
//    //获得一个自定义状态栏提示条的实例
////    MTStatusBarOverlay *myoverlay = [MTStatusBarOverlay sharedInstance];
////    myoverlay.animation = MTStatusBarOverlayAnimationFallDown;
////    myoverlay.detailViewMode = MTDetailViewModeHistory;
////    myoverlay.frame = CGRectMake(SCREEN_CGSIZE_WIDTH-200, 0, 180, 20);
////    //新消息提示条在状态栏停留5秒钟
////    [myoverlay postImmediateFinishMessage:NSLocalizedString(@"NSStringReadMessageFaildList",@"网络错误!") duration:5.0 animated:YES];
//}
//
///**
// *在状态栏提示通知上传错误错误
// */
//+(void)onStatusBarAlertNotificationError{
//    //获得一个自定义状态栏提示条的实例
//    MTStatusBarOverlay *myoverlay = [MTStatusBarOverlay sharedInstance];
//    myoverlay.animation = MTStatusBarOverlayAnimationFallDown;
//    myoverlay.detailViewMode = MTDetailViewModeHistory;
//    myoverlay.frame = CGRectMake(SCREEN_CGSIZE_WIDTH-200, 0, 180, 20);
//    //新消息提示条在状态栏停留5秒钟
//    [myoverlay postImmediateFinishMessage:NSLocalizedString(@"NSStringNotificationErrorFaild",@"通知不可用!") duration:5.0 animated:YES];
//}
//
//
////传入一个图片用于放大
//+(void)showImage:(UIImageView *)avatarImageView{
//    UIImage *image=avatarImageView.image;
//    UIWindow *window=[UIApplication sharedApplication].keyWindow;
//    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
//    backgroundView.backgroundColor=[UIColor blackColor];
//    backgroundView.alpha=0;
//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
//    imageView.image=image;
//    imageView.tag=1;
//    [backgroundView addSubview:imageView];
//    [window addSubview:backgroundView];
//    
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
//    [backgroundView addGestureRecognizer: tap];
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
//        backgroundView.alpha=1;
//    } completion:^(BOOL finished) {
//        
//    }];
//}
//
//+(void)hideImage:(UITapGestureRecognizer*)tap{
//    UIView *backgroundView=tap.view;
//    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
//    [UIView animateWithDuration:0.3 animations:^{
//        imageView.frame=oldframe;
//        backgroundView.alpha=0;
//    } completion:^(BOOL finished) {
//        [backgroundView removeFromSuperview];
//    }];
//}
//
//
/**
 *@brief 获得应用的沙盒路径
 */
+ (NSString *)applicationDocumentsDirectory{
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}


+(void)alertViewLoginSender:(id)sender Andtitle:(NSString*)title Andmessage:(NSString*)message{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    title = NSLocalizedString(@"NSString24", @"提示");
	message = [[NSString alloc]initWithFormat:@"\n\n\n%@",NSLocalizedString(@"NSStringOtherlogin", @"您的账号在其他地方登陆了,已被迫下线！")];
    //自定义的提示框
	AHAlertView *alert = [[AHAlertView alloc] initWithTitle:title message:message];
    
	[alert addButtonWithTitle:NSLocalizedString(@"NSStringYes",@"确定") block:^{
        DLog(@"重新登陆");
        [ud removeObjectForKey:@"user_mail"];
        [ud removeObjectForKey:@"user_num"];
        [ud setObject:nil forKey:@"user_alias"];
        [ud removeObjectForKey:@"user_alias"];
        [ud removeObjectForKey:@"user_name"];
        [ud removeObjectForKey:@"user_image"];
        [ud removeObjectForKey:@"user_status"];
        [ud removeObjectForKey:@"role_id"];
        [ud removeObjectForKey:@"user_company"];
        [ud setObject:@"" forKey:@"key"];
        [ud synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGE_HEADVIEW object:nil userInfo:nil];
        isAlert=0;
        alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
//        YXMAppDelegate *appD = (YXMAppDelegate*)[[UIApplication sharedApplication] delegate];
//        [appD intoMain];
    }];
    isAlert=3;
	[alert show];
}



/**
 *@brief url中有中文的情况使用此方法转为UTF-8
 */
+(NSString*)stringCovertToUTF8:(NSString *)urlString{
    NSString *encodingString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodingString;
}


///**
// *@brief 性别的代码与字符串之间的转换
// */
//+(NSString*)sexCodeCovertString:(NSString*)sexCode{
//    if ([sexCode isEqualToString:@"0"]) {
//        return NSLocalizedString(@"NSStringSexMan",@"男");
//    }else{
//        return NSLocalizedString(@"NSStringSexWoMan",@"女");
//    }
//}
//
//
///**
// *@brief 判断字符串是否全部为数字
// */
//+(BOOL)stringIsDigit:(NSString*)inputStr{
//    int inputStrLength = [inputStr length];
//    if (inputStrLength!=0) {
//        char *covertChar = [inputStr cStringUsingEncoding:NSASCIIStringEncoding];
//        if (covertChar==NULL) {
//            return NO;
//        }
//        DLog(@"covertChar =%s",covertChar);
//        for(int i=0;i<inputStrLength;i++)
//        {
//            if(covertChar[i]<='0' || covertChar[i]>='9')
//            {
//                DLog(@"不是数字");
//                return NO;
//            }
//        }
//        return YES;
//    }else{
//        return NO;
//    }
//    
//}
//
//
//+(BOOL)yxmCheckDevice:(NSString*)name
//{
//    NSString* deviceType = [UIDevice currentDevice].model;
//    NSRange range = [deviceType rangeOfString:name];
//    return range.location != NSNotFound;
//}
//
///**
// *@brief 判断设备是否是iPhone
// */
//+(BOOL)CheckDeviceIsiPhone{
//    NSString *  nsStrIphone=@"iPhone";
//    bool  bIsiPhone=false;
//    bIsiPhone=[self  yxmCheckDevice:nsStrIphone];
//    return bIsiPhone;
//}
//
///**
// *@brief 判断设备是否是iPad
// */
//+(BOOL)CheckDeviceIsiPad{
//    NSString *  nsStrIpad=@"iPad";
//    bool  bIsiPad=false;
//    bIsiPad=[self yxmCheckDevice:nsStrIpad];
//    return bIsiPad;
//}
//
///**
// *@brief 判断设备是否是iPod
// */
//+(BOOL)CheckDeviceIsiPod{
//    NSString *  nsStrIpod=@"iPod";
//    bool  bIsiPod=false;
//    bIsiPod=[self yxmCheckDevice:nsStrIpod];
//    return bIsiPod;
//}

/**
 *@brief 过滤请求返回的数据中的非法字符
 */
+(NSString*)filterResponseString:(NSString*)responseString{
    //将null替换为""
    responseString =[responseString stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
    
    //将"\r\n\t替换为"
    responseString =[responseString stringByReplacingOccurrencesOfString:@"\"\\r\\n\\t" withString:@"\""];
    
    //将"\r\n"替换为"
    responseString =[responseString stringByReplacingOccurrencesOfString:@"\"\\r\\n\"" withString:@"\""];
    
    //将[,替换为[
    responseString =[responseString stringByReplacingOccurrencesOfString:@"[," withString:@"["];
    //    //将"\r\n\t替换为"
    //    responseString =[responseString stringByReplacingOccurrencesOfString:@"\"\\r\\n\\t" withString:@"\""];
    
    return responseString;
}


///**
// *@brief 写入缓存文件
// */
//+(void)writeCacheFile:(NSData *)buffer{
//    NSFileHandle *outFile;
//    
//    //打开offlinephoto.zip文件用于写入操作
//    outFile = [NSFileHandle fileHandleForWritingAtPath:@"offlinephoto.zip"];
//    
//    if(outFile == nil)
//    {
//        NSLog(@"Open of offlinephoto.zip for writing failed!");
//        [[NSFileManager defaultManager] createFileAtPath:@"offlinephoto.zip" contents:buffer attributes:nil];
//    }else{
//        
//        NSInteger fileOffset=0;
//        if ([outFile offsetInFile]==0) {
//            fileOffset=0;
//        }else{
//            fileOffset=[outFile offsetInFile]+[buffer length];
//        }
//        
//        DLog(@"fileOffset = %ld",fileOffset);
//        
//        [outFile seekToFileOffset:fileOffset];
//        
//        [outFile writeData:buffer];
//        
//        [outFile closeFile];
//    }
//}
//
//
///**
// *@brief 重置窗口的frame
// */
//+(void)resetWindowFrame{
//    int windowTopOffset=0;
//    float iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
//    if ((iOSVersion < (float)7.0) || (iOSVersion >= (float)7.1)) {
//        windowTopOffset=-20;
//    }
//    if ((iOSVersion < (float)7.1)&&(iOSVersion >= (float)7.0)) {
//        windowTopOffset=0;
//    }
//    DLog(@"windowTopOffset=%d",windowTopOffset);
//    YXMAppDelegate *appDelegate = (YXMAppDelegate *)[UIApplication sharedApplication].delegate;
//    [appDelegate.window setFrame:CGRectMake(0,windowTopOffset,SCREEN_CGSIZE_WIDTH, SCREEN_CGSIZE_HEIGHT+(-windowTopOffset))];
//}


/**
 *@brief 判断是否是11位手机号码
 */
+(BOOL)localRegexPhone:(NSString *)phoneNumberString
{
    NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumberString];
}

/**
 *@brief 判断输入的时email还是手机号码
 */
+ (BOOL)localRegexEmail:(NSString *)emailString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9._]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:emailString];
}


//+(UIBarButtonItem *)createBarButtonItemWithOwner:(UIViewController *)containtCtrl title:(NSString *)title imageNamed:(NSString *)imageNamed tag:(NSInteger)tag{
////    CGSize viewSize = containtCtrl.view.frame.size;
//    //底部toolBar的高度
//    float bottomToolBarHeight = Config.currentTabBarHeight;
////    CGRect bottomToolBarFrame = CGRectMake(0,viewSize.height-bottomToolBarHeight,viewSize.width,bottomToolBarHeight);
//    
//    float buttonWidth;
//    if ([UIDevice isRunningOniPad]) {
//        buttonWidth = SCREEN_CGSIZE_WIDTH/(4.5f);
//    }else{
//        buttonWidth = SCREEN_CGSIZE_WIDTH/(5.0f);
//    }
//    NSInteger titleHeight=15;
//    
//    UIButton *myButton0 = [UIButton buttonWithType:UIButtonTypeCustom];
//    myButton0.frame = CGRectMake(0, 0, buttonWidth, bottomToolBarHeight);
////    [myButton0 setImage:[UIImage imageNamed:@"content_toolbar_download"] forState:UIControlStateNormal];
//    
//    [myButton0 setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
////    [myButton0 setTitle:NSLocalizedString(@"NSStringWebDownload",@"下载") forState:UIControlStateNormal];
//    [myButton0 setTitle:title forState:UIControlStateNormal];
//    [myButton0 setImageEdgeInsets:UIEdgeInsetsMake(0, 10, titleHeight, 0)];
//    [myButton0 setTitleEdgeInsets:UIEdgeInsetsMake(bottomToolBarHeight-titleHeight, -36, 0, 0)];
//    [myButton0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [myButton0.titleLabel setAdjustsFontSizeToFitWidth:YES];
//    SEL clickSelector = @selector(itemButtonClick:);
//    if ([containtCtrl respondsToSelector:clickSelector]) {
//        [myButton0 addTarget:containtCtrl action:clickSelector forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    [myButton0 setTag:tag];
//    UIBarButtonItem *myBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:myButton0];
//    return myBarButtonItem;
//}
//
///**
// *@brief 在视图的底部插入toolBar
// */
//+(void)insertBottomToolBar:(UIViewController *)containtController{
//    CGSize viewSize = containtController.view.frame.size;
//    //底部toolBar的高度
//    float bottomToolBarHeight = Config.currentTabBarHeight;
//    CGRect bottomToolBarFrame = CGRectMake(0,viewSize.height-bottomToolBarHeight,viewSize.width,bottomToolBarHeight);
//    
//    MyToolBar *bottomToolbar = [[MyToolBar alloc] initWithFrame:bottomToolBarFrame];
//    //设置bottomToolbar的索引
//    [bottomToolbar setTag:TAG_BOTTOM_TOOL_BAR];
//    bottomToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth
//    |
//    UIViewAutoresizingFlexibleLeftMargin
//    |
//    UIViewAutoresizingFlexibleRightMargin
//    |
//    UIViewAutoresizingFlexibleTopMargin;
//    
//    NSMutableArray *buttonsArray = [[NSMutableArray alloc]init];
//    
//    //收藏
//    [buttonsArray addObject:[self createBarButtonItemWithOwner:containtController title:NSLocalizedString(@"NSStringWebCollect",@"收藏") imageNamed:@"content_toolbar_collect" tag:(TAG_MYTOOLBAR+0)]];
//    //下载
//    [buttonsArray addObject:[self createBarButtonItemWithOwner:containtController title:NSLocalizedString(@"NSStringWebDownload",@"下载") imageNamed:@"content_toolbar_download" tag:(TAG_MYTOOLBAR+1)]];
//    //分享
//    [buttonsArray addObject:[self createBarButtonItemWithOwner:containtController title:NSLocalizedString(@"NSStringWebShare",@"分享") imageNamed:@"contenttoolbar_hd_share_light" tag:(TAG_MYTOOLBAR+2)]];
//    //推送
//    [buttonsArray addObject:[self createBarButtonItemWithOwner:containtController title:NSLocalizedString(@"NSStringWebPush",@"推送") imageNamed:@"contenttoolbar_push" tag:(TAG_MYTOOLBAR+3)]];
//
//    [bottomToolbar setItems:buttonsArray animated:YES];
//    [containtController.view addSubview:bottomToolbar];
//}
//
//
///**
// *@brief 在视图顶部插入工具栏作为导航条,带改变字体大小按钮
// */
//+(void)insertTopNavToolBar:(UIViewController *)containtController{
//    //顶部状态栏
//    MyToolBar *topNavToolBar=[[MyToolBar alloc]initWithFrame:CGRectMake(0, 0, containtController.view.frame.size.width, Config.currentNavigateHeight)];
//    //左侧返回按钮
//    UIBarButtonItem *leftBarBtn=[[UIBarButtonItem alloc]
//                                 initWithImage:[UIImage imageNamed:@"backitem.png"]
//                                 style:UIBarButtonItemStylePlain
//                                 target:containtController
//                                 action:@selector(backToSuperView)];
//    //设置为白色
//    [leftBarBtn setTintColor:[UIColor whiteColor]];
//    //左侧按钮的宽度
//    [leftBarBtn setWidth:60];
//    
//    UIBarButtonItem *titleView = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"NSString35",@"标题") style:UIBarButtonItemStylePlain target:containtController action:nil];
//    [titleView setWidth:SCREEN_CGSIZE_WIDTH-100];
//    [titleView setTintColor:[UIColor whiteColor]];
//    
//    UIBarButtonItem *barButtonItemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:containtController action:nil];
//    //toolBar上按钮间的宽度
//    [barButtonItemSpace setWidth:20];
//    
//    //左侧改变字体大小的按钮
//    UIBarButtonItem *rightBarBtn=[[UIBarButtonItem alloc]
//                                  initWithImage:[UIImage imageNamed:@"fontchange.png"]
//                                  style:UIBarButtonItemStylePlain
//                                  target:containtController
//                                  action:@selector(changeFontSize:)];
//    //设置按钮为白色
//    [rightBarBtn setTintColor:[UIColor whiteColor]];
//    //左侧按钮的宽度
//    [rightBarBtn setWidth:60];
//    
//    NSMutableArray *myTopNavToolBarItems = [[NSMutableArray alloc]initWithObjects:leftBarBtn,barButtonItemSpace,titleView,barButtonItemSpace,rightBarBtn,nil ];
//    [topNavToolBar setItems:myTopNavToolBarItems animated:YES];
//    [containtController.view addSubview:topNavToolBar];
//}
//
/**
 *@brief 修改html代码的内容
 */

+(void)changeWebView:(UIWebView *)newWebView HtmlContentTextSizeAdjust:(int)textSizeAdjust{
    //向网页中添加的JavaScript
    //判断如果页面中有设置页面放大比例的代码,则不放大页面,否则执行放大代码
    NSString *addJavaScriptContent =
    [[NSString alloc]initWithFormat:@"var script=document.createElement('script');"
     "script.type='text/javascript';"
     "script.text=\"function myFunction(){"
     "var field=document.getElementsByName('viewport')[0];"
     "var fieldContent='width=device-width, initial-scale=1.0';"
     "var fieldContent2='width=device-width,user-scalable=no';"
     "if(field!='undefined'){document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='%d%@';"
     "if((field.content==fieldContent)||(field.content==fieldContent2)){document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='100%@';}"
     "}}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);",textSizeAdjust,@"%",@"%"];
    DLog(@"addJavaScriptContent = %@",addJavaScriptContent);
    [newWebView stringByEvaluatingJavaScriptFromString:addJavaScriptContent];
    [newWebView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
    
    DLog(@"修改html代码的内容");
}


///**
// *@brief 添加shareSDK的引用到指定视图
// */
//+(void)insertShareSDKButton:(UIViewController *)containtViewController{
//    sharesdkButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_CGSIZE_WIDTH/5)*3+2.5-20, containtViewController.view.frame.size.height-44+2.5-2.5, 40, 1)];
//    [containtViewController.view addSubview:sharesdkButton];
//}
//
//
//
///**
// *@brief 在视图顶部插入返回的导航条
// */
//+(void)insertTopNavgationView:(UIViewController *)containtViewController titleString:(NSString *)titleString topOffSet:(NSInteger)topOffSet{
//    NSString *topnavistr=[[NSString alloc]initWithFormat:@"topnavigata.png"];
//    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:topnavistr]];
//    [titleImageView setTag:TAG_TOP_NAVGATION_VIEW];
//    titleImageView.frame = CGRectMake(0,topOffSet, containtViewController.view.frame.size.width, 44);
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_CGSIZE_WIDTH/2-30, 12, containtViewController.view.frame.size.width-3*50, 20)];
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.text = ((!titleString) ? NSLocalizedString(@"NSString35",@"LED人") : titleString);
//    titleLabel.textColor = [UIColor whiteColor];
//    [titleLabel setFont:[UIFont systemFontOfSize:17]];
//    titleLabel.textAlignment = NSTextAlignmentLeft;
//    [titleImageView addSubview:titleLabel];
//    [titleLabel release];
//    
//    UIButton *callModalViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [callModalViewButton setFrame:CGRectMake(7.0f, 7.0f, 47.0f, 30.0f)];
//    [callModalViewButton addTarget:containtViewController action:@selector(backToSuperView) forControlEvents:UIControlEventTouchUpInside];
//    callModalViewButton.backgroundColor = [UIColor clearColor];
//    [callModalViewButton setImage:[UIImage imageNamed:@"backitem.png"] forState:UIControlStateNormal];
//    [titleImageView setUserInteractionEnabled:YES];
//    [titleImageView addSubview:callModalViewButton];
//    
//    [containtViewController.view addSubview:titleImageView];
//    [titleImageView release];
//    
//}
//
//
///**
// *@brief 加载一级目录的数据
// */
//+(void)getFirstMenuData:(UIViewController *)containtCtrl{
//    DLog(@"一级目录解析开始,打印时间=%@",[MyTool getCurrentDateString]);
//    
//    //获得一级菜单数据
//    NSString *firstMenuUrlString = nil;
//    NSString *langString = URL_CHINESE_CSHARP_MARK;//默认中文
//    NSString *strLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
//    if ([strLanguage isEqualToString:@"zh-Hans"]) {
//        //中文
//        langString = URL_CHINESE_CSHARP_MARK;
//    }else{
//        //如果英文表示打开,则显示英文
//        if ([[NSUserDefaults standardUserDefaults] boolForKey:LANG_IS_ENGLISH]) {
//            langString = [[NSString alloc]initWithFormat:@"%@",URL_ENGLISH_CSHARP_MARK];
//        }
//    }
//    firstMenuUrlString = [[NSString alloc]initWithFormat:@"%@%@%@",URL_FOR_IP_OR_DOMAIN,URL_INTERFACE_IMPORT,langString];
//    
//    DLog(@"一级菜单的路径 = %@",firstMenuUrlString);
//    
//    __block ASIHTTPRequest *firstMenuRequest = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:firstMenuUrlString]];
//    [firstMenuRequest setTag:TAG_FIRST_MENU_DATA_REQUEST];
//    [firstMenuRequest setCompletionBlock:^{
//        [FirstMenuDataFilter refreshFirstMenuData:firstMenuRequest];
//        DLog(@"一级目录解析完毕,打印时间=%@",[MyTool getCurrentDateString]);
//        SEL finishSelector = @selector(requestFinished:);
//        if ([containtCtrl respondsToSelector:finishSelector]) {
//            [containtCtrl requestFinished:firstMenuRequest];
//        }
//    }];
//    [firstMenuRequest setFailedBlock:^{
//        DLog(@"一级目录请求失败,请检查网络");
//        SEL failSelector = @selector(requestFailed:);
//        if ([containtCtrl respondsToSelector:failSelector]) {
//            [containtCtrl requestFailed:firstMenuRequest];
//        }
//    }];
//    [firstMenuRequest startAsynchronous];
//}

/**
 *@brief 请求二级菜单数据,
 *       传入数据加载失败和数据加载成功的回调函数的拥有者,
 *       拥有者必须实现的方法
 * -(void)queueFetchFailed:(ASIHTTPRequest *)request;
 * -(void)queueFetchFinished:(ASIHTTPRequest *)request;
 */
+(void)getSecondMenuData:(UIViewController *)containtCtrl oneDataCategory:(DataCategories *)oneDataCategory{
     ASINetworkQueue *networkQueue = [[ASINetworkQueue alloc] init];
    [networkQueue reset];
    SEL failSelector = @selector(queueFetchFailed:);
    if ([containtCtrl respondsToSelector:failSelector]) {
        [networkQueue setRequestDidFailSelector:failSelector];
    }
    SEL finishSelector = @selector(queueFetchFinished:);
    if ([containtCtrl respondsToSelector:finishSelector]) {
        [networkQueue setQueueDidFinishSelector:finishSelector];
    }
    
    [networkQueue setDelegate:containtCtrl];
    
    if (!oneDataCategory) {
        return;
    }
    //获得一级菜单下的二级菜单
    if (![_ColumnsDictionary objectForKey:oneDataCategory.category_id]) {
        NSURL *oneFirstMenuUrl = [NSURL URLWithString:oneDataCategory.category_url];
        ASIHTTPRequest *getSecondMenuRequest = [[ASIHTTPRequest alloc]initWithURL:oneFirstMenuUrl];
        [getSecondMenuRequest setTag:[oneDataCategory.category_id integerValue]];
        [getSecondMenuRequest setCompletionBlock:^{
            DLog(@"请求二级目录的数据完毕");
            [SecondMenuDataFilter refreshSecondMenuData:getSecondMenuRequest];
        }];
        [getSecondMenuRequest setFailedBlock:^{
            DLog(@"请求二级目录的数据失败");
        }];
        [networkQueue addOperation:getSecondMenuRequest];
    }
    [networkQueue go];
}

///**
// *@brief 判断返回的字符串是否表示异地登陆
// */
//+(BOOL)accountOtherLogin:(NSString *)responseString{
//    if (responseString) {
//        NSDictionary *loginResponseStringDict = [responseString JSONValue];
////        @"{\"message\":{\"error\":\"1\",\"key\":\"\",\"msg\":\"99\"}}"
//        NSDictionary *messageDict = [loginResponseStringDict objectForKey:@"message"];
//        NSString *msgString = [messageDict objectForKey:@"msg"];
//        if ([msgString isEqualToString:@"99"]) {
//            return YES;
//        }else{
//            return NO;
//        }
//    }else{
//        return NO;
//    }
//}
//
///**
// *@brief 如果数据刷新失败则增加刷新按钮;
// *       需要在增加此方法的Controller里加入refreshDataButtonClick方法
// */
//+(void)insertRefreshDataButton:(UIView *)containtView containtCtrl:(UIViewController *)containtCtrl{
//    CGPoint refreshViewCenter = containtView.center;
//    UIView *oldView = [containtCtrl.view viewWithTag:TAG_REFRESH_VIEW];
//    [oldView removeFromSuperview];
//    UIView *refreshView = [[UIView alloc]initWithFrame:CGRectMake(refreshViewCenter.x-50,refreshViewCenter.y-47,100,94)];
//    [refreshView setTag:TAG_REFRESH_VIEW];
//    [refreshView setUserInteractionEnabled:YES];
//    
//    UIButton *refreshButton = [[UIButton alloc]initWithFrame:CGRectMake((refreshView.frame.size.width/2)-27,0,54,64)];
//    [refreshButton setImage:[UIImage imageNamed:@"refreshDataButton.png"] forState:UIControlStateNormal];
//    [refreshButton addTarget:containtCtrl action:@selector(refreshDataButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [refreshView addSubview:refreshButton];
//    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake(refreshView.frame.origin.x, refreshButton.frame.origin.y+refreshButton.frame.size.height, 100, 30)];
//    [promptLabel setCenter:CGPointMake(refreshButton.center.x,refreshButton.frame.origin.y+refreshButton.frame.size.height+10)];
//    [promptLabel setText:@"点击屏幕重新加载数据"];
//    [promptLabel setFont:[UIFont systemFontOfSize:10]];
//    [promptLabel setBackgroundColor:[UIColor clearColor]];
//    [refreshView addSubview:promptLabel];
//    [containtView setUserInteractionEnabled:YES];
//    [containtView addSubview:refreshView];
//}
//
//
///**
// *@brief 开始进度条
// */
//+(void)startProgress:(UIViewController *)containtCtrl{
//    UIView *refrshView = [containtCtrl.view viewWithTag:TAG_REFRESH_VIEW];
//    [refrshView removeFromSuperview];
//    
//    KKProgressTimer *myProgress = [[KKProgressTimer alloc]initWithFrame:CGRectMake((SCREEN_CGSIZE_WIDTH/2)-50, (SCREEN_CGSIZE_HEIGHT/2)-50, 100, 100)];
//    myProgress.delegate = containtCtrl;
//    [myProgress setTag:TAG_FIRST_PAGE_MY_PROGRESS];
//    [containtCtrl.view addSubview:myProgress];
//    
//    __block CGFloat i3 = 0;
//    [myProgress startWithBlock:^CGFloat {
//        return ((i3++ >= 50) ? (i3 = 0) : i3) / 50;
//    }];
//}
//
///**
// *@brief 停止进度条
// */
//+(void)stopProgress:(UIViewController *)containtCtrl{
//    UIView *refrshView = [containtCtrl.view viewWithTag:TAG_REFRESH_VIEW];
//    [refrshView removeFromSuperview];
//    
//    KKProgressTimer *oldProgress = (KKProgressTimer *)[containtCtrl.view viewWithTag:TAG_FIRST_PAGE_MY_PROGRESS];
//    [oldProgress stop];
//    [oldProgress removeFromSuperview];
//}
//
//
///**
// *@brief 加载广告焦点图
// */
//-(void)insertCustomAdView:(UIViewController *)containtCtrl{
//    DLog(@"加载广告模块,打印时间=%@",[MyTool getCurrentDateString]);
//    NSInteger _adModelScrollHeight = ((DEVICE_IS_IPAD) ? MAIN_AD_MODEL_HEIGHT : MAIN_AD_MODEL_HEIGHT_IPHONE);
//    //获得焦点图的的容器视图
//    UIView *containtView = [containtCtrl.view viewWithTag:TAG_AD_CONTAINT_VIEW];
//    
//    EScrollerView *adEScrollerView=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, containtCtrl.view.frame.size.width,_adModelScrollHeight) dataArray:adDataArray];
//    adEScrollerView.delegate = containtCtrl;
//    [adEScrollerView setTag:TAG_ESCROLLER_VIEW];
//    [containtView addSubview:adEScrollerView];
//    DLog(@"加载广告模块完毕,打印时间=%@",[MyTool getCurrentDateString]);
//}
//
//
/**
 *@brief 取得路径的语言后缀
 */
+(NSString *)getURLLangSuffix{
    NSString* strLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    NSString *lengUrl = URL_CHINESE_CSHARP_MARK;
    if ([strLanguage isEqualToString:@"zh-Hans"]) {
        lengUrl = URL_CHINESE_CSHARP_MARK;
    }else{
        lengUrl = URL_ENGLISH_CSHARP_MARK;
    }
    return lengUrl;
}


///**
// *@brief 改变导航栏的颜色
// */
//+(void)changeNavgationBarColor:(UIViewController *)containtCtrl{
//    //改变导航栏的颜色
////    if (OS_VERSION_FLOAT < 7.0f) {
////        [containtCtrl.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_toolbar.png"]]];
////    }else{
////        if (!DEVICE_IS_IPAD) {
////            [containtCtrl.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_toolbar_64.png"] forBarMetrics:UIBarMetricsDefault];
////        }else{
////            [containtCtrl.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_toolbar.png"]]];
////        }
////    }
//}


/**
 *@brief 导航视图切换器
 */
+(CATransition *)viewSwitcher:(NSString *)animationType owner:(UIViewController *)ownerController transitionFromStyle:(NSString *)transitionFromStyle{
    NSString *tempTransitionFromStyleString = transitionFromStyle;
    tempTransitionFromStyleString = (!tempTransitionFromStyleString) ? kCATransitionFromRight : tempTransitionFromStyleString;
    NSString *animationTypeString = animationType;
    animationTypeString = (!animationType) ? @"rippleEffect" : animationTypeString;
    
    CATransition *animation = [CATransition animation];
    animation.delegate = ownerController;
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = animationTypeString;
    animation.subtype = transitionFromStyle;
    [[ownerController.navigationController.view layer] addAnimation:animation forKey:@"animation"];
    return animation;
}



///**
// *@brief 判断一个类中的方法是否可以被调用
// */
//+(SEL)filterSelector:(SEL)selectorName target:(UIViewController *)target{
//    SEL tempSelector = selectorName;
//    
//    if ([target respondsToSelector:tempSelector]) {
//        return tempSelector;
//    }else{
//        NSString *selectorNameString = NSStringFromSelector(selectorName);
//        DLog(@"方法名 %@ 不存在,请在 %@ 中查找错误,未定义或拼写错误!",selectorNameString,NSStringFromClass([target class]));
//        return nil;
//    }
//}
//
//
//
///**
// *@brief 获取名片的二级目录
// */
//+(void)getNameCardData:(UIViewController *)containtCtrl{
//    //获得二级菜单数据
//    NSString *nameCardColumnURLString = nil;
//    NSString *langString = URL_CHINESE_CSHARP_MARK;//默认中文
//    NSString *strLanguage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
//    if ([strLanguage isEqualToString:@"zh-Hans"]) {
//        //中文
//        langString = URL_CHINESE_CSHARP_MARK;
//    }else{
//        //如果英文表示打开,则显示英文
//        if ([[NSUserDefaults standardUserDefaults] boolForKey:LANG_IS_ENGLISH]) {
//            langString = [[NSString alloc]initWithFormat:@"%@",URL_ENGLISH_CSHARP_MARK];
//        }
//    }
//    nameCardColumnURLString = [[NSString alloc]initWithFormat:@"%@%@",URL_GET_NAME_CARD_COLUMN,langString];
//    
//    DLog(@"名片一级菜单的路径 = %@",nameCardColumnURLString);
//    
//    __block ASIHTTPRequest *nameCardColumnRequest = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:nameCardColumnURLString]];
//    [nameCardColumnRequest setTag:TAG_URL_GET_NAME_CARD_DATA];
//    [nameCardColumnRequest setCompletionBlock:^{
//        if (nameCardColumnRequest.tag == TAG_URL_GET_NAME_CARD_DATA) {
//            [NameCardSecondMenuDataFilter refreshSecondMenuData:nameCardColumnRequest];
//            DLog(@"名片二级目录解析完毕,打印时间=%@",[MyTool getCurrentDateString]);
//        }
//        SEL finishSelector = @selector(requestFinished:);
//        if ([containtCtrl respondsToSelector:finishSelector]) {
//            [containtCtrl requestFinished:nameCardColumnRequest];
//        }
//    }];
//    [nameCardColumnRequest setFailedBlock:^{
//        DLog(@"一级目录请求失败,请检查网络");
//        SEL failSelector = @selector(requestFailed:);
//        if ([containtCtrl respondsToSelector:failSelector]) {
//            [containtCtrl requestFailed:nameCardColumnRequest];
//        }
//    }];
//    [nameCardColumnRequest startAsynchronous];
//}
//
//
///**
// *@brief 显示提示登录的警告窗
// */
//-(void)alertViewLoginAndJumpToLogin:(UIViewController *)containtCtrl{
//    NSString *title = @"";
//	NSString *message = [[NSString alloc]initWithFormat:@"\n\n\n%@",NSLocalizedString(@"NSStringYouNotlogin", @"您尚未登陆，请登陆！")];
//    //自定义的提示框
//	AHAlertView *alert = [[AHAlertView alloc] initWithTitle:title message:message];
//	[alert setCancelButtonTitle:NSLocalizedString(@"NSStringNO",@"取消") block:^{
//        alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
//        DLog(@"点击了取消");
//	}];
//    
//    UIImageView *viewe = [[UIImageView alloc]initWithFrame:CGRectMake((alert.frame.size.width/2)-(45/2),15.0,45.0,45.0)];
//    viewe.image = [UIImage imageNamed:@"crytoastimage.png"];
//    
//    [alert addSubview:viewe];
//	[alert addButtonWithTitle:NSLocalizedString(@"NSStringYes",@"确定") block:^{
//        LoginViewController *loginViewController= [[LoginViewController alloc]init];
//        [containtCtrl presentViewController:loginViewController animated:NO completion:nil];
//    }];
//	[alert show];
//}
//
//
///**
// *@brief 清除通知
// */
//+(void)clearRmoteNotification{
//    DLog(@"清除角标通知");
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//}
//
//
///**
// *@brief 格式化发布的时间
// */
//+ (NSString *) transTimeSp:(NSString *) time
//{
//    NSDate *datenow = [NSDate date];
//    NSInteger duration = (NSInteger)[datenow timeIntervalSince1970] - [time integerValue];
//    NSString *str;
//    
//    int second = 1;
//    int minute = second * 60;
//    int hour = minute * 60;
//    int day = hour * 24;
//    
//    if (duration < second * 7) {
//        str = NSLocalizedString(@"刚刚发布", @"rightnow");
//    }else if (duration < minute) {
//        int n = (int)duration/second;
//        str = [NSString stringWithFormat:NSLocalizedString(@"%d秒钟前", @"second before"),n];
//    }else if (duration < hour) {
//        int n = (int)duration/minute;
//        str = [NSString stringWithFormat:NSLocalizedString(@"%d分钟前", @"minute before"),n];
//    }else if (duration < day) {
//        int n = (int)duration/hour;
//        str = [NSString stringWithFormat:NSLocalizedString(@"%d小时前", @"hour before"),n];
//    }else if (duration > day && duration < day * 2) {
//        str = NSLocalizedString(@"昨天", @"day yestoday");
//    }else if (duration > day && duration < day * 3) {
//        str = NSLocalizedString(@"前天", @"day the day before yestoday");
//    }else if (duration < day * 7) {
//        int n = (int)duration/day;
//        str = [NSString stringWithFormat:NSLocalizedString(@"%d天前", @"day before"),n];
//    }else{
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        NSLocale *chLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CH"];
//        [formatter setLocale:chLocale];
//        [formatter setDateFormat:NSLocalizedString(@"MM月dd日 hh:mm", @"date formatter")];
//        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-duration];
//        str = [formatter stringFromDate:date];
//    }
//    
//    return str;
//}
//
///**
// *@brief 判断一个路径是否是图片路径
// */
//+(BOOL)isImagePath:(NSString *)imangePath{
//    if ([imangePath isEqualToString:URL_BBS_DOMAIN]) {
//        DLog(@"不存在imangePath = %@",imangePath);
//        return NO;
//    }else{
//        DLog(@"图片路径存在 ＝ %@",imangePath);
//       return YES;
//    }
//}


/**
 *  验证像素值是否在-1到2048之间
 *
 *  @param iPixle 传入像素值
 *
 *  @return 返回布尔值
 */
+(BOOL)validatePixleValue:(NSInteger)iPixle{
    if ((iPixle>-1)&&(iPixle<2048)) {
        return YES;
    }else{
        return NO;
    }
}

/**
 *  对角线长度计算
 *
 *  @return 对角线长度
 */
+(float)diagonalCalculateWithA:(float)a andB:(float)b{
    return hypotf(a, b);
}

/**
 *  根据对角线的长度和宽高比来计算矩形的高度
 *
 *  @param dia   对角线长度
 *  @param scale 宽高比
 *
 *  @return 矩形的高度
 */
+(float)heightCalculateWithDiagonal:(float)dia andhwScale:(float)scale{
    return sqrtf(powf(dia, 2)/(powf(scale,2)+1));
}

/**
 *  根据对角线的长度和宽高比来计算矩形的宽度
 *
 *  @param dia   对角线长度
 *  @param scale 宽高比
 *
 *  @return 矩形的宽度
 */
+(float)widthCalculateWithDiagonal:(float)dia andhwScale:(float)scale{
    return sqrtf(powf(dia, 2)/(powf(scale,2)+1))*scale;
}


/**
 *@brief 写入Video文件，存储在Documents/VideoFile目录下
 */
+(void)writeVideoCacheRequestUrl:(NSString*)url{
    NetworkStatus netStatus = [Reachability GobalcurrentReachabilityStatus];
    if (netStatus == NotReachable) {
        DLog(@"无网络时直接返回");
        return;
    }
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    //缓存文件假的路径
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/VideoFile/"];
    //创建缓存文件夹路径
    if (![fileMgr fileExistsAtPath:documentsDirectory]) {
        [fileMgr createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    }

    NSString *saveURL = [url stringByReplacingOccurrencesOfString:@".mp4" withString:@""];
    //缓存文件的路径
    NSString *filePath = [documentsDirectory
                          stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[saveURL md5Encrypt]]];

    if ([fileMgr fileExistsAtPath:filePath]) {
        //需要判断文件存在的时间,如果超过7天则删除
        //        NSDictionary *fileInfoDict = [fileMgr attributesOfItemAtPath:filePath error:&error];
        //        if (fileInfoDict) {
        //            DLog(@"存储的文件信息 = %@",fileInfoDict);
        //            DLog(@"文件创建的时间 = %@",[fileInfoDict objectForKey:NSFileCreationDate]);
        //            NSDateFormatter *df=[[NSDateFormatter alloc] init];
        //            [df setDateFormat:@"yyyy-MM-dd"];
        //
        //            NSDate *date1=[df dateFromString:@"2013-09-11"];
        //            NSLog(@"dateDay =%@",date1);
        //
        //            NSDate *date2=[df dateFromString:@"2013-09-10"];
        //
        //            NSLog(@"mydate =%@",date2);
        //            switch ([date1 compare:date2]) {
        //                case NSOrderedSame:
        //                    NSLog(@"相等");
        //                    break;
        //                case NSOrderedAscending:
        //                    NSLog(@"date1比date2小");
        //                    break;
        //                case NSOrderedDescending:
        //                    NSLog(@"date1比date2大");
        //                    break;
        //                default:
        //                    NSLog(@"非法时间");
        //                    break;
        //            }
        //        }
        [fileMgr removeItemAtPath:filePath error:&error];
    }
    DLog(@"下载的url=%@",url);
    if (url!=nil) {
        if ([url length]>0) {
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
            [request setDownloadDestinationPath:filePath];
            //            [request setCompletionBlock:^{
            //                DLog(@"CompletionBlock:%@",[request url]);
            //            }];
            //            [request setFailedBlock:^{
            //                NSError *error = [request error];
            //                DLog(@"Error:%@",error.userInfo);
            //            }];
            [request startAsynchronous];
        }
    }
}

@end
