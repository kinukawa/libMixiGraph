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

-(id)init{
	if((self = [super init])){
    }
	return self;
}

- (void) dealloc {
	[super dealloc];
}

#pragma mark - set http requests

//get
-(BOOL)httpGet:(NSURL*)url{
    if([super httpGet:url]){    
        NSString * accessToken = [NSString stringWithFormat:@"OAuth %@",[MGUserDefaults loadAccessToken]];
        [self.request setValue:accessToken forHTTPHeaderField:@"Authorization"];
        return YES;
    }
    return NO;
}


-(BOOL)httpPost:(NSString *)method 
        url:(NSURL*)url 
      param:(NSDictionary *)param 
	   body:(NSData*)body{
    if([super httpPost:url param:param body:body]){
        NSString * accessToken = [NSString stringWithFormat:@"OAuth %@",[MGUserDefaults loadAccessToken]];
        [self.request setValue:accessToken forHTTPHeaderField:@"Authorization"];        
        return YES;
    }
    return NO;
}

-(BOOL)httpDelete:(NSURL*)url{
    if([super httpDelete:url]){
        NSString * accessToken = [NSString stringWithFormat:@"OAuth %@",[MGUserDefaults loadAccessToken]];
        [self.request setValue:accessToken forHTTPHeaderField:@"Authorization"];        
        return YES;
    }
    return NO;
}


-(BOOL)httpImagePost:(NSURL*)url 
		   image:(UIImage*)image{
	
	NSData* jpegData = UIImageJPEGRepresentation( image, 1.0 );
	if([self httpPost:url
		 param:[NSDictionary dictionaryWithObjectsAndKeys:
				@"image/jpeg",@"Content-type",nil]
             body:jpegData]){
        return YES;
    }
    return NO;
}

#pragma mark - NSURLConnection delegate method

//エラー受信
-(void)connection:(NSURLConnection*)conn didFailWithError:(NSError*)error{
	NSLog(@"Connection failed! Error - %@ %d %@",
		  [error domain],
		  [error code],
		  [error localizedDescription]);
	self.buffer = nil;
	
	//ネットワークに接続されていない時
    if ([delegate respondsToSelector:@selector(mgHttpClient:httpClient:didFailWithError:)]) {
		[delegate mgHttpClient:conn httpClient:self didFailWithError:error];
	}
}

-(void)retryRequest{
    NSLog(@"one more request!!!!!!");
    
    NSString * accessToken = [NSString stringWithFormat:@"OAuth %@",[MGUserDefaults loadAccessToken]];
    [self.request setValue:accessToken forHTTPHeaderField:@"Authorization"];
    //[self doRequest:self.request];
    [self doRequest];
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
                self.response = nil;
                [self retryRequest];
                return;
            }else{
                NSLog(@"Invalid grant. please relogin.");
                apiError.errorType = MGApiErrorTypeInvalidGrant;
                //エラーデリゲート呼ぶ
            }
        }
        if([delegate respondsToSelector:@selector(mgHttpClient:httpClient:didFailWithAPIError:)]){
            [delegate mgHttpClient:conn httpClient:self didFailWithAPIError:apiError];
        }
    }else if([response statusCode]>=200 &&
             [response statusCode]<400){
        if([delegate respondsToSelector:@selector(mgHttpClient:httpClient:didFinishLoading:)]){
            [delegate mgHttpClient:conn httpClient:self didFinishLoading:buffer];
        }
    }else{
        if([delegate respondsToSelector:@selector(mgHttpClient:httpClient:didFailWithAPIError:)]){
            MGApiError * apiError = [self checkResponseError:[response allHeaderFields]];
            apiError.response = response;
            apiError.errorType = MGApiErrorTypeOther;
            [delegate mgHttpClient:conn httpClient:self didFailWithAPIError:apiError];
        }
    }
    self.buffer = nil;
    self.response = nil;
    return;
}

@end
