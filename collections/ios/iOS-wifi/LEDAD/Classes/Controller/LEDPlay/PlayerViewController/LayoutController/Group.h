//
//  FriendGroup.h
//  QQ好友列表
//
//  Created by TianGe-ios on 14-8-21.
//  Copyright (c) 2014年 TianGe-ios. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property (nonatomic, strong) NSArray *Materials; //数组元素
@property (nonatomic, copy) NSString *Grouping_Name; //分组名
@property (nonatomic, copy) NSString *ID;  //分组id
@property (nonatomic, copy) NSString *UserId; // 用户id
@property (nonatomic, copy) NSString *IsShow;  //
@property (nonatomic, copy) NSString *Note;  //

@property(nonatomic,assign)BOOL qcheck;

@property (nonatomic, assign, getter = isOpened) BOOL opened;

+ (instancetype) projectGroupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

