//
//  MGHttpReceiver.h
//  libMixiGraph
//
//  Created by Kinukawa Kenji on 11/06/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGHttpClient.h"
#import "HttpReceiver.h"
#import "MGApiError.h"
@interface MGHttpReceiver : HttpReceiver{
    
}
-(void)notifyDidFinishLoading:(MGHttpClient *)client;
-(void)notifyWithAPIError:(MGApiError *)error;
@end
