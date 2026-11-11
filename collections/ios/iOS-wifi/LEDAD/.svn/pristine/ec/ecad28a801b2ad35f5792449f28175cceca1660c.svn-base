//
//  JsonToObjectAdapter.m
//  ZDEC
//
//  Created by yixingman on 9/6/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import "JsonToObjectAdapter.h"
#import "ComplaintEntity.h"
//#import "GeneralDatabaseOperation.h"
#import "UserInfoEntity.h"
#import "MyTool.h"


@implementation JsonToObjectAdapter
+(NSArray*)customerJsonToObject:(NSString*)jsonStr{
//    //客户信息
//    @try {
//        NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:1];
//        if (jsonStr==nil) {
//            return arr;
//        }
//        jsonStr =[jsonStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
//        NSDictionary *jsonDict = [jsonStr JSONValue];
//        if (![jsonDict isKindOfClass:[NSDictionary class]]) {
//            return arr;
//        }
//        NSArray *cus_list_Array = [jsonDict objectForKey:@"cus_list"];
//        if (![cus_list_Array isKindOfClass:[NSArray class]]) {
//            return arr;
//        }else{
//            [arr removeAllObjects];
//            GeneralDatabaseOperation *dbOperation = [[GeneralDatabaseOperation alloc]init];
//            for (NSDictionary *one_cus in cus_list_Array) {
//                UserInfoEntity *cus = [[UserInfoEntity alloc]init];
//                cus.user_sid = [one_cus objectForKey:@"cus_id"];
//                cus.user_name = [one_cus objectForKey:@"cus_name"];
//                cus.user_position = [one_cus objectForKey:@"cus_position"];
//                cus.user_headimg = [one_cus objectForKey:@"cus_headimg"];
//
//                cus.user_phone = [one_cus objectForKey:@"cus_tel"];
//                cus.user_email = [one_cus objectForKey:@"cus_email"];
//                cus.user_qq = [one_cus objectForKey:@"cus_qq"];
//                cus.user_company = [one_cus objectForKey:@"cus_company"];
//                cus.cus_is_active = [one_cus objectForKey:@"cus_is_active"];
//                //需要存储客户信息数据
//                cus.is_salesman=@"0";
//                [dbOperation saveUserInfoEntityData:cus];
//                [arr addObject:cus];
//            }
//            return arr;
//        }
//    }
//    @catch (NSException *exception) {
//        DLog(@"%@",exception);
//    }
//    @finally {
//        
//    }
//}
//
    return nil;
}


+(NSArray*)customerRepairJsonToObject:(NSString*)jsonStr{
//    //客户服务申请记录
//    NSMutableArray *customerRepairarr = [[NSMutableArray alloc]initWithCapacity:0];
//    if (jsonStr==nil) {
//        return customerRepairarr;
//    }
//    jsonStr =[jsonStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
//    NSDictionary *jsonDict = [jsonStr JSONValue];
//    if (![jsonDict isKindOfClass:[NSDictionary class]]) {
//        return customerRepairarr;
//    }
//    NSArray *cus_list_Array = [jsonDict objectForKey:@"apply_list"];
//    if (![cus_list_Array isKindOfClass:[NSArray class]]) {
//        return customerRepairarr;
//    }else{
//        GeneralDatabaseOperation *dbOperation = [[GeneralDatabaseOperation alloc]init];
//        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//        for (NSDictionary *one_cus in cus_list_Array) {
//            RepairEntity *mycus = [[RepairEntity alloc]init];
//            mycus.cus_company = [one_cus objectForKey:@"company"];
//            mycus.apply_company = [one_cus objectForKey:@"cus_company"];
//            mycus.apply_id = [one_cus objectForKey:@"apply_id"];
//            mycus.cus_name = [one_cus objectForKey:@"cus_name"];
//            mycus.cus_tel = [one_cus objectForKey:@"cus_tel"];
//            mycus.jj_no = [one_cus objectForKey:@"jj_no"];
//            mycus.tl_no = [one_cus objectForKey:@"tl_no"];
//            mycus.pro_name = [one_cus objectForKey:@"pro_name"];
//            mycus.pro_type = [one_cus objectForKey:@"pro_type"];
//            mycus.pro_date = [one_cus objectForKey:@"pro_date"];
//            mycus.pcb_no = [one_cus objectForKey:@"pcb_no"];
//            mycus.num = [one_cus objectForKey:@"num"];
//            mycus.description = [one_cus objectForKey:@"description"];
//            mycus.price = [one_cus objectForKey:@"price"];
//            mycus.repair_no = [one_cus objectForKey:@"repair_no"];
//            mycus.cus_headimg = [one_cus objectForKey:@"cus_headimg"];
//            mycus.apply_date = [one_cus objectForKey:@"time"];
//            mycus.apply_type = [one_cus objectForKey:@"apply_type"];
//            mycus.repair_state = [one_cus objectForKey:@"repair_state"];
//            mycus.fee = [one_cus objectForKey:@"fee"];
//            mycus.fast_mail_no = [one_cus objectForKey:@"fast_mail_no"];
//            mycus.linkman = [one_cus objectForKey:@"linkman"];
//
//            mycus.service_address = [one_cus objectForKey:@"service_address"];
//            mycus.mtype = [one_cus objectForKey:@"mtype"];
//            mycus.liveImage = [one_cus objectForKey:@"image"];
//            mycus.pro_description = [one_cus objectForKey:@"pro_description"];
//            mycus.tro_description = [one_cus objectForKey:@"tro_description"];
//            mycus.salekey = [ud objectForKey:@"key"];
//            mycus.mid = [ud objectForKey:@"mid"];
//            mycus.apply_tel = [one_cus objectForKey:@"tel"];
//            mycus.isread = @"0";
//            //需要本地存储数据，为查看服务申请记录做基础
//            [dbOperation saveRepairEntity:mycus];
//            [customerRepairarr addObject:mycus];
//        }
//        return customerRepairarr;
//    }
//}
    return nil;
}

