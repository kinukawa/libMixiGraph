//
//  MGHttpConnector.h
//  libMixiGraph
//
//  Created by Kinukawa Kenji on 11/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGUtil.h"
#import "MGHttpReceiver.h"
#import "MGOAuthClient.h"

@interface MGHttpConnector : NSObject{
    NSMutableArray * httpClients;
}

@property (nonatomic, readonly, getter = isNetworkAccessing) BOOL networkAccessing;
@property (nonatomic, retain) NSMutableArray * httpClients;
+(MGHttpConnector *)sharedConnector;
-(void)setHttpClient:(SimpleHttpClient*)httpClient;
-(void)cancelAllRequests;

@end
