//
//  FTPManager.h
//  SimpleFTPClinet
//
//  Created by Yutian Duan on 15/11/14.
//  Copyright © 2015年 Yutian Duan. All rights reserved.
//


#import <Foundation/Foundation.h>


#include <CFNetwork/CFNetwork.h>
enum {
    kSendBufferSize = 32768
};

@protocol FTPManagerDelegate <NSObject>

- (void)ftpUploadFinishedWithSuccess:(BOOL)success;

- (void)ftpDownloadFinishedWithSuccess:(BOOL)success;

- (void)directoryListingFinishedWithSuccess:(NSArray *)arr;

- (void)ftpError:(NSString *)err;

@end

@interface FTPManager : NSObject<NSStreamDelegate>

- (id)initWithServer:(NSString *)server user:(NSString *)username password:(NSString *)password;

/**
 *  下载
 *
 *  @param filename  远程路径
 *  @param localfile 本地路径
 */
- (void)downloadRemoteFile:(NSString *)filename localFileName:(NSString *)localfile;

// 上传
- (void)uploadFileWithFilePath:(NSString *)filePath;
/**
 *  创建目录
 *
 *  @param file    路径下
 *  @param dirname 目录名称
 */
- (void)createRemotefile:(NSString *)file Directory:(NSString *)dirname;
/**
 *  查询
 *
 *  @param path 路径
 */
- (void)listRemoteDirectory:(NSString *)path;

@property (nonatomic, assign) id<FTPManagerDelegate> delegate;

@end

