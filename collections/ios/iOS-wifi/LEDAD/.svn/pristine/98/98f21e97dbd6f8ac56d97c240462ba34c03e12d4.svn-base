//
//  AsyncUdpSocketRevicePlayerBroadcastIp.h
//  XCloudsManager
//
//  Created by LDY on 13-11-28.
//
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"

typedef void (^ReceivePlayerBroadcastBlock)(NSString *ledPlayerName,NSString *ledPlayerIP);

@interface AsyncUdpSocketReceivePlayerBroadcastIp : NSObject<GCDAsyncUdpSocketDelegate>
{
    ReceivePlayerBroadcastBlock _playerBroadcastBlock;
}
@property (nonatomic, strong) ReceivePlayerBroadcastBlock playerBroadcastBlock;
-(id)initReceivePlayerBroadcastIp:(ReceivePlayerBroadcastBlock)block;
-(BOOL)startUDPSocket;
-(void)closeUDPSocket;
@end
