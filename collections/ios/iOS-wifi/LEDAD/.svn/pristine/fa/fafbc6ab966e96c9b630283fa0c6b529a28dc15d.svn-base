//
//  DYT_LanguageSettingViewViewController.m
//  LEDAD
//
//  Created by laidiya on 15/8/3.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_LanguageSettingViewViewController.h"
#import "BaseButton.h"
#import "Config.h"
@implementation DYT_LanguageSettingViewViewController
-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self _setbaseview];
    }
    return self;

}

-(void)_setbaseview
{

   
    
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [back setBackgroundImage: [UIImage imageNamed:@"dyt_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(upgback:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:back];

    [self setimagebutton];
    
    


}



-(void)setimagebutton
{

    
    
  UIView  *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-30)];
    [self addSubview:containerView];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height-30)];
    backgroundImageView.image = [UIImage imageNamed:@"LanguageBackground.png"];
    [containerView addSubview:backgroundImageView];

    
    
    NSArray *imagearr = [[NSArray alloc]initWithObjects:@"Language_SimplifiedChinese_Normal.png",@"Language_TraditionalChinese_Normal.png",@"Language_English_Normal.png", nil];
    NSArray *imageharr = [[NSArray alloc]initWithObjects:@"Language_SimplifiedChinese_Selected.png",@"Language_TraditionalChinese_Selected.png",@"Language_English_Selected.png" ,nil];
    titlearr = [[NSArray alloc]initWithObjects:@"zh-Hans",@"zh-Hant",@"en", nil];
    
    
    NSArray *name = [[NSArray alloc]initWithObjects:@"中文简体",@"中文繁体",@"英文", nil];
    
    for (int i=0; i<titlearr.count; i++) {
        
        BaseButton *button = [[BaseButton alloc]initWithFrame:CGRectMake(5, 95*i, 250, 90)];
        button.nametitle = name[i];
        
        button.tag =i+1000;
        [button setImage:[UIImage imageNamed:imagearr[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageharr[i]] forState:UIControlStateSelected];

        if ([languageString isEqualToString:titlearr[i]]) {
            
            button.selected = YES;
        }
        [button addTarget:self action:@selector(chooselanguange:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:button];
    }
    

    
    
    
}


-(void)chooselanguange:(BaseButton *)sender
{
//    当前语言为\"中文简体\",无需重复设置!
    
    UIAlertView *alertViewSelect;//选择语言

    if (sender.selected==YES) {
        
        alertViewSelect = [[UIAlertView alloc] initWithTitle:[Config DPLocalizedString:@"Tips"] message:[NSString stringWithFormat:@"当前语言为\"%@\",无需重复设置!",sender.nametitle] delegate:nil cancelButtonTitle:nil otherButtonTitles:[Config DPLocalizedString:@"User_OK"], nil];
        [alertViewSelect show];
    }else
    {
//        @"您确定要将应用语言更改为"
    
        alertViewSelect = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_zc19"] message:[NSString stringWithFormat:@"您确定要将应用语言更改为:%@吗?",sender.nametitle] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
//        nowlanguage = sender.nametitle;
        
        alertViewSelect.tag = sender.tag+1000;
        [alertViewSelect show];
    
    
    }

    

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex==0) {
        
        NSUserDefaults * language1 = [NSUserDefaults standardUserDefaults];
        languageString = titlearr[alertView.tag-2000];
        [language1 setObject:languageString forKey:LOCAL_LANGUAGE];
        
////        languageString = nowlanguage;
//        if (alertView.tag==2000) {
//            
//            languageString = @"zh-Hans";
//            DLog(@"选择的是中文");
//            
//            return;
//        }
//        if (alertView.tag==2001) {
//            languageString = @"zh-Hant";
//            DLog(@"选择的是繁体");
//            [language1 setObject:languageString forKey:LOCAL_LANGUAGE];
//           
//        }
        
    }
    
    
    
    [self removeFromSuperview];

     
}


-(void)upgback:(UIButton *)sender
{
    
    [self removeFromSuperview];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
