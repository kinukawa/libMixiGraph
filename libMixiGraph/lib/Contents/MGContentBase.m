//
//  MGContentBase.m
//  libMixiGraph
//
//  Created by kinukawa on 11/05/01.
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

#import "MGContentBase.h"


@implementation MGContentBase
@synthesize httpConnector;

-(id)init{
	if((self = [super init])){
		//initialize
        self.httpConnector = [MGHttpConnector sharedConnector];
    }
	return self;
}

- (void) dealloc {
    self.httpConnector = nil;
    [super dealloc];
}

+(id)makeContentFromDict:(NSDictionary*)dict{
    NSLog(@"Please inherit me.");
    return nil;
}

+(id)makeContentFromResponseData:(NSData*)data{
    NSString *dataStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSDictionary * contentDict = [dataStr JSONValue];
    id contentObject = [self makeContentFromDict:contentDict];
    return contentObject;
}

+(NSArray *)makeContentArrayFromEntryArray:(NSArray*)dataArray{
    //NSString *dataStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSMutableArray * contentsArray = [NSMutableArray array];
    //NSArray * dataArray = [dataStr JSONValue];
    for(NSDictionary * contentDict in dataArray){
        id content = [self makeContentFromDict:contentDict];
        [contentsArray addObject:content];
    }
    return contentsArray;
}
@end
