//
//  MGVoice.m
//  libMixiGraph
//
//  Created by kinukawa on 11/02/17.
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

#import "MGVoice.h"


@implementation MGVoice

@synthesize delegate;
//@synthesize httpClient;
//@synthesize identifier;
//@synthesize commentList;
//@synthesize favoriteList;

@synthesize postId;
@synthesize createdAt;
@synthesize voiceText;
@synthesize userId;
@synthesize userScreeName;
@synthesize userProfileImageUrl;
@synthesize userUrl;
@synthesize replyCount;
@synthesize favoriteCount;
@synthesize source;
@synthesize favorited;
@synthesize photoImageUrl;
@synthesize photoThumbnailUrl;

-(id)init{
	if((self = [super init])){
		//initialize
        self.httpClient = [[MGHttpClient alloc]init];
        self.httpClient.delegate = self;
    }
	return self;
}

- (void) dealloc {
    self.delegate = nil;
    self.httpClient = nil;
    self.identifier = nil;
    
    self.postId = nil;
    self.createdAt = nil;
    self.voiceText = nil;
    self.userId = nil;
    self.userScreeName = nil;
    self.userProfileImageUrl = nil;
    self.userUrl = nil;
    self.replyCount = 0;
    self.favoriteCount = 0;
    self.source = nil;
    self.favorited = nil;
    self.photoImageUrl = nil;
    self.photoThumbnailUrl = nil;

	[super dealloc];
}

+(MGVoice *)makeVoiceFromDict:(NSDictionary*)dict{
    MGVoice * voice = [[[MGVoice alloc] init] autorelease];
    /*for (id key in voiceContentDict){
     NSLog(@"key=[%@] value=[%@] type=[%@]",key,[voiceContentDict objectForKey:key],[[voiceContentDict objectForKey:key] class]);	 
     }*/
    NSDictionary * user = [dict objectForKey:@"user"];
    voice.postId = [dict objectForKey:@"id"];
    voice.createdAt = [dict objectForKey:@"created_at"];
    voice.voiceText = [dict objectForKey:@"text"];
    voice.userId = [user objectForKey:@"id"];
    voice.userScreeName = [user objectForKey:@"screen_name"];
    voice.userProfileImageUrl = [user objectForKey:@"profile_image_url"];
    voice.userUrl = [user objectForKey:@"url"];
    voice.replyCount = [[dict objectForKey:@"reply_count"] intValue];
    voice.favoriteCount = [[dict objectForKey:@"favorite_count"] intValue];
    voice.source = [dict objectForKey:@"source"];
    voice.favorited = [dict objectForKey:@"favorited"];
    NSArray * photoArr =[dict objectForKey:@"photo"];
    if (photoArr) {
        if ([photoArr count]>0) {
            voice.photoImageUrl = [[photoArr objectAtIndex:0] objectForKey:@"image_url"];
            voice.photoThumbnailUrl = [[photoArr objectAtIndex:0] objectForKey:@"thumbnail_url"];
        }
    }
    return voice;
}

+(MGVoice *)makeVoiceFromResponseData:(NSData*)data{
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	//NSLog(@"%@",contents);
    NSDictionary * voiceContentDict = [contents JSONValue];
    MGVoice * voice = [self makeVoiceFromDict:voiceContentDict];
    return voice;
}

+(NSArray *)makeVoiceArrayFromResponseData:(NSData*)data{
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	//NSLog(@"%@",contents);
    NSMutableArray * voiceArray = [NSMutableArray array];
    NSArray * voiceJsonArray = [contents JSONValue];
    for(NSDictionary * voiceContentDict in voiceJsonArray){
        MGVoice * voice = [self makeVoiceFromDict:voiceContentDict];
        [voiceArray addObject:voice];
    }
    return voiceArray;
}


-(void)getComments{
    NSURL * url = [MGUtil buildAPIURL:VOICE_REPLYS_URL
                                 path:[NSArray arrayWithObjects:
                                       self.postId,
                                       nil]
                                query:nil];
    self.httpClient.identifier = @"getComments";
	[self.httpClient get:url];
}

