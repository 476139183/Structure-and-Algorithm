//
//  AsyncUdpSocketRevicePlayerBroadcastIp.h
//  XCloudsManager
//
//  Created by LDY on 13-11-28.
//
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"

typedef void (^ReceiveTranscationBroadcastBlock)(NSString *ledPlayerName,NSString *ledPlayerIP);

@interface AsyncUdpSocketReceiveUpgradeTranscationBroadcastIp : NSObject<GCDAsyncUdpSocketDelegate>
{
    ReceiveTranscationBroadcastBlock _trancationBroadcastBlock;
}
@property (nonatomic, strong) ReceiveTranscationBroadcastBlock trancationBroadcastBlock;
-(id)initReceivePlayerBroadcastIp:(ReceiveTranscationBroadcastBlock)block;
-(BOOL)startUDPSocket;
-(void)closeUDPSocket;
@end
