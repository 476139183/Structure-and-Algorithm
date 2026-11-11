//
//  DYT_soureCollectionViewCell.h
//  LEDAD
//   网格cell
//  Created by laidiya on 15/7/24.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^addBlockButton)(NSString *str);
typedef void(^lookBlockButton)(NSString *str);

@interface DYT_soureCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)NSString *myip;
@property(nonatomic,strong)UIImageView *headview;
@property(nonatomic,strong)UIButton *lookbutton;
@property(nonatomic,strong)UIButton *addbutton;
@property(nonatomic,strong)NSMutableArray *sourearray;
@property(nonatomic,assign)NSInteger mytag;
@property(nonatomic,copy)addBlockButton addbut;
@property(nonatomic,copy)lookBlockButton lookbut;
- (void)addButtonAction:(addBlockButton)block;
-(void)lookButtonAction:(lookBlockButton)block;

@end
