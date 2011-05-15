//
//  MGHttpClientManager.m
//  libMixiGraph
//
//  Created by kinukawa on 11/05/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGHttpClientManager.h"


@implementation MGHttpClientManager
@synthesize delegate;
@synthesize requestQueue;

-(void)postVoice:(NSString*)text{
	//httpClient.identifier = @"postVoice";
	//[httpClient post:url param:nil body:body];
}


-(void)mgHttpClient:(NSURLConnection *)conn didFailWithError:(NSError*)error{
	NSLog(@"mgHttpClientManager didFailWithError");
	if([delegate respondsToSelector:@selector(mgHttpClientManager:didFailWithError:)]){
		[delegate mgHttpClientManager:conn didFailWithError:error];
	}
}

-(void)mgHttpClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
	NSLog(@"mgHttpClientManager didFailWithAPIError");
	if([delegate respondsToSelector:@selector(mgHttpClientManager:didFailWithAPIError:)]){
		[delegate mgHttpClientManager:conn didFailWithAPIError:error];
	}    
}

-(void)mgHttpClient:(NSURLConnection *)conn didFinishLoading:(NSMutableData *)data{
	NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"mgHttpClientManager didFinishLoading %@",contents);
    
	if([delegate respondsToSelector:@selector(mgHttpClientManager:didFinishLoading:)]){
        [delegate mgHttpClientManager:conn didFinishLoading:data];
    }
}

@end
