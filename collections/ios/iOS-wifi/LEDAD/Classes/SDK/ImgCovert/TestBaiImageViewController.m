//
//  TestBaiImageViewController.m
//  XCloudsManager
//  传入一张图片在图片上显示百叶窗效果
//  Created by yixingman on 14-7-2.
//
//

#import "TestBaiImageViewController.h"
#import "BaiImage.h"

@interface TestBaiImageViewController ()

@end

@implementation TestBaiImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    mdict = [[NSMutableDictionary alloc]init];
    // 调用下述函数分割图片，得到相应的dictionary，以不同的图片文件名作为key
    [mdict setDictionary:[BaiImage SeparateImage:[UIImage imageNamed:@"3613807_085323014942_2.jpg"] ByX:15 andY:1 cacheQuality:0.8]];

    [self performSelector:@selector(myTimerEvent) withObject:nil afterDelay:0];
}


-(void)createBaiYeWith:(UIImage *)srcImage{
    NSMutableDictionary *myBaiYeDict = [[NSMutableDictionary alloc]init];
    // 调用下述函数分割图片，得到相应的dictionary，以不同的图片文件名作为key
    [myBaiYeDict setDictionary:[BaiImage SeparateImage:srcImage ByX:15 andY:1 cacheQuality:0.8]];
    [self performSelector:@selector(myTimerEvent:) withObject:myBaiYeDict afterDelay:0];
}
-(void)myBaiYeTimerEvent:(NSDictionary *)myBaiYeDict{
    NSArray *keys = [myBaiYeDict allKeys];
    
    // 设置动画的各种参数
    CABasicAnimation *mrotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    mrotation.duration = 4.0;
    mrotation.fromValue=[NSNumber numberWithFloat:M_PI/1.5];
    mrotation.toValue=[NSNumber numberWithFloat:0];
    mrotation.timingFunction=[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    mrotation.autoreverses=YES;
    mrotation.repeatCount=9;
    
    
    // 给所有小图片添加动画
    for (int count=0; count<15; count++)
    {
        NSString *key = [keys objectAtIndex:count];
        UIImageView *imageView = [myBaiYeDict objectForKey:key];
        [imageView.layer addAnimation:mrotation forKey:@"rotation"];
        [self.view addSubview:imageView];
        [imageView release];
    }
}


-(void)myTimerEvent{
    NSArray *keys = [mdict allKeys];
    
    // 设置动画的各种参数
    CABasicAnimation *mrotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    mrotation.duration = 4.0;
    mrotation.fromValue=[NSNumber numberWithFloat:M_PI/1.5];
    mrotation.toValue=[NSNumber numberWithFloat:0];
    mrotation.timingFunction=[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    mrotation.autoreverses=YES;
    mrotation.repeatCount=9;

    
    // 给所有小图片添加动画
    for (int count=0; count<15; count++)
    {
        NSString *key = [keys objectAtIndex:count];
        UIImageView *imageView = [mdict objectForKey:key];
        [imageView.layer addAnimation:mrotation forKey:@"rotation"];
        [self.view addSubview:imageView];
        [imageView release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
