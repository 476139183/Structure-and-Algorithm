//
//  Book.m
//  ReactiveCocoa
//
//  Created by yz on 15/10/6.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "Book.h"

@implementation Book

+ (instancetype)bookWithDict:(NSDictionary *)dict
{
    Book *book = [[Book alloc] init];
    
    book.title = dict[@"title"];
    book.subtitle = dict[@"subtitle"];
    return book;
}

@end
