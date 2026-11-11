//
//  KFCModel.h
//  RAC-第二课
//
//  Created by Yutian Duan on 2018/11/16.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFCModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

+ (instancetype)mj_keywithVaule:(NSDictionary *)dic;

@end
