//
//  ChenXuNeedDemos.m
//  TestSixViedo
//
//  Created by 安静。 on 15/4/13.
//  我叫小安静，我是一名iOS开发菜鸟，欢迎加我qq379255484  也欢迎致电喷我 18603048453
//  我是小安静我怕谁。
//  Copyright (c) 2015年 lingtele. All rights reserved.
//

#import "ChenXuNeedDemos.h"
#import "PlayView.h"
#import <AVFoundation/AVFoundation.h>

//获得物理屏幕的宽
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface ChenXuNeedDemos (){


}

@property (strong,nonatomic)   PlayView * thePlayer;
@property (strong,nonatomic)  AVPlayer *avPlayer;


@end

@implementation ChenXuNeedDemos

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (_filePath.length == 0) {
        [self showAlertView:@"对不起，获取路径失败了"];
    }else{
        NSString *str = [[[[_filePath componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] lastObject];
        if ([str isEqualToString:@"PNG"] || [str isEqualToString:@"png"] || [str isEqualToString:@"JPG"] || [str isEqualToString:@"jpg"]) {
            [self img:_filePath];
        }
        [self playMovie:_filePath];
    
    }
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)img:(NSString *)filepath{
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(50, 0, self.view.frame.size.height/640*192, self.view.frame.size.height)];
    [img setImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:_filePath]]];
    [self.view addSubview:img];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclick1)];
    [img addGestureRecognizer:tap];
}

-(void)onclick1{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playMovie:(NSString *)fileName
{

        
//        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp4"];
        NSURL *url = [NSURL fileURLWithPath:fileName];
        AVPlayerItem *_itemone = [[AVPlayerItem alloc]initWithURL:url];
        //
        _avPlayer = [[AVPlayer alloc]initWithPlayerItem:_itemone];
        
    CGRect frame;
    frame = CGRectMake(50, 0, self.view.frame.size.height/640*192, self.view.frame.size.height);
//    if (kScreenWidth >  320 && kScreenWidth < 400 ){
//        
//        //6的适配
//        frame = CGRectMake(50, 0, 192, self.view.frame.size.height);
//
//        
//    }else if (kScreenWidth>400) {
//        //6+的适配
//        frame = CGRectMake(50, 0, 192, self.view.frame.size.height);
//
//    
//    }else{
//    
//        //5s  4s的适配
//        frame = CGRectMake(50, 0, self.view.frame.size.height/640*192, self.view.frame.size.height);
//
//    
//    }
        _thePlayer = [[PlayView alloc]initWithFrame:frame];
    
        _thePlayer.player = _avPlayer;
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclick)];
    [_thePlayer addGestureRecognizer:tap];
        
        
    [self.view addSubview:_thePlayer];
    
        [ _avPlayer play];
        
        //注册通知   当播放结束后执行  runLoopTheMovie方法
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    
}//播放视频调用该方法

//退出播放
-(void)onclick{
    [_avPlayer pause];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)runLoopTheMovie:(NSNotification *)notification
{
    //注册的通知  可以自动把 AVPlayerItem 对象传过来，只要接收一下就OK
    
    AVPlayerItem * p = [notification object];
    //关键代码
    [p seekToTime:kCMTimeZero];
    
    [_thePlayer.player play];
    
    
}//注册通知执行的方法


#pragma mark - showAlertView
-(void)showAlertView:(NSString*)showString
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:showString delegate:nil  cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:2.0];
    
    
    
}//温馨提示



- (void)dimissAlert:(UIAlertView *)alert
{
    if(alert)
    {
        
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
        
    }
}//温馨提示



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