-(void)postComment:(NSString *)comment{
    NSURL * url = [MGUtil buildAPIURL:VOICE_REPLYS_URL
                                 path:[NSArray arrayWithObjects:
                                       self.postId,
                                       nil]
                                query:nil];
    NSData * body = [[[NSString stringWithFormat:@"text=%@",comment] 
                      stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] 
                     dataUsingEncoding:NSUTF8StringEncoding];
    self.httpClient.identifier = @"postComment";
	[self.httpClient post:url param:nil body:body];
} 

-(void)deleteCommentByComment:(MGComment *)comment{
    NSURL * url = [MGUtil buildAPIURL:VOICE_REPLYS_URL
                                 path:[NSArray arrayWithObjects:
                                       @"destroy",
                                       self.postId,
                                       comment.commentId,
                                       nil]
                                query:nil];
    self.httpClient.identifier = @"deleteComment";
	[self.httpClient post:url param:nil body:nil];
}


-(void)getFavorites{
    NSURL * url = [MGUtil buildAPIURL:VOICE_FAVORITES_URL
                                 path:[NSArray arrayWithObjects:
                                       @"show",
                                       self.postId,
                                       nil]
                                query:nil];
    self.httpClient.identifier = @"getFavorites";
	[self.httpClient get:url];
}

-(void)postFavorite{
    NSURL * url = [MGUtil buildAPIURL:VOICE_FAVORITES_URL
                                 path:[NSArray arrayWithObjects:
                                       @"create",
                                       self.postId,
                                       nil]
                                query:nil];
    self.httpClient.identifier = @"postFavorite";
	[self.httpClient post:url param:nil body:nil];
}

-(void)deleteFavoriteByUserId:(NSString *)uId{
    NSURL * url = [MGUtil buildAPIURL:VOICE_FAVORITES_URL
                                 path:[NSArray arrayWithObjects:
                                       @"destroy",
                                       self.postId,
                                       uId,
                                       nil]
                                query:nil];
    self.httpClient.identifier = @"deleteFavorite";
	[self.httpClient post:url param:nil body:nil];
}

//////////////MGHttpClientDelegate/////////////////////
-(void)mgHttpClient:(NSURLConnection *)conn didFailWithError:(NSError*)error{
	NSLog(@"MGVoice didFailWithError");
	if([delegate respondsToSelector:@selector(mgVoice:didFailWithError:)]){
		[delegate mgVoice:conn didFailWithError:error];
	}
}

-(void)mgHttpClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
	NSLog(@"MGVoice didFailWithError : %@",error);
	if([delegate respondsToSelector:@selector(mgVoice:didFailWithAPIError:)]){
		[delegate mgVoice:conn didFailWithAPIError:error];
	}
}

-(void)mgHttpClient:(NSURLConnection *)conn didFinishLoading:(NSData *)data{
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"MGVoice didFinishLoading %@:%@",self.httpClient.identifier,contents);
    id result = data;
    if(self.httpClient.identifier==@"getComments"){
        result = [MGComment makeCommentArrayFromResponseData:data];
    }else if(self.httpClient.identifier==@"postComment"){
        result = [MGComment makeCommentFromResponseData:data];
        self.replyCount++;
    }else if(self.httpClient.identifier==@"deleteComment"){
        result = [MGComment makeCommentFromResponseData:data];
        self.replyCount--;
    }else if(self.httpClient.identifier==@"getFavorites"){
        result = [MGFavorite makeFavoriteArrayFromResponseData:data];
    }else if(self.httpClient.identifier==@"postFavorite"){
        result = [MGVoice makeVoiceFromResponseData:data];
    }else if(self.httpClient.identifier==@"deleteFavorite"){
        result = [MGFavorite makeFavoriteFromResponseData:data];
        self.favoriteCount--;
    }
    
	if([delegate respondsToSelector:@selector(mgVoice:didFinishLoading:)]){
        [delegate mgVoice:conn didFinishLoading:data];
    }
}

@end
