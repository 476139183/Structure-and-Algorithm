//
//  AppDelegate.m
//  YTColorfulRefresh
//
//  Created by 段雨田 on 2020/4/27.
//  Copyright © 2020 段雨田. All rights reserved.
//  参考 ：https://www.jianshu.com/p/6d6573fbd60b

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  if (@available(iOS 13.0, *)) {

      
  } else {
      
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
         
    [self.window setBackgroundColor:[UIColor whiteColor]];
        
    ViewController *con = [[ViewController alloc] init];
        
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:con];
       
    [self.window setRootViewController:nav];
        
    [self.window makeKeyAndVisible];
     
  }

  return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
  // Called when a new scene session is being created.
  // Use this method to select a configuration to create the new scene with.
  return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
  // Called when the user discards a scene session.
  // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
  // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
