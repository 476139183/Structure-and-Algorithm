//
//  YXM_FTPManager.m
//  LEDAD
//
//  Created by yixingman on 14-9-29.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import "YXM_FTPManager.h"

@interface YXM_FTPManager ()
//内部变量
@property (nonatomic, readonly) BOOL              isSending;
@property (nonatomic, retain)   NSOutputStream *  networkStream;
@property (nonatomic, retain)   NSInputStream *   fileStream;
@property (nonatomic, readonly) uint8_t *         buffer;
@property (nonatomic, assign)   size_t            bufferOffset;
@property (nonatomic, assign)   size_t            bufferLimit;

@end

//存取方法
@implementation YXM_FTPManager

@synthesize delegate;
@synthesize listEntries;

- (uint8_t *)buffer
{
    return self->_buffer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)startUploadFileWithAccountqq:(NSString *)account andPassword:(NSString *)password andUrl:(NSString *)sUrl andFilePath:(NSString *)sFilePath{
//    NSURL *url = [NSURL alloc];//ftp服务器地址
    CFWriteStreamRef ftpStream;

    //获得输入
   NSURL *urlOnly = [NSURL URLWithString:sUrl];
    DLog(@"%@",urlOnly);
    //添加后缀（文件名称）
    urlOnly = NSMakeCollectable(CFURLCreateCopyAppendingPathComponent(NULL, (CFURLRef) urlOnly, (CFStringRef) @"warty-final-ubuntu.png", false));

    DLog(@"%@",urlOnly);

    //读取文件，转化为输入流
    self.fileStream = [NSInputStream inputStreamWithFileAtPath:sFilePath];

    [self.fileStream open];

    //为url开启CFFTPStream输出流
    ftpStream = CFWriteStreamCreateWithFTPURL(NULL, (CFURLRef) urlOnly);
    self.networkStream = (NSOutputStream *) ftpStream;

    //设置ftp账号密码
    [self.networkStream setProperty:account forKey:(id)kCFStreamPropertyFTPUserName];
    [self.networkStream setProperty:password forKey:(id)kCFStreamPropertyFTPPassword];

    //设置networkStream流的代理，任何关于networkStream的事件发生都会调用代理方法
    self.networkStream.delegate = self;

    //设置runloop
    [self.networkStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.networkStream open];

    //完成释放链接
    CFRelease(ftpStream);
}
-(void)startUploadFileWithAccount:(NSString *)account andPassword:(NSString *)password andUrl:(NSString *)sUrl andFilePath:(NSString *)sFilePath{
    NSURL *url = nil;//ftp服务器地址
    CFWriteStreamRef ftpStream;

    //获得输入
    url = [NSURL URLWithString:sUrl];

    //添加后缀（文件名称）
    url = NSMakeCollectable(CFURLCreateCopyAppendingPathComponent(NULL, (CFURLRef) url, (CFStringRef) [sFilePath lastPathComponent], false));

    //读取文件，转化为输入流
    self.fileStream = [NSInputStream inputStreamWithFileAtPath:sFilePath];

    [self.fileStream open];

    //为url开启CFFTPStream输出流
    ftpStream = CFWriteStreamCreateWithFTPURL(NULL, (CFURLRef) url);
    self.networkStream = (NSOutputStream *) ftpStream;

    //设置ftp账号密码
    [self.networkStream setProperty:account forKey:(id)kCFStreamPropertyFTPUserName];
    [self.networkStream setProperty:password forKey:(id)kCFStreamPropertyFTPPassword];

    //设置networkStream流的代理，任何关于networkStream的事件发生都会调用代理方法
    self.networkStream.delegate = self;

    //设置runloop
    [self.networkStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.networkStream open];

    //完成释放链接
    CFRelease(ftpStream);
}

#pragma mark 回调方法
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
    //aStream 即为设置为代理的networkStream
    switch (eventCode) {
        case NSStreamEventOpenCompleted: {
            DLog(@"NSStreamEventOpenCompleted");
        } break;
        case NSStreamEventHasBytesAvailable: {
            DLog(@"NSStreamEventHasBytesAvailable");     // 在上传的时候不会调用
        } break;
        case NSStreamEventHasSpaceAvailable: {
            if (self.bufferOffset == self.bufferLimit) {
                NSInteger   bytesRead;
                bytesRead = [self.fileStream read:self.buffer maxLength:kSendBufferSize];

                if (bytesRead == -1) {
                    //读取文件错误
                    [self _stopSendWithStatus:[NSString stringWithFormat:@"error_ReadFileError"]];
                } else if (bytesRead == 0) {
                    //文件读取完成 上传完成
                    [self _stopSendWithStatus:@"uploadComplete"];
                } else {
                    self.bufferOffset = 0;
                    self.bufferLimit  = bytesRead;
                }
            }

            if (self.bufferOffset != self.bufferLimit) {
                //写入数据
                NSInteger bytesWritten;//bytesWritten为成功写入的数据
                bytesWritten = [self.networkStream write:&self.buffer[self.bufferOffset] maxLength:self.bufferLimit - self.bufferOffset];
                
                [mydelegate uploadWriteData:bytesWritten];
                assert(bytesWritten != 0);
                if (bytesWritten == -1) {
                    [self _stopSendWithStatus:@"error_NetWriteInError"];
                } else {
                    self.bufferOffset += bytesWritten;
                }
            }
        } break;
        case NSStreamEventErrorOccurred: {
            [self _stopSendWithStatus:@"error_StreamOpenError"];
        } break;
        case NSStreamEventEndEncountered: {
            // 忽略
            DLog(@"NSStreamEventEndEncountered");
        } break;
        default: {
        } break;
    }
}

//结果处理
- (void)_stopSendWithStatus:(NSString *)statusString
{
    if (self.networkStream != nil) {
        [self.networkStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.networkStream.delegate = nil;
        [self.networkStream close];
        self.networkStream = nil;
    }
    if (self.fileStream != nil) {
        [self.fileStream close];
        self.fileStream = nil;
    }
    [self _sendDidStopWithStatus:statusString];
}


- (void)_sendDidStopWithStatus:(NSString *)statusString
{
    DLog(@"返回信息 = %@",statusString);
    if (self.delegate) {
        [self.delegate uploadResultInfo:statusString];

    }
    
}

-(void)dytstop:(NSString *)string
{
    [self _stopSendWithStatus:@"uploadComplete"];
    
}



@end
