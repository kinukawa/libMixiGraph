//
//  MGUpdatesClient.m
//  libMixiGraph
//
//  Created by kenji.kinukawa on 11/06/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGUpdatesClient.h"


@implementation MGUpdatesClient
@synthesize delegate;

-(id)init{
	if((self = [super init])){
		//initialize
	}
	return self;
}

- (void) dealloc {
    self.delegate = nil;
	[super dealloc];
}

//あるユーザの新着フィード取得
-(void)getUpdatesFeedByUserID:(NSString *)userId 
                      groupId:(NSString *)groupId
                       fields:(NSString *)fields
                        count:(NSString *)count
                 updatedSince:(NSString *)updatedSince
                       device:(NSString *)device
                   identifier:(NSString *)identifier{
    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
    if (fields) {
		[queryDict setObject:fields forKey:@"fields"];
	} 
    if (count) {
		[queryDict setObject:count forKey:@"count"];
	}    
    if (updatedSince) {
		[queryDict setObject:updatedSince forKey:@"updatedSince"];
	} 
    if (device) {
		[queryDict setObject:device forKey:@"device"];
	} 
    
	NSURL * url = [MGUtil buildAPIURL:UPDATES_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       userId,
                                       groupId,
                                       nil]
                                query:queryDict];
    [httpClientManager get:@"getUpdatesFeedByUserID" identifier:identifier url:url];
}

//////////////MGhttpClientManagerDelegate/////////////////////

-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithError:(NSError*)error{
	NSLog(@"mgUpdatesClient didFailWithError");
	if([delegate respondsToSelector:@selector(mgUpdatesClient:didFailWithError:)]){
		[delegate mgUpdatesClient:conn didFailWithError:error];
	}
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
	NSLog(@"mgUpdatesClient didFailWithAPIError");
	if([delegate respondsToSelector:@selector(mgUpdatesClient:didFailWithAPIError:)]){
		[delegate mgUpdatesClient:conn didFailWithAPIError:error];
	}    
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFinishLoading:(NSDictionary *)reply{
	NSData *data = [reply objectForKey:@"data"];
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSString *identifier = [reply objectForKey:@"id"];
    NSString *method = [reply objectForKey:@"method"];
	NSLog(@"mgUpdatesClient didFinishLoading %@:%@",identifier,contents);
    
    id result = reply;
    if(method==@"getUserVoices"){
    }
    
	if([delegate respondsToSelector:@selector(mgUpdatesClient:didFinishLoading:)]){
        [delegate mgUpdatesClient:conn didFinishLoading:result];
    }
}

@end
