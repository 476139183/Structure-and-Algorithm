//
//  RequestViewModel.h
//  ReactiveCocoa
//
//  Created by yz on 15/10/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
@interface RequestViewModel : NSObject<UITableViewDataSource>


// 请求命令
@property (nonatomic, strong, readonly) RACCommand *reuqesCommand;

//模型数组
@property (nonatomic, strong, readonly) NSArray *models;

// 控制器中的view
@property (nonatomic, weak) UITableView *tableView;

@end
