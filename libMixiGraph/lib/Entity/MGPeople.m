//
//  MGPeople.m
//  Picxi
//
//  Created by kinukawa on 11/02/28.
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

#import "MGPeople.h"


@implementation MGPeople
@synthesize peopleId;
@synthesize displayName;
@synthesize thumbnailUrl;
@synthesize profileUrl;
@synthesize statusPostedTime;
@synthesize statusText;
@synthesize lastLogin;

#warning ユーザーの詳細情報の取得は未実装
-(id)init{
	if((self = [super init])){
		//initialize
        
    }
	return self;
}

- (void) dealloc {
    self.peopleId = nil;
    self.displayName = nil;
    self.thumbnailUrl = nil;
    self.profileUrl = nil;
    self.statusPostedTime = nil;
    self.statusText = nil;
    self.lastLogin = nil;
    
	[super dealloc];
}

+(MGPeople *)makeContentFromDict:(NSDictionary*)dict{
    MGPeople * people = [[[MGPeople alloc] init] autorelease];
    
    people.peopleId			= [dict objectForKey:@"id"];
    people.displayName		= [dict objectForKey:@"displayName"];
    people.lastLogin		= [dict objectForKey:@"lastLogin"];
    people.thumbnailUrl		= [dict objectForKey:@"thumbnailUrl"];
    people.profileUrl		= [dict objectForKey:@"profileUrl"];
    NSDictionary*status = [dict objectForKey:@"status"];
    if (![status isEqual:[NSNull null]]) {
        people.statusText		= [status objectForKey:@"text"];
        people.statusPostedTime		= [status objectForKey:@"postedTime"];
    }
    return people;
}

@end
