//
//  FTPManager.m
//  SimpleFTPClinet
//
//  Created by Yutian Duan on 15/11/14.
//  Copyright © 2015年 Yutian Duan. All rights reserved.
//

#import "FTPManager.h"

@interface FTPManager ()

@property (nonatomic, strong, readonly ) NSString*         currentOperation;
@property (nonatomic, strong, readwrite) NSOutputStream *  commandStream;
@property (nonatomic, strong, readwrite) NSInputStream *   dataStream;
@property (nonatomic, strong, readwrite) NSInputStream *   uploadStream;
@property (nonatomic, strong, readwrite) NSOutputStream *  downloadfileStream;
@property (nonatomic, assign, readonly ) uint8_t *         buffer;
@property (nonatomic, assign, readwrite) size_t            bufferOffset;
@property (nonatomic, assign, readwrite) size_t            bufferLimit;
@property (nonatomic, assign, readonly ) BOOL              isReceiving;
@property (nonatomic, assign, readonly ) BOOL              isSending;

@property (nonatomic, assign, readwrite) NSString*         ftpServer;
@property (nonatomic, assign, readwrite) NSString*         ftpUsername;
@property (nonatomic, assign, readwrite) NSString*         ftpPassword;
@property (nonatomic, strong, readwrite) NSMutableData *   listData;
@property (nonatomic, strong, readwrite) NSMutableArray *  listEntries;

@end


@implementation FTPManager {
  uint8_t                     _buffer[kSendBufferSize];
}

- (id)initWithServer:(NSString *)server user:(NSString *)username password:(NSString *)password {
  
  if ((self = [super init])) {
    self.ftpServer = server;
    self.ftpUsername = username;
    self.ftpPassword = password;
  }
  return self;
}

#pragma mark buffer declaration

- (uint8_t *)buffer {
  return  self.buffer;
}


#pragma mark -thread management
+ (NSThread *)networkThread {
  static NSThread *networkThread = nil;
  static dispatch_once_t oncePredicate;
  
  dispatch_once(&oncePredicate, ^{
    networkThread =
    [[NSThread alloc] initWithTarget:self
                            selector:@selector(networkThreadMain:)
                              object:nil];
    [networkThread start];
  });
  
  return networkThread;
}

+ (void)networkThreadMain:(id)unused {
  do {
    @autoreleasepool {
      [[NSRunLoop currentRunLoop] run];
    }
  } while (YES);
}

- (void)scheduleInCurrentThread:(NSStream*)aStream {
  [aStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                     forMode:NSRunLoopCommonModes];
}

-(NSURL *)smartURLForString:(NSString *)str {
  NSURL *     result;
  NSString *  trimmedStr;
  NSRange     schemeMarkerRange;
  NSString *  scheme;
  result = nil;
  trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  if ( (trimmedStr != nil) && ([trimmedStr length] != 0) ) {
    schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
    if (schemeMarkerRange.location == NSNotFound) {
      result = [NSURL URLWithString:[NSString stringWithFormat:@"ftp://%@", trimmedStr]];
    } else {
      scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
      if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
        result = [NSURL URLWithString:trimmedStr];
      } else {
        //unsupported url schema
      }
    }
  }
  return result;
}

- (BOOL)isReceiving {
  return (self.dataStream != nil);
}

- (BOOL)isSending {
  return (self.commandStream != nil);
}

/**
 *  关闭
 */
