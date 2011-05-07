//
//  MGHttpClient.m
//  libMixiGraph
//
//  Created by kenji kinukawa on 11/02/18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
/*
 Copyright (c) 2011, kenji kinukawa
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "MGHttpClient.h"


@implementation MGHttpClient

@synthesize delegate;
@synthesize backupRequest;
@synthesize buffer;
@synthesize response;
@synthesize identifier;

-(id)init{
	if((self = [super init])){
        refresh = YES;
	}
	return self;
}

- (void) dealloc {
	self.backupRequest = nil;
	self.buffer = nil;
    self.identifier = nil;
	[super dealloc];
}

-(bool)doRequest:(NSURLRequest*)req{
	NSURLConnection *conn = [NSURLConnection connectionWithRequest:req delegate:self];
    if (conn) {
        self.buffer = [NSMutableData data];
		return YES;
	} else {
		return NO;		
	}	
}

//get
-(bool)get:(NSURL*)url{
	//NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
	[request setHTTPMethod:@"GET"];
    
	NSString * accessToken = [NSString stringWithFormat:@"OAuth %@",[MGUserDefaults loadAccessToken]];
	[request setValue:accessToken forHTTPHeaderField:@"Authorization"];
	
	self.backupRequest = nil;
	self.backupRequest = request;
	return [self doRequest:request];
}


-(bool)post:(NSURL*)url 
	   param:(NSDictionary *)param 
	   body:(NSData*)body{
	
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
	[request setHTTPMethod:@"POST"];
	
	NSString * accessToken = [NSString stringWithFormat:@"OAuth %@",[MGUserDefaults loadAccessToken]];
	[request setValue:accessToken forHTTPHeaderField:@"Authorization"];
	
	for (id key in param){
		[request setValue:[param objectForKey:key] forHTTPHeaderField:key];		 
	}
	[request setHTTPBody:body];
	
	self.backupRequest = nil;
	self.backupRequest = request;
	
	return [self doRequest:request];
}

-(bool)delete:(NSURL*)url{
	
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
	[request setHTTPMethod:@"DELETE"];
	
	NSString * accessToken = [NSString stringWithFormat:@"OAuth %@",[MGUserDefaults loadAccessToken]];
	[request setValue:accessToken forHTTPHeaderField:@"Authorization"];
	
	self.backupRequest = nil;
	self.backupRequest = request;
	
	return [self doRequest:request];
}


-(void)imagePost:(NSURL*)url 
		   image:(UIImage*)image{
	
	NSData* jpegData = UIImageJPEGRepresentation( image, 1.0 );
	[self post:url
		 param:[NSDictionary dictionaryWithObjectsAndKeys:
				@"image/jpeg",@"Content-type",nil]
		  body:jpegData];
}


//レスポンス受信時に呼ばれる
- (void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)res {
	NSHTTPURLResponse *hres = (NSHTTPURLResponse *)res;
    self.response = hres;	
}

//レスポンスデータ受信
- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)receivedData {
	[self.buffer appendData:receivedData];
	if ([delegate respondsToSelector:@selector(mgHttpClient:didReceiveData:)]) {
		[delegate mgHttpClient:conn didReceiveData:receivedData];
	}
}


//エラー受信
-(void)connection:(NSURLConnection*)conn didFailWithError:(NSError*)error{
	NSLog(@"Connection failed! Error - %@ %d %@",
		  [error domain],
		  [error code],
		  [error localizedDescription]);
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	self.buffer = nil;
	
	//ネットワークに接続されていない時
	
    if ([delegate respondsToSelector:@selector(mgHttpClient:didFailWithError:)]) {
		[delegate mgHttpClient:conn didFailWithError:error];
	}
}

-(void)retryRequest{
    NSLog(@"one more request!!!!!!");
    self.buffer = nil;
    
    NSString * accessToken = [NSString stringWithFormat:@"OAuth %@",[MGUserDefaults loadAccessToken]];
    [self.backupRequest setValue:accessToken forHTTPHeaderField:@"Authorization"];
    [self doRequest:self.backupRequest];
    //refresh = NO;
}

//レスポンスエラーチェック
-(MGApiError *)checkResponseError:(NSDictionary *)dict{
	NSString *authenticate = [dict objectForKey:@"Www-Authenticate"];
	MGApiError * apiError = [[[MGApiError alloc]init]autorelease];
    if(authenticate){
		NSDictionary * authDict = [MGUtil parseAuthenticateHeader:authenticate];
		NSString * error = [authDict objectForKey:@"error"];
		if ([error isEqualToString:@"expired_token"]){
			apiError.errorType = MGApiErrorTypeExpiredToken;
		}else if([error isEqualToString:@"invalid_request"]){
			apiError.errorType = MGApiErrorTypeInvalidRequest;
		}else if([error isEqualToString:@"invalid_token"]){
			apiError.errorType = MGApiErrorTypeInvalidToken;
		}else if([error isEqualToString:@"insufficient_scope"]){
			apiError.errorType = MGApiErrorTypeInsufficientScope;
		}else{
			apiError.errorType = MGApiErrorTypeOther;
		}
	}
    apiError.body = [[[NSString alloc] initWithData:buffer encoding:NSUTF8StringEncoding]autorelease];
	return apiError;
}

//受信終了
- (void)connectionDidFinishLoading:(NSURLConnection *)conn {
	NSLog(@"Succeed!! Received %d bytes of data", [buffer length]);
	//NSLog(@"%@", [[[NSString alloc]initWithData:buffer encoding:NSASCIIStringEncoding]autorelease]);
    
    NSLog(@"Received Response. Status Code: %d", [response statusCode]);
	NSLog(@"Expected ContentLength: %qi", [response expectedContentLength]);
	NSLog(@"MIMEType: %@", [response MIMEType]);
	NSLog(@"Suggested File Name: %@", [response suggestedFilename]);
	NSLog(@"Text Encoding Name: %@", [response textEncodingName]);
	NSLog(@"URL: %@", [response URL]);
	
    if([response statusCode]==401){
        //リフレッシュ処理
        MGApiError * apiError = [self checkResponseError:[response allHeaderFields]];
        apiError.response = response;
        if(apiError.errorType == MGApiErrorTypeExpiredToken){
            NSLog(@"OAuth Token is expired.");
            MGOAuthClient * oauthClient = [[[MGOAuthClient alloc]init]autorelease];
            if([oauthClient refreshOAuthToken]){
                NSLog(@"Refreshed and retry request.");
                self.buffer = nil;
                [self retryRequest];
                return;
            }else{
                NSLog(@"Invalid grant. please relogin.");
                apiError.errorType = MGApiErrorTypeInvalidGrant;
                //エラーデリゲート呼ぶ
            }
        }
        if([delegate respondsToSelector:@selector(mgHttpClient:didFailWithAPIError:)]){
            [delegate mgHttpClient:conn didFailWithAPIError:apiError];
        }
    }else if([response statusCode]>=200 &&
             [response statusCode]<400){
        if([delegate respondsToSelector:@selector(mgHttpClient:didFinishLoading:)]){
            [delegate mgHttpClient:conn didFinishLoading:buffer];
        }
    }else{
        if([delegate respondsToSelector:@selector(mgHttpClient:didFailWithAPIError:)]){
            MGApiError * apiError = [self checkResponseError:[response allHeaderFields]];
            apiError.response = response;
            apiError.errorType = MGApiErrorTypeOther;
            [delegate mgHttpClient:conn didFailWithAPIError:apiError];
        }
    }
    self.buffer = nil;
    self.response = nil;
    return;
}

@end
