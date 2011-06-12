//
//  MGHttpConnector.h
//  libMixiGraph
//
//  Created by Kinukawa Kenji on 11/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleHttpClient.h"
#import "MGUtil.h"
#import "MGHttpReceiver.h"

@interface MGHttpConnector : NSObject{
    NSMutableArray * httpClients;
}

@property (nonatomic, readonly, getter = isNetworkAccessing) BOOL networkAccessing;

+(MGHttpConnector *)sharedConnector;
-(void)setHttpClient:(SimpleHttpClient*)httpClient;
-(void)cancelAllRequests;

@end
