//
//  MGComment.m
//  libMixiGraph
//
//  Created by kenji kinukawa on 11/02/21.
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

#import "MGComment.h"


@implementation MGComment

@synthesize commentId;
@synthesize createdAt;
@synthesize commentText;
@synthesize userId;
@synthesize userScreeName;
@synthesize userProfileImageUrl;
@synthesize userUrl;

-(id)init{
	if((self = [super init])){
		//initialize
    }
	return self;
}

- (void) dealloc {
    self.commentId = nil;
    self.createdAt = nil;
    self.commentText = nil;
    self.userId = nil;
    self.userScreeName = nil;
    self.userProfileImageUrl = nil;
    self.userUrl = nil;
	[super dealloc];
}


+(MGComment *)makeCommentFromDict:(NSDictionary*)dict{
    MGComment * comment = [[[MGComment alloc] init] autorelease];
    /*for (id key in voiceContentDict){
     NSLog(@"key=[%@] value=[%@] type=[%@]",key,[voiceContentDict objectForKey:key],[[voiceContentDict objectForKey:key] class]);	 
     }*/
    NSDictionary * user = [dict objectForKey:@"user"];
    comment.commentId = [dict objectForKey:@"id"];
    comment.createdAt = [dict objectForKey:@"created_at"];
    comment.commentText = [dict objectForKey:@"text"];
    comment.userId = [user objectForKey:@"id"];
    comment.userScreeName = [user objectForKey:@"screen_name"];
    comment.userProfileImageUrl = [user objectForKey:@"profile_image_url"];
    comment.userUrl = [user objectForKey:@"url"];
    return comment;
}

+(MGComment *)makeCommentFromResponseData:(NSData*)data{
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSDictionary * commentContentDict = [contents JSONValue];
    MGComment * comment = [self makeCommentFromDict:commentContentDict];
    return comment;
}

+(NSMutableArray *)makeCommentArrayFromResponseData:(NSData*)data{
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	//NSLog(@"%@",contents);
    NSMutableArray * commentArray = [NSMutableArray array];
    NSArray * commentJsonArray = [contents JSONValue];
    for(NSDictionary * commentContentDict in commentJsonArray){
        MGComment * comment = [self makeCommentFromDict:commentContentDict];
        [commentArray addObject:comment];
    }
    return commentArray;
}

@end
