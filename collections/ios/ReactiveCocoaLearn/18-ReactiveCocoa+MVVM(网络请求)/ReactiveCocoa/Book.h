//
//  Book.h
//  ReactiveCocoa
//
//  Created by yz on 15/10/6.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *title;

+ (instancetype)bookWithDict:(NSDictionary *)dict;


@end
