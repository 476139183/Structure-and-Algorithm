//
//  ViewController.m
//  ios  WIFE
//
//  Created by duanyutian on 15/9/6.
//  Copyright (c) 2015年 yutianduan. All rights reserved.
//

#import "ViewController.h"
#import <corefoundation/corefoundation.h>

#import <unistd.h>

#import <systemconfiguration/captivenetwork.h>


#include <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#include <netdb.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import "getgateway.h"
#import <arpa/inet.h>



//#import <Apple80211.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSLog(@"ip地址=======%@",[ViewController  localIPAddress]);
  NSLog(@"wifi信息=====%@",[self getWIFIDic]);
  NSLog(@"wifi名字=====%@",[ViewController getWifiName]);
  NSLog(@"wifi信息其二=========%@",[self fetchSSIDInfo]);
  NSLog(@"SSID===%@",[self getDeviceSSID]);

  UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
  button.backgroundColor = [UIColor redColor];
  [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)click {
  NSLog(@"ip地址===%@",[self routerIp]);
}


+ (NSString *)localIPAddress {
  NSString *localIP = nil;
  struct ifaddrs *addrs;
  if (getifaddrs(&addrs) == 0) {
    const struct ifaddrs *cursor = addrs;
    while (cursor != NULL) {
      if (cursor->ifa_addr->sa_family == AF_INET
          && (cursor->ifa_flags & IFF_LOOPBACK) == 0) {
        NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
        if ([name isEqualToString:@"en0"]) {
          // Wi-Fi adapter
          localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
          break;
        }
      }
      cursor = cursor->ifa_next;
    }
    freeifaddrs(addrs);
  }
  return localIP;
}

- (NSDictionary *)getWIFIDic {
  CFArrayRef myArray = CNCopySupportedInterfaces();
  if (myArray != nil) {
    CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
    if (myDict != nil) {
      NSDictionary *dic = (NSDictionary*)CFBridgingRelease(myDict);
      return dic;
    }
  }
  return nil;
}

- (NSString *)getBSSID {
  NSDictionary *dic = [self getWIFIDic];
  if (dic == nil) {
    return nil;
  }
  return dic[@"BSSID"];
}

- (NSString *)getSSID {
  NSDictionary *dic = [self getWIFIDic];
  if (dic == nil) {
    return nil;
  }
  return dic[@"SSID"];
}


- (void)registerNetwork:(NSString *)ssid {
  NSString *values[] = {ssid};
  CFArrayRef arrayRef = CFArrayCreate(kCFAllocatorDefault,(void *)values,
                                      (CFIndex)1, &kCFTypeArrayCallBacks);
  if( CNSetSupportedSSIDs(arrayRef)) {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    CNMarkPortalOnline((__bridge CFStringRef)(ifs[0]));
    NSLog(@"wifi===%@", ifs);
  }
  
  
}

