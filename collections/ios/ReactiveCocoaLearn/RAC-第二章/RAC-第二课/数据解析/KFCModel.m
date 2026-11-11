//
//  KFCModel.m
//  RAC-第二课
//
//  Created by Yutian Duan on 2018/11/16.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "KFCModel.h"

@implementation KFCModel

+ (instancetype)mj_keywithVaule:(NSDictionary *)dic {
  KFCModel *model = [[KFCModel alloc] init];
  [model setValuesForKeysWithDictionary:dic];
  return model;
}


@end
