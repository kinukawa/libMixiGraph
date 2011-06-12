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
@interface MGHttpReceiver : HttpReceiver{
    
}
-(void)notify:(id)client response:(id)response;
@end
