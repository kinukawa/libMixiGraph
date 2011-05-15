//
//  MGDiaryClient.m
//  libMixiGraph
//
//  Created by kenji kinukawa on 11/02/24.
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

#import "MGDiaryClient.h"


@implementation MGDiaryClient
@synthesize delegate;

-(id)init{
	if((self = [super init])){
		//initialize
	}
	return self;
}

//日記の投稿
-(void)postDiary:(NSString*)title body:(NSString*)body{
	NSURL * url = [MGUtil buildAPIURL:@"http://api.mixi-platform.com/" 
							   path:[NSArray arrayWithObjects:
									 @"2",
									 @"diary",
									 @"articles",
									 @"@me",
									 @"@self",
									 nil]
							  query:nil];
	NSString * json = [NSString stringWithFormat:@"{\"title\":\"%@\",\"body\":\"%@\",\"privacy\":{\"visibility\":\"self\",\"show_users\":\"0\"}}",title,body];
	NSLog(@"%@",json);
	NSData * postData = [json dataUsingEncoding:NSUTF8StringEncoding];
	[self.httpClientManager post:url param:[NSDictionary dictionaryWithObjectsAndKeys:
								@"application/json",@"Content-type",nil] body:postData];
}

//
//写真をサーバにPOSTする
//
-(void)postDiaryWithPhoto:(NSString*)title 
					 body:(NSString*)body 
					photo:(UIImage *)photo{
	
	NSURL * url = [MGUtil buildAPIURL:@"http://api.mixi-platform.com/" 
								 path:[NSArray arrayWithObjects:
									   @"2",
									   @"diary",
									   @"articles",
									   @"@me",
									   @"@self",
									   nil]
								query:nil];

	NSString * json = [NSString stringWithFormat:@"{\"title\":\"%@\",\"body\":\"%@\",\"privacy\":{\"visibility\":\"self\",\"show_users\":\"0\"}}",title,body];
	
	NSMutableData* imgData = [[[NSData alloc] initWithData:UIImageJPEGRepresentation(photo, 1.0)] autorelease];
	NSString *stringBoundary, *contentType; 
	stringBoundary = [NSString stringWithString:@"0xKhTmLbOuNdArY"]; 
    contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary]; 
	
    // Setting up the POST request's multipart/form-data body 
	NSMutableData *postBody; 
    postBody = [NSMutableData data]; 
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]]; 
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"request\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]]; 
	[postBody appendData:[[NSString stringWithString:json] dataUsingEncoding:NSUTF8StringEncoding]]; 
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]]; 
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo1\"; filename=\"%@\"\r\n", @"test.jpg" ] dataUsingEncoding:NSUTF8StringEncoding]]; 
    [postBody appendData:[[NSString stringWithString:@"Content-Type: image/jpg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]]; // jpeg as data 
    [postBody appendData:imgData];
    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]]; 
	
	[httpClientManager post:url param:[NSDictionary dictionaryWithObjectsAndKeys:
								contentType,@"Content-type",nil] body:postBody];
}


-(void)mghttpClientManager:(NSURLConnection *)conn didReceiveResponseError:(MGApiError *)error{
	NSLog(@"didReceiveResponseError");
	/*if([delegate respondsToSelector:@selector(mgFeedbackClient:didReceiveResponseError:)]){
		[delegate mgFeedbackClient:conn didReceiveResponseError:error];
	}*/
	
}

-(void)mghttpClientManager:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)res{
	NSLog(@"didReceiveResponse");
}

-(void)mghttpClientManager:(NSURLConnection *)conn didReceiveData:(NSData *)receivedData{
	NSLog(@"didReceiveData");
}

-(void)mghttpClientManager:(NSURLConnection *)conn didFailWithError:(NSError*)error{
	NSLog(@"didFailWithError");
}

-(void)mghttpClientManager:(NSURLConnection *)conn didFinishLoadingGet:(NSMutableData *)data{
	NSLog(@"didFinishLoading");
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFinishLoading:(NSDictionary *)reply{
	NSLog(@"didFinishLoading");
	NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"%@",contents);
	/*if([delegate respondsToSelector:@selector(mgVoiceClient:didFinishPosting:)]){
		[delegate mgVoiceClient:conn didFinishPosting:contents];
	}*/
}

- (void) dealloc {
	[httpClientManager release];
	[super dealloc];
}

@end
