//
//  HeadView.h
//  QQ好友列表
//
//  Created by TianGe-ios on 14-8-21.
//  Copyright (c) 2014年 TianGe-ios. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>
@class Group;

@protocol HeadViewDelegate <NSObject>

@optional
//点击展开或收
- (void)clickHeadView:(NSInteger)tag;
//选择框
-(void)chooseview:(NSInteger)tag andchoose:(BOOL)chex;
// 下载
-(void)downloadview:(NSInteger)tag;
//上传
-(void)uploadview:(NSInteger)tag;


@end

@interface HeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) Group *group;
@property(nonatomic,assign)NSInteger mytag;
@property (nonatomic, weak) id<HeadViewDelegate> delegate;
@property (nonatomic,assign)BOOL qchek;;
@property(nonatomic,copy)UIButton *choose;
+ (instancetype)headViewWithTableView:(UITableView *)tableView;

@end