+(NSArray*)complaintJsonToObject:(NSString*)jsonStr{
//    //投诉记录
//    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:1];
//    if (jsonStr==nil) {
//        return arr;
//    }
//    jsonStr =[jsonStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
//    NSDictionary *jsonDict = [jsonStr JSONValue];
//    if (![jsonDict isKindOfClass:[NSDictionary class]]) {
//        return arr;
//    }
//    NSArray *cus_list_Array = [jsonDict objectForKey:[ComplaintEntity forkey]];
//    if (![cus_list_Array isKindOfClass:[NSArray class]]) {
//        return arr;
//    }else{
//        [arr removeAllObjects];
//        GeneralDatabaseOperation *dbOperation = [[GeneralDatabaseOperation alloc]init];
//        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//        NSString *keyString = [ud objectForKey:@"key"];
//        for (NSDictionary *one_cus in cus_list_Array) {
//            ComplaintEntity *cus = [[ComplaintEntity alloc]init];
//            cus.complaint_id = [one_cus objectForKey:@"complaint_id"];
//            cus.cus_name = [one_cus objectForKey:@"cus_name"];
//            cus.cus_position = [one_cus objectForKey:@"cus_position"];
//            cus.cus_headimg = [one_cus objectForKey:@"cus_headimg"];
//            cus.complaint_date = [one_cus objectForKey:@"complaint_date"];
//            cus.complaint_inf = [one_cus objectForKey:@"complaint_info"];
//            cus.cus_company = [one_cus objectForKey:@"cus_company"];
//            cus.salekey = keyString;
//            //需要存储客户的投诉信息
//            [dbOperation savecomplaintEntity:cus];
//            [arr addObject:cus];
//        }
//        return arr;
//    }
    return nil;
}


+(NSArray*)contactsJsonToObject:(NSString*)jsonStr{
    //公司通讯录
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:1];
    if (jsonStr==nil) {
        return arr;
    }
    //过滤字符串中的null
    jsonStr =[jsonStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
    NSDictionary *jsonDict = [jsonStr JSONValue];
    if (![jsonDict isKindOfClass:[NSDictionary class]]) {
        return arr;
    }
    NSArray *cus_list_Array = [jsonDict objectForKey:@"contacts_list"];
    if (![cus_list_Array isKindOfClass:[NSArray class]]) {
        return arr;
    }else{
        [arr removeAllObjects];
        for (NSDictionary *one_cus in cus_list_Array) {
            UserInfoEntity *contact = [[UserInfoEntity alloc]init];
            contact.user_sid = [one_cus objectForKey:@"emp_id"];
            contact.user_headimg = [one_cus objectForKey:@"emp_headimg"];
            contact.user_name = [one_cus objectForKey:@"emp_name"];
            contact.user_position = [one_cus objectForKey:@"emp_position"];
            contact.user_sign = [one_cus objectForKey:@"emp_sign"];
            contact.user_phone = [one_cus objectForKey:@"emp_tel"];
            contact.user_email = [one_cus objectForKey:@"emp_email"];
            contact.user_qq = [one_cus objectForKey:@"emp_qq"];
            contact.user_company = [one_cus objectForKey:@"emp_company"];
            [arr addObject:contact];
        }
        return arr;
    }
}

