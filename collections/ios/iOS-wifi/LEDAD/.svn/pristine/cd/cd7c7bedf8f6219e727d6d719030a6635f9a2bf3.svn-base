//
//  DYT_soureCollectionViewCell.m
//  LEDAD
//
//  Created by laidiya on 15/7/24.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_soureCollectionViewCell.h"
#import "Config.h"

@implementation DYT_soureCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:[self addview]];
        self.sourearray = [[NSMutableArray alloc]init];
        
        
        
    }
    return self;
    

}
-(UIView *)addview
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    

    self.title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,view.frame.size.width, 20)];
    [view addSubview:self.title];
    
    self.headview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, view.frame.size.width, view.frame.size.height-70)];
    self.headview.image = [UIImage imageNamed:@"LEDYES"];
    [view addSubview:self.headview];
    
    self.lookbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.headview.frame.size.height+20, view.frame.size.width, 20)];
    [self.lookbutton setTitle:[Config DPLocalizedString:@"adedit_ck"] forState:UIControlStateNormal];
    [self.lookbutton addTarget:self action:@selector(lookbutton:) forControlEvents:UIControlEventTouchUpInside];
    self.lookbutton.backgroundColor = [UIColor redColor];
    [view addSubview:self.lookbutton];
    
    self.addbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.lookbutton.frame.origin.y+25, view.frame.size.width, 20)];

    [self.addbutton addTarget:self action:@selector(addbutton:) forControlEvents:UIControlEventTouchUpInside];
    [self.addbutton setTitle:[Config DPLocalizedString:@"adedit_add"] forState:UIControlStateNormal];
    self.addbutton.backgroundColor = [UIColor redColor];
    [view addSubview:self.addbutton];
    
    return view;
}


-(void)lookbutton:(UIButton *)sender
{
    
    self.lookbut(@"1");
    

}

-(void)addbutton:(UIButton *)sender
{

    self.addbut(@"0");

}

- (void)addButtonAction:(addBlockButton)block;
{

    self.addbut = block;
    
}
-(void)lookButtonAction:(lookBlockButton)block;
{
    self.lookbut = block;


}


@end
