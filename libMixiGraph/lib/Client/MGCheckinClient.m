//
//  MGCheckinClient.m
//  libMixiGraph
//
//  Created by Kenji Kinukawa on 11/08/07.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MGCheckinClient.h"

@implementation MGCheckinClient

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) dealloc {
	[httpClientManager release];
	[super dealloc];
}

-(void)getAroundMySpotWithCenter:(NSString *)center 
                          fields:(NSString *)fields 
                               q:(NSString *)q 
                         sinceId:(NSString *)sinceId
                      startIndex:(NSString *)startIndex
                           count:(NSString *)count
                      identifier:(NSString *)identifier{
    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (center) {
		[queryDict setObject:center forKey:@"center"];
	}
    if (fields) {
		[queryDict setObject:fields forKey:@"fields"];
	}
    if (q) {
		[queryDict setObject:q forKey:@"q"];
	}
    if (sinceId) {
		[queryDict setObject:sinceId forKey:@"sinceId"];
	}
    if (startIndex) {
		[queryDict setObject:startIndex forKey:@"startIndex"];
	}
    if (fields) {
		[queryDict setObject:count forKey:@"count"];
	}
    
    NSURL * url = [MGUtil buildAPIURL:CHECKIN_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       @"me",
                                       @"self",
                                       nil]
                                query:queryDict];
    //httpClientManager.identifier = @"getUserVoices";
	[httpClientManager get:@"getAroundMySpotWithCenter" identifier:identifier url:url];
}



@end
