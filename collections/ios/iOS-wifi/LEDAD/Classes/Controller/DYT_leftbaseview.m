//
//  DYT_leftbaseview.m
//  LEDAD
//
//  Created by laidiya on 15/7/20.
//  Copyright (c) 2015年 yxm. All rights reserved.
//

#import "DYT_leftbaseview.h"
#import "LayoutYXMViewController.h"
#import "MyButton.h"
@implementation DYT_leftbaseview
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        image.image = [UIImage imageNamed:@"leftk"];
        [self addSubview:image];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        [self initview];
//        myasymodel = [[DYT_AsyModel alloc]init];
//        myasymodel.mydelegate = self;
        
        
        self.backgroundColor = [UIColor clearColor];

    }
  

    return self;
}

-(void)initview
{
    
    

    //   上传素材  调节亮度   关机    重启    重置   修改终端名称
    
    NSArray *titlearrayname = [[NSArray alloc]initWithObjects:@"上传素材",@"调节亮度",@"关机",@"重启",@"重置",@"修改终端名称", nil];
    
//    NSArray *titleleftarray = [[NSArray alloc]initWithObjects:@"多联屏控制",@"关机云屏", @"调节亮度",@"重置素材",@"上传素材",@"查看云屏方案",nil];
    
    NSInteger hei = self.frame.size.width/3;
    
    
    
    for (int i=0; i<titlearrayname.count; i++) {
        
        MyButton *leftbutton = [[MyButton alloc]initWithFrame:CGRectMake(hei*(i%3), 10+60*(i/3), 50, 44)];
        
//        [leftbutton setTitle:titleleftarray[i] forState:UIControlStateNormal];
        [leftbutton setBackgroundImage:[UIImage imageNamed:titlearrayname[i]] forState:UIControlStateNormal];
        [leftbutton addTarget:self action:@selector(leftbutton:) forControlEvents:UIControlEventTouchUpInside];
        leftbutton.center = CGPointMake(leftbutton.frame.origin.x+hei/2, leftbutton.center.y);
        [leftbutton setTitle:titlearrayname[i] forState:0];
        
//        [leftbutton setBackgroundImage:[UIImage imageNamed:@"tkbtn"] forState:UIControlStateNormal];
        leftbutton.tag = 1000+i;
        [self addSubview:leftbutton];
       
    }

}
-(void)leftbutton:(UIButton *)sender
{
    //上传素材
    
    // 调节亮度
    
    // 关机
    if (sender.tag==1002) {
        //关机
        
                if (selectIpArr.count ==0) {
                    UIAlertView *aletview= [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_shoose"] delegate:nil cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles: nil];
                    [aletview show];
                    return;
                }
        
                //关机
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_guanji"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptno"], nil];
        
                [myAlertView setTag:2002];
                myAlertView.delegate = self;
                [myAlertView show];

        return;
        
    }
    
    //重启
    
    if (sender.tag==1003) {
        //   重启
        
                //重启动
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_chongqi"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptno"], nil];
                [myAlertView setTag:2003];
                myAlertView.delegate = self;
                [myAlertView show];
        return;

        
    }
    
    //重置
    
    if (sender.tag==1004) {
        //重置
        
                //重zhi
                UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_resetscreenbutton"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptno"], nil];
                [myAlertView setTag:2004];
                myAlertView.delegate = self;
                [myAlertView show];
        return;

        
    }
//    修改终端名称
        if (sender.tag==1005) {
            UIAlertView *myalert = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_ledname"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles:[Config DPLocalizedString:@"NSStringNO"], nil];
            myalert.tag = 2005;
            myalert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
            [myalert show];
            return;
        }

    
    _leftblock(sender.tag);
    
    
    
    
////   多连屏控制
//    if (sender.tag==1000 || sender.tag == 1005) {
//        NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
//        NSArray *filenameArray = [LayoutYXMViewController getFilenamelistOfType:@"xml"
//                                                                    fromDirPath:documentsDirectory AndIsGroupDir:YES];
//        DLog(@"%@",filenameArray);
//        if (filenameArray.count == 0) {
//            UIAlertView *alerview = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_zc16"] delegate:nil cancelButtonTitle:[Config DPLocalizedString: @"NSStringYes"] otherButtonTitles: nil];
//            [alerview show];
//            return;
//        }
//    }
////    关机
//    if (sender.tag==1001) {
//        
//        if (selectIpArr.count ==0) {
//            UIAlertView *aletview= [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"User_Prompt"] message:[Config DPLocalizedString:@"adedit_shoose"] delegate:nil cancelButtonTitle:[Config DPLocalizedString:@"NSStringYes"] otherButtonTitles: nil];
//            [aletview show];
//            return;
//        }
//        
//        //关机
//        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_guanji"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptno"], nil];
//        
//        [myAlertView setTag:2002];
//        myAlertView.delegate = self;
//        [myAlertView show];
//
//        
//    }
////    调节亮度
//    if (sender.tag==1002) {
//        
//        
//    }
//    
////重置素材
//    if (sender.tag==1003) {
//        
//        //重zhi
//        UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:[Config DPLocalizedString:@"adedit_xcoludsprompt"] message:[Config DPLocalizedString:@"adedit_resetscreenbutton"] delegate:self cancelButtonTitle:[Config DPLocalizedString:@"adedit_promptyes"] otherButtonTitles:[Config DPLocalizedString:@"adedit_promptno"], nil];
//        [myAlertView setTag:2003];
//        myAlertView.delegate = self;
//        [myAlertView show];
//        
//
//        
//    }
//    
//    
//    
//    
//    
//    [self.delegate retureleftview:sender.tag];
    

}

