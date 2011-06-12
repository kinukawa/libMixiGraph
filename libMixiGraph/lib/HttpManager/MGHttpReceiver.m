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

-(void)notify:(id)client response:(id)res{
    
    MGHttpClient * httpClient = (MGHttpClient*)client;
    NSString * senderClassStr = [httpClient.sender objectForKey:@"class"];
    NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               senderClassStr, @"class", 
                               [httpClient.sender objectForKey:@"selector"], @"selector",
                               res, @"data",
                               nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:senderClassStr object:self userInfo:userInfo];
}

@end
