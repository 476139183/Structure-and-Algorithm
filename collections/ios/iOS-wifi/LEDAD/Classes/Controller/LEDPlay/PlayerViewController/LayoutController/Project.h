//
//  Friend.h
//  QQ好友列表
//
//  Created by TianGe-ios on 14-8-21.
//  Copyright (c) 2014年 TianGe-ios. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <Foundation/Foundation.h>

@interface Project : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *GroupingID;
@property (nonatomic, copy) NSString *Material_Name;
@property (nonatomic, copy) NSString *IsShow;
@property (nonatomic, copy) NSString *Note;
@property (nonatomic, copy) NSString *Video_url;
@property (nonatomic, copy) NSString *Xml_url;
@property (nonatomic, copy) NSString *XmlName;
@property (nonatomic, copy) NSString *VideoName;

@property(nonatomic,assign)BOOL qchexk;

+ (instancetype)projectWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
