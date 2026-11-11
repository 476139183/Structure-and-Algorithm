//
//  BaiImage.m
//  XCloudsManager
//
//  Created by yixingman on 14-7-2.
//
//

#import "BaiImage.h"

@implementation BaiImage
// 新建一个image类，作为百叶窗中每一横条的图片
+(NSDictionary*)SeparateImage:(UIImage*)image ByX:(int)x andY:(int)y cacheQuality:(float)quality
{
    //kill errors
    if (x<1) {
        DLog(@"illegal x!");
        return nil;
    }else if (y<1) {
        DLog(@"illegal y!");
        return nil;
    }
    if (![image isKindOfClass:[UIImage class]]) {
        DLog(@"illegal image format!");
        return nil;
    }
    //错误处理做得比较完善，赞一个！
    float _xstep = image.size.width*1.0/y;
    float _ystep = image.size.height*1.0/x;
    //新建一个dictionary，用于存放这些小矩形图片
    NSMutableDictionary*_mutableDictionary=[[[NSMutableDictionary alloc]initWithCapacity:1]autorelease];
    NSString *prefixName = @"win";
    for (int i=0; i<x; i++)
    {
        for (int j=0; j<y; j++)
        {
            CGRect rect=CGRectMake(_xstep*j, _ystep*i, _xstep, _ystep);
            CGImageRef imageRef=CGImageCreateWithImageInRect([image CGImage],rect);
            UIImage * elementImage=[UIImage imageWithCGImage:imageRef];
            UIImageView *_imageView=[[UIImageView alloc] initWithImage:elementImage];
            _imageView.frame=rect;
            NSString *_imageString=[NSString stringWithFormat:@"%@_%d_%d.jpg",prefixName,i,j];
            [_mutableDictionary setObject:_imageView forKey:_imageString];
            CFRelease(imageRef);
            if(quality<=0)
            {
                continue;
            }
            quality = (quality>1)?1:quality;
            NSString *_imagePath = [NSHomeDirectory() stringByAppendingPathComponent:_imageString];
            NSData* _imageData = UIImageJPEGRepresentation(elementImage, quality);
            [_imageData writeToFile:_imagePath atomically:NO];
        }
    }
    
    // 存取dictionary的循环过程
    NSDictionary*_dictionary=_mutableDictionary;
    return _dictionary;
}

@end

