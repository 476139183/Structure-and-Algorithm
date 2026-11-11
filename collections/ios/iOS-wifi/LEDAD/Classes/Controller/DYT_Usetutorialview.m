//
//  DYT_Usetutorialview.m
//  LEDAD
//
//  Created by laidiya on 15/8/5.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_Usetutorialview.h"
#import "DYT_Usetutorialtable.h"
#import "Config.h"

@implementation DYT_Usetutorialview
-(id)initWithFrame:(CGRect)frame
{

    
    self = [super initWithFrame:frame];
    if (self) {
        [self _setview];
    }
    return self;

}

-(void)_setview
{
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    UILabel *toptitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, topview.frame.size.width, topview.frame.size.height)];
    toptitle.text =[Config DPLocalizedString:@"Button_syproject"];
    toptitle.font = [UIFont systemFontOfSize:20];
    toptitle.textAlignment = NSTextAlignmentCenter;
    topview.backgroundColor =[UIColor cyanColor];
    [topview addSubview:toptitle];
    [self addSubview:topview];
    
    
    DYT_Usetutorialtable *table = [[DYT_Usetutorialtable alloc]initWithFrame:CGRectMake(0, topview.frame.size.height, self.frame.size.width, self.frame.size.height - topview.frame.size.height) anddeleta:self];
    
    [table remodata];
    
    [self addSubview:table];
    
    
    
    
    
    
    
    
    
    
    
    
    
//    myscrollview = [[DYT_myuserScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
////    myscrollview.backgroundColor = [UIColor redColor];
//    [self addSubview:myscrollview];
    


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
