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

-(bool)get:(NSURL*)url{
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    if(!request){
        return NO;
    }
    
	self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (self.connection) {
        self.buffer = [NSMutableData data];
        self.networkState = MIXINetworkStateInProgress;
		return YES;
	} else {
		return NO;		
	}	
}

-(void)cancel{
    [connection cancel];
    self.networkState = MIXINetworkStateCanceled;
    if([delegate respondsToSelector:@selector(httpClientDidCancel:)]){
        [delegate httpClientDidCancel:self];
    }     
}

//レスポンス受信時に呼ばれる
- (void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)res {
    NSHTTPURLResponse * httpRes = (NSHTTPURLResponse*)res;
    NSLog(@"Received Response. Status Code: %d", [httpRes statusCode]);
	NSLog(@"Expected ContentLength: %qi", [httpRes expectedContentLength]);
	NSLog(@"MIMEType: %@", [httpRes MIMEType]);
	NSLog(@"Suggested File Name: %@", [httpRes suggestedFilename]);
	NSLog(@"Text Encoding Name: %@", [httpRes textEncodingName]);
	NSLog(@"URL: %@", [httpRes URL]);
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
	self.networkState = MIXINetworkStateFinished;
    if([delegate respondsToSelector:@selector(httpClient:didFinishLoading:)]){
        [delegate httpClient:self didFinishLoading:self.buffer];
    } 
    self.connection = nil;
}

@end
