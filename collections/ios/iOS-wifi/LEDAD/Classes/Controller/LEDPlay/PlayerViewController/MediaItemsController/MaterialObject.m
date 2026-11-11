//
//  MaterialObject.m
//  XCloudsManager
//  播放列表中的素材对象
//  Created by yixingman on 14-6-25.
//
//

#import "MaterialObject.h"
#import "MyPlayListViewController.h"
#import "NSString+MD5.h"
#import "YXM_MasterTableViewCell.h"
#import "MyTool.h"

@implementation MaterialObject

@synthesize material_name = _material_name;
@synthesize material_path = _material_path;
@synthesize material_original_path = _material_original_path;
@synthesize material_type = _material_type;
@synthesize material_x = _material_x;
@synthesize material_y = _material_y;
@synthesize material_w = _material_w;
@synthesize material_h = _material_h;
@synthesize material_duration = _material_duration;
@synthesize material_thumbnail = _material_thumbnail;
@synthesize material_direction = _material_direction;
@synthesize material_angle = _material_angle;
@synthesize material_of_projectfolder = _material_of_projectfolder;
@synthesize material_alpha = _material_alpha;

+(MaterialObject*)revertALAssetToMaterialObject:(ALAsset*)myALAsset{
    //创建项目文件保存的文件夹
    @try {
        [self createProjectFoler];
        MaterialObject *myMaterial = [[MaterialObject alloc]init];
        //缩略图
        [myMaterial setMaterial_thumbnail:CGImageRetain([myALAsset thumbnail])];
        //播放延时
        //如果素材有duration这个属性,则直接使用素材的duration,否则默认值设置为I_DEFAULT_TIME
        NSInteger tempDuration = [[myALAsset valueForProperty:ALAssetPropertyDuration] integerValue];
        if (tempDuration>1) {
            [myMaterial setMaterial_duration:tempDuration];
        }else{
            [myMaterial setMaterial_duration:I_DEFAULT_TIME];
        }
        //素材类型，视频或者图片
        NSString *materialType = [myALAsset valueForProperty:ALAssetPropertyType];
        [myMaterial setMaterial_type:[MyPlayListViewController sourceType:materialType]];
        
        
        //存放在相册中的原始路径
        [myMaterial setMaterial_original_path:[myALAsset valueForProperty:ALAssetPropertyAssetURL]];

        //内部生成的名称
        int randomNumber = (arc4random() % 100000) + 1;
        NSString *sRandom = [[NSString alloc]initWithFormat:@"%d,%@",randomNumber,[MyTool getCurrentDateString]];
        //沙盒中的资源路径
        NSString *pathString = [MaterialObject handleWrittenFileWithSourceAsset:myALAsset AndMatrialName:sRandom];
        if (pathString) {
            [myMaterial setMaterial_path:pathString];
        }
        

        [myMaterial setMaterial_name:[sRandom md5Encrypt]];

        //x,y,w,h
        CGSize imageSize = [YXM_MasterTableViewCell sizeOfAsset:myALAsset];
        [myMaterial setMaterial_w:imageSize.width];
        [myMaterial setMaterial_h:imageSize.height];

        return myMaterial;
    }
    @catch (NSException *exception) {
        DLog(@"ALAsset对象转换为自定义素材对象异常 = %@",exception);
    }
    @finally {
        
    }
    
}

/**
 *  创建项目文件保存的文件夹
 */
