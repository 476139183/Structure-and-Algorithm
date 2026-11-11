//
//  DYT_uploadMaterial.m
//  LEDAD
//
//  Created by laidiya on 15/7/21.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_uploadMaterial.h"

@implementation DYT_uploadMaterial
-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *title = [[NSArray alloc]initWithObjects:@"1",@"2" ,@"3",nil];
        for (int i=0; i<3; i++) {
            UIButton *projetcbutton = [[UIButton alloc]initWithFrame:CGRectMake(10+70*i, 20, 60, 60)];
            [projetcbutton setTitle:title[i] forState:UIControlStateNormal];
            projetcbutton.backgroundColor = [UIColor redColor];
            projetcbutton.tag = 6100+i;
            [projetcbutton addTarget:self action:@selector(uploadmyproject:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:projetcbutton];
        }
        self.backgroundColor = [UIColor orangeColor];

    }
    return self;
    


}


-(void)uploadmyproject:(UIButton *)sender
{
    
    if (sender.tag==6100) {
        
        
        
    }
    
    if (sender.tag==6101) {
        
        
        
    }
    
    if (sender.tag==6103) {
        
        
        
        
    }
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
