//
//  SimpleHttpClient.m
//  mixi_hd
//
//  Created by kenji.kinukawa on 11/06/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SimpleHttpClient.h"


@implementation SimpleHttpClient

@synthesize delegate;
@synthesize buffer;
@synthesize identifier;
@synthesize connection;
@synthesize networkState;
@synthesize request;
@synthesize response;

-(id)init{
	if((self = [super init])){
    }
	return self;
}

- (void) dealloc {
    [self.connection cancel];
    self.connection = nil;
	self.buffer = nil;
    self.identifier = nil;
	[super dealloc];
}

-(bool)doRequest{
	self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
    if (self.connection) {
        self.buffer = [NSMutableData data];
	    self.networkState = MIXINetworkStateInProgress;
		return YES;
	} else {
		return NO;		
	}	
}

#pragma mark - set http requests

-(BOOL)httpGet:(NSURL*)url{
    self.request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
	if(!self.request){
        return NO;
    }
    [self.request setHTTPMethod:@"GET"];
	
    return YES;
}

-(BOOL)httpPost:(NSURL*)url 
      param:(NSDictionary *)param 
	   body:(NSData*)body{
	
    self.request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
	
    if(!self.request){
        return NO;
    }
    [self.request setHTTPMethod:@"POST"];
	
	for (id key in param){
		[self.request setValue:[param objectForKey:key] forHTTPHeaderField:key];		 
	}
	[self.request setHTTPBody:body];
    
    return YES;
}

-(BOOL)httpDelete:(NSURL*)url{
	
    self.request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
	
    if(!self.request){
        return NO;
    }
    
    [self.request setHTTPMethod:@"DELETE"];
    return YES;
}

-(void)httpCancel{
    [connection cancel];
    self.networkState = MIXINetworkStateCanceled;
    if([delegate respondsToSelector:@selector(httpClientDidCancel:)]){
        [delegate httpClientDidCancel:self];
    }     
}

#pragma mark - NSURLConnection delegate method

//レスポンス受信時に呼ばれる
- (void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)res {
    NSHTTPURLResponse *hres = (NSHTTPURLResponse *)res;
    self.response = hres;	
    if([delegate respondsToSelector:@selector(httpClient:didReceiveResponse:)]){
        [delegate httpClient:self didReceiveResponse:res];
    }     
}

//レスポンスデータ受信
- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)receivedData {
	[self.buffer appendData:receivedData];
    if([delegate respondsToSelector:@selector(httpClient:didReceiveData:)]){
        [delegate httpClient:self didReceiveData:receivedData];
    }     
}


//エラー受信
-(void)connection:(NSURLConnection*)conn didFailWithError:(NSError*)error{
    self.networkState = MIXINetworkStateError;
	if([delegate respondsToSelector:@selector(httpClient:didFailWithError:)]){
        [delegate httpClient:self didFailWithError:error];
    } 
    self.connection = nil;
}

//受信終了
- (void)connectionDidFinishLoading:(NSURLConnection *)conn {
	NSLog(@"Succeed!! Received %d bytes of data", [buffer length]);
    NSLog(@"Received Response. Status Code: %d", [self.response statusCode]);
	NSLog(@"Expected ContentLength: %qi", [self.response expectedContentLength]);
	NSLog(@"MIMEType: %@", [self.response MIMEType]);
	NSLog(@"Suggested File Name: %@", [self.response suggestedFilename]);
	NSLog(@"Text Encoding Name: %@", [self.response textEncodingName]);
	NSLog(@"URL: %@", [self.response URL]);
    
	self.networkState = MIXINetworkStateFinished;
    if([delegate respondsToSelector:@selector(httpClient:didFinishLoading:)]){
        [delegate httpClient:self didFinishLoading:self.buffer];
    } 
    self.connection = nil;
}

@end
