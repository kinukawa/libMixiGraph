//
//  MGPhoto.m
//  Picxi
//
//  Created by kenji kinukawa on 11/03/04.
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

#import "MGPhoto.h"


@implementation MGPhoto
@synthesize delegate;
@synthesize albumId;
@synthesize created;
@synthesize photoId;
@synthesize largeImageUrl;
@synthesize mimeType;
@synthesize numComments;
@synthesize numFavorites;
@synthesize thumbnailUrl;
@synthesize title;
@synthesize type;
@synthesize url;
@synthesize viewPageUrl;
@synthesize ownerThumbnailUrl;
@synthesize ownerId;
@synthesize ownerDisplayName;
@synthesize ownerProfileUrl;
@synthesize ownerThumbnailImage;

-(id)init{
	if((self = [super init])){
		//initialize
    }
	return self;
}

- (void) dealloc {
    self.delegate = nil;
    
    self.albumId = nil;
    self.created = nil;
    self.photoId = nil;
    self.largeImageUrl = nil;
    self.mimeType = nil;
    self.numComments = 0;
    self.numFavorites = 0;
    self.thumbnailUrl = nil;
    self.title = nil;
    self.type = nil;
    self.url = nil;
    self.viewPageUrl = nil;
    self.ownerThumbnailUrl = nil;
    self.ownerId = nil;
    self.ownerDisplayName = nil;
    self.ownerProfileUrl = nil;
    self.ownerThumbnailImage = nil;
    
	[super dealloc];
}

+(MGPhoto *)makeContentFromDict:(NSDictionary*)dict{
    MGPhoto * photo = [[[MGPhoto alloc] init] autorelease];
    
    photo.albumId       = [dict objectForKey:@"albumId"];
    photo.created       = [dict objectForKey:@"created"];
    photo.photoId       = [dict objectForKey:@"id"];
    photo.largeImageUrl = [dict objectForKey:@"largeImageUrl"];
    photo.mimeType      = [dict objectForKey:@"mimeType"];
    if ([[dict objectForKey:@"numComments"] isEqual:[NSNull null]]) {
        photo.numComments = [[dict objectForKey:@"numComments"] intValue];
    }
    if (![[dict objectForKey:@"numFavorites"] isEqual:[NSNull null]]) {
        photo.numFavorites = [[dict objectForKey:@"numFavorites"] intValue];
    }
    photo.thumbnailUrl = [dict objectForKey:@"thumbnailUrl"];
    photo.title        = [dict objectForKey:@"title"];
    photo.type         = [dict objectForKey:@"type"];
    photo.url          = [dict objectForKey:@"url"];
    photo.viewPageUrl  = [dict objectForKey:@"viewPageUrl"];
    
    NSDictionary * owner = [dict objectForKey:@"owner"];
    if (![owner isEqual:[NSNull null]]) {
        photo.ownerDisplayName	= [owner objectForKey:@"displayName"];
        photo.ownerId           = [owner objectForKey:@"id"];
        photo.ownerProfileUrl   = [owner objectForKey:@"profileUrl"];
        photo.ownerThumbnailUrl = [owner objectForKey:@"thumbnailUrl"];
    }
    return photo;
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
                                              @"mediaItems",
                                              self.ownerId,
                                              @"@self",
                                              self.albumId,
                                              self.photoId,
                                              nil]
                                       query:queryDict];
    //self.httpClientManager.identifier = @"getComments";
	[self.httpClientManager get:@"getComments" identifier:identifier url:requestUrl];
}

-(void)postComment:(NSString *)comment withAccessKey:(NSString *)accessKey 
        identifier:(NSString *)identifier{

    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (accessKey) {
		[queryDict setObject:accessKey forKey:@"accessKey"];
	}
    NSURL * requestUrl = [MGUtil buildAPIURL:PHOTO_REPLYS_URL
                                        path:[NSArray arrayWithObjects:
                                              @"mediaItems",
                                              self.ownerId,
                                              @"@self",
                                              self.albumId,
                                              self.photoId,
                                              nil]
                                       query:queryDict];
    NSString * escapedString = [comment encodeURIComponent];
    NSData * body = [[NSString stringWithFormat:@"text=%@",escapedString] 
                     dataUsingEncoding:NSUTF8StringEncoding];
    
    //self.httpClientManager.identifier = @"postComment";
	[self.httpClientManager post: @"postComment" identifier:identifier url:requestUrl param:nil body:body];
} 

-(void)deleteCommentByComment:(MGComment *)comment withAccessKey:(NSString *)accessKey
                   identifier:(NSString *)identifier{

    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (accessKey) {
		[queryDict setObject:accessKey forKey:@"accessKey"];
	}
    NSURL * requestUrl;
    requestUrl = [MGUtil buildAPIURL:PHOTO_REPLYS_URL
                                        path:[NSArray arrayWithObjects:
                                              @"mediaItems",
                                              self.ownerId,
                                              @"@self",
                                              self.albumId,
                                              self.photoId,
                                              comment.commentId,
                                              nil]
                                       query:queryDict];
    //self.httpClientManager.identifier = @"deleteComment";
	[self.httpClientManager delete:@"deleteComment" identifier:identifier url:requestUrl];
}

