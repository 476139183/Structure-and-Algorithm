//
//  AppDelegate.h
//  简单的贝塞尔路径绘图
//
//  Created by Yutian Duan on 2018/3/27.
//  Copyright © 2018年 duanyutian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

