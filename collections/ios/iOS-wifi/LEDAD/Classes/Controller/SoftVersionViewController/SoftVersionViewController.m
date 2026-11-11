//
//  SoftVersionViewController.m
//  版本信息的类文件
//  Created by LDY on 13-9-17.
//
//

#import "SoftVersionViewController.h"
#import "BaseUILabel.h"
#import "Config.h"
#import "ASIHTTPRequest.h"
#import "AHAlertView.h"
#import "NSString+SBJSON.h"


@interface SoftVersionViewController ()

@end

@implementation SoftVersionViewController

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
    CGRect rectContainerView = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-20);
    if (OS_VERSION_FLOAT>7.9) {
        rectContainerView = CGRectMake(0, 0, self.view.frame.size.width-320,self.view.frame.size.height-20);
    }
    containerView = [[UIView alloc]initWithFrame:rectContainerView];
    [self.view addSubview:containerView];
    
    NSString *topnavistr=[[NSString alloc]initWithFormat:@"置顶横条"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:topnavistr]];
    titleImageView.frame = CGRectMake(0, 0, containerView.frame.size.width, 44);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, containerView.frame.size.width, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [Config DPLocalizedString:@"Soft_SoftVersion"];//@"软件版本"
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleImageView addSubview:titleLabel];
    [titleLabel release];
    [containerView addSubview:titleImageView];
    [titleImageView release];
    
    UIImageView *versionImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"version.png"]];
    versionImageView.frame = CGRectMake(207, 182, 290, 218);
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(versionImageView.frame.origin.x, versionImageView.frame.origin.y+versionImageView.frame.size.height, 290, 80)];//@"版本  V3.2.0"
    versionLabel.text = @"Version4.2.0";
    versionLabel.textColor = [UIColor blackColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = [UIFont systemFontOfSize:30];
    
    UILabel *versionLabels = [[UILabel alloc] initWithFrame:CGRectMake(versionLabel.frame.origin.x, versionLabel.frame.origin.y+versionLabel.frame.size.height, 350, 80)];
    versionLabels.text =@"Copyright (C) 2015-2016";
    versionLabels.textColor = [UIColor blackColor];
    versionLabels.textAlignment = NSTextAlignmentCenter;
    versionLabels.font = [UIFont systemFontOfSize:30];
    [containerView addSubview:versionImageView];
    [containerView addSubview:versionLabel];
    [containerView addSubview:versionLabels];
    
    //检查新版本
    [SoftVersionViewController updateAppVersion:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *@brief 到appStore更新app版本的方法;需要传入是否是手动更新
 */
+(void)updateAppVersion:(BOOL)isManual
{
    __block BOOL returnIsUpdateBool = NO;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *appleID = APPID;
    NSURL *updateURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appleID]];
    __block ASIHTTPRequest *updateRequest = [[ASIHTTPRequest alloc]initWithURL:updateURL];
    [updateRequest setCompletionBlock:^{
        NSString *returnString = [updateRequest responseString];
        if (returnString) {
            if ([returnString isKindOfClass:[NSString class]]) {
                //解析从苹果返回的版本信息
                NSDictionary *jsonData = [returnString JSONValue];
                DLog(@"jsonData = %@",jsonData);
                if (jsonData==nil || (![jsonData isKindOfClass:[NSDictionary class]])) {
                    returnIsUpdateBool = NO;
                }else{
                    NSArray *results = [jsonData objectForKey:@"results"];
                    if (results == nil || (![results isKindOfClass:[NSArray class]])) {
                        returnIsUpdateBool = NO;
                    }else{
                        NSString *latestVersion = nil;
                        NSString *trackName = nil;
                        for (NSDictionary *dic in results) {
                            DLog(@"results = %@",dic);
                            latestVersion = [dic objectForKey:@"version"];
                            trackViewUrl = [dic objectForKey:@"trackViewUrl"];
                            [ud setObject:trackViewUrl forKey:@"trackViewUrl"];
                            trackName = [dic objectForKey:@"trackName"];
                            DLog(@"latestVersion = %@\n trackViewUrl = %@\n trackName = %@",latestVersion,trackViewUrl,trackName);
                        }
                        if (latestVersion == nil || ([latestVersion length]<1) || trackViewUrl == nil || ([trackViewUrl length]<1) || trackName == nil || ([trackName length]<1)) {
                            returnIsUpdateBool = NO;
                        }else{
                            NSDictionary *localDict = [[NSBundle mainBundle] infoDictionary];
                            NSString *localVersion = [localDict objectForKey:@"CFBundleVersion"];
                            NSRange range1 =NSMakeRange(0, 1);
                            NSRange range2 =NSMakeRange(2, 1);
                            NSRange range3 =NSMakeRange(4, 1);
                            if ([latestVersion isKindOfClass:[NSString class]] && (latestVersion!=nil)){
                                //网络的版本
                                NSInteger latestbaiwei = [[latestVersion substringWithRange:range1] intValue]*100;
                                NSInteger latestshiwei = [[latestVersion substringWithRange:range2] intValue]*10;
                                NSInteger latestgewei = [[latestVersion substringWithRange:range3] intValue];
                                //网络版本和
                                NSInteger latestbanbenhe = latestbaiwei + latestshiwei + latestgewei;

                                //本地的版本
                                NSInteger currentbaiwei = [[localVersion substringWithRange:range1] intValue]*100;
                                NSInteger currentshiwei = [[localVersion substringWithRange:range2] intValue]*10;
                                NSInteger currentgewei = [[localVersion substringWithRange:range3] intValue];
                                //本地版本和
                                NSInteger currentbanbenhe = currentbaiwei + currentshiwei + currentgewei;

                                //如果本地版本小于网络版本
                                if (currentbanbenhe<latestbanbenhe) {
                                    [ud setObject:trackName forKey:@"trackName"];
                                    [ud setObject:trackViewUrl forKey:@"trackViewUrl"];
                                    returnIsUpdateBool = YES;
                                }else{
                                    returnIsUpdateBool = NO;
                                }
                            }else{
                                returnIsUpdateBool = NO;
                            }
                        }
                    }
                }
            }
        }

        if (returnIsUpdateBool) {
            AHAlertView *alert = [[AHAlertView alloc] initWithTitle:NSLocalizedString(@"CheckUpdate", @"更新") message:NSLocalizedString(@"GotNewVersion", @"有新版本，是否升级！")];
            [alert setCancelButtonTitle:NSLocalizedString(@"NSStringNO", @"取消") block:^{
                alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
            }];
            [alert addButtonWithTitle:NSLocalizedString(@"Update", @"更新") block:^{
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                DLog(@"trackViewUrl = %@",[ud objectForKey:@"trackViewUrl"]);
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ud objectForKey:@"trackViewUrl"]]];
            }];
            [alert show];
        }else{
            if (isManual) {
                AHAlertView *alert = [[AHAlertView alloc] initWithTitle:NSLocalizedString(@"CheckUpdate", @"更新") message:NSLocalizedString(@"NoNewVersion", @"无新版本")];
                [alert setCancelButtonTitle:NSLocalizedString(@"NSStringNO", @"取消") block:^{
                    alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
                }];
                [alert addButtonWithTitle:NSLocalizedString(@"NSStringReloadButton", @"再次检查") block:^{
                    alert.dismissalStyle = AHAlertViewDismissalStyleFade;
                    [SoftVersionViewController updateAppVersion:YES];
                }];
                [alert show];
            }
        }
    }];
    [updateRequest setFailedBlock:^{
        if (isManual) {
            AHAlertView *alert = [[AHAlertView alloc] initWithTitle:NSLocalizedString(@"CheckUpdate", @"更新") message:NSLocalizedString(@"NSString25",@"无网络连接")];
            [alert setCancelButtonTitle:NSLocalizedString(@"NSStringNO", @"取消") block:^{
                alert.dismissalStyle = AHAlertViewDismissalStyleTumble;
            }];
            [alert addButtonWithTitle:NSLocalizedString(@"NSStringReloadButton", @"再次检查") block:^{
                alert.dismissalStyle = AHAlertViewDismissalStyleFade;
                [SoftVersionViewController updateAppVersion:YES];
            }];
            [alert show];
        }
    }];
    [updateRequest startAsynchronous];
}


@end