-(void)getFavoritesWithAccessKey:(NSString *)accessKey 
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
    NSURL * requestUrl = [MGUtil buildAPIURL:PHOTO_FAVORITES_URL
                                        path:[NSArray arrayWithObjects:
                                              self.ownerId,
                                              @"@self",
                                              self.albumId,
                                              self.photoId,
                                              nil]
                                       query:queryDict];
    //self.httpClientManager.identifier = @"getFavorites";
	[self.httpClientManager get:@"getFavorites" identifier:identifier url:requestUrl];
}

-(void)postFavoriteWithAccessKey:(NSString *)accessKey 
                      identifier:(NSString *)identifier{

    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (accessKey) {
		[queryDict setObject:accessKey forKey:@"accessKey"];
	}
    NSURL * requestUrl = [MGUtil buildAPIURL:PHOTO_FAVORITES_URL
                                        path:[NSArray arrayWithObjects:
                                              self.ownerId,
                                              @"@self",
                                              self.albumId,
                                              self.photoId,
                                              nil]
                                       query:queryDict];
    //self.httpClientManager.identifier = @"postFavorite";
	[self.httpClientManager post:@"postFavorite" identifier:identifier url:requestUrl param:nil body:nil];
} 

-(void)deleteFavoriteByUserId:(NSString *)uId withAccessKey:(NSString *)accessKey
                   identifier:(NSString *)identifier{

    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (accessKey) {
		[queryDict setObject:accessKey forKey:@"accessKey"];
	}
    NSURL * requestUrl;
    requestUrl = [MGUtil buildAPIURL:PHOTO_FAVORITES_URL
                                path:[NSArray arrayWithObjects:
                                      self.ownerId,
                                      @"@self",
                                      self.albumId,
                                      self.photoId,
                                      uId,
                                      nil]
                               query:queryDict];
    //self.httpClientManager.identifier = @"deleteFavorite";
	[self.httpClientManager delete:@"deleteFavorite" identifier:identifier url:requestUrl];
}

-(void)deletePhoto:(NSString *)identifier{

    NSURL * requestUrl = [MGUtil buildAPIURL:PHOTO_BASE_URL
                                        path:[NSArray arrayWithObjects:
                                              @"mediaItems",
                                              @"@me",
                                              @"@self",
                                              self.albumId,
                                              self.photoId,
                                              nil]
                                       query:nil];
    //self.httpClientManager.identifier = @"deletePhoto";
	[self.httpClientManager delete:@"deletePhoto" identifier:identifier url:requestUrl];
}

//////////////mgHttpClientManagerDelegate/////////////////////
-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithError:(NSError*)error{
	NSLog(@"mgPhoto didFailWithError");
	if([delegate respondsToSelector:@selector(mgPhoto:didFailWithError:)]){
		[delegate mgPhoto:conn didFailWithError:error];
	}
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
	NSLog(@"mgPhoto didFailWithError : %@",error);
	if([delegate respondsToSelector:@selector(mgPhoto:didFailWithAPIError:)]){
		[delegate mgPhoto:conn didFailWithAPIError:error];
	}
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFinishLoading:(NSDictionary *)reply{
    NSData *data = [reply objectForKey:@"data"];
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSString *identifier = [reply objectForKey:@"id"];
    NSString *method = [reply objectForKey:@"method"];
	NSLog(@"MGPhoto didFinishLoading %@:%@",identifier,contents);
    
    id result = reply;
    //if(method==@"getComments"){

    if(method==@"getComments"){
        NSDictionary * jsonDict = [contents JSONValue];
        NSArray * commentsArray = [MGComment makeCommentArrayFromEntryArray:
                                   [jsonDict objectForKey:@"entry"]];
        
        
        NSDictionary * responseDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       commentsArray,@"data",
                                       [jsonDict objectForKey:@"itemsPerPage"], @"itemsPerPage", 
                                       [jsonDict objectForKey:@"startIndex"], @"startIndex", 
                                       [jsonDict objectForKey:@"totalResults"], @"totalResults", 
                                       identifier,@"id",
                                       nil];
        result = responseDict;
    }else if(method==@"postComment"){
    }else if(method==@"deleteComment"){
    }else if(method==@"getFavorites"){
        NSDictionary * jsonDict = [contents JSONValue];
        NSArray * favoritesArray = [MGFavorite makeCommentArrayFromEntryArray:
                                   [jsonDict objectForKey:@"entry"]];
        
        
        NSDictionary * responseDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       favoritesArray,@"data",
                                       [jsonDict objectForKey:@"itemsPerPage"], @"itemsPerPage", 
                                       [jsonDict objectForKey:@"startIndex"], @"startIndex", 
                                       [jsonDict objectForKey:@"totalResults"], @"totalResults", 
                                       identifier,@"id",
                                       nil];
        result = responseDict;
    }else if(method==@"postFavorite"){
        //result = [MGVoice makeContentFromResponseData:data];
    }else if(method==@"deleteFavorite"){
        //result = [MGFavorite makeFavoriteFromResponseData:data];
    }else if(method==@"deletePhoto"){
        //result = [contents JSONValue];
    }
    
    if([delegate respondsToSelector:@selector(mgPhoto:didFinishLoading:)]){
        [delegate mgPhoto:conn didFinishLoading:result];
    }
}

@end
