//
//  YXM_FTPManager.h
//  LEDAD
//
//  Created by yixingman on 14-9-29.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol UploadResultDelegate <NSObject>

-(void)uploadResultInfo:(NSString *)sInfo;
-(void)uploadWriteData:(NSInteger)writeDataLength;

@end


enum {
    kSendBufferSize = 32768
};


@interface YXM_FTPManager : UIViewController<NSStreamDelegate>
{
    uint8_t _buffer[kSendBufferSize];
    id<UploadResultDelegate> mydelegate;
}
@property (nonatomic,assign) id<UploadResultDelegate> delegate;
@property (nonatomic,retain) NSMutableArray *listEntries;
-(void)startUploadFileWithAccountqq:(NSString *)account andPassword:(NSString *)password andUrl:(NSString *)sUrl andFilePath:(NSString *)sFilePath;
-(void)startUploadFileWithAccount:(NSString *)account andPassword:(NSString *)password andUrl:(NSString *)sUrl andFilePath:(NSString *)sFilePath;
-(void)dytstop:(NSString *)string;

@end
