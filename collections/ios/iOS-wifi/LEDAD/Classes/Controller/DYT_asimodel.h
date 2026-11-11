//
//  DYT_asimodel.h
//  LEDAD
//
//  Created by laidiya on 15/7/29.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol myasidelegate <NSObject>

//
-(void)showAlertView:(NSString *)string andtag:(NSInteger )tag;

-(void)returegress:(long long)siez andtotal:(long long)total andtext:(NSString *)string andtag:(NSInteger)tag;

@end

@interface DYT_asimodel : NSObject

-(instancetype)initwith:(id)delegate;

-(void)uploadRequstMovPath:(NSString *)movPath movName:(NSString *)movName xmlPath:(NSString *)xmlPath xmlName:(NSString *)xmlName Material:(NSString *)materialName andgourpid:(NSString *)mygroupid;

@property(nonatomic,assign)NSInteger mytag;
@property(nonatomic,assign)id<myasidelegate>delegate;
@end
