//
//  MGHttpReceiver.m
//  libMixiGraph
//
//  Created by Kinukawa Kenji on 11/06/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGHttpReceiver.h"

@implementation MGHttpReceiver

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)notifyDidFinishLoading:(MGHttpClient *)client{
    NSString *contents = [[[NSString alloc] initWithData:client.buffer encoding:NSUTF8StringEncoding] autorelease];
    MGHttpClient * httpClient = (MGHttpClient*)client;
    NSString * senderClassStr = [httpClient.sender objectForKey:@"class"];
    NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               senderClassStr, @"class", 
                               [httpClient.sender objectForKey:@"selector"], @"selector",
                               contents, @"data",
                               nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:senderClassStr object:self userInfo:userInfo];
}

-(void)notifyWithAPIError:(MGApiError *)error{
    NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               error, @"apiError",
                               nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MGApiError" object:self userInfo:userInfo];
}

@end
