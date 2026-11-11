//
//  ComplaintEntity.h
//  ZDEC
//  客户投诉信息
//  Created by yixingman on 9/7/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplaintEntity : NSObject
{
    NSString *complaint_id;//投诉编号
    NSString *cus_name; //客户名称
    NSString *cus_headimg; // 客户头像
    NSString *complaint_date; //(long时间戳)投诉的时间
    NSString *cus_company;//客户的公司
    NSString *cus_position;//客户的职位
    NSString *complaint_inf;//投诉的详细信息
    NSString *salekey;//销售员的key
    NSString *isread;//是否已读
}
@property (nonatomic,retain) NSString *complaint_id;
@property (nonatomic,retain) NSString *cus_name;
@property (nonatomic,retain) NSString *cus_headimg;
@property (nonatomic,retain) NSString *complaint_date; //(long时间戳)
@property (nonatomic,retain) NSString *cus_company;
@property (nonatomic,retain) NSString *cus_position;
@property (nonatomic,retain) NSString *complaint_inf;
@property (nonatomic,retain) NSString *salekey;
@property (nonatomic,retain) NSString *isread;
+(NSString *)forkey;
@end
