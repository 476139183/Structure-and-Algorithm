//
//  CX_MODEL.m
//  LEDAD
//
//  Created by chengxu on 15/7/23.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "CX_MODEL.h"
#import "AHReach.h"
#import "Config.h"
#import <SystemConfiguration/CaptiveNetwork.h>
@implementation CX_MODEL

+ (NSString *)getWifiName
{
    NSString *wifiName = @"Not Found";

    CFArrayRef myArray = CNCopySupportedInterfaces();

    if (myArray != nil) {

        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));

        if (myDict != nil) {

            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);



            wifiName = [dict valueForKey:@"SSID"];

        }

    }
    
    NSLog(@"wifiName:%@", wifiName);
    return wifiName;
}

-(void)wifi{
    AHReach *defaultHostReach = [AHReach reachForDefaultHost];
    [defaultHostReach startUpdatingWithBlock:^(AHReach *reach) {
        [self updateAvailabilityField:nil withReach:reach];
    }];
    [self updateAvailabilityField:nil withReach:defaultHostReach];
}

- (void)updateAvailabilityField:(UITextField *)field withReach:(AHReach *)reach {
    if (ConnectionStatus == nil) {
        ConnectionStatus = [[NSMutableArray alloc]init];
    }else{
        [ConnectionStatus removeAllObjects];
    }
    if([reach isReachableViaWiFi]){
        DLog(@"已连接wifi");
        [ConnectionStatus addObject:@"OK"];
    }else{
        DLog(@"未连接");
        [ConnectionStatus addObject:@"NO"];
    }
}



@end
