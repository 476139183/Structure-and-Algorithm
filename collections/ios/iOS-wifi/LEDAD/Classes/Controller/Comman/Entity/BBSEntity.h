//
//  BBS.h
//  LED2Buy
//
//  Created by LDY on 14-7-16.
//  Copyright (c) 2014年 LDY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBSEntity : NSObject
{
    NSString *m_id;
    NSString *m_name;
    NSString *status;
    NSString *other;
    NSString *lang;
    NSString *companyid;
}

@property (nonatomic, retain) NSString *m_id;
@property (nonatomic, retain) NSString *m_name;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *other;
@property (nonatomic, retain) NSString *lang;
@property (nonatomic, retain) NSString *companyid;

@end
