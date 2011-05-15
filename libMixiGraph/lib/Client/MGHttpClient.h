//
//  MGHttpClient.h
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

#import <Foundation/Foundation.h>
#import "MGUserDefaults.h"
#import "MGUtil.h"
#import "MGApiError.h"
#import "MGOAuthClient.h"

@protocol MGHttpCliendDelegate;

@interface MGHttpClient : NSObject {
@public
	id <MGHttpCliendDelegate> delegate;
    NSString * identifier;
@private
	NSMutableData * buffer;
	NSMutableURLRequest * backupRequest;
    NSHTTPURLResponse *response;
    NSURLConnection *connection;
}

-(bool)post:(NSURL*)url param:(NSDictionary *)param body:(NSData*)body;
-(bool)get:(NSURL*)url;
-(void)imagePost:(NSURL*)url image:(UIImage*)image;
-(bool)delete:(NSURL*)url;

@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) NSMutableURLRequest * backupRequest;
@property (nonatomic,retain) NSMutableData * buffer;
@property (nonatomic,retain) NSHTTPURLResponse *response;
@property (nonatomic,retain) NSString * identifier;
@property (nonatomic,retain) NSURLConnection *connection;
@end

@protocol MGHttpCliendDelegate<NSObject>
-(void)mgHttpClient:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)res;
-(void)mgHttpClient:(NSURLConnection *)conn didReceiveData:(NSData *)receivedData;
-(void)mgHttpClient:(NSURLConnection *)conn didFailWithError:(NSError*)error;
-(void)mgHttpClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error;
-(void)mgHttpClient:(NSURLConnection *)conn didFinishLoading:(NSMutableData *)data;
@end

