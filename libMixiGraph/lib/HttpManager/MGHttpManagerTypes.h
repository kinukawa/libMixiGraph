//
//  MGHttpManagerTypes.h
//  libMixiGraph
//
//  Created by Kinukawa Kenji on 11/06/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    MIXINetworkStateNotConnected = 0,
    MIXINetworkStateInProgress,
    MIXINetworkStateFinished,
    MIXINetworkStateError,
    MIXINetworkStateCanceled,
} MIXINetworkState;

typedef enum {
    MIXIHttpReceiverTypeNormal = 0,
    MIXIHttpReceiverTypeGraph,
    MIXIHttpReceiverTypeCache,
} MIXIHttpReceiverType;


@interface MGHttpManagerTypes : NSObject

@end
