//
//  AsyncUdpSocketRevicePlayerBroadcastIp.m
//  XCloudsManager
//
//  Created by LDY on 13-11-28.
//
//

#import "AsyncUdpSocketReceivePlayerBroadcastIp.h"

#import "RegexKitLite.h"
#import "Config.h"

#define FORMAT(format,...)[NSString stringWithFormat:(format),##__VA_ARGS__]

@interface AsyncUdpSocketReceivePlayerBroadcastIp ()
{
    BOOL _isRunning;
    GCDAsyncUdpSocket *_udpSocket;
}

@end

@implementation AsyncUdpSocketReceivePlayerBroadcastIp
@synthesize playerBroadcastBlock = _playerBroadcastBlock;

-(id)initReceivePlayerBroadcastIp:(ReceivePlayerBroadcastBlock)block
{
    [super self];
    if (self) {
        self.playerBroadcastBlock = block;
        [self startUDPSocket];
    }
    return self;
}

-(BOOL)startUDPSocket{
    if (!_udpSocket) {
        _udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];

        int port = PORT_OF_GET_SERVICE_IP;
        NSError *error = nil;
        BOOL bindAndRecResult = NO;
        bindAndRecResult = [_udpSocket bindToPort:port error:&error];
        if (error) {
            DLog(@"port = %d,%@",port,FORMAT(@"Error bindToPort server (recv): %@", error));
        }
        if (bindAndRecResult) {
            bindAndRecResult = [_udpSocket beginReceiving:&error];
            if (error) {
                [_udpSocket close];
                DLog(@"port = %d,%@",port,FORMAT(@"Error starting server (recv): %@", error));
            }
        }
        if(!bindAndRecResult){
            self.playerBroadcastBlock(nil,nil);
        }
        return bindAndRecResult;
    }else{
        return YES;
    }
}


-(void)closeUDPSocket{
    [_udpSocket close];
    RELEASE_SAFELY(_udpSocket);
}



-(void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError *)error{
    self.playerBroadcastBlock(nil,nil);
    if (error) {
        DLog(@"%@",FORMAT(@"Error didNotConnect : %@", error));
    }
}

-(void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error{
    self.playerBroadcastBlock(nil,nil);
    if (error) {
        DLog(@"%@",FORMAT(@"Error udpSocketDidClose : %@", error));
    }
}



-(void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag{

}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address{
    DLog(@"address = %@",[[NSString alloc] initWithData:address encoding:NSUTF8StringEncoding]);
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error{
    if (error) {
        self.playerBroadcastBlock(nil,nil);
        DLog(@"%@",FORMAT(@"Error didNotSendDataWithTag : %@", error));
    }
}


- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(id)filterContext
{
    NSString *sHostIP = nil;
	NSString *sReceiveData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    uint16_t iPort = 0;
    [GCDAsyncUdpSocket getHost:&sHostIP port:&iPort fromAddress:address];
    
    if (sock.localPort == PORT_OF_GET_SERVICE_IP) {
        if ((sReceiveData!=nil)&&(sHostIP!=nil)) {
            self.playerBroadcastBlock(sReceiveData,sHostIP);
        }else{
            self.playerBroadcastBlock(nil,nil);
        }
    }

	[_udpSocket sendData:data toAddress:address withTimeout:-1 tag:0];
}

@end
