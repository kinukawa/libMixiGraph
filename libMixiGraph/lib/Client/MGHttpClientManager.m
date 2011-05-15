//
//  MGHttpClientManager.m
//  libMixiGraph
//
//  Created by kinukawa on 11/05/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGHttpClientManager.h"


@implementation MGHttpClientManager
@synthesize identifier;
@synthesize delegate;
@synthesize requestQueue;
//@synthesize request;

-(id)init{
	if((self = [super init])){
		//initialize
        self.requestQueue = [NSMutableArray array];
    }
	return self;
}

- (void) dealloc {
    self.requestQueue = nil;
    [super dealloc];
}

-(void)enqueue:(NSMutableURLRequest *)req{
    MGHttpClient * httpClient = [[[MGHttpClient alloc]initWithURLRequest:req]autorelease];
    httpClient.delegate = self;
    [httpClient doRequest];
    [self.requestQueue addObject:httpClient];
}

//get
-(void)get:(NSURL*)url{
	//NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
	[req setHTTPMethod:@"GET"];
    
	NSString * accessToken = [NSString stringWithFormat:@"OAuth %@",[MGUserDefaults loadAccessToken]];
	[req setValue:accessToken forHTTPHeaderField:@"Authorization"];
	
    [self enqueue:req];
	//self.request = nil;
	//self.request = req;
    //httpClientつくって、実行、キューに入れる
	//return [self doRequest:request];
}


-(void)post:(NSURL*)url 
      param:(NSDictionary *)param 
	   body:(NSData*)body{
	
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
	[req setHTTPMethod:@"POST"];
	
	NSString * accessToken = [NSString stringWithFormat:@"OAuth %@",[MGUserDefaults loadAccessToken]];
	[req setValue:accessToken forHTTPHeaderField:@"Authorization"];
	
	for (id key in param){
		[req setValue:[param objectForKey:key] forHTTPHeaderField:key];		 
	}
	[req setHTTPBody:body];
	
	[self enqueue:req];
	//self.request = nil;
	//self.request = req;
	
	//return [self doRequest:request];
}

-(void)delete:(NSURL*)url{
	
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
	[req setHTTPMethod:@"DELETE"];
	
	NSString * accessToken = [NSString stringWithFormat:@"OAuth %@",[MGUserDefaults loadAccessToken]];
	[req setValue:accessToken forHTTPHeaderField:@"Authorization"];
	
	[self enqueue:req];
	//self.request = nil;
	//self.request = req;
	
	//return [self doRequest:request];
}


-(void)imagePost:(NSURL*)url 
		   image:(UIImage*)image{
	
	NSData* jpegData = UIImageJPEGRepresentation( image, 1.0 );
	[self post:url
		 param:[NSDictionary dictionaryWithObjectsAndKeys:
				@"image/jpeg",@"Content-type",nil]
		  body:jpegData];
}


-(void)mgHttpClient:(NSURLConnection *)conn httpClient:(MGHttpClient*)client didFailWithError:(NSError*)error{
	NSLog(@"mgHttpClientManager didFailWithError");
	if([delegate respondsToSelector:@selector(mgHttpClientManager:didFailWithError:)]){
		[delegate mgHttpClientManager:conn didFailWithError:error];
	}
    [self.requestQueue removeObject:client];
    //[client release];
}

-(void)mgHttpClient:(NSURLConnection *)conn httpClient:(MGHttpClient*)client didFailWithAPIError:(MGApiError*)error{
	NSLog(@"mgHttpClientManager didFailWithAPIError");
	if([delegate respondsToSelector:@selector(mgHttpClientManager:didFailWithAPIError:)]){
		[delegate mgHttpClientManager:conn didFailWithAPIError:error];
	}    
    [self.requestQueue removeObject:client];
    //[client release];
}

-(void)mgHttpClient:(NSURLConnection *)conn httpClient:(MGHttpClient*)client didFinishLoading:(NSMutableData *)data{
	NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"mgHttpClientManager didFinishLoading %@",contents);
    
	if([delegate respondsToSelector:@selector(mgHttpClientManager:didFinishLoading:)]){
        [delegate mgHttpClientManager:conn didFinishLoading:data];
    }
    [self.requestQueue removeObject:client];
    //[client release];
}

@end
