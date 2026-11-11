//
//  ViewController.m
//  SimpleFTPClinet
//
//  Created by Yutian Duan on 15/11/14.
//  Copyright © 2015年 Yutian Duan. All rights reserved.
//
// 必须 mac 下啊

#import "ViewController.h"
#import "FTPManager.h"

@interface ViewController ()<FTPManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  //   ftp://192.168.1.139:21/rec_bmp
  
  NSString *str = @"192.168.1.20";
  FTPManager *ma = [[FTPManager alloc] initWithServer:[NSString stringWithFormat:@"%@:%@/",str,@"21"] user:@"ftpuser" password:@"ftpuser"];
  ma.delegate = self;
  NSString *dicfile = [self dicFile];
  NSString *file = [NSString stringWithFormat:@"%@/%@",dicfile,@"110.mp4"];
  
  //    [ma createRemotefile:@"config/" Directory:@"xiaominzi"];
  // config 下的1.txt 文件
  [ma downloadRemoteFile:@"rec_bmp/f89ce03a4f37064f9680231959574357.mp4" localFileName:file];
  //    [ma listRemoteDirectory:@"rec_bmp/"];
  
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)ftpUploadFinishedWithSuccess:(BOOL)success; {
  NSLog(@"上传成功---%d",success);
}

- (void)ftpDownloadFinishedWithSuccess:(BOOL)success {
  NSLog(@"下----%d",success);
}

- (void)directoryListingFinishedWithSuccess:(NSArray *)arr {
  NSLog(@"列表%@",arr);
}

- (void)ftpError:(NSString *)err {
  //    receiving in progress 接受过程中
  NSLog(@"错误啊！!!!%@",err);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (NSString *)dicFile {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
  
  NSString *sProjectDirPath = [[NSString alloc]initWithFormat:@"%@/%@",[paths objectAtIndex:0],@"duanyutian"] ;
  
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  BOOL isDir = YES;
  NSError *error = nil;
  // 如果没有就创建
  if (![fileMgr fileExistsAtPath:sProjectDirPath isDirectory:&isDir]) {
    BOOL createResult = [fileMgr createDirectoryAtPath:sProjectDirPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!createResult) {
      NSLog(@"项目存放文件夹的路径创建出错 = %@",error);
    }
  }
  
  NSLog(@"----%@",sProjectDirPath);
  return sProjectDirPath;
  
}

@end