#pragma mark-通信反馈
//通信命令的返回
-(void)returemydata:(NSData *)mydata
{
//    Byte *AckByte = (Byte *)[mydata bytes];
    NSLog(@"反馈数据=====%@",mydata);
    
    
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    //    关机
    if (alertView.tag==2002) {
        if (buttonIndex==0) {
            
            for (int i=0; i<selectIpArr.count; i++) {
                DLog(@"关机次数");
                
                DYT_AsyModel *masay = [[DYT_AsyModel alloc]init];
//                masay.mydelegate = self;
                
                [masay SafetySignout:selectIpArr[i]];
                
            }
        
        }
    }
    
    
        //    重启云屏
        if (alertView.tag==2003) {
            if (buttonIndex==0) {
    
                for (int i=0; i<selectIpArr.count; i++) {
    
                    DYT_AsyModel *myasy = [[DYT_AsyModel alloc]init];
    
                    [myasy RestartScreen:selectIpArr[i]];
                }
                
            
            }
        }
    
    
//   重置素材
    if (alertView.tag==2004) {
        if (buttonIndex==0) {
            for (int i=0; i<selectIpArr.count; i++) {
                DYT_AsyModel *myasy = [[DYT_AsyModel alloc]init];
//                myasy.mydelegate = self;
                [myasy ResetScreen:selectIpArr[i]];
            }
        }
        
    
    }
            
            //修改终端名称
            
            
    if (alertView.tag==2005) {
        
        if (buttonIndex==0) {
            
            UITextField *mytextfild = [alertView textFieldAtIndex:0];
            
            if (mytextfild.text.length!=0&&![mytextfild.text isEqualToString:@""]) {
                
                [self writeFile:@"vlc.txt" Data:mytextfild.text];
                
                [self ftpuser1];
                
                
                
            }else
            {
                
                
                
            }
            
            
        }

        
    }

    
    
    
    
    


}

//写文件
-(void)writeFile:(NSString*)filename Data:(NSString*)data

{
    //获得应用程序沙盒的Documents目录，官方推荐数据文件保存在此
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* doc_path = [path objectAtIndex:0];
    
    DLog(@"Documents Directory:%@",doc_path);
    
    //创建文件管理器对象
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString* _filename = [doc_path stringByAppendingPathComponent:filename];
    //NSString* new_folder = [doc_path stringByAppendingPathComponent:@"test"];
    //创建目录
    //[fm createDirectoryAtPath:new_folder withIntermediateDirectories:YES attributes:nil error:nil];
    [fm createFileAtPath:_filename contents:[data dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    NSArray *files = [fm subpathsAtPath: doc_path];
    DLog(@"修改终端%@",files);
    
}

-(void)ftpuser1{
    
    isgaiming = YES;
    
    //    if (!_ftpMgr) {
    //连接ftp服务器
    _ftpMgr = [[YXM_FTPManager alloc]init];
    _ftpMgr.delegate = self;
    //    }
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* sZipPath =[NSString stringWithFormat:@"%@/vlc.txt",DocumentsPath];
    NSString *sUploadUrl = [[NSString alloc]initWithFormat:@"ftp://%@:21/config",ipAddressString];
    [_ftpMgr startUploadFileWithAccount:@"ftpuser" andPassword:@"ftpuser" andUrl:sUploadUrl andFilePath:sZipPath];
    NSFileManager * fm = [NSFileManager defaultManager];
    NSDictionary * dict = [fm attributesOfItemAtPath:sZipPath error:nil];
    //方法一:
    NSLog(@"size = %lld",[dict fileSize]);
    
}


/**
 *  反映上传进度的回调，每次写入流的数据长度
 *
 *  @param writeDataLength 数据长度
 */
-(void)uploadWriteData:(NSInteger)writeDataLength{
    _sendFileCountSize += writeDataLength;
    
}
-(void)uploadResultInfo:(NSString *)sInfo{
    DLog(@"sInfo = %@",sInfo);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
