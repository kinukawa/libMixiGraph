//
//  HttpReceiver.m
//  libMixiGraph
//
//  Created by Kinukawa Kenji on 11/06/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HttpReceiver.h"

@implementation HttpReceiver

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)notifyDidReceiveResponse:(NSURLResponse *)response{
    NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               response, @"response",
                               nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyDidReceiveResponse" object:self userInfo:userInfo];

}

-(void)notifyDidReceiveData:(NSData *)receivedData{
    NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               receivedData, @"receivedData",
                               nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyDidReceiveData" object:self userInfo:userInfo];

}

-(void)notifyDidFailWithError:(NSError*)error{
    NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               error, @"error",
                               nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyDidFailWithError" object:self userInfo:userInfo];
}

-(void)notifyDidFinishLoading:(SimpleHttpClient *)client{
    NSString *contents = [[[NSString alloc] initWithData:client.buffer encoding:NSUTF8StringEncoding] autorelease];
    NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               contents, @"data",
                               nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyDidFinishLoading" object:self userInfo:userInfo];
}
@end
