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
@synthesize sender;

-(id)init{
	if(self = [super init]){
        self.receiverType = MIXIHttpReceiverTypeGraph;
    }
	return self;
}

- (void) dealloc {
    self.sender = nil;
	[super dealloc];
}

-(void)setSenderWithClass:(Class)class selector:(SEL)sel{
    self.sender = [NSDictionary dictionaryWithObjectsAndKeys: NSStringFromClass(class), @"class", NSStringFromSelector(sel), @"selector", nil];
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

@end
