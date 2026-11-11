//
//  FriendGroup.m
//  QQ好友列表
//
//  Created by TianGe-ios on 14-8-21.
//  Copyright (c) 2014年 TianGe-ios. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "Group.h"
#import "Project.h"

@implementation Group

+ (instancetype) projectGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
        [self setValuesForKeysWithDictionary:dict];
    
        
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in _Materials) {
            Project *project = [Project projectWithDict:dict];
            [tempArray addObject:project];
        }
        _Materials = tempArray;
    
    
    return self;
}

@end
