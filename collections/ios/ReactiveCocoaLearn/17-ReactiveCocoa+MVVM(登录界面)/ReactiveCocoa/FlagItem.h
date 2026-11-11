//
//  FlagItem.h
//  ReactiveCocoa
//
//  Created by yz on 15/9/25.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlagItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;

+ (instancetype)flagWithDict:(NSDictionary *)dict;

@end