+(NSArray*)salesJsonToObject:(NSString*)jsonStr{
//    //销售员列表
//    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:1];
//    if (jsonStr==nil) {
//        return arr;
//    }
//    jsonStr =[jsonStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
//    NSDictionary *jsonDict = [jsonStr JSONValue];
//    if (![jsonDict isKindOfClass:[NSDictionary class]]) {
//        return arr;
//    }
//    NSArray *cus_list_Array = [jsonDict objectForKey:@"sale_list"];
//    if (![cus_list_Array isKindOfClass:[NSArray class]]) {
//        return arr;
//    }else{
//        [arr removeAllObjects];
//        GeneralDatabaseOperation *dbOperation = [[GeneralDatabaseOperation alloc]init];
//        for (NSDictionary *one_cus in cus_list_Array) {
//            UserInfoEntity *sales = [[UserInfoEntity alloc]init];
//            sales.user_sid = [one_cus objectForKey:@"sale_id"];
//            sales.user_headimg = [one_cus objectForKey:@"sale_headimg"];
//            sales.user_name = [one_cus objectForKey:@"sale_name"];
//            sales.user_position = [one_cus objectForKey:@"sale_position"];
//            sales.user_sign = [one_cus objectForKey:@"sale_sign"];
//            sales.user_phone = [one_cus objectForKey:@"sale_tel"];
//            sales.user_email = [one_cus objectForKey:@"sale_email"];
//            sales.user_qq = [one_cus objectForKey:@"sale_qq"];
//            sales.user_company = [one_cus objectForKey:@"sale_company"];
//            sales.user_company = [one_cus objectForKey:@"sale_company"];
//            sales.is_salesman = @"1";
//            [dbOperation saveUserInfoEntityData:sales];
//            [arr addObject:sales];
//        }
//        return arr;
//    }
//}
    return nil;
}

+(CompanyContactsEntity*)oneContactJsonToObject:(NSString*)jsonStr{
    //单个用户信息
    CompanyContactsEntity *comeTmp = [[CompanyContactsEntity alloc]init];
    if (jsonStr==nil) {
        return comeTmp;
    }
    NSDictionary *jsonDict = [jsonStr JSONValue];
    if (![jsonDict isKindOfClass:[NSDictionary class]]) {
        return comeTmp;
    }
    NSDictionary *cus_list_Array = [jsonDict objectForKey:[CompanyContactsEntity forkey]];
    DLog(@"%@",cus_list_Array);
    if (![cus_list_Array isKindOfClass:[NSDictionary class]]) {
        return comeTmp;
    }else{
        return nil;
    }
}

+(void)saveLoginInformation:(NSDictionary*)userDict{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (userDict==nil) {
        return;
    }
    
    //存储头像到本地
    [MyTool writeImageCacheRequestUrl:[userDict objectForKey:@"user_image"]];
    
    if ([userDict objectForKey:@"user_image"]!=nil) {
        [ud setObject:[userDict objectForKey:@"user_image"] forKey:@"user_image"];
    }
    [ud setObject:[userDict objectForKey:@"user_num"] forKey:@"user_num"];
    [ud setObject:[userDict objectForKey:@"user_mail"] forKey:@"user_mail"];
    
    
    //用户登录之后保存用户的别名
    if ([userDict objectForKey:@"user_alias"]!=nil) {
        [ud setObject:[userDict objectForKey:@"user_alias"] forKey:USER_ALIAS];
    }
    if ([userDict objectForKey:@"role_id"]!=nil) {
        [ud setObject:[userDict objectForKey:@"role_id"] forKey:USER_ROLE_ID];
    }
    [ud setObject:[userDict objectForKey:@"user_status"] forKey:@"user_status"];
    [ud setObject:[userDict objectForKey:@"user_id"] forKey:@"user_id"];
    [ud setObject:[userDict objectForKey:@"user_code"] forKey:@"user_code"];
    [ud setObject:[userDict objectForKey:@"user_id"] forKey:@"user_id"];
    [ud setObject:[userDict objectForKey:@"user_name"] forKey:@"user_name"];
    [ud setObject:[userDict objectForKey:@"user_sign"] forKey:@"user_sign"];
    [ud setObject:[userDict objectForKey:@"user_company"] forKey:@"user_company"];
    [ud synchronize];

}
@end
