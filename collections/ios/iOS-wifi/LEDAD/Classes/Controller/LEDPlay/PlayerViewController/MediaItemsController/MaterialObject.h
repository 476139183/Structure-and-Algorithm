//
//  MaterialObject.h
//  XCloudsManager
//  播放列表中的素材对象
//  Created by yixingman on 14-6-25.
//
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MaterialObject : NSObject
{
    NSString *_material_name;
    NSString *_material_path;
    NSString *_material_original_path;
    NSString *_material_type;
    NSInteger _material_duration;
    NSInteger _material_x;
    NSInteger _material_y;
    NSInteger _material_w;
    NSInteger _material_h;
    NSString *_material_direction;
    CGImageRef _material_thumbnail;
    int _material_angle;
    NSString *_material_of_projectfolder;
    NSString *_material_alpha;
}

@property (nonatomic,retain) NSString *material_name;
@property (nonatomic,retain) NSString *material_path;
@property (nonatomic,retain) NSString *material_type;
@property (nonatomic,retain) NSString *material_original_path;
@property (nonatomic) NSInteger material_duration;
@property (nonatomic) NSInteger material_x;
@property (nonatomic) NSInteger material_y;
@property (nonatomic) NSInteger material_w;
@property (nonatomic) NSInteger material_h;
@property (nonatomic) CGImageRef material_thumbnail;
@property (nonatomic,retain) NSString *material_direction;
@property (nonatomic,assign) int material_angle;
@property (nonatomic,retain) NSString *material_of_projectfolder;
@property (nonatomic,retain) NSString *material_alpha;
+(MaterialObject*)revertALAssetToMaterialObject:(ALAsset*)myALAsset;

-(NSString*)description;

/**
 *@brief 创建临时图片存储路径
 */
+(NSString *)createMatrialRootPath;


/**
 *  将相册内的资源写入到沙盒中
 *
 *  @param videoAsset 传入系统的资源对象
 *  @return 素材在沙盒中的路径
 */
+(NSString *)handleWrittenFileWithSourceAsset:(ALAsset*)sourceAsset AndMatrialName:(NSString *)sRandom;
@end
