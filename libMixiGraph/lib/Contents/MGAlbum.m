//
//  MGAlbum.m
//  libMixiGraph
//
//  Created by kinukawa on 11/05/03.
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

#import "MGAlbum.h"


@implementation MGAlbum

@synthesize delegate;

@synthesize created;
@synthesize description;
@synthesize albumId; 
@synthesize mediaItemCount; 
@synthesize numComments;
@synthesize ownerDisplayName;
@synthesize ownerId;
@synthesize ownerProfileUrl;
@synthesize ownerThumbnailUrl;
@synthesize privacyVisibility;
@synthesize thumbnailUrl;
@synthesize title;
@synthesize url;
@synthesize viewPageUrl;

-(id)init{
	if((self = [super init])){
		//initialize
        
    }
	return self;
}

- (void) dealloc {
    self.created = nil;
    self.description = nil;
    self.albumId = nil;
    self.ownerDisplayName = nil;
    self.ownerId = nil;
    self.ownerProfileUrl = nil;
    self.ownerThumbnailUrl = nil;
    self.privacyVisibility = nil;
    self.thumbnailUrl = nil;
    self.title = nil;
    self.url = nil;
    self.viewPageUrl = nil;
    
	[super dealloc];
}

+(MGAlbum *)makeContentFromDict:(NSDictionary*)dict{
    MGAlbum * album = [[[MGAlbum alloc] init] autorelease];
    
    album.created        = [dict objectForKey:@"created"];
    album.description    = [dict objectForKey:@"description"];
    album.albumId        = [dict objectForKey:@"id"];
    if (![[dict objectForKey:@"mediaItemCount"] isEqual:[NSNull null]]) {
        album.mediaItemCount = [[dict objectForKey:@"mediaItemCount"] intValue]; 
    }
    if (![[dict objectForKey:@"numComments"] isEqual:[NSNull null]]) {
        album.numComments    = [[dict objectForKey:@"numComments"] intValue];
    }
    NSDictionary * owner = [dict objectForKey:@"owner"];
    if (![owner isEqual:[NSNull null]]) {
        album.ownerDisplayName	= [owner objectForKey:@"displayName"];
        album.ownerId           = [owner objectForKey:@"id"];
        album.ownerProfileUrl   = [owner objectForKey:@"profileUrl"];
        album.ownerThumbnailUrl = [owner objectForKey:@"thumbnailUrl"];
    }
    NSDictionary * privacy = [dict objectForKey:@"privacy"];
    if (![privacy isEqual:[NSNull null]]) {
        album.privacyVisibility = [privacy objectForKey:@"visibility"];
    }
    album.thumbnailUrl     = [dict objectForKey:@"thumbnailUrl"];
    album.title = [dict objectForKey:@"title"];
    album.url = [dict objectForKey:@"url"];
    album.viewPageUrl = [dict objectForKey:@"viewPageUrl"];

    return album;
}

-(void)getCommentsWithAccessKey:(NSString *)accessKey 
                     startIndex:(NSString *)startIndex
                          count:(NSString *)count
                     identifier:(NSString *)identifier{

    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (accessKey) {
		[queryDict setObject:accessKey forKey:@"accessKey"];
	}
    if (startIndex) {
		[queryDict setObject:startIndex forKey:@"startIndex"];
	} 
    if (count) {
		[queryDict setObject:count forKey:@"count"];
	}
    NSURL * requestUrl = [MGUtil buildAPIURL:PHOTO_REPLYS_URL
                                 path:[NSArray arrayWithObjects:
                                       @"albums",
                                       self.ownerId,
                                       @"@self",
                                       self.albumId,
                                       nil]
                                query:queryDict];
    //self.httpClientManager.identifier = @"getComments";
	[self.httpClientManager get:@"getComments" identifier:identifier url:requestUrl];
}

