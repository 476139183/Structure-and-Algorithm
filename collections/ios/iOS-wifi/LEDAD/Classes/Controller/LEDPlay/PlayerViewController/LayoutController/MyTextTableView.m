//
//  MyTextTableView.m
//  MP4Play
//
//  Created by duanyutian on 15/4/16.
//  Copyright (c) 2015年 ZQWK. All rights reserved.
//

#import "MyTextTableView.h"
@interface MyTextTableView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *assets;

@end

@implementation MyTextTableView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource =self;
    }
    return self;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    return 10;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *indefi = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indefi];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indefi];
    }
    cell.backgroundColor = [UIColor redColor];
    return cell;


}
@end
