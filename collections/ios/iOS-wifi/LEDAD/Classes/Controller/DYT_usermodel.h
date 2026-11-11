//
//  DYT_usermodel.h
//  LEDAD
//
//  Created by laidiya on 15/8/5.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYT_textandpic.h"
@interface DYT_usermodel : NSObject
@property(nonatomic,copy)NSString *titel;

@property(nonatomic,copy)NSString *imagename;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)CGRect datasize;
@property(nonatomic,strong)DYT_textandpic *mypic;
@end