//iOS获取当前连接wifi名
- (NSString *)getCurrentWifiName {
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


//</corefoundation></systemconfiguration>
//通过官方的API 可以获取到wifi的信息，实现代码： 搜索
- (id)fetchSSIDInfo {
  NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
  NSLog(@"Supported interfaces: %@", ifs);
  id info = nil;
  for (NSString *ifnam in ifs) {
    info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
    NSLog(@"%@ => %@", ifnam, info);
    if (info && [info count]) { break; }
  }
  return info;
}


+ (NSString *)getWifiName {
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


//- (void)scanNetworks
//{
//    NSLog(@"Scanning WiFi Channels...");
//    NSDictionary *parameters = [[NSDictionary alloc] init];
//    NSArray *scan_networks; //is a CFArrayRef of CFDictionaryRef(s) containing key/value data on each discovered network
//    apple80211Scan(airportHandle, &amp;scan_networks, parameters);
//    // NSLog(@"===--======\n%@",scan_networks);
//    networks = ［NSMutableDictionary alloc] init];
//    networkDicts = [NSMutableArray array];
//    for (int i = 0; i &lt; [scan_networks count]; i++) {
//        [networks setObject:[scan_networks objectAtIndex: i] forKey:［scan_networks objectAtIndex: i] objectForKey:@"BSSID"］;
//        [networkDicts addObject:[scan_networks objectAtIndex: i］;
//                                 }
//                                 NSLog(@"Scanning WiFi Channels Finished.");
//}



/******************************************************************
 Name:        iSTCClientOpen
 Description: open a socket for wifi
 ******************************************************************/
//int iSTCClientOpen(void)
//{
//
//    Client_t *pClient = (Client_t *)calloc(1, sizeof(Client_t));
//
//    if (pClient != NULL)
//    {
//        pClient->sockFd = socket(AF_INET, SOCK_STREAM, 0);
//        if (pClient->sockFd < 0)
//        {
//            printf("@err: socket() for Send\n");
//            goto fail;
//        }
//
//        pClient->thisAddr.sin_family = AF_INET;
//        pClient->thisAddr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
//        pClient->thisAddr.sin_port = ntohs(INADDR_ANY);
//
//        if (bind(pClient->sockFd, (struct sockaddr *) &pClient->thisAddr, sizeof(pClient->thisAddr)) < 0)
//        {
//            printf("@err: bind error(%x).\n", errno);
//            goto fail;
//        }
//
//        pClient->peerAddr.sin_family = AF_INET;
//        pClient->peerAddr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
//        pClient->peerAddr.sin_port = ntohs(DEFAULT_PORT);
//
//        if (connect(pClient->sockFd, (struct sockaddr *)&pClient->peerAddr, sizeof(pClient->peerAddr)) < 0)
//        {
//            printf("@err: connect %d:%s\n", errno,strerror(errno));
//            goto fail;
//        }
//    }
//
//    return (int)pClient;
//
//fail:
//    if (pClient)
//    {
//        if (pClient->sockFd >= 0)
//            close(pClient->sockFd);
//        free(pClient);
//    }
//
//    return 0;
//}
//
//int iSTC_WIFI_Connect(char *ESSID, char *Password,int Encryptiontype, char *ifname, int timeout)
//{
//    int ret = -1;
//    int len;
//    char buf[256];
//    int cid = iSTCClientOpen();
//    if(cid == 0)
//    {
//        return -1;
//    }
//    Client_t *pClient = (Client_t *)cid;
//
//    iSTCHead_t *pHead = (iSTCHead_t *)buf;
//    iSTCWifiConnect_t *pConnect = (iSTCWifiConnect_t *)pHead->data;
//
//    strncpy(pConnect->ESSID, ESSID,sizeof(pConnect->ESSID));
//    strncpy(pConnect->Password, Password,sizeof(pConnect->Password));
//#ifndef USEISTCDAEMON
//    strncpy(pConnect->ifname,ifname,sizeof(pConnect->ifname));
//    pConnect->Encryption_type = Encryptiontype;
//#endif
//    pConnect->timeout = timeout;
//
//    pHead->version  = iSTC_VERSION;
//    pHead->type     = iSTC_TYPE_REQUEST;
//    pHead->length   = sizeof(iSTCWifiConnect_t);
//    pHead->seq      = 0;
//    pHead->command  = iSTC_CMD_WIFI_CONNECT;
//    pHead->checksum = 0;
//    printf("Encryptiontype %d ,%d,%d\n",Encryptiontype,sizeof(iSTCHead_t),pHead->length);
//    len = send(pClient->sockFd, pHead, sizeof(iSTCHead_t) + pHead->length, 0);
//    if (len != sizeof(iSTCHead_t) + pHead->length) goto bye;
//    printf("send over\n");
//    len = read(pClient->sockFd, pHead, sizeof(iSTCHead_t));
//    if (len != sizeof(iSTCHead_t)) goto bye;
//    printf("read over\n");
//    if (pHead->response == iSTC_OK)
//        ret = 0;
//    else
//        ret = -1;
//    if(pHead->response == iSTC_ERROR_SYSTEM)
//    {
//        printf("----------------wpa error ---------\n");
//        system("killall wpa_cli\n");
//        system("killall wpa_supplicant\n");
//        sleep(1);
//        system("wpa_supplicant -B -c /etc/wpa_supplicant/wpa_supplicant.conf -i wlan0\n");
//        sleep(1);
//        system("wpa_cli &\n");
//    }
//bye:
//    iSTCClientClose(cid);
//    return ret;
//}
//

- (NSString *) routerIp {
  
  NSString *address = @"error";
  struct ifaddrs *interfaces = NULL;
  struct ifaddrs *temp_addr = NULL;
  int success = 0;
  
  // retrieve the current interfaces - returns 0 on success
  success = getifaddrs(&interfaces);
  if (success == 0) {
    // Loop through linked list of interfaces
    temp_addr = interfaces;
    //*/
    while(temp_addr != NULL) {
    /*/
     int i=255;
     while((i--)>0)
     //*/
    
      if(temp_addr->ifa_addr->sa_family == AF_INET) {
        // Check if interface is en0 which is the wifi connection on the iPhone
        if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
          // Get NSString from C String //ifa_addr
          //ifa->ifa_dstaddr is the broadcast address, which explains the "255's"
          //                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
          
          address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
          
          //routerIP----192.168.1.255 广播地址
          NSLog(@"broadcast address--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)]);
          //--192.168.1.106 本机地址
          NSLog(@"local device ip--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]);
          //--255.255.255.0 子网掩码地址
          NSLog(@"netmask--%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)]);
          //--en0 端口地址
          NSLog(@"interface--%@",[NSString stringWithUTF8String:temp_addr->ifa_name]);
          
        }
        
      }
      
      temp_addr = temp_addr->ifa_next;
    }
  }
  
  // Free memory
  freeifaddrs(interfaces);
  
  in_addr_t i =inet_addr([address cStringUsingEncoding:NSUTF8StringEncoding]);
  in_addr_t* x =&i;
  
  
  unsigned char *s=getdefaultgateway(x);
  NSString *ip=[NSString stringWithFormat:@"%d.%d.%d.%d",s[0],s[1],s[2],s[3]];
  free(s);
  NSLog(@"ip=====%@",ip);
  return ip;
}

- (NSString *) getDeviceSSID {
  NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
  
  id info = nil;
  for (NSString *ifnam in ifs) {
    info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
    if (info && [info count]) {
      break;
    }
  }
  
  NSDictionary *dctySSID = (NSDictionary *)info;
  NSString *ssid = [[dctySSID objectForKey:@"SSID"] lowercaseString];
  
  return ssid;
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end