-(void)postComment:(NSString *)comment 
     withAccessKey:(NSString *)accessKey                      
        identifier:(NSString *)identifier{

    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (accessKey) {
		[queryDict setObject:accessKey forKey:@"accessKey"];
	}
    NSURL * requestUrl = [MGUtil buildAPIURL:PHOTO_REPLYS_URL
                                 path:[NSArray arrayWithObjects:
                                       @"albums",
                                       self.ownerId,
                                       @"@self",
                                       self.albumId,
                                       nil]
                                query:queryDict];
    NSString * escapedString = [comment encodeURIComponent];
    NSData * body = [[NSString stringWithFormat:@"text=%@",escapedString] 
                     dataUsingEncoding:NSUTF8StringEncoding];
    //self.httpClientManager.identifier = @"postComment";
	[self.httpClientManager post:@"postComment" identifier:identifier url:requestUrl param:nil body:body];
} 


-(void)deleteCommentByComment:(MGComment *)comment 
                withAccessKey:(NSString *)accessKey                     
                   identifier:(NSString *)identifier{

    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (accessKey) {
		[queryDict setObject:accessKey forKey:@"accessKey"];
	}
    NSURL * requestUrl = [MGUtil buildAPIURL:PHOTO_REPLYS_URL
                                        path:[NSArray arrayWithObjects:
                                              @"albums",
                                              self.ownerId,
                                              @"@self",
                                              self.albumId,
                                              comment.commentId,
                                              nil]
                                       query:queryDict];
    //self.httpClientManager.identifier = @"deleteComment";
	[self.httpClientManager delete:@"deleteComment" identifier:identifier url:requestUrl];
    
}

-(void)deleteAlbum:(NSString *)identifier{

    NSURL * requestUrl = [MGUtil buildAPIURL:PHOTO_BASE_URL
                                        path:[NSArray arrayWithObjects:
                                              @"albums",
                                              @"@me",
                                              @"@self",
                                              self.albumId,
                                              nil]
                                       query:nil];
    //self.httpClientManager.identifier = @"deleteAlbum";
	[self.httpClientManager delete:@"deleteAlbum" identifier:identifier url:requestUrl];
}

//////////////mgHttpClientManagerDelegate/////////////////////
-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithError:(NSError*)error{
	NSLog(@"mgAlbum didFailWithError");
	if([delegate respondsToSelector:@selector(mgAlbum:didFailWithError:)]){
		[delegate mgAlbum:conn didFailWithError:error];
	}
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
	NSLog(@"mgAlbum didFailWithError : %@",error);
	if([delegate respondsToSelector:@selector(mgAlbum:didFailWithAPIError:)]){
		[delegate mgAlbum:conn didFailWithAPIError:error];
	}
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFinishLoading:(NSDictionary *)reply{
    NSData *data = [reply objectForKey:@"data"];
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSString *identifier = [reply objectForKey:@"id"];
    NSString *method = [reply objectForKey:@"method"];
    NSLog(@"mgAlbum didFinishLoading %@:%@",identifier,contents);
    
    id result = reply;
    if(method==@"getComments"){
        
        NSDictionary * jsonDict = [contents JSONValue];
        NSArray * commentsArray = [MGComment makeCommentArrayFromEntryArray:
                                 [jsonDict objectForKey:@"entry"]];

        
        NSDictionary * responseDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       commentsArray,@"entry",
                                       [jsonDict objectForKey:@"itemsPerPage"], @"itemsPerPage", 
                                       [jsonDict objectForKey:@"startIndex"], @"startIndex", 
                                       [jsonDict objectForKey:@"totalResults"], @"totalResults", 
                                       identifier,@"id",
                                       nil];
        result = responseDict;
    }else if(method==@"postComment"){
        //result = [MGComment makeCommentFromResponseData:data];
    }else if(method==@"deleteComment"){
        //result = [MGComment makeCommentFromResponseData:data];
    }else if(method==@"deleteAlbum"){
        //result = [MGComment makeCommentFromResponseData:data];
    }
    
	if([delegate respondsToSelector:@selector(mgAlbum:didFinishLoading:)]){
        [delegate mgAlbum:conn didFinishLoading:result];
    }
}

@end