- (void)closeAll {
  if (self.commandStream != nil) {
    [self.commandStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    self.commandStream.delegate = nil;
    [self.commandStream close];
    self.commandStream = nil;
  }
  if (self.uploadStream != nil) {
    [self.uploadStream close];
    self.uploadStream = nil;
  }
  if (self.downloadfileStream != nil) {
    [self.downloadfileStream close];
    self.downloadfileStream = nil;
  }
  if (self.dataStream != nil) {
    [self.dataStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    self.dataStream.delegate = nil;
    [self.dataStream close];
    self.dataStream = nil;
  }
  _currentOperation = @"";
}


- (void)downloadRemoteFile:(NSString *)filename
             localFileName:(NSString *)localfile {
  BOOL success;
  NSURL *url;
  
  //获得输入      //添加后缀（文件名称）
  url = [self smartURLForString:[NSString stringWithFormat:@"%@%@",_ftpServer,filename]];
  
  success = (url != nil);
  if ( ! success) {
    [self.delegate ftpError:@"invalid url for downloadRemoteFile method"];
  } else {
    if (self.isReceiving){
      [self.delegate ftpError:@"receiving in progress"];
      return ;
    }
    
    //读取本地文件，转化为输入流
    self.downloadfileStream = [NSOutputStream outputStreamToFileAtPath:localfile append:NO];
    
    [self.downloadfileStream open];
    
    _currentOperation = @"GET";
    
    //为url开启CFFTPStream输出流
    
    self.dataStream = CFBridgingRelease(CFReadStreamCreateWithFTPURL(NULL, (__bridge CFURLRef) url));
    
    //设置ftp账号密码
    [self.dataStream setProperty:self.ftpUsername forKey:(id)kCFStreamPropertyFTPUserName];
    
    [self.dataStream setProperty:self.ftpPassword forKey:(id)kCFStreamPropertyFTPPassword];
    
    self.dataStream.delegate = self;
    
    [self performSelector:@selector(scheduleInCurrentThread:)
                 onThread:[[self class] networkThread]
               withObject:self.dataStream
            waitUntilDone:YES];
    
    [self.dataStream open];
    
    
  }
}

- (void)createRemotefile:(NSString *)file
               Directory:(NSString *)dirname {
  BOOL success;
  NSURL *url;
  
  NSString *urlstring = [[NSString alloc] initWithFormat:@"%@%@",self.ftpServer,file];
  
  url = [self smartURLForString:urlstring];
  success = (url != nil);
  if (success) {
    url = CFBridgingRelease(
                            CFURLCreateCopyAppendingPathComponent(NULL, (__bridge CFURLRef) url, (__bridge CFStringRef) dirname, true)
                            );
    success = (url != nil);
  }
  if ( ! success) {
    [self.delegate ftpError:@"invalid url for createRemoteDirectory method"];
  } else {
    if (self.isSending){
      [self.delegate ftpError:@"sending in progress"];
      return ;
    }
    _commandStream = CFBridgingRelease(
                                       CFWriteStreamCreateWithFTPURL(NULL, (__bridge CFURLRef) url)
                                       );
    //set credentials
    [self.commandStream setProperty:self.ftpUsername forKey:(id)kCFStreamPropertyFTPUserName];
    [self.commandStream setProperty:self.ftpPassword forKey:(id)kCFStreamPropertyFTPPassword];
    self.commandStream.delegate = self;
    [self performSelector:@selector(scheduleInCurrentThread:)
                 onThread:[[self class] networkThread]
               withObject:self.commandStream
            waitUntilDone:YES];
    [self.commandStream open];
    
  }
}

- (void)listRemoteDirectory:(NSString *)path {
  BOOL success;
  
  NSURL *url;
  
  NSString *urlstring = [[NSString alloc] initWithFormat:@"%@%@",self.ftpServer,path];
  url = [self smartURLForString:urlstring];
  
  success = (url != nil);
  if ( ! success) {
    [self.delegate ftpError:@"invalid url for listRemoteDirectory method"];
  } else {
    if (self.isReceiving) {
      [self.delegate ftpError:@"receiving in progress"];
      return ;
    }
    
    self.listData = [NSMutableData data];
    if (self.listEntries)
      self.listEntries=nil;
    self.listEntries=[[NSMutableArray alloc] init];
    _currentOperation = @"LIST";
    
    self.dataStream = CFBridgingRelease(
                                        CFReadStreamCreateWithFTPURL(NULL, (__bridge CFURLRef) url));
    //set credentials
    [self.dataStream setProperty:self.ftpUsername forKey:(id)kCFStreamPropertyFTPUserName];
    [self.dataStream setProperty:self.ftpPassword forKey:(id)kCFStreamPropertyFTPPassword];
    _dataStream.delegate = self;
    [self performSelector:@selector(scheduleInCurrentThread:)
                 onThread:[[self class] networkThread]
               withObject:self.dataStream
            waitUntilDone:YES];
    [self.dataStream open];
  }
}

#pragma listing helpers

- (void)addListEntries:(NSArray *)newEntries {
  [self.listEntries addObjectsFromArray:newEntries];
  [self closeAll];
  [self.delegate directoryListingFinishedWithSuccess:self.listEntries];
}

//this function is taken over from Apple samples
- (NSDictionary *)entryByReencodingNameInEntry:(NSDictionary *)entry encoding:(NSStringEncoding)newEncoding {
  NSDictionary *  result;
  NSString *      name;
  NSData *        nameData;
  NSString *      newName;
  newName = nil;
  // Try to get the name, convert it back to MacRoman, and then reconvert it
  // with the preferred encoding.
  name = [entry objectForKey:(id) kCFFTPResourceName];
  if (name != nil) {
    nameData = [name dataUsingEncoding:NSMacOSRomanStringEncoding];
    if (nameData != nil) {
      newName = [[NSString alloc] initWithData:nameData encoding:newEncoding];
    }
  }
  if (newName == nil) {
    result = (NSDictionary *) entry;
  } else {
    NSMutableDictionary *   newEntry;
    newEntry = [entry mutableCopy];
    [newEntry setObject:newName forKey:(id) kCFFTPResourceName];
    result = newEntry;
  }
  return result;
}

//also this function is taken over from Apple samples
- (void)parseListData {
  NSMutableArray *    newEntries;
  NSUInteger          offset;
  newEntries = [NSMutableArray array];
  offset = 0;
  do {
    CFIndex         bytesConsumed;
    CFDictionaryRef thisEntry;
    thisEntry = NULL;
    bytesConsumed = CFFTPCreateParsedResourceListing(NULL, &((const uint8_t *) self.listData.bytes)[offset], (CFIndex) ([self.listData length] - offset), &thisEntry);
    if (bytesConsumed > 0) {
      if (thisEntry != NULL) {
        NSDictionary *  entryToAdd;
        entryToAdd = [self entryByReencodingNameInEntry:(__bridge NSDictionary *) thisEntry encoding:NSUTF8StringEncoding];
        [newEntries addObject:entryToAdd];
      }
      // We consume the bytes regardless of whether we get an entry.
      offset += (NSUInteger) bytesConsumed;
    }
    if (thisEntry != NULL) {
      CFRelease(thisEntry);
    }
    if (bytesConsumed == 0) {
      // We haven't yet got enough data to parse an entry.
      //Wait for more data to arrive
      break;
    } else if (bytesConsumed < 0) {
      // We totally failed to parse the listing.  Fail.
      break;
    }
  } while (YES);
  
  if ([newEntries count] != 0) {
    [self addListEntries:newEntries];
  }
  if (offset != 0) {
    [self.listData replaceBytesInRange:NSMakeRange(0, offset) withBytes:NULL length:0];
  }
}


- (void)uploadFileWithFilePath:(NSString *)filePath {
  BOOL success;
  NSURL *url;
  
  url = [self smartURLForString:self.ftpServer];
  
  success = (url != nil);
  if (success) {
    url = CFBridgingRelease(
                            CFURLCreateCopyAppendingPathComponent(NULL, ( CFURLRef) url,
                                                                  ( CFStringRef) [filePath lastPathComponent], false));
    success = (url != nil);
  }
  if ( !success) {
    [self.delegate ftpError:@"invalid url for uploadFileWithFilePath method"];
  } else {
    
    if (self.isSending) {
      [self.delegate ftpError:@"sending in progress"];
      return ;
    }
    self.uploadStream = [NSInputStream inputStreamWithFileAtPath:filePath];
    
    [self.uploadStream open];
    
    self.commandStream = CFBridgingRelease(CFWriteStreamCreateWithFTPURL(NULL, (__bridge  CFURLRef) url));
    
    //set credentials
    [self.commandStream setProperty:self.ftpUsername forKey:(id)kCFStreamPropertyFTPUserName];
    
    [self.commandStream setProperty:self.ftpPassword forKey:(id)kCFStreamPropertyFTPPassword];
    
    self.commandStream.delegate = self;
    
    [self performSelector:@selector(scheduleInCurrentThread:)
                 onThread:[[self class] networkThread]
               withObject:self.commandStream
            waitUntilDone:YES];
    
    [self.commandStream open];
  }
}

#pragma mark 回调方法
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
// An NSStream delegate callback that's called when events happen on our
// network stream.

#pragma unused(aStream)
  switch (eventCode) {
    case NSStreamEventOpenCompleted: {
      NSLog(@"stream openend");
    } break;
    case NSStreamEventHasBytesAvailable: { //上传的时候不会调用  下载
      NSInteger       bytesRead;
      uint8_t         buffer[32768];
      // Pull some data off the network.
      if ([_currentOperation isEqualToString:@"LIST"]) {
        bytesRead = [self.dataStream read:buffer maxLength:sizeof(buffer)];
        if (bytesRead < 0) {
          [self.delegate ftpError:@"can't read data stream"];
          [self closeAll];
        } else if (bytesRead == 0) {
          
        } else {
          [self.listData appendBytes:buffer length:(NSUInteger) bytesRead];
          NSLog(@"下载的＝＝＝＝%ld",(long)bytesRead);
          [self parseListData];
        }
      }
      else if ([self.currentOperation isEqualToString:@"GET"]) {
        bytesRead = [self.dataStream read:buffer maxLength:sizeof(buffer)];
        if (bytesRead == -1) {
          [self.delegate ftpError:@"can't read data stream"];
          [self closeAll];
        } else if (bytesRead == 0) {
          
        } else {
          NSInteger   bytesWritten;
          NSInteger   bytesWrittenSoFar;
          bytesWrittenSoFar = 0;
          
          do {
            // 写入进度
            bytesWritten = [self.downloadfileStream write:&buffer[bytesWrittenSoFar] maxLength:(NSUInteger) (bytesRead - bytesWrittenSoFar)];
            
            NSLog(@"文件总字节大小%ld -----%ld",(long)bytesWritten,(long)bytesRead);
            
            if (bytesWritten == -1) {
              [self.delegate ftpDownloadFinishedWithSuccess:NO];
              [self closeAll];
              break;
            } else {
              bytesWrittenSoFar += bytesWritten;
              NSLog(@"----%zd",bytesWrittenSoFar);
            }
            
          } while (bytesWrittenSoFar != bytesRead);//    bytesWrittenSoFar 总上传   bytesRead 文件大小
          [self closeAll];
          
          [self.delegate ftpDownloadFinishedWithSuccess:YES];
        }
      }
    } break;
      
    case NSStreamEventHasSpaceAvailable: {  //上传
      // If we don't have any data buffered, go read the next chunk of data.
      if (self.bufferOffset == self.bufferLimit) {
        NSInteger   bytesRead;
        bytesRead = [_uploadStream read:self.buffer maxLength:kSendBufferSize];
        if (bytesRead == -1) {
          // 读取文件错误
          [self.delegate ftpError:@"can't read fileupload stream"];
          [self closeAll];
        } else if (bytesRead == 0) {
          // 文件读取完成 上传成功
        } else {
          self.bufferOffset = 0;
          self.bufferLimit  = bytesRead;
        }
      }
      // If we're not out of data completely, send the next chunk.
      if (self.bufferOffset != self.bufferLimit) {
        // 写入数据
        NSInteger   bytesWritten;   //bytesWritten为成功写入的数据
        bytesWritten = [self.commandStream write:&self.buffer[self.bufferOffset] maxLength:self.bufferLimit - self.bufferOffset];
        
        //                NSLog(@"上传进度====%ld",(long)bytesWritten);
        // assert(bytesWritten != 0);
        if (bytesWritten == -1) {
          [self.delegate ftpError:@"can't read data stream"];
          [self closeAll];
        } else {
          self.bufferOffset += bytesWritten;
        }
      }
    } break;
    case NSStreamEventErrorOccurred: {
      [self.delegate ftpError:@"stream open error"];
      [self closeAll];
    } break;
    case NSStreamEventEndEncountered: {
      // ignore
    } break;
    default: {
      assert(NO);
    } break;
  }
}


@end