+(void)createProjectFoler{

    NSFileManager *fileMgr = [NSFileManager defaultManager];
    //缓存文件夹的路径
    NSString *sProjectDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ProjectCaches/"];

    BOOL isDir;
    NSError *error;
    if (![fileMgr fileExistsAtPath:sProjectDirectory isDirectory:&isDir]) {
        //创建缓存文件夹路径
        [fileMgr createDirectoryAtPath:sProjectDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    }
}

/**
 *  将相册内的资源写入到沙盒中
 *
 *  @param videoAsset 传入系统的资源对象
 *  @return 素材在沙盒中的路径
 */
+(NSString *)handleWrittenFileWithSourceAsset:(ALAsset*)sourceAsset AndMatrialName:(NSString *)sRandom
{
    NSString *pathString = nil;
    ALAssetRepresentation *rep = [sourceAsset defaultRepresentation];
    //素材存储的文件夹的路径
    NSString *documentsDirectory = [MaterialObject createMatrialRootPath];
    //素材的原始路径
    NSString *originalPath = [[NSString alloc]initWithFormat:@"%@",[sourceAsset valueForProperty:ALAssetPropertyAssetURL]];

    NSArray *pathSeparatedArray = [originalPath componentsSeparatedByString:@"&ext="];
    NSString *sExtString = nil;
    if ([pathSeparatedArray count]==2) {
        sExtString = [pathSeparatedArray objectAtIndex:1];
    }

    @try {
        if ([[sourceAsset valueForProperty:ALAssetPropertyType] isEqualToString:@"ALAssetTypeVideo"]) {
            if (sExtString==nil) {
                sExtString = @"mov";
            }
            NSString *myFilePath = [NSString stringWithFormat:@"%@%@.%@",documentsDirectory,[sRandom md5Encrypt],sExtString];
            pathString = [[NSString alloc]initWithString:myFilePath];
            
            NSUInteger size = [rep size];
            const int bufferSize = 65636;

            FILE *f = fopen([myFilePath cStringUsingEncoding:1], "wb+");
            if (f==NULL) {
                return nil;
            }
            Byte *buffer =(Byte*)malloc(bufferSize);
            int read =0, offset = 0;
            NSError *error;
            if (size != 0) {
                do {
                    read = [rep getBytes:buffer
                              fromOffset:offset
                                  length:bufferSize
                                   error:&error];
                    fwrite(buffer, sizeof(char), read, f);
                    offset += read;
                } while (read != 0);
            }
            fclose(f);
        }


        if ([[sourceAsset valueForProperty:ALAssetPropertyType] isEqualToString:@"ALAssetTypePhoto"]) {
            //保存图片
            UIImage *resolutionImage = [UIImage imageWithCGImage:[rep fullResolutionImage]];

            NSData *imageDataObj = UIImagePNGRepresentation(resolutionImage);
            NSString *myFilePath = [documentsDirectory
                                    stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[sRandom md5Encrypt]]];
            pathString = [[NSString alloc]initWithString:myFilePath];
            [imageDataObj writeToFile:myFilePath atomically:YES];
        }

    }
    @catch (NSException *exception) {
        DLog(@"存储视频异常 = %@",exception);
    }
    @finally {
        
    }
    return pathString;
}

-(NSString *)description{
    NSString *myDescription = [[NSString alloc]initWithFormat:@"_material_name = %@,_material_path = %@,_material_original_path=%@,_material_type=%@,_material_duration=%d,_material_x=%d,_material_y=%d,_material_w=%d,_material_h=%d,_material_direction=%@,_material_angle=%d,%@",_material_name,_material_path,_material_original_path,_material_type,_material_duration,_material_x,_material_y,_material_w,_material_h,_material_direction,_material_angle,_material_thumbnail];
    return myDescription;
}

/**
 *@brief 创建临时图片存储路径
 */
+(NSString *)createMatrialRootPath{
    //素材存储的文件夹的路径
    NSString *sMatrialRootPath = [[NSString alloc]initWithFormat:@"%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ADMaterial/"]];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL isDir = YES;
    NSError *myError;
    if (![fileMgr fileExistsAtPath:sMatrialRootPath isDirectory:&isDir]) {
        BOOL createResult = [fileMgr createDirectoryAtPath:sMatrialRootPath withIntermediateDirectories:YES attributes:nil error:&myError];
        if (!createResult) {
            DLog(@"创建目录出错");
        }
    }
    return sMatrialRootPath;
}

-(void)dealloc{
    [_material_name release];
    [_material_path release];
    [_material_type release];
    [_material_original_path release];
    [_material_alpha release];
    [super dealloc];
}
@end
