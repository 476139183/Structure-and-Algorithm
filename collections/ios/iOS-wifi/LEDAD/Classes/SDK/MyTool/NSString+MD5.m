//
//  NSString+MD5.m
//  DianXiaoEr
//
//  Created by 兴满 易 on 13-6-26.
//  Copyright (c) 2013年 YiXingMan. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString (MD5)  

- (NSString *)md5Encrypt {  
    const char *original_str = [self UTF8String];  
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);  
    NSMutableString *hash = [NSMutableString string];  
    for (int i = 0; i < 16; i++)
    {  
        [hash appendFormat:@"%02X", result[i]];  
    }
    return [hash lowercaseString];
}

- (NSString *)md5EncryptLower{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

- (NSString *)md5Encrypt:(NSString *)cryptKey{
    NSMutableString *crypt = [[NSMutableString alloc]initWithFormat:@"%@%@",[self md5Encrypt],cryptKey];
    return [crypt md5Encrypt];
}


@end  
