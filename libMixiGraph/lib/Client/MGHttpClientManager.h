//
//  MGHttpClientManager.h
//  libMixiGraph
//
//  Created by kinukawa on 11/05/15.
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
#import "MGApiError.h"
#import "MGHttpClient.h"
@protocol MGHttpClientManagerDelegate;

@interface MGHttpClientManager : NSObject {
@public	
	id <MGHttpClientManagerDelegate> delegate;
    //NSString * identifier;
    NSMutableArray * requestQueue;
    //NSMutableURLRequest * request;

}
//@property (nonatomic,retain) NSString * identifier;
@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) NSMutableArray * requestQueue;
//@property (nonatomic,retain) NSMutableURLRequest * request;

-(void)post:(NSURL*)url param:(NSDictionary *)param body:(NSData*)body;
-(void)get:(NSURL*)url;
-(void)imagePost:(NSURL*)url image:(UIImage*)image;
-(void)delete:(NSURL*)url;
@end

@protocol MGHttpClientManagerDelegate<NSObject>
-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithError:(NSError*)error;
-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error;
-(void)mgHttpClientManager:(NSURLConnection *)conn didFinishLoading:(NSDictionary *)reply;
@end