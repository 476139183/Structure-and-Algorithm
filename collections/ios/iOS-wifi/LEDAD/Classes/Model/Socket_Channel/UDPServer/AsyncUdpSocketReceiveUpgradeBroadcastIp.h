//
//  AsyncUdpSocketRevicePlayerBroadcastIp.h
//  XCloudsManager
//
//  Created by LDY on 13-11-28.
//
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"

typedef void (^ReceiveUpgradeBroadcastBlock)(NSString *ledPlayerName,NSString *ledPlayerIP);

@interface AsyncUdpSocketReceiveUpgradeBroadcastIp : NSObject<GCDAsyncUdpSocketDelegate>
{
    ReceiveUpgradeBroadcastBlock _upgradeBroadcastBlock;
}
@property (nonatomic, strong) ReceiveUpgradeBroadcastBlock upgradeBroadcastBlock;
-(id)initReceivePlayerBroadcastIp:(ReceiveUpgradeBroadcastBlock)block;
-(BOOL)startUDPSocket;
-(void)closeUDPSocket;
@end
